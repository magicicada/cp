"""Convert labs.md to labs.tex.

Handles only the Markdown used in labs.md: headings, paragraphs, bold and
italic, inline code, inline maths, fenced code blocks, pipe tables,
horizontal rules, and bulleted and numbered lists (nested by indentation).

Usage: python3 md2tex.py labs.md labs.tex
"""
import re
import sys

PREAMBLE = r"""\documentclass[11pt]{article}
\usepackage[margin=1in]{geometry}
\usepackage{amsmath,amssymb}
\usepackage[T1]{fontenc}
\usepackage{lmodern}
\usepackage{booktabs}
\usepackage{enumitem}
\usepackage{fancyvrb}
\usepackage[hidelinks]{hyperref}

\setlength{\parindent}{0pt}
\setlength{\parskip}{0.7\baselineskip}
\setlength{\emergencystretch}{3em}
\hfuzz=2pt
\setlist{itemsep=0.2\baselineskip, parsep=0.3\baselineskip}
\fvset{fontsize=\small, xleftmargin=1.5em, frame=leftline, framesep=1em}

\begin{document}
"""

SPECIAL = {"\\": r"\textbackslash{}", "{": r"\{", "}": r"\}", "_": r"\_",
           "&": r"\&", "%": r"\%", "#": r"\#", "$": r"\$", "^": r"\^{}",
           "~": r"\~{}"}


def escape(text):
    return "".join(SPECIAL.get(c, c) for c in text)


def code(text):
    # \texttt with every special character escaped; hyphens kept literal
    out = escape(text).replace("-", "-{}").replace("<", r"\textless{}").replace(">", r"\textgreater{}")
    out = out.replace("/", r"/\allowbreak{}")
    if len(text) <= 20:
        return r"\mbox{\texttt{" + out + "}}"
    return r"\texttt{" + out + "}"


def inline(text):
    """Convert inline Markdown: `code`, $maths$, **bold**, *italic*."""
    parts = re.split(r"(`[^`]*`|\$[^$]+\$)", text)
    out = []
    for p in parts:
        if p.startswith("`") and p.endswith("`") and len(p) > 1:
            out.append(code(p[1:-1]))
        elif p.startswith("$") and p.endswith("$") and len(p) > 1:
            out.append(p)
        else:
            s = escape(p)
            s = re.sub(r"\*\*(.+?)\*\*", r"\\textbf{\1}", s)
            s = re.sub(r"\*(.+?)\*", r"\\emph{\1}", s)
            s = s.replace('"', "''")
            out.append(s)
    s = "".join(out)
    # opening double quotes
    s = re.sub(r"(^|[\s(])''", r"\1``", s)
    return s


def table(rows):
    cells = [[c.strip() for c in r.strip().strip("|").split("|")] for r in rows]
    header, body = cells[0], cells[2:]
    cols = "l" * len(header)
    out = [r"\begin{center}", r"\small", r"\begin{tabular}{" + cols + "}", r"\toprule"]
    out.append(" & ".join(inline(c) for c in header) + r" \\")
    out.append(r"\midrule")
    for r in body:
        out.append(" & ".join(inline(c) for c in r) + r" \\")
    out += [r"\bottomrule", r"\end{tabular}", r"\end{center}"]
    return out


def convert(md):
    lines = md.split("\n")
    out = [PREAMBLE]
    list_stack = []  # (indent, env)
    para = []

    def flush_para():
        if para:
            out.append(inline(" ".join(para)))
            out.append("")
            para.clear()

    def close_lists(to_indent=-1):
        while list_stack and list_stack[-1][0] > to_indent:
            out.append(r"\end{" + list_stack.pop()[1] + "}")

    i = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        indent = len(line) - len(line.lstrip())

        if stripped.startswith("```"):
            flush_para()
            j = i + 1
            block = []
            while not lines[j].strip().startswith("```"):
                block.append(lines[j][indent:] if lines[j].strip() else "")
                j += 1
            out.append(r"\begin{Verbatim}")
            out += block
            out.append(r"\end{Verbatim}")
            i = j + 1
            continue

        if not stripped:
            flush_para()
            # a blank line ends a list unless the list continues afterwards
            k = i + 1
            while k < len(lines) and not lines[k].strip():
                k += 1
            nxt = lines[k] if k < len(lines) else ""
            nind = len(nxt) - len(nxt.lstrip())
            if list_stack and not (nind > 0 or re.match(r"\s*([-*]|\d+\.)\s", nxt)):
                close_lists()
            i += 1
            continue

        if stripped.startswith("#"):
            flush_para()
            close_lists()
            level = len(stripped) - len(stripped.lstrip("#"))
            title = inline(stripped[level:].strip())
            if level == 1:
                out.append(r"\begin{center}{\LARGE\bfseries " + title + r"}\end{center}")
            else:
                cmd = {2: "section*", 3: "subsection*"}.get(level, "paragraph")
                out.append("\\" + cmd + "{" + title + "}")
            out.append("")
            i += 1
            continue

        if stripped == "---":
            flush_para()
            close_lists()
            out.append(r"\bigskip\hrule\bigskip")
            out.append("")
            i += 1
            continue

        if stripped.startswith("|"):
            flush_para()
            close_lists()
            rows = []
            while i < len(lines) and lines[i].strip().startswith("|"):
                rows.append(lines[i])
                i += 1
            out += table(rows)
            out.append("")
            continue

        m = re.match(r"(\s*)([-*]|\d+\.)\s+(.*)", line)
        if m:
            flush_para()
            env = "itemize" if m.group(2) in "-*" else "enumerate"
            close_lists(indent)
            if not list_stack or list_stack[-1][0] < indent:
                out.append(r"\begin{" + env + "}")
                list_stack.append((indent, env))
            out.append(r"\item " + inline(m.group(3)))
            i += 1
            continue

        # continuation of a list item or a paragraph
        if list_stack and indent > list_stack[-1][0] and not para:
            out.append("")
        para.append(stripped)
        i += 1

    flush_para()
    close_lists()
    out.append(r"\end{document}")
    return "\n".join(out) + "\n"


if __name__ == "__main__":
    src, dst = sys.argv[1], sys.argv[2]
    with open(src) as f:
        md = f.read()
    with open(dst, "w") as f:
        f.write(convert(md))

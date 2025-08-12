import sys

def find_unsat():
    input_stream = sys.stdin
    for line in input_stream:
        if 'UNSAT' in line:
            return True
    return False


points_for_unsat = 3
if find_unsat():
    print(str(points_for_unsat))
else:
    print("0")


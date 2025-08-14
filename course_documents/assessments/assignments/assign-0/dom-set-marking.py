import networkx as nx
import re
import sys

def get_just_number_list(str):
    return [int(x) for x in re.findall(r"-?\d+", str)]

def get_just_number(str):
    m = re.search(r"-?\d+", str)
    return int(m.group(0)) if m else None

def read_dzn(filename):
    from_list = []
    to = []
    n = 0
    for line in open(filename):
         if line.startswith('from'):
            from_list = get_just_number_list(line)
            
         elif line.startswith('to'):
            to = get_just_number_list(line)         

         elif line.startswith('n'):
            n = get_just_number(line)
            
    graph = nx.Graph()
    for i in range(1, n):
       graph.add_node(i)
    for i in range(len(to)):
       graph.add_edge(from_list[i], to[i])
    return graph


def read_solution(filename):
    for line in open(filename):
         if line.startswith('decision'):
             return get_just_number_list(line.strip())  

def main():
    
    marking_string = ""
    dzn_file = sys.argv[1]
    output_file = sys.argv[2]
    
    graph = read_dzn(dzn_file)

    binary_solution = read_solution(output_file)
    node_solution = []
    for i in range(len(binary_solution)):
      if binary_solution[i] == 1:
          node_solution.append(i+1)    

    if nx.is_dominating_set(graph, node_solution):
       marking_string += 'true,'
    else:
       marking_string += 'false,'
    
    marking_string += str(sum(binary_solution))
    print(marking_string)

if __name__ == "__main__":
    main()


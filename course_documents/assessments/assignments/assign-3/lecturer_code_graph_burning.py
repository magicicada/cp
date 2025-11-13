import time
import networkx as nx
import submitted_graph_burning_solution as sub
from minizinc import Instance, Model, Solver


RUNTIME_PRINTING = True

# networkx graph
def generate_binary_tree_instance(height):
  arity = 2
  tree = nx.balanced_tree(arity, height)
  assert tree.degree(root) == arity
  return tree

#  networkx graph
def generate_ladder_instance(height):
  ladder = nx.ladder_graph(height)
  return ladder


# in case student doesn't do time zero, or the structure is longer than needed:
def trim_trailing_nones(lst):
    while lst and lst[-1] is None:
        lst.pop()
    return lst
def trim_leading_nones(lst):
    while lst and lst[0] is None:
        lst.pop(0)
    return lst

def translate_dec_1(dec_1):
# set to t at position i if vertex i is selected for active burning on turn t, -1 otherwise
    burning_seq = [None] * (max(dec_1)+1)
    for vertex in range(len(dec_1)):
        if dec_1[vertex] > -1:
            t = dec_1[vertex]
            if burning_seq[t] > -1:
                #then we have multiple burns at the same time, not valid
                return None
            burning_seq[t] = vertex
    trim_trailing_nones(burning_seq)
    trim_leading_nones(burning_seq)
    return burning_seq        



def translate_dec_2(dec_2):
#     decision_2[i, j] should be set to 1 if you choose to burn vertex i at time j, 0 otherwise
    n = len(dec_2)        # number of vertices

    max_t = len(dec_2[0])     # number of time steps
    burning_seq = [None] * max_t

    for t in range(max_t):
        for vertex in range(n):
            if dec_2[vertex][t] == 1:
                burning_seq[t] = vertex
    trim_trailing_nones(burning_seq)
    trim_leading_nones(burning_seq)

    return burning_seq
    
def parse_minizinc_result(result):
    decision = None
    try:
        decision = translate_dec_1(result["decision_1"])      
    except KeyError:
        decision = translate_dec_2(result["decision_2"])
    finally:
        return decision

BURN = "burn"
OPEN = "open"

def do_a_spread(graph, state_dict):
    new_burns = []
    for vertex in graph.nodes():
        for other in graph.neighbors(vertex):
            if state_dict[other] == BURN:
                new_burns.append(vertex)
    for vertex in new_burns:
        state_dict[vertex] = BURN
    
    
def is_a_burning_seq(graph, burning_seq):
    state_dict = {}
    for vertex in graph.nodes():
        state_dict[vertex] = OPEN
    
    for time in range(len(burning_seq)):
        do_a_spread(graph, state_dict)
        state_dict[burning_seq[time]] = BURN
    # and do one more step: allow spread without last selection
    do_a_spread(graph, state_dict)        
    
    for vertex in graph.nodes():
        if state_dict[vertex] != BURN:
            return False
    return True
        

    
def do_minizinc_run(graph, result_dict, name_graph = "", name_of_minizinc ="graph-burning-assign-3.mzn"):
    burning_csp = Model("./"+ name_of_minizinc)
    gecode = Solver.lookup("gecode")
    instance = Instance(gecode, burning_csp)
    
    n = len(graph.nodes())
    m = len(graph.edges())
    
    name_dict = {}
    
    nodes_list =list(graph.nodes())
    for index in range(len(nodes_list)):
        name_dict[nodes_list[index]] = index +1
    to_list = []
    from_list = []
    for (u, v) in graph.edges():
        to_list.append(name_dict[u])
        from_list.append(name_dict[v])
    instance["n"] = n;
    instance["m"] = m;
    instance["from"] = from_list
    instance["to"] = to_list
    
    result = instance.solve()
    
    burning_seq = parse_minizinc_result(result)
    graph = nx.Graph()
    for edge in range(len(from_list)):
        graph.add_edge(from_list[edge], to_list[edge])
    
    result_dict[(name_graph, "mzn")] = (is_a_burning_seq(graph, burning_seq), len(burning_seq))

def do_ilp_run(graph, result_dict, name_graph = ""):
    burning_seq = sub.run_ilp(graph)["burn_seq"]
    result_dict[(name_graph, "ilp")] = (is_a_burning_seq(graph, burning_seq), len(burning_seq))
    
    
def run_dual_trials(graph, result_dict, name_graph = "", 
                    name_of_minizinc = "graph-burning-assign-3.mzn"):
    print("running " + name_graph)
    do_minizinc_run(graph, result_dict, name_graph = name_graph, name_of_minizinc = name_of_minizinc)
    do_ilp_run(graph, result_dict, name_graph = name_graph)

def skeleton_runs():
    name_of_minizinc = "graph-burning-assign-3.mzn"
    result_dict = {}
    
#     note that you may not be able to solve instances up to the full sizes - this is meant to be challenging, some students may not manage it

#     for size in [4,6,10]:
    for size in [3, 5]:
        path_graph = nx.path_graph(size)
        run_dual_trials(path_graph, result_dict, name_graph = "path_"+str(size))
        
#     for height in [4, 6, 10]:
    for height in [4]:
        ladder_graph = generate_ladder_instance(height)
        run_dual_trials(ladder_graph, result_dict, name_graph = "ladder_"+str(height))
    
#     for dim in [3, 5, 7]:
    for dim in [3]:
        grid_graph = nx.grid_2d_graph(dim, dim)
        run_dual_trials(grid_graph, result_dict, name_graph = "grid_"+str(dim))
    
    print(result_dict)
skeleton_runs()

                                          

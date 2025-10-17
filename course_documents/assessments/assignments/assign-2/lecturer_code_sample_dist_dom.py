import time
import networkx as nx
import submitted_dist_dom_solution


RUNTIME_PRINTING = True

# networkx graph
def generate_binary_tree_instance(height):
  arity = 2
  tree = nx.balanced_tree(arity, height)
  assert tree.degree(root) == arity
  return tree

#  networkx graph
def generate_ladder_instance():
  height = 20
  ladder = nx.ladder_graph(height)
  return ladder


VERY_LARGE_NUMBER = 10000000000

def find_shortest_path(graph, source, target_set):
  min = VERY_LARGE_NUMBER
  for target in target_set:
    path = nx.shortest_path(graph, source, target)
    if len(path) < min:
      min = len(path)
  return min -1

def is_distance_dominated(graph, node, dom_set, k):
  return find_shortest_path(graph, node, dom_set) <= k


def distance_dominates(graph, dom_set, k):
  for node in graph:
    if not is_distance_dominated(graph, node, dom_set, k):
      return False
  return True


def skeleton_runs():
    # runs_results dictionary will be have tuples as values, ("name-of-instance", distance_used)
    # where "name-of-instance" is a name I'll use for the graph involved, and 
    # distance_used is a positive integer that is the distance used for distance domination     
    runs_results = {}
    
    # I'll have a variety of instances, here are a few toy ones
    # as examples
    
    if RUNTIME_PRINTING:
        print("Doing path graphs")
    graph = nx.path_graph(6)
    name = "path_6_verts"
    
    for dist in [1, 2, 5]:
        result_dict = submitted_dist_dom_solution.run_ilp(graph, distance = dist)
        dom_cand = result_dict["dom_set"]
        runs_results[(name, dist)] = (distance_dominates(graph, dom_cand, dist), len(dom_cand))
    

    if RUNTIME_PRINTING:
        print("Doing complete graphs")
    # in a complete graph one vertex should suffice
    graph = nx.complete_graph(6)
    name = "complete_graph"
    for dist in [1, 5]:
        result_dict = submitted_dist_dom_solution.run_ilp(graph, distance = dist)
        dom_cand = result_dict["dom_set"]
        runs_results[(name, dist)] = (distance_dominates(graph, dom_cand, dist), len(dom_cand))


    if RUNTIME_PRINTING:
        print("Doing grid graphs")
    graph = nx.grid_2d_graph(5, 5)
    name = "grid"
    for dist in [1, 3, 5, 20]:
        result_dict = submitted_dist_dom_solution.run_ilp(graph, distance = dist)
        dom_cand = result_dict["dom_set"]
        runs_results[(name, dist)] = (distance_dominates(graph, dom_cand, dist), len(dom_cand))


    return runs_results
   

def nice_print(dict_of_results):
    for (graph, distance) in dict_of_results:
        (dominates, size) = dict_of_results[(graph, distance)]
        print("On graph " + str(graph) + " with distance " + str(distance) + ": proposed dominating set of size " + 
              str(size) + " dominates is " + str(dominates)) 
    
   
nice_print(skeleton_runs())

import time
import networkx as nx
import submitted_solution


# height + 1 should burn
# returns start, networkx graph
def generate_binary_tree_instance(height):
  arity = 2
  tree = nx.balanced_tree(arity, height)
  # find the root
  root = 0
  assert tree.degree(root) == arity
  return root,tree

# four should burn
# returns start, networkx graph
def generate_ladder_instance():
  height = 20
  ladder = nx.ladder_graph(height)
  return int(height/2), ladder


def run_trial(graph, start, timeout=5000):
   ilp_result = submitted_solution.run_ilp(graph, start_node=start, timeout=timeout)
   cp_result = submitted_solution.run_cp(graph, start_node=start, timeout=timeout)
   return cp_result['num_saved'], ilp_result['num_saved']

def skeleton_runs():
   runs_results = {}
# I'll have a variety of instances, here are a few toy ones
   graph = nx.path_graph(12)
   cp, ilp = run_trial(graph, start = 5)
   runs_results['path_start_mid'] = {'cp': cp, 'ilp': ilp}

# in a complete graph all but one vertex should burn
   graph = nx.complete_graph(12)
   cp, ilp = run_trial(graph, start = 0)
   runs_results['complete'] = {'cp': cp, 'ilp': ilp}

   
   graph = nx.grid_2d_graph(10,10)
   cp, ilp = run_trial(graph, start = (4, 5))
   runs_results['grid'] = {'cp': cp, 'ilp': ilp}

   return runs_results
   
   
   
print(skeleton_runs())

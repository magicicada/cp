import time
import networkx as nx
import submitted_solution



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

   graph = nx.complete_graph(12)
   cp, ilp = run_trial(graph, start = 0)
   runs_results['complete'] = {'cp': cp, 'ilp': ilp}

   
   graph = nx.grid_2d_graph(10,10)
   cp, ilp = run_trial(graph, start = (4, 5))
   runs_results['grid'] = {'cp': cp, 'ilp': ilp}

   return runs_results
   
   
   
print(skeleton_runs())

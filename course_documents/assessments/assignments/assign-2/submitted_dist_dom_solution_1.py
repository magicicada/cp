import random
import networkx as nx
import ortools
from ortools.linear_solver import pywraplp

# THIS FILE IS WHERE STUDENTS SHOULD DO THEIR WORK
# This function should run your ILP implementation
# for distance dominating set 
# - instance_graph will be a networkx graph object
# - distance is the distance over which vertices can dominate
# - timeout is the maximum time in ms you should let the search run for
# The function should return a dictionary that has 'dom_set' mapped to 
# a list with the vertex names (as they are in instance_graph)
# that are chosen by your solution
# or None if the model does not halt in the time allowed
# (The dictionary structure is so you can return other things if it's 
# useful for your debugging)
def run_ilp(instance_graph, distance = 1, timeout=1000):
  #  in here you can modify the graph to get whatever format you need, implement your ILP, call your solver
  #  and then translate the result back into a set of nodes from instance_graph   
  model = pywraplp.Solver.CreateSolver("SCIP")
  if not model:
    raise Exception("SCIP solver not available on this system.")

  model.SetTimeLimit(timeout)

  # collect graph's nodes
  nodes = list(instance_graph.nodes())

  # decision variables: whether each node is in the dominating set
  x = {}
  for v in nodes:
    x[v] = model.BoolVar('x_%s' % str(v))

  # precompute shortest-path distances - build a plain dict-of-dicts: dist[u][v] = length of shortest path from u to v
  nx_dist_source_view = nx.all_pairs_shortest_path_length(instance_graph)
  dist = {}
  for (u, lengths_from_u) in nx_dist_source_view:
    dist[u] = {}
    for v, d_uv in lengths_from_u.items():
      dist[u][v] = d_uv

  # constraints
  VERY_LARGE_NUMBER = 10000000000

  for v in nodes:
    #build list of variables that can dominate v within k distance
    dominating_vars_for_v = []
    for u in nodes:
      #get distance (u, v)
      if u in dist and v in dist[u]:
        d_uv = dist[u][v]
      else:
        d_uv = VERY_LARGE_NUMBER

      if d_uv <= distance:
        dominating_vars_for_v.append(x[u])

    #if the list is empty this will be an infeasible model
    model.Add(model.Sum(dominating_vars_for_v) >= 1)

  #objective function
  model.Minimize(model.Sum(x[v] for v in nodes))
  
  #solve
  status = model.Solve()
  
  if status == pywraplp.Solver.NOT_SOLVED:
      # None if the model does not halt in the time allowed
      return None

  if status == pywraplp.Solver.INFEASIBLE:
      # No feasible solution (shouldn’t happen for k >= 0 on typical inputs)
      return {'dom_set': []}

  # OPTIMAL or FEASIBLE solution - collect chosen vertices
  dom_set = []
  for v in nodes:
    if x[v].solution_value() > 0.5:
      dom_set.append(v)

  return {'dom_set': dom_set}
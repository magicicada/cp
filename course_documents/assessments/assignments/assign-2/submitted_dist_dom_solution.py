import random
import networkx as nx
import ortools

# THIS FILE IS WHERE STUDENTS SHOULD DO THEIR WORK


#
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
  
  #  This is obviously not a solution, but just me choosing a single vertex from the graph
    dom_set = [list(instance_graph.nodes())[0]]
    
    return {'dom_set': dom_set}

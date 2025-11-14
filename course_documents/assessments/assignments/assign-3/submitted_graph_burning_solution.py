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
# The function should return a dictionary that has 'burn_seq' mapped to 
# a list of vertices in order that your solution sets fires on them. 
# or None if the model does not halt in the time allowed
# That is: if your solution sets fires at vertex "a", then "b", then "c" and that ends the process, then 
# the dicitonary you return should include 'burn_seq': ["a", "b, "c"]
# It is possible you will want your model to have a different decision structure: you are
# welcome to compute in that structure and then translate. 
# (The dictionary structure is so you can return other things if it's 
# useful for your debugging)
def run_ilp(instance_graph, timeout=1000):
  #  in here you can modify the graph to get whatever format you need, implement your ILP, call your solver
  #  and then translate the result back into a set of nodes from instance_graph   
  
  #  This is obviously not a solution, but just me choosing a single vertex from the graph
    burn_list = [list(instance_graph.nodes())[0]]
    
    return {'burn_seq': burn_list}

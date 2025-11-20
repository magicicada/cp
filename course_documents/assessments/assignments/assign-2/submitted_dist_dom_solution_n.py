import random
import networkx as nx
import ortools
from ortools.linear_solver import pywraplp


def run_ilp(instance_graph, distance=1, timeout=1000):


    model = pywraplp.Solver.CreateSolver("SCIP")
    model.EnableOutput()


    n = len(instance_graph.nodes())

    # Variable: Map S of Node -> bool where S[n: Node] = True iff n \in k-dominating set.
    S = {}
    for node in instance_graph.nodes():
        S[node] = model.BoolVar(
            f"node({node})"
        ) 

    distances = dict(nx.all_pairs_shortest_path_length(instance_graph))

    # Constraint time baybee
    for node in instance_graph.nodes():
        # forall nodes node...
        # node in S
        a_condition = S[node]
        # exists m in S s.t. distance(node, m) <= k
        b_condition = [
            S[m] for m in instance_graph.nodes if distances[m][node] <= distance
        ]
        # node in S or exists m in S s.t. distance(node, m) <= k
        model.Add(sum(b_condition + [a_condition]) >= 1)

    # Solve minimize
    model.Minimize(model.Sum(S.values()))
    model.Solve()

    dom_set = [node for node in instance_graph.nodes if S[node].solution_value()]

    return {"dom_set": dom_set}

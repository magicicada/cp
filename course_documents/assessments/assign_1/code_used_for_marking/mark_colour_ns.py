import sys

def everyone_has_colour(sol_d, edge_list):
    for guy in edge_list:
      if guy not in sol_d:
        return False

    return True

def antigonish(sol_d):
    return sol_d['Antigonish'] == 3


def valid_colouring(sol_d, edge_list):
    for source in edge_list:
       for dest in edge_list[source]:
          if sol_d[dest] == sol_d[source]:
             return False
    return True


def max_num_colours(sol_d):
    return max(list(sol_d.values())) <= 4



def read_out():
   read_sol = {}
   input_stream = sys.stdin
   for line in input_stream:
      if not line.startswith("-") and not line.startswith("="):
        split = line.strip().split()
        read_sol[split[0]] = int(split[2].split(";")[0])
   return read_sol

def mark_mzn_output(verbose = False):
   edge_list = {}
   edge_list['Shelburne'] = ['Yarmouth', "Queens"]
   edge_list['Yarmouth'] = ['Shelburne', 'Digby']
   edge_list['Digby'] = ['Yarmouth', 'Queens', 'Annapolis']
   edge_list['Queens'] = ['Shelburne', 'Digby', 'Annapolis', 'Lunenburg']
   edge_list['Annapolis'] = ['Digby', 'Queens', 'Lunenburg', 'Kings']
   edge_list['Lunenburg'] = ['Queens', 'Annapolis', 'Kings', 'Hants', 'Halifax']
   edge_list['Kings'] = ['Annapolis', 'Lunenburg', 'Hants']
   edge_list['Hants'] = ['Kings', 'Lunenburg', 'Halifax', 'Colchester']
   edge_list['Halifax'] = ['Lunenburg', 'Hants', 'Colchester', 'Guysborough']
   edge_list['Colchester'] = ['Cumberland', 'Hants', 'Halifax', 'Pictou']
   edge_list['Cumberland'] = ['Colchester']
   edge_list['Pictou'] = ['Colchester', 'Guysborough', 'Antigonish']
   edge_list['Guysborough'] = ['Halifax', 'Pictou', 'Antigonish', 'Richmond']
   edge_list['Antigonish'] = ['Pictou', 'Guysborough', 'Inverness']
   edge_list['Inverness'] = ['Antigonish', 'Guysborough', 'Richmond', 'Victoria']
   edge_list['Richmond'] = ['Guysborough', 'Inverness', 'Cape-Breton']
   edge_list['Victoria'] = ['Inverness', 'Cape-Breton']
   edge_list['Cape-Breton'] = ['Victoria', 'Richmond']
   
   student_sol = read_out()
   fix_CB = {}
   for guy in student_sol:
      if guy == 'Cape_Breton':
          fix_CB['Cape-Breton'] = student_sol['Cape_Breton'] 
      else:
          fix_CB[guy] = student_sol[guy]
   student_sol = fix_CB
   
   
   max_marks = 8
   marks = 0
   if everyone_has_colour(student_sol, edge_list):
      marks = marks + 1
      if verbose:
         print('everyone has a colour: 1 of 1 marks')
   elif verbose:
         print('someone has no colour: 0 of 1 marks')
   
   if antigonish(student_sol):
      marks = marks + 1
      if verbose:
         print('Antigonish has the required colour: 1 of 1 marks')
   elif verbose:
         print('Antigonish  DOES NOT have the required colour: 0 of 1 marks')
      
   if max_num_colours(student_sol):
      marks = marks+1
      if verbose:
         print('you\'ve not exceeded 4 colours: 1 of 1 marks')
   elif verbose:
         print('You have exceeded 4 colours: 0 of 1 marks')
   
   if valid_colouring(student_sol, edge_list):
      marks = marks + 3
      if verbose:
         print('you have a valid colouring: 3 of 3 marks')
   elif verbose:
         print('your colouring is not valid: 0 of 3 marks')
   
   if verbose:
      print('Total marks for colouring NS: ' + str(marks))
   else:
      print(marks)
mark_mzn_output(verbose = False)

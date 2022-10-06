import sys

def everyone_has_colour(sol_d, edge_list):
    for guy in edge_list:
      if guy not in sol_d:
        return False

    return True

def pe_and_yt(sol_d):
    return sol_d['PE'] == 3 and sol_d['YT'] == 1


def valid_colouring(sol_d, edge_list):
    for source in edge_list:
       for dest in edge_list[source]:
          if sol_d[dest] == sol_d[source]:
             return False
    return True


def max_num_colours(sol_d):
    return max(list(sol_d.values())) <= 3



def read_out():
   read_sol = {}
   input_stream = sys.stdin
   for line in input_stream:
      if not line.startswith("-"):
        split = line.strip().split()
        read_sol[split[0]] = int(split[2].split(";")[0])
   return read_sol

def mark_mzn_output(verbose = False):
   edge_list = {}
   edge_list['YT'] = ['BC', "NT"]
   edge_list['NT'] = ['BC', 'AB', 'SK', 'NU']
   edge_list['NU'] = ['MB', 'ON', 'QC', 'NL']
   edge_list['BC']  = ['AB']
   edge_list['AB'] = ['NT', 'SK']
   edge_list['SK'] = ['MB']
   edge_list['MB'] = ['ON']
   edge_list['ON'] = ['QC']
   edge_list['QC'] = ['NB', 'NL']
   edge_list['NB'] = ['NS']
   edge_list['PE'] = ['QC', 'NL', 'NB', 'NS']
   
   student_sol = read_out()
   
   max_marks = 8
   marks = 0
   if everyone_has_colour(student_sol, edge_list):
      marks = marks + 1
      if verbose:
         print('everyone has a colour: 1 of 1 marks')
   elif verbose:
         print('someone has no colour: 0 of 1 marks')
   
   if pe_and_yt(student_sol):
      marks = marks + 1
      if verbose:
         print('PE and YT have the required colours: 1 of 1 marks')
   elif verbose:
         print('PE and/or YT DO NOT have the required colours: 0 of 1 marks')
      
   if max_num_colours(student_sol):
      marks = marks+1
      if verbose:
         print('you\'ve not exceeded 3 colours: 1 of 1 marks')
   elif verbose:
         print('You have exceeded 3 colours: 0 of 1 marks')
   
   if valid_colouring(student_sol, edge_list):
      marks = marks + 3
      if verbose:
         print('you have a valid colouring: 3 of 3 marks')
   elif verbose:
         print('your colouring is not valid: 0 of 3 marks')
   
   if verbose:
      print('Total marks for colouring Canada: ' + str(marks))
   else:
      print(marks)
mark_mzn_output(verbose = True)
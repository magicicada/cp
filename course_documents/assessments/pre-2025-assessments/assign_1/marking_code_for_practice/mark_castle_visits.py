import sys

def intervals_valid(start, end):
  for i in range(len(start)):
    if start[i] >= end[i]:
      return False
  return True

def max_time_respected(dict_in, end, max_time = 30):
  return max(end) <= max_time

def everyone_has_time(dict_in, start, end):
   return len(start) == len(end) and len(start) == dict_in['n']
  
def all_arrivals_different(start):
  return len(list(set(start))) == len(start)
    
def all_departures_different(end):
  return len(list(set(end))) == len(end)

def check_overlap(i, j, start, end):
  # case iji   
  if start[i] <= start[j] and start[j] < end[i]:
    return True
#  case jij
  if start[j] <= start[i] and start[i] < end[j]:
    return True
  return False
  
def meet_that_should(dict_in, start, end):
  for ind in range(len(dict_in['from'])):
    i = dict_in['from'][ind] -1
    j = dict_in['to'][ind] -1
    if not check_overlap(i, j, start, end):
      print(str(i+1) + " and " + str(j+1) + "don't meet")
      return False
  return True

def dont_meet_shouldnt(dict_in, start, end):
  for ind in range(len(dict_in['no_from'])):
    i = dict_in['no_from'][ind] -1
    j = dict_in['no_to'][ind] -1
    if check_overlap(i, j, start, end):
      return False
  return True

def read_input_file(filename):
  dict_input = {}
  integer_vals = ['n', 'm', 'no_m']
  list_vals = ['from', 'to', 'no_from', 'no_to']
  for line in open(filename, 'r'):
    first_token = line.strip().split()[0]
    if first_token in integer_vals:
      dict_input[first_token] = read_int_mzn(line)
    elif first_token in list_vals:
      dict_input[first_token] = read_int_list_mzn(line)
  return dict_input

def read_int_mzn(s):
  split = s.strip().split()
  return int(split[2].replace(";", ""))

def read_int_list_mzn(s):
  split = s.strip().split("[")[1].split("]")
  split = split[0].split(",")
  return list(map(int, split))

def read_student_sol():
   start_time = []
   end_time = []
   input_stream = sys.stdin
   for line in input_stream:
      if line.startswith("start_time"):
         start_time = read_int_list_mzn(line)
      elif line.startswith('end_time'):
        end_time = read_int_list_mzn(line)
        
   return start_time,end_time
  


def do_testing(verbose = False):
  start,end = read_student_sol()
  dict_in = read_input_file(sys.argv[1])
  solution_max_time = int(sys.argv[2])
  
  print(start)
  print(end)
  
  marks = 0
  max_marks = 9
  if intervals_valid(start, end)and everyone_has_time(dict_in, start, end):
    marks = marks + 1
    if(verbose):
      print('GOOD: intervals are individually valid -  1 mark of 1')
  elif verbose:
    print("BAD: The intervals are not individually valid intervals - 0 marks of 1")

  if max_time_respected(dict_in, end, solution_max_time):
    marks = marks + 1
    if(verbose):
      print('GOOD: maximum time respected -  1 mark of 1')
  elif verbose:
      print("BAD: Your solution exceeds the time that a lecturer solution found, it may not be minimizing correctly - 0 marks of 1")
  
  if all_arrivals_different(start) and all_departures_different(end):
    marks = marks +1
    if(verbose):
      print('GOOD: all arrivals different, all departures different -  1 mark of 1')
  elif verbose:
      print("BAD: Either not all your arrivals are different or not all your departures are different, or both - 0 marks of 1")
  
  if meet_that_should(dict_in, start, end):
    marks = marks + 3
    if(verbose):
      print('GOOD: Everyone who should meet does - 3 marks of 3')
  elif verbose:
      print("BAD: Some pair who ought to meet does not 0  marks of 3")

  if dont_meet_shouldnt(dict_in, start, end):
     marks = marks + 3
     if(verbose):
        print('GOOD: Everyone who should not meet does not - 3 marks of 3')
  elif verbose:
      print("BAD: Some pair who ought not to meet does meet - 0 marks of 3")
  
  if verbose:
    print("Total:  " + str(marks) + " of a possible " + str(max_marks))
  return marks
  
print(do_testing(verbose = True))


# #  This is example marking code for a typical instance - for some (eg edge or unsatisfiable) instances I test with, not all marks will be available.

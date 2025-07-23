#=========================#
#  module                 # 
#=========================#
import re
import numpy as np

#=========================#
#  read binary files      # 
#=========================#
def binary_files(file_name, dim_1, dim_2):
    endian = '>'                                     # output have big-endian
    file  = open(file_name, 'rb')                    # open
    array = np.fromfile(file, dtype=endian+'f8')     # read
    array = array.reshape((dim_1, dim_2), order='F') # reshape
    file.close()
    return (array)

#=========================#
#  read variables         # 
#=========================#
def read_variables(variable_path):
    file = open(variable_path , 'r') # open
    list = file .readlines()         # read
    file.close()                     # close

    for i in range(len(list)):
        list[i] = list[i].rstrip('\n')         # remove '\n'
        list[i] = list[i].replace(' ', '')     # remove space

        if (re.search(r'\.', list[i]) == None): # float or int ?
            list[i] = int(list[i])             # int
        else:
            list[i] = float(list[i])           # float

    return(list)

# END #
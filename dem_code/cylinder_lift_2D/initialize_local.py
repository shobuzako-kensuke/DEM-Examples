#=========================#
#  module                 #
#=========================#
import glob
import os
import shutil
#=========================#
#  settings               #
#=========================#
path_output  = []
path_fig     = []
path_mod     = []
path_o       = []
path_pycache = []
path_exe     = []
#=========================#
#  PATH                   #
#=========================#
ans = input('Initialize this directory ? [y/n]: ')
if (ans == 'yes' or ans == 'y'):
    path_output  += glob.glob('./output')
    path_fig     += glob.glob('./fig')
    path_mod     += glob.glob('./source_code/*.mod')
    path_o       += glob.glob('./source_code/*.o'  )
    path_pycache += glob.glob('./source_code/__pycache__')
    path_exe     += glob.glob('./source_code/start_calculation')

path_all = path_output + path_fig + path_mod + path_o + path_pycache + path_exe
#=========================#
#  remove                 #
#=========================#
for i in path_all:

    # directory
    if os.path.isdir(i):
        shutil.rmtree(i)  # remove directory recursively

    # file
    if os.path.isfile(i):
        os.remove(i)      # remove file
            
# END #
#=========================#
#  file name              # 
#=========================#
save_name     = 'test'
analysis_step = 'n'  # if specifying analysis step, input file ID

#=========================#
#  program switch         # 
#=========================#
fig_ini = True    # initial settings
fig_position_only = False   # position only
fig_vel_u_cmap    = False  # colored in terms of velocity u
fig_vel_v_cmap    = True   # colored in terms of velocity v
fig_ang_vel_cmap  = False  # colored in terms of angular velocity
#=========================#
#  scatter size           # 
#=========================#
mark_size = 10
val_min   = -0.1  # for color bar
val_max   = +0.1

#==============================================================================#
#=========================== NOT CHANGE BELOW =================================#
#==============================================================================#

#=========================#
#  module                 # 
#=========================#
import os
import numpy as np
import time
import math
import ana_read_fortran as read_f90
import ana_initial_setting as ini
import ana_snapshot_movie as snap_movie

start_time = time.perf_counter() # cpu time
print('+ -------------------------------------------------------- +')

#=========================#
#  read variables         # 
#=========================#
parent_path   = '../output/{}'.format(save_name)                    # path of the saved data
variable_path = parent_path + '/system_info/system_info_VALUES.dat' # file path

Nx, Ny, N, D, m, I, dt, start_step, end_step, write_step, total_step, \
R, k, e, rho, mu_s, mu_r, mu_w, g, Lx, Ly, W, H, v_lift \
= read_f90.read_variables(variable_path) # read

#=========================#
#  count                  # 
#=========================#
N_file = 0
if (analysis_step == 'n'):
    last = end_step + 1 # including initial conditions
else:
    last = analysis_step + 1

for i in range(0, last, write_step):
    file_path = parent_path + '/data/{}/x.dat'.format(i)
    if os.path.exists(file_path): # if file exists
        N_file += 1               # number of the saved files
        last_file = i             # save last file name
    else:
        break                     # if file does not exist, break
print('[message] number of read files: {}'.format(N_file))
print('+ -------------------------------------------------------- +')
#==============================================================================#
#                            main program below                                #
#==============================================================================#

#=========================#
#  initial conditions     # 
#=========================#
if fig_ini:
    print('[message] fig_ini has started')
    save_path = '../fig/{}'.format(save_name)
    os.makedirs(save_path, exist_ok=True) # mkdir
    ini.main(N, Lx, Ly, W, v_lift, mark_size, parent_path, save_path)
    print('[message] fig_ini has finished')
    print('+ -------------------------------------------------------- +')

#=========================#
#  exe_snapshots          # 
#=========================#
if fig_position_only:
    print('[message] Snapshots for only position are being made')
    snap_movie.position_only(last_file, write_step, N_file, dt, N, Lx, Ly, W, v_lift, mark_size, parent_path, save_name)

if fig_vel_u_cmap:
    print('[message] Snapshots for velocity u are being made')
    tmp_name = 'u'
    snap_movie.fig_cmap(tmp_name, last_file, write_step, N_file, dt, N, Lx, Ly, W, v_lift, mark_size, val_min, val_max, parent_path, save_name)
    
if fig_vel_v_cmap:
    print('[message] Snapshots for velocity v are being made')
    tmp_name = 'v'
    snap_movie.fig_cmap(tmp_name, last_file, write_step, N_file, dt, N, Lx, Ly, W, v_lift, mark_size, val_min, val_max, parent_path, save_name)

if fig_ang_vel_cmap:
    print('[message] Snapshots for angular velocity are being made')
    tmp_name = 'o'
    snap_movie.fig_cmap(tmp_name, last_file, write_step, N_file, dt, N, Lx, Ly, W, v_lift, mark_size, val_min, val_max, parent_path, save_name)

print('+ -------------------------------------------------------- +')
end_time = time.perf_counter()  # cpu time
print('[message] program has finished: {:.2f} [s]'.format(end_time - start_time))
print('')

# END #
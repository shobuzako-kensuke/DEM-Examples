#=========================#
#  file name              #
#=========================#
save_name = 'test'
#=========================#
#  program switch         #
#=========================#
fig_ini = True   # figures for initial settings
fig_pos = True   # snapshots of position
fig_u   = False  # snapshots of velocity u
fig_v   = True   # snapshots of velocity v
fig_o   = False  # snapshots of angular velocity o
#=========================#
#  scatter size           #
#=========================#
mark_size = 10
val_min   = -0.1  # minimum for color bar
val_max   = +0.1  # maximum for color bar

#==============================================================================#
#=========================== NOT CHANGE BELOW =================================#
#==============================================================================#

#=========================#
#  module                 #
#=========================#
import os
import time
import ana_read_fortran as read_f90
import ana_initial_setting as ini
import ana_snapshot_movie as snap_movie

start_time = time.perf_counter()
print('+ -------------------------------------------------------- +')

#=========================#
#  read variables         #
#=========================#
parent_path   = '../output/{}'.format(save_name)                     # path to the saved data
variable_path = parent_path + '/system_info/system_info_VALUES.dat'  # file path
 
Nx, Ny, N, D, m, I, dt, total_step, write_step, \
R, k, e, eta, rho, mu_s, mu_r, mu_w, \
g, Lx, Ly, W, H, v_lift, U_threshold \
= read_f90.read_variables(variable_path)

#=========================#
#  file count             #
#=========================#
N_file = 0
for i in range(0, total_step+1, write_step):
    file_path = parent_path + '/data/{}/x.dat'.format(i)
    if os.path.exists(file_path):  # if file exists
        N_file += 1                # number of the saved files
        last_file = i              # save last file name
    else:
        break                      # if file does not exist, break
print('[message] Number of read files: {}'.format(N_file))
print('+ -------------------------------------------------------- +')
#==============================================================================#
#                            main program below                                #
#==============================================================================#

#=========================#
#  initial settings       #
#=========================#
if fig_ini:
    print('[message] Figures for initial settings are being made.')
    save_path = '../fig/{}'.format(save_name)
    os.makedirs(save_path, exist_ok=True)
    ini.main(N, Lx, Ly, W, v_lift, mark_size, parent_path, save_path)
    print('[message] Figures for initial settings have been made.')
    print('+ -------------------------------------------------------- +')

#=========================#
#  exe_snapshots          #
#=========================#
if fig_pos:
    print('[message] Snapshots of position are being made.')
    snap_movie.position(last_file, write_step, N_file, dt, N, Lx, Ly, W, mark_size, parent_path, save_name)

if fig_u:
    print('[message] Snapshots of velocity u are being made.')
    tmp_name = 'u'
    snap_movie.fig_cmap(tmp_name, last_file, write_step, N_file, dt, N, Lx, Ly, W, mark_size, val_min, val_max, parent_path, save_name)
    
if fig_v:
    print('[message] Snapshots of velocity v are being made.')
    tmp_name = 'v'
    snap_movie.fig_cmap(tmp_name, last_file, write_step, N_file, dt, N, Lx, Ly, W, mark_size, val_min, val_max, parent_path, save_name)

if fig_o:
    print('[message] Snapshots of angular velocity o are being made.')
    tmp_name = 'o'
    snap_movie.fig_cmap(tmp_name, last_file, write_step, N_file, dt, N, Lx, Ly, W, mark_size, val_min, val_max, parent_path, save_name)

print('+ -------------------------------------------------------- +')
end_time = time.perf_counter()
print('[message] Program has finished: {:.2f} [s]'.format(end_time - start_time))
print('')

# END #
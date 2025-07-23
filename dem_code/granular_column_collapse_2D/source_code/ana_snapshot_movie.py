#=========================#
#  module                 # 
#=========================#
import os
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import math
import ana_read_fortran as read_f90
import ana_mk_movie as mk_movie
plt.rcParams['mathtext.fontset'] = 'cm' # mathfont for figure

#=========================#
#  position_only          # 
#=========================#
def position_only(last_file, write_step, N_file, dt, N, Lx, Ly, W, v_lift, mark_size, parent_path, save_name):
    save_path = '../fig/{}/snapshot_position'.format(save_name)
    os.makedirs(save_path, exist_ok=True)
    #=========================#
    #  make snapshots         # 
    #=========================#
    count = 0
    for i in range(0, last_file+1, write_step):
        count += 1
        time = dt * float(i)  # simulation time
        #=========================#
        #  read                   # 
        #=========================#   
        file_name = parent_path + '/data/{}/x.dat'.format(i)
        x = read_f90.binary_files(file_name, 2, N)

        file_name = parent_path + '/data/{}/gate_height.dat'.format(i)
        gate_height = read_f90.binary_files(file_name, 1, 1)
        #=========================#
        #  figure                 # 
        #=========================#   
        fig = plt.figure(figsize=(7,7), facecolor='white')
        plt.subplots_adjust(left=0.18, right=0.95, bottom=0.18, top=0.90, wspace=0.35, hspace=0.4)
        
        ax = fig.add_subplot(111, facecolor='white')
        ax.scatter(x[0,:], x[1,:], c='dimgray', ec='none', marker='.', s=mark_size)
        ax.plot([W, W], [gate_height[0,0], Ly], c='k', linewidth=1.0)

        # axis label
        ax.set_xlabel(r'$x~[\mathrm{m}]$', fontsize=20, labelpad=10)
        ax.set_ylabel(r'$y~[\mathrm{m}]$', fontsize=20, labelpad=16)
        
        # lim
        ax.set_xlim(0, Lx)
        ax.set_ylim(0, Ly)
        #ax.axis('equal')

        # ticks
        ax.tick_params(axis='both', which='major', direction='out', length=4, width=1, labelsize=14)
        ax.minorticks_off()

        # grid
        ax.grid(which='major', color='none', linewidth=0.5)
        ax.set_axisbelow(True) # grid back

        # title
        ax.set_title('{:3.2e} [s]  ({} step)'.format(time, i), c='k', y=1.02, fontsize=14)

        # save
        fig.savefig('../fig/{}/snapshot_position/{}.png'.format(save_name, i), format='png', dpi=300, transparent=False)
        plt.close()
        #=========================#
        #  progress               # 
        #=========================#
        if (i==0):
            print('          >> {:.2f} %'  .format(float(count)/float(N_file)*100), end='')
        else:
            print('\r          >> {:.2f} %'.format(float(count)/float(N_file)*100), end='')

    #=========================#
    #  make movie             #
    #=========================#
    print('')
    print('          Movie is being made ... ', end='', flush=True)
    mk_movie.func_animation(last_file, write_step, save_name, 'position')
    print('finish')



#=========================#
#  fig_cmap               # 
#=========================#
def fig_cmap(tmp_name, last_file, write_step, N_file, dt, N, Lx, Ly, W, v_lift, mark_size, val_min, val_max, parent_path, save_name):
    save_path = '../fig/{}/snapshot_{}'.format(save_name, tmp_name)
    os.makedirs(save_path, exist_ok=True)
    #=========================#
    #  make snapshots         # 
    #=========================#
    count = 0
    for i in range(0, last_file+1, write_step):
        count += 1
        #=========================#
        #  read                   # 
        #=========================#   
        time  = dt * float(i)  # simulation time

        file_name = parent_path + '/data/{}/x.dat'.format(i)
        x = read_f90.binary_files(file_name, 2, N)

        file_name = parent_path + '/data/{}/gate_height.dat'.format(i)
        gate_height = read_f90.binary_files(file_name, 1, 1)

        if ((tmp_name == 'u') or (tmp_name == 'v')):
            file_name = parent_path + '/data/{}/u.dat'.format(i)
            u = read_f90.binary_files(file_name, 2, N)

        if (tmp_name == 'o'):
            file_name = parent_path + '/data/{}/o.dat'.format(i)
            o = read_f90.binary_files(file_name, 1, N)

        #=========================#
        #  figure                 # 
        #=========================#   
        fig = plt.figure(figsize=(7.5,6), facecolor='white')
        plt.subplots_adjust(left=0.18, right=0.9, bottom=0.18, top=0.90, wspace=0.35, hspace=0.4)
        
        ax = fig.add_subplot(111, facecolor='white')
        ax.plot([W, W], [gate_height[0,0], Ly], c='k', linewidth=1.0)

        if (tmp_name == 'u'):
            cfig = ax.scatter(x[0,:], x[1,:], c=u[0,:], ec='k', marker='.', \
                              cmap='bwr', s=mark_size, linewidth=0.1, vmin=val_min, vmax=val_max)
            cbar = plt.colorbar(cfig, aspect=30, shrink=0.9, ax=ax, orientation='vertical', pad=0.05, location='right')
            cbar.set_label(r'$u~[\mathrm{m/s}]$', fontsize=18, labelpad=15)

        
        if (tmp_name == 'v'):
            cfig = ax.scatter(x[0,:], x[1,:], c=u[1,:], ec='k', marker='.', \
                              cmap='bwr', s=mark_size, linewidth=0.1, vmin=val_min, vmax=val_max)
            cbar = plt.colorbar(cfig, aspect=30, shrink=0.9, ax=ax, orientation='vertical', pad=0.05, location='right')
            cbar.set_label(r'$v~[\mathrm{m/s}]$', fontsize=18, labelpad=15)

        if (tmp_name == 'o'):
            cfig = ax.scatter(x[0,:], x[1,:], c=o[0,:], ec='k', marker='.', \
                              cmap='bwr', s=mark_size, linewidth=0.1, vmin=val_min, vmax=val_max)
            cbar = plt.colorbar(cfig, aspect=30, shrink=0.9, ax=ax, orientation='vertical', pad=0.05, location='right')
            cbar.set_label(r'$\omega~[\mathrm{rad/s}]$', fontsize=18, labelpad=15)
            
        # color bar
        cbar.ax.tick_params(direction='out', length=4, width=1, labelsize=14)
        cbar.ax.set_ylim(val_min, val_max)

        # axis label
        ax.set_xlabel(r'$x~[\mathrm{m}]$', fontsize=20, labelpad=10)
        ax.set_ylabel(r'$y~[\mathrm{m}]$', fontsize=20, labelpad=16)
        
        # lim
        ax.set_xlim(0, Lx)
        ax.set_ylim(0, Ly)
        #ax.axis('equal')

        # ticks
        ax.tick_params(axis='both', which='major', direction='out', length=4, width=1, labelsize=14)
        ax.minorticks_off()

        # grid
        ax.grid(which='major', color='none', linewidth=0.5)
        ax.set_axisbelow(True) # grid back

        # title
        ax.set_title('{:3.2e} [s]  ({} step)'.format(time, i), c='k', y=1.02, fontsize=14)

        # save
        fig.savefig('../fig/{}/snapshot_{}/{}.png'.format(save_name, tmp_name, i), format='png', dpi=300, transparent=False)
        plt.close()
        #=========================#
        #  progress               # 
        #=========================#
        if (i==0):
            print('          >> {:.2f} %'  .format(float(count)/float(N_file)*100), end='')
        else:
            print('\r          >> {:.2f} %'.format(float(count)/float(N_file)*100), end='')

    #=========================#
    #  make movie             #
    #=========================#
    print('')
    print('          Movie is being made ... ', end='', flush=True)
    mk_movie.func_animation(last_file, write_step, save_name, tmp_name)
    print('finish')


    
# END #
#=========================#
#  module                 #
#=========================#
import numpy as np
import matplotlib.pyplot as plt
import ana_read_fortran as read_f90
plt.rcParams['mathtext.fontset'] = 'cm' # mathfont for figure

#=========================#
#  main                   #
#=========================#
def main(N, Lx, Ly, W, v_lift, mark_size, parent_path, save_path):

    #=========================#
    #  read                   #
    #=========================#
    file_name = parent_path + '/data/0/x.dat'
    x = read_f90.binary_files(file_name, 2, N)

    file_name = parent_path + '/data/0/gate_height.dat'
    gate_height = read_f90.binary_files(file_name, 1, 1)

    file_name = parent_path + '/cell/initial_cell.dat'
    cell = read_f90.binary_files(file_name, N, 1)
    cell = cell.astype(np.int64)  # float >> int
    
    #=========================#
    #  figure                 #
    #=========================#
    fig = plt.figure(figsize=(12,5.5), facecolor='white')
    plt.subplots_adjust(left=0.1, right=0.9, bottom=0.18, top=0.95, wspace=0.35, hspace=0.4)

    ax1 = fig.add_subplot(121, facecolor='white')
    ax2 = fig.add_subplot(122, facecolor='white')

    ax1.scatter(x[0,:], x[1,:], c='dimgray', ec='none', marker='.', s=mark_size)
    cfig = ax2.scatter(x[0,:], x[1,:], c=cell, cmap='jet', ec='none', \
                       vmin=cell.min(), vmax=cell.max(), marker='.', s=mark_size)
    
    ax1.plot([W, W], [gate_height[0,0], Ly], c='k', linewidth=1.0)
    ax2.plot([W, W], [gate_height[0,0], Ly], c='k', linewidth=1.0)

    ax1.text(1.1*W, 0.8*Ly, '↑ v_lift = {:.2f}'.format(v_lift), fontsize=14)

    # color bar
    cbar = plt.colorbar(cfig, aspect=30, shrink=0.9, ax=ax2, orientation='vertical', pad=0.05, location='right')
    cbar.ax.tick_params(direction='out', length=4, width=1, labelsize=14)
    cbar.set_label('cell number', fontsize=16, labelpad=10)

    # axis label
    ax1.set_xlabel(r'$x~[\mathrm{m}]$', fontsize=24, labelpad=10)
    ax1.set_ylabel(r'$y~[\mathrm{m}]$', fontsize=24, labelpad=16)
    ax2.set_xlabel(r'$x~[\mathrm{m}]$', fontsize=24, labelpad=10)
    ax2.set_ylabel(r'$y~[\mathrm{m}]$', fontsize=24, labelpad=16)

    # lim
    ax1.set_xlim(0, Lx)
    ax1.set_ylim(0, Lx)
    ax2.set_xlim(0, Ly)
    ax2.set_ylim(0, Ly)
        
    # ticks
    ax1.tick_params(axis='both', which='major', direction='out', length=4, width=1, labelsize=14)
    ax1.minorticks_off()
    ax2.tick_params(axis='both', which='major', direction='out', length=4, width=1, labelsize=14)
    ax2.minorticks_off()
    
    # grid
    ax1.grid(which='major', color='none', linewidth=0.5)
    ax1.set_axisbelow(True) # grid back
    ax2.grid(which='major', color='none', linewidth=0.5)
    ax2.set_axisbelow(True)

    # save
    fig.savefig('{}/initial_setting.png'.format(save_path), format='png', dpi=600, transparent=False)
    plt.close()
    
# END #
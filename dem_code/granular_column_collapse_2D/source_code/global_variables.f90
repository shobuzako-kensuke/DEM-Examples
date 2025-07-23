module global_variables
    implicit none
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!
    !                             global variables                             ! 
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!
    !  set_system.f90
    integer, save :: total_step, Nx, Ny, N, N_you  ! fundamental info
    real(8), save :: D, m, I, dt, eta              ! fundamental info

    !  set_background_cell.f90
    integer, save :: cell_x_max, cell_y_max, cell_max

    !  main.f90
    integer, save :: step, gate_switch
    real(8), save :: start_time, tmp_time, U_max, gate_height(1,1)


    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!
    !                              global arrays                               ! 
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!
    !  set_system.f90
    real(8), allocatable, save :: x(:,:), u(:,:), o(:,:)
    real(8), allocatable, save :: cumulative_delta(:,:,:)
    integer, allocatable, save :: cumulative_name(:,:)

    !  set_background_cell.f90
    integer, allocatable, save :: cell(:), cell_9(:,:), N_cell(:), cell_info(:,:)

    contains
    !=========================!
    !  subroutine deallocate  ! 
    !=========================!
    subroutine deallocate_array
        deallocate(x, u, o, cumulative_delta, cumulative_name)
        deallocate(cell, cell_9, N_cell, cell_info)
    end subroutine deallocate_array

end module global_variables

! END !
subroutine out_system_info
    !=========================!
    !  module                 !
    !=========================!
    use input
    use global_variables
    use lib_file_operations

    !=========================!
    !  local variables        ! 
    !=========================!
    implicit none
    character(len=999) :: path_name, file_name

    !=========================!
    !  mkdir                  ! 
    !=========================!
    path_name = '../output/'//trim(adjustl(save_name))//'/system_info/'
    call mkdir(trim(adjustl(path_name)))

    !=========================!
    !  write                  ! 
    !=========================!
    file_name = trim(adjustl(path_name))//'system_info_NAMES.dat'
    open(10, file=file_name, status='replace', form='formatted')  ! save variable names as ascii

    file_name = trim(adjustl(path_name))//'system_info_VALUES.dat'
    open(11, file=file_name, status='replace', form='formatted')  ! save variable values as ascii

    ! write variable names
    write(10, *) 'Nx'
    write(10, *) 'Ny'
    write(10, *) 'N'
    
    write(10, *) 'D'
    write(10, *) 'm'
    write(10, *) 'I'
    write(10, *) 'dt'

    write(10, *) 'start_step'
    write(10, *) 'end_step'
    write(10, *) 'write_step'
    write(10, *) 'total_step'

    write(10, *) 'R'
    write(10, *) 'k'
    write(10, *) 'e'
    write(10, *) 'rho'
    write(10, *) 'mu_s'
    write(10, *) 'mu_r'
    write(10, *) 'mu_w'
    
    write(10, *) 'g'
    write(10, *) 'Lx'
    write(10, *) 'Ly'
    write(10, *) 'W'
    write(10, *) 'H'
    write(10, *) 'v_lift'

    ! write variable values [note: the same order as variable names]
    write(11, *) Nx
    write(11, *) Ny
    write(11, *) N
    
    write(11, *) D
    write(11, *) m
    write(11, *) I
    write(11, *) dt
    
    write(11, *) start_step
    write(11, *) end_step
    write(11, *) write_step
    write(11, *) total_step

    write(11, *) R
    write(11, *) k
    write(11, *) e
    write(11, *) rho
    write(11, *) mu_s
    write(11, *) mu_r
    write(11, *) mu_w
    
    write(11, *) g
    write(11, *) Lx
    write(11, *) Ly
    write(11, *) W
    write(11, *) H
    write(11, *) v_lift

    close(10)
    close(11)

end subroutine out_system_info

! END !

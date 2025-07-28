program main
    !=========================!
    !  module                 !
    !=========================!
    !$use omp_lib
    use input
    use global_variables

    !=========================!
    !  local variables        !
    !=========================!
    implicit none
    character(len=999) :: save_step
    real(8) :: omp_get_wtime, y_min

    write(*,*) '+ ------------------------------------------------------------------------ +'
    write(*,*) '[message] Calculation has started.'
    !$ start_time = omp_get_wtime()

    !=========================!
    !  initial setting        !
    !=========================!
    call set_system                     ! initial setting
    call out_input                      ! copy input file
    call set_background_cell            ! set background cell
    call out_system_info                ! output system info
    call out_data('0')                  ! output initial setting

    !=========================!
    !  main loop              !
    !=========================!
    gate_height = 0.0d0                 ! initial gate height
    gate_switch = 0                     ! 0=closed, 1=opening, 2=opened

    do step = 1, total_step
        !=========================!
        !  DEM calculation        !
        !=========================!
        call cal_background_cell        ! calculate background cell
        call cal_EOM_AME                ! calculate new x, u, and o
        call cal_U_max                  ! calculate U_max

        !=========================!
        !  gate operation         !
        !=========================!
        y_min = minval(x(2,:))

        if ((gate_switch == 0).and.(U_max <= U_threshold).and.(y_min <= Ly/5.0d0)) then
            gate_switch = 1                          ! set gate state to 'opening'
        elseif ((gate_switch == 1).and.(gate_height(1,1) <= Ly))then
            gate_height = gate_height + v_lift* dt   ! lifting gate
        elseif ((gate_switch == 1).and.(gate_height(1,1) > Ly))then
            gate_switch = 2                          ! set gate state to 'opened'
        endif

        !=========================!
        !  save & progress bar    !
        !=========================!
        if (mod(step, write_step) == 0) then
            write(save_step,*) step                  ! step >> str(step)
            call out_data(trim(adjustl(save_step)))  ! output
        endif

        !$ tmp_time = omp_get_wtime()   ! get temporary CPU time
        call out_progress               ! progress bar
    enddo

    call deallocate_array
    write(*,*) '[message] Calculation has finished.'
    write(*,*) '+ ------------------------------------------------------------------------ +'
    write(*,*) ''

end program main

! END !
subroutine out_progress
    !=========================!
    !  module                 ! 
    !=========================!
    use input
    use global_variables

    !=========================!
    !  local variables        ! 
    !=========================!
    implicit none
    character(len=1  ) :: esc = achar(27)
    character(len=999) :: progress, progress_time

    real(8) :: dble_step

    !=========================!
    !  progress bar           ! 
    !=========================!
    dble_step = dble(step) - dble(start_step) + 1.0d0
    write(progress     , '(f10.4)') dble_step/dble(total_step)*100.0d0
    write(progress_time, '(f12.3)') tmp_time - start_time

    write(*,'(a)', advance='no') esc//'M'  ! esc + M >> up one row
    write(*,'(a)', advance='no') esc//'M'  ! esc + M >> up one row
    write(*,'(a)', advance='no') esc//'M'  ! esc + M >> up one row
    
    
    if (gate_switch == 0) then
        write(*,*) '[message] Gate is currently closed'
    elseif (gate_switch == 1) then
        write(*,*) '[message] Gate is currently opening'
    elseif (gate_switch == 2) then
        write(*,*) '[message] Gate is currently opened'
    endif


    if ((0.0d0/2.0d0<dble_step).and.(dble_step<=0.1d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [                    ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((0.1d0/2.0d0<dble_step).and.(dble_step<=0.2d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [=                   ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((0.2d0/2.0d0<dble_step).and.(dble_step<=0.3d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [==                  ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((0.3d0/2.0d0<dble_step).and.(dble_step<=0.4d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [===                 ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((0.4d0/2.0d0<dble_step).and.(dble_step<=0.5d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [====                ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((0.5d0/2.0d0<dble_step).and.(dble_step<=0.6d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [=====               ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((0.6d0/2.0d0<dble_step).and.(dble_step<=0.7d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [======              ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((0.7d0/2.0d0<dble_step).and.(dble_step<=0.8d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [=======             ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((0.8d0/2.0d0<dble_step).and.(dble_step<=0.9d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [========            ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((0.9d0/2.0d0<dble_step).and.(dble_step<=1.0d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [=========           ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((1.0d0/2.0d0<dble_step).and.(dble_step<=1.1d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [==========          ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((1.1d0/2.0d0<dble_step).and.(dble_step<=1.2d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [===========         ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((1.2d0/2.0d0<dble_step).and.(dble_step<=1.3d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [============        ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((1.3d0/2.0d0<dble_step).and.(dble_step<=1.4d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [=============       ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((1.4d0/2.0d0<dble_step).and.(dble_step<=1.5d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [==============      ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((1.5d0/2.0d0<dble_step).and.(dble_step<=1.6d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [===============     ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((1.6d0/2.0d0<dble_step).and.(dble_step<=1.7d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [================    ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((1.7d0/2.0d0<dble_step).and.(dble_step<=1.8d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [=================   ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((1.8d0/2.0d0<dble_step).and.(dble_step<=1.9d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [==================  ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'

    elseif ((1.9d0/2.0d0<dble_step).and.(dble_step< 2.0d0/2.0d0*dble(total_step))) then
        write(*,'(1x,a)') '[message] progress [=================== ] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'
    
    else
        write(*,'(1x,a)') '[message] progress [====================] '//trim(adjustl(progress))//'%'
        write(*,'(1x,a)') '          >> cpu time: '//trim(adjustl(progress_time))//' [s]'
    endif
    
end subroutine out_progress

! END !

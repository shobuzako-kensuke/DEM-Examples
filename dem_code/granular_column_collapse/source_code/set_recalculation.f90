subroutine set_recalculation
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
    character(len=999) :: read_path, file_name, file_ID
    integer :: j
    real(8) :: tmp

    !=========================!
    !  read settings          !
    !=========================!
    file_name = '../output/'//trim(adjustl(save_name))//'/system_info/system_info_VALUES.dat'
    open(10, file=file_name, form='formatted', status='old')

    do j = 1, 6
        read(10,*) tmp ! read system_info.dat
        if (j == 1) Nx = int(tmp)
        if (j == 2) Ny = int(tmp)
        if (j == 3) N  = int(tmp)
        if (j == 4) D  = tmp
        if (j == 5) m  = tmp
        if (j == 6) I  = tmp
        if (j == 7) dt = tmp
    enddo
    close(10)

    !=========================!
    !  allocate               !
    !=========================!
    allocate(x(2,N), u(2,N), o(1,N))  ! x=position, u=velocity, o=angular velocity; ((x,y), N)
    x(:,:) = 0.0d0
    u(:,:) = 0.0d0
    o(1,:)   = 0.0d0

    !=========================!
    !  read files             !
    !=========================!
    ! read last data
    write(file_ID,*) start_step
    read_path = '../output/'//trim(adjustl(save_name))//'/data/'//trim(adjustl(file_ID))//'/'

    ! x
    file_name = trim(adjustl(read_path))//'x.dat'
    call read_binary(file_name, x, 2, N)

    ! u
    file_name = trim(adjustl(read_path))//'u.dat'
    call read_binary(file_name, u, 2, N)

    ! o
    file_name = trim(adjustl(read_path))//'o.dat'
    call read_binary(file_name, o, 1, N)

end subroutine set_recalculation

! END !
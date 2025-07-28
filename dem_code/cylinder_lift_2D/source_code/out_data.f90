subroutine out_data(recording_ID)
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
    character(len=*), intent(in) :: recording_ID
    character(len=999) :: save_path, file_name

    !=========================!
    !  mkdir                  !
    !=========================!
    save_path = '../output/'//trim(adjustl(save_name))//'/data/'&
                //trim(adjustl(recording_ID))//'/'
    call mkdir(trim(adjustl(save_path)))

    !=========================!
    !  output                 !
    !=========================!
    ! x
    file_name = trim(adjustl(save_path))//'x.dat'
    call write_binary(file_name, x, 2, N)

    ! u
    file_name = trim(adjustl(save_path))//'u.dat'
    call write_binary(file_name, u, 2, N)

    ! o
    file_name = trim(adjustl(save_path))//'o.dat'
    call write_binary(file_name, o, 1, N)

    ! gate_height
    file_name = trim(adjustl(save_path))//'gate_height.dat'
    call write_binary(file_name, gate_height, 1, 1)

end subroutine out_data

! END !

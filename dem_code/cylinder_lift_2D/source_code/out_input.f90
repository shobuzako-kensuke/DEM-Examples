subroutine out_input
    !=========================!
    !  module                 !
    !=========================!
    use input
    use lib_file_operations

    !=========================!
    !  local variables        !
    !=========================!
    implicit none
    character(len=999) :: path_name, source_name

    !=========================!
    !  mkdir and cp           !
    !=========================!
    path_name = '../output/'
    call mkdir(trim(adjustl(path_name)))
    path_name = '../output/'//trim(adjustl(save_name))//'/'
    call mkdir(trim(adjustl(path_name)))
    source_name = './input.f90'
    call cp_file(trim(adjustl(source_name)), trim(adjustl(path_name))) ! copy input.f90

end subroutine out_input

! END !
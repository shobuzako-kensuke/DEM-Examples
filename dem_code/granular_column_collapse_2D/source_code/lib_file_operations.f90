module lib_file_operations
    contains
    !=========================!
    !  make directory         ! 
    !=========================!
    subroutine mkdir(directory_name)
        implicit none
        character(len=*), intent(in) :: directory_name
        character(len=999) :: command
        write(command,*) 'mkdir -p '//trim(adjustl(directory_name))
        call system(command)
    end subroutine mkdir

    !=========================!
    !  copy file              ! 
    !=========================!
    subroutine cp_file(from, to)
        implicit none
        character(len=*), intent(in) :: from, to
        character(len=999) :: command
        write(command,*) 'cp -f '//trim(adjustl(from))//' '//trim(adjustl(to))
        call system(command)
    end subroutine cp_file
    
    !=========================!
    !  write as binary        ! 
    !=========================!
    subroutine write_binary(file_name, array, dim_1, dim_2)
        implicit none
        character(len=*), intent(in) :: file_name
        integer, intent(in) :: dim_1, dim_2
        real(8), intent(in) :: array(dim_1, dim_2)
        open (10, file=file_name, status='replace', form='unformatted', access='stream')
        write(10) array
        close(10)
    end subroutine write_binary

    !=========================!
    !  write as ascii         ! 
    !=========================!
    subroutine write_ascii(file_name, array, dim_1, dim_2)
        implicit none
        character(len=*), intent(in) :: file_name
        integer, intent(in) :: dim_1, dim_2
        real(8), intent(in) :: array(dim_1, dim_2)
        open (10, file=file_name, status='replace', form='formatted')
        write(10, '(e21.14)') array
        close(10)
    end subroutine write_ascii
    
    !=========================!
    !  read binary            ! 
    !=========================!
    subroutine read_binary(file_name, array, dim_1, dim_2)
        implicit none
        character(len=*), intent(in) :: file_name
        integer, intent(in)    :: dim_1, dim_2
        real(8), intent(inout) :: array(dim_1, dim_2)    
        open (10, file=file_name, form='unformatted', access='stream')
        read (10) array
        close(10)
    end subroutine read_binary

end module lib_file_operations

! END !

subroutine set_background_cell
    !=========================!
    !  module                 ! 
    !=========================!
    !$use omp_lib
    use input
    use global_variables
    use lib_file_operations

    !=========================!
    !  local variables        ! 
    !=========================!
    implicit none
    integer :: me, cell_x, cell_y, my_cell
    character(len=999) :: path_name, file_name

    !=========================!
    !  cell max               !
    !=========================!
    cell_x_max = ceiling(Lx/ D)
    cell_y_max = ceiling(Ly/ D)
    cell_max   = cell_x_max + (cell_y_max - 1) * cell_x_max  ! max cell number

    !=========================!
    !  allocate               !
    !=========================!
    allocate(cell(N))                 ! cell(me) = my cell number
    allocate(cell_9   (9, cell_max))  ! cell_9(9, my cell) = neighboring 9 cells
    allocate(N_cell   (   cell_max))  ! N_cell   (my cell) = number of residents in my cell
    allocate(cell_info(4, cell_max))  ! cell_info(names, my_cell)
    cell   = 0
    cell_9 = 0
    N_cell = 0
    cell_info = 0
    
    !=========================!
    !  check initial cells    ! 
    !=========================!
    !$ call omp_set_dynamic(.false.)
    !$ call omp_set_num_threads(N_threads)
    !$OMP parallel default(none) &
    !$OMP private(me, cell_x, cell_y, my_cell) &
    !$OMP shared(N, D, cell_max, cell_x_max, cell, cell_9, x)
    !$OMP do
    do me = 1, N
        cell_x = ceiling(x(1,me) / D)
        cell_y = ceiling(x(2,me) / D)
        my_cell = cell_x + (cell_y - 1) * cell_x_max  ! my cell number
        cell(me) = my_cell                            ! store my cell number
    enddo
    !$OMP enddo
    !$OMP barrier

    !=========================!
    !  cell_9                 ! 
    !=========================!
    !$OMP do
    do my_cell = 1, cell_max
        cell_9(1, my_cell) = my_cell - cell_x_max - 1  ! lower left
        cell_9(2, my_cell) = my_cell - cell_x_max      ! lower center
        cell_9(3, my_cell) = my_cell - cell_x_max + 1  ! lower right
        cell_9(4, my_cell) = my_cell - 1               ! left
        cell_9(5, my_cell) = my_cell                   ! center
        cell_9(6, my_cell) = my_cell + 1               ! right
        cell_9(7, my_cell) = my_cell + cell_x_max - 1  ! upper left
        cell_9(8, my_cell) = my_cell + cell_x_max      ! upper center
        cell_9(9, my_cell) = my_cell + cell_x_max + 1  ! upper right
    enddo
    !$OMP enddo
    !$OMP end parallel

    path_name = '../output/'//trim(adjustl(save_name))//'/cell/'
    call mkdir(trim(adjustl(path_name)))
    file_name = trim(adjustl(path_name))//'initial_cell.dat'
    call write_binary(file_name, dble(cell), N, 1)  ! save cell information
    
end subroutine set_background_cell

! END !
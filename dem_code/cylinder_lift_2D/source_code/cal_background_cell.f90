subroutine cal_background_cell
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
    integer :: me, cell_x, cell_y, my_cell

    !=========================!
    !  zero clear             !
    !=========================!
    cell      = 0
    N_cell    = 0
    cell_info = 0

    !=========================!
    !  cal my cell            !
    !=========================!
    !$ call omp_set_dynamic(.false.)
    !$ call omp_set_num_threads(N_threads)
    !$OMP parallel default(none) &
    !$OMP private(me, cell_x, cell_y, my_cell) &
    !$OMP shared(x, N, D, cell_x_max, cell, N_cell, cell_info)
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
    !  cal cell_info          !
    !=========================!
    !$OMP single
    do me = 1, N
        my_cell = cell(me)
        N_cell(my_cell) = N_cell(my_cell) + 1     ! count
        cell_info(N_cell(my_cell), my_cell) = me  ! cal cell_info
    enddo
    !$OMP end single
    !$OMP end parallel
  
end subroutine cal_background_cell

! END !
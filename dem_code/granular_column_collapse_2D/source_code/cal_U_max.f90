subroutine cal_U_max
    !=========================!
    !  module                 ! 
    !=========================!
    use input
    use global_variables

    !=========================!
    !  local variables        ! 
    !=========================!
    implicit none
    integer :: me
    real(8) :: U_tmp(N)

    !=========================!
    !  calculate U_max        ! 
    !=========================!
    !$ call omp_set_dynamic(.false.)
    !$ call omp_set_num_threads(N_threads)
    !$OMP parallel default(none) &
    !$OMP private(me) &
    !$OMP shared(N, u, U_tmp)
    !$OMP do
    do me = 1, N
        U_tmp(me) = sqrt(u(1,me)**2.0d0 + u(2,me)**2.0d0)
    enddo
    !$OMP enddo
    !$OMP end parallel

    U_max = maxval(U_tmp)
    
end subroutine cal_U_max

! END !

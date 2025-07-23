subroutine cal_EOM_AME
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
    integer :: me, you, my_cell, your_cell, link_cell, num, index, c_name(N_you), zero_index
    real(8) :: x_new(2,N), u_new(2,N), o_new(1,N)
    real(8) :: c_delta(N_you,2), x_ij(2), u_ij(2), r_ij, f_n(2), f_t(2), n_ij(2), t_ij(2)
    real(8) :: d_n(2), u_n(2), d_t(2), u_t(2), u_t_ij, f_n_ij, f_t_ij, omega_sign, Force(2), Torque
    
    !=========================!
    !  cal EOM & AME          ! 
    !=========================!
    !$ call omp_set_dynamic(.false.)
    !$ call omp_set_num_threads(N_threads)
    !$OMP parallel default(none) &
    !$OMP private(me, you, my_cell, your_cell, link_cell, num, index, zero_index) &
    !$OMP private(c_delta, c_name, x_ij, u_ij, r_ij, f_n, f_t, n_ij, t_ij) &
    !$OMP private(d_n, u_n, d_t, u_t, u_t_ij, f_n_ij, f_t_ij, omega_sign, Force, Torque) &
    !$OMP shared(N, N_you, eta, cell, cell_9, cell_max, N_cell, cell_info, x, u, o, D) &
    !$OMP shared(cumulative_delta, cumulative_name, m, I, dt, x_new, u_new, o_new)
    !$OMP do
    do me = 1, N
        !=========================!
        !  initial setting        !
        !=========================!
        Force  = 0.0d0      ! zero clear
        Torque = 0.0d0      ! zero clear
        c_delta(:,:) = cumulative_delta(:,:,me)  ! temporary cumulative_delta
        c_name (:)   = cumulative_name (:,me)    ! temporary cumulative_name

        !=========================!
        !  search neighbors       !
        !=========================!
        my_cell = cell(me)  ! my cell

        do link_cell = 1, 9
            your_cell = cell_9(link_cell, my_cell)  ! neighboring 9 cells

            if ((your_cell < 1).or.(cell_max < your_cell)) cycle  ! out of range
            if (N_cell(your_cell) == 0) cycle                     ! no particle in your_cell

            do num = 1, N_cell(your_cell)
                you = cell_info(num, your_cell)  ! your name

                if (me == you) cycle             ! if me=you, skip

                x_ij(:) = x(:,me) - x(:,you)                     ! relative position
                r_ij    = sqrt(x_ij(1)**2.0d0 + x_ij(2)**2.0d0)  ! particle distance

                !=========================!
                !  no contact             !
                !=========================!
                if (r_ij - D >= 0.0d0) then
                    do index = 1, N_you
                        if (c_name (index) == you) then
                            c_name (index)   = 0      ! zero clear
                            c_delta(index,:) = 0.0d0  ! zero clear
                            exit
                        endif
                    enddo

                !=========================!
                !  in contact             !
                !=========================!
                else
                    !=========================!
                    !  normal force           !
                    !=========================!
                    u_ij(:) = u(:,me) - u(:,you)                ! relative velocity
                    n_ij(:) = x_ij(:) / r_ij                    ! unit normal vector
                    d_n (:) = (r_ij - D)* n_ij(:)               ! normal relative displacement 
                    u_n (:) = dot_product(u_ij, n_ij)* n_ij(:)  ! normal relative velocity
                    f_n(:)  = - (k*d_n(:) + eta*u_n(:))         ! normal contact force
                    !=========================!
                    !  tangential  force      !
                    !=========================!
                    zero_index = 0  ! zero clear

                    ! check if contact has occurred
                    do index = 1, N_you
                        if (c_name(index) == you) then  ! Yes, already contacted
                            d_t(:) = c_delta(index,:)   ! tangential relative displacement
                            exit
                        elseif ((c_name(index) == 0).and.(zero_index == 0))then  ! No
                            zero_index = index          ! store first index with zero
                        endif
                    enddo

                    ! if contact has not occurred
                    if (index-1 == N_you) then
                        if (c_name(index-1) /= you) then
                            d_t(:) = 0.0d0                  ! zero
                            c_name(zero_index) = you        ! register your name
                            index = zero_index
                        endif
                    endif

                    ! calculate tangential relative velocity & unit tangential vector
                    u_t(1) = u_ij(1) - u_n(1) - R* (o(1,me) + o(1,you))* (-n_ij(2))
                    u_t(2) = u_ij(2) - u_n(2) - R* (o(1,me) + o(1,you))* ( n_ij(1))
                    u_t_ij = sqrt(u_t(1)**2.0d0 + u_t(2)**2.0d0)  ! speed u_t

                    if (u_t_ij == 0.0d0) then
                        t_ij(:) = 0.0d0                           ! not consider friction
                    else
                        t_ij(:) = u_t(:) / u_t_ij                 ! unit tangential vector
                    endif

                    ! calculate tangential cumulative displacement
                    d_t(:) = sqrt(d_t(1)**2.0d0 + d_t(2)**2.0d0)* t_ij(:) + u_t(:)*dt

                    ! check sliding friction
                    f_t(:) = - (k*d_t(:) + eta*u_t(:))            ! tangential contact force
                    f_n_ij = sqrt(f_n(1)**2.0d0 + f_n(2)**2.0d0)  ! magnitude of f_n
                    f_t_ij = sqrt(f_t(1)**2.0d0 + f_t(2)**2.0d0)  ! magnitude of f_t

                    if (f_t_ij > mu_s* f_n_ij) then               ! Yes, sliding
                        f_t(:) = - mu_s* f_t_ij* t_ij(:)          ! kinetic friction force
                        c_delta(index,:) = d_t(:) - u_t(:)*dt     ! not change displacement

                    else                                          ! No, below sliding friction
                        c_delta(index,:) = d_t(:)                 ! renew displacement
                    endif
                    !=========================!
                    !  total force            !
                    !=========================!
                    Force(:) = Force(:) + (f_n(:) + f_t(:))
                    !=========================!
                    !  total torque           !
                    !=========================!
                    Torque = Torque + ((-x_ij(1))* f_t(2) - (-x_ij(2))* f_t(1))

                    ! rolling friction
                    if (abs(o(1,me) - o(1,you)) >= 1.0d-10) then
                        omega_sign = (o(1,me) - o(1,you)) / abs(o(1,me) - o(1,you))
                        Torque = Torque - mu_r* R* f_n_ij* omega_sign
                    endif
                endif
            enddo
        enddo

        !=========================!
        !  boundary conditions    !
        !=========================!
        call cal_boundary(x(:,me), u(:,me), o(1,me), c_delta, c_name, Force, Torque)

        !=========================!
        !  time integration       !
        !=========================!
        Force(2) = Force(2) - m* g               ! add gravity force
        u_new(:,me) = u(:,me) + Force(:) /m* dt  ! new velocity
        x_new(:,me) = x(:,me) + u_new(:,me)* dt  ! new position
        o_new(:,me) = o(:,me) + Torque   /I* dt  ! new angular momentum

        !=========================!
        !  check out of bounds    !
        !=========================!
        ! if ((x_new(1,me) < 0).or.(x_new(1,me) > Lx).or. &
        !     (x_new(2,me) < 0).or.(x_new(2,me) > Ly)) then
        !     write(*,*) '[error] out of bounds @ cal_EOM_AME.f90'
        !     stop
        ! endif

        !=========================!
        !  save                   !
        !=========================!
        cumulative_delta(:,:,me) = c_delta(:,:)
        cumulative_name (:,me)   = c_name (:)
    enddo
    !$OMP enddo
    !$OMP end parallel

    !=========================!
    !  renew x,u,o            !
    !=========================!
    x(:,:) = x_new(:,:)
    u(:,:) = u_new(:,:)
    o(:,:) = o_new(:,:)

end subroutine cal_EOM_AME

! END !
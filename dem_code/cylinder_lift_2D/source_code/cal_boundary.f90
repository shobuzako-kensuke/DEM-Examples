subroutine cal_boundary(x_me, u_me, o_me, c_delta, c_name, Force, Torque)
    !=========================!
    !  module                 !
    !=========================!
    use input
    use global_variables

    !=========================!
    !  local variables        !
    !=========================!
    implicit none
    real(8), intent(in) :: x_me(2), u_me(2), o_me
    real(8), intent(inout) :: c_delta(N_you,2), Force(2), Torque
    integer, intent(inout) :: c_name(N_you)

    integer :: wl_kind
    real(8) :: n_wl(2), r_wl, u_wl(2), o_wl
    !=========================!
    !  bottom wall >> -1      !
    !=========================!
    wl_kind = -1
    n_wl(:) = (/0.0d0, 1.0d0/)
    r_wl    = x_me(2)
    u_wl(:) = (/0.0d0, 0.0d0/)
    o_wl    = 0.0d0

    if (x_me(2) >= 0.0d0 + R) then  ! if no contact
        call delete_index(wl_kind, c_name, c_delta)
    else                            ! if contact
        call cal_wl(x_me, u_me, o_me, c_delta, c_name, Force, Torque, &
                    n_wl, r_wl, u_wl, o_wl, wl_kind)
    endif

    !=========================!
    !  top wall >> -2         !
    !=========================!
    wl_kind = -2
    n_wl(:) = (/0.0d0, -1.0d0/)
    r_wl    = Ly - x_me(2)
    u_wl(:) = (/0.0d0, 0.0d0/)
    o_wl    = 0.0d0

    if (x_me(2) <= Ly - R) then  ! if no contact
        call delete_index(wl_kind, c_name, c_delta)
    else                         ! if contact
        call cal_wl(x_me, u_me, o_me, c_delta, c_name, Force, Torque, &
                    n_wl, r_wl, u_wl, o_wl, wl_kind)
    endif

    !=========================!
    !  left wall >> -3        !
    !=========================!
    wl_kind = -3
    n_wl(:) = (/1.0d0, 0.0d0/)
    r_wl    = x_me(1)
    u_wl(:) = (/0.0d0, 0.0d0/)
    o_wl    = 0.0d0

    if (x_me(1) >= 0.0d0 + R) then  ! if no contact
        call delete_index(wl_kind, c_name, c_delta)
    else                            ! if contact
        call cal_wl(x_me, u_me, o_me, c_delta, c_name, Force, Torque, &
                    n_wl, r_wl, u_wl, o_wl, wl_kind)
    endif

    !=========================!
    !  right wall >> -4       !
    !=========================!
    wl_kind = -4
    n_wl(:) = (/-1.0d0, 0.0d0/)
    r_wl    = Lx - x_me(1)
    u_wl(:) = (/0.0d0, 0.0d0/)
    o_wl    = 0.0d0

    if (x_me(1) <= Lx - R) then  ! if no contact
        call delete_index(wl_kind, c_name, c_delta)
    else                         ! if contact
        call cal_wl(x_me, u_me, o_me, c_delta, c_name, Force, Torque, &
                    n_wl, r_wl, u_wl, o_wl, wl_kind)
    endif

    !=========================!
    !  right gate >> -5       !
    !=========================!
    if ((gate_switch == 0).or.(gate_switch == 1)) then  ! if gate is closed or opening
        wl_kind = -5
        n_wl(:) = (/-1.0d0, 0.0d0/)
        r_wl    = x1 + W - x_me(1)
        o_wl    = 0.0d0

        if (gate_switch == 0) then
            u_wl(:) = (/0.0d0, 0.0d0/)
        elseif (gate_switch == 1) then
            u_wl(:) = (/0.0d0, v_lift/)
        endif

        ! if contact
        if ((-R+x1+W <= x_me(1)).and.(x_me(1) <= x1+W).and.(x_me(2) >= gate_height(1,1))) then
            call cal_wl(x_me, u_me, o_me, c_delta, c_name, Force, Torque, &
                        n_wl, r_wl, u_wl, o_wl, wl_kind)

        ! if no contact
        else
            call delete_index(wl_kind, c_name, c_delta)
        endif
    endif

    !=========================!
    !  left gate >> -6        !
    !=========================!
    if ((gate_switch == 0).or.(gate_switch == 1)) then  ! if gate is closed or opening
        wl_kind = -6
        n_wl(:) = (/1.0d0, 0.0d0/)
        r_wl    = x_me(1) - x1
        o_wl    = 0.0d0

        if (gate_switch == 0) then
            u_wl(:) = (/0.0d0, 0.0d0/)
        elseif (gate_switch == 1) then
            u_wl(:) = (/0.0d0, v_lift/)
        endif

        ! if contact
        if ((x1 <= x_me(1)).and.(x_me(1) <= x1+R).and.(x_me(2) >= gate_height(1,1))) then
            call cal_wl(x_me, u_me, o_me, c_delta, c_name, Force, Torque, &
                        n_wl, r_wl, u_wl, o_wl, wl_kind)

        ! if no contact
        else
            call delete_index(wl_kind, c_name, c_delta)
        endif
    endif


!>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!
!  inner subroutines                                                        !
!>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>!
contains
    !=========================!
    !  delete_index           !
    !=========================!
    subroutine delete_index(wl_kind, c_name, c_delta)
        use input
        use global_variables
        implicit none
        integer, intent(in) :: wl_kind
        integer, intent(inout) :: c_name(N_you)
        real(8), intent(inout) :: c_delta(N_you,2)
        integer :: index

        do index = 1, N_you
            if (c_name (index) == wl_kind) then
                c_name (index)   = 0      ! zero clear (delete data)
                c_delta(index,:) = 0.0d0  ! zero clear (delete data)
                exit
            endif
        enddo
    end subroutine delete_index


    !=========================!
    !  cal_wl                 !
    !=========================!
    subroutine cal_wl(x_me, u_me, o_me, c_delta, c_name, Force, Torque, &
                      n_wl, r_wl, u_wl, o_wl, wl_kind)
        use input
        use global_variables

        !=========================!
        !  local variables        !
        !=========================!
        implicit none
        real(8), intent(in) :: x_me(2), u_me(2), o_me, n_wl(2), r_wl, u_wl(2), o_wl
        integer, intent(in) :: wl_kind
        real(8), intent(inout) :: c_delta(N_you,2), Force(2), Torque
        integer, intent(inout) :: c_name(N_you)

        integer :: index, zero_index
        real(8) :: u_ij(2), d_n(2), u_n(2), f_n(2), d_t(2), u_t(2), u_t_ij
        real(8) :: t_ij(2), f_t(2), f_n_ij, f_t_ij, x_iwl(2), omega_sign

        !=========================!
        !  normal force           !
        !=========================!
        u_ij(:) = u_me(:) - u_wl(:)                 ! relative velocity
        d_n (:) = (r_wl - R)* n_wl(:)               ! normal relative displacement 
        u_n (:) = dot_product(u_ij, n_wl)* n_wl(:)  ! normal relative velocity
        f_n(:)  = - (k*d_n(:) + eta*u_n(:))         ! normal contact force
        !=========================!
        !  tangential  force      !
        !=========================!
        zero_index = 0  ! zero clear

        ! check if contact has occurred
        do index = 1, N_you
            if (c_name(index) == wl_kind) then      ! Yes, already contacted
                d_t(:) = c_delta(index,:)           ! tangential relative displacement
                exit
            elseif ((c_name(index) == 0).and.(zero_index == 0))then  ! No
                zero_index = index                  ! store first index with zero
            endif
        enddo

        ! if contact has not occurred
        if (index-1 == N_you) then
            if (c_name(index-1) /= wl_kind) then
                d_t(:) = 0.0d0                          ! zero
                c_name(zero_index) = wl_kind            ! register your name
                index = zero_index
            endif
        endif

        ! calculate tangential relative velocity & unit tangential vector
        u_t(1) = u_ij(1) - u_n(1) - R* (o_me + o_wl)* (-n_wl(2))
        u_t(2) = u_ij(2) - u_n(2) - R* (o_me + o_wl)* ( n_wl(1))
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

        if (f_t_ij > mu_w* f_n_ij) then               ! Yes, sliding
            f_t(:) = - mu_w* f_n_ij* t_ij(:)          ! kinetic friction force
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
        x_iwl(:) = r_wl* (-n_wl(:))                   ! normal relative velocity
        Torque = Torque + ((x_iwl(1))* f_t(2) - (x_iwl(2))* f_t(1))
        ! rolling friction
        if (abs(o_me - o_wl) >= 1.0d-10) then
            omega_sign = (o_me - o_wl) / abs(o_me - o_wl)
            Torque = Torque - mu_r* R* f_n_ij* omega_sign
        endif

    end subroutine cal_wl

end subroutine cal_boundary

! END !
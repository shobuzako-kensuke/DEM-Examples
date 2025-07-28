subroutine set_system
    !=========================!
    !  module                 !
    !=========================!
    use input
    use global_variables

    !=========================!
    !  local variables        !
    !=========================!
    implicit none
    real(8) :: pi=acos(-1.0d0), rand_val
    integer :: me

    !=========================!
    !  fundamental info       !
    !=========================!
    D  = 2.0d0* R                            ! diameter [m]
    Nx = int(W/ D)                           ! number of particles along x axis
    Ny = int(H/ D)                           ! number of particles along y axis
    N  = Nx* Ny                              ! total number of particles

    m  = rho* (4.0d0/3.0d0)* pi* R**3.0d0    ! mass [kg]
    I  = (2.0d0/5.0d0)* m* R**2.0d0          ! moment of inertia [kg m2]
    dt = 0.05d0* 2.0d0*sqrt(m/k)             ! time step [s]
    eta = - 2.0d0* log(e)* sqrt(m*k/ (pi**2.0d0 + log(e)*log(e) ))  ! damping coefficient

    write(*,*) '+ ------------------------------------------------------------------------ +'
    write(*,*) '[message] Nx, Ny, N           :', Nx, Ny, N
    write(*,*) '          D [m]               :', D
    write(*,*) '          m [kg]              :', m
    write(*,*) '          I [kg m2]           :', I
    write(*,*) '          eta [kg s-1]        :', eta
    write(*,*) '          time step [s]       :', dt
    write(*,*) '          simulation time [s] :', dt* dble(total_step)
    write(*,*) '+ ------------------------------------------------------------------------ +'
    write(*,*) ''
    write(*,*) ''
    write(*,*) ''
    
    N_you = 8  ! maximum number of neighbors

    !=========================!
    !  allocate               !
    !=========================!
    allocate(x(2,N), u(2,N), o(1,N))       ! x=position, u=velocity, o=angular velocity; ((x,y), name)
    allocate(cumulative_delta(N_you,2,N))  ! cumulative_delta(index, (x,y), name)
    allocate(cumulative_name (N_you,N))    ! cumulative_name (index, name)
    x = 0.0d0
    u = 0.0d0
    o = 0.0d0
    cumulative_delta = 0.0d0
    cumulative_name  = 0
    
    !=========================!
    !  initial configuration  !
    !=========================!
    x(1,1) = x1 + R
    x(2,1) = R
    do me = 2, N
        if (me <= Nx) then
            x(1,me) = x(1,me-1) + D
            x(2,me) = x(2,me-1)
        else
            x(1,me) = x(1,me-Nx)
            x(2,me) = x(2,me-Nx) + D
        endif
    enddo

    if (Ly < 2.0d0*H) stop '[error] input Ly >= 2*H'
    x(2,:) = x(2,:) + 1.0d0*H  ! lift up to 2*H

    ! perturbation up to pm 0.05% of diameter
    CALL random_seed()
    do me = 1, N
        call random_number(rand_val)
        x(1,me) = x(1,me) + (rand_val - 0.5d0)* 1.0d-3* D
    enddo

end subroutine set_system

! END !
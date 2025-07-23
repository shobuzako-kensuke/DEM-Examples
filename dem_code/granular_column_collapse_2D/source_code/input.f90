module input
    implicit none
    !=========================!
    !  file name              !
    !=========================!
    character(len=999), parameter :: save_name = 'test'
    !=========================!
    !  OpenMP                 !
    !=========================!
    integer, parameter :: N_threads = 8          ! number of threads in OpenMP
    !=========================!
    !  time integration       !
    !=========================!
    integer, parameter :: start_step = 1
    integer, parameter :: end_step   = 300000
    integer, parameter :: write_step = 1000      ! writing interval
    !=========================!
    !  physical parameter     !
    !=========================!
    real(8), parameter :: R = 2.5d-4             ! radius [m]
    real(8), parameter :: k = 1.0d2              ! spring constant [kg s-2]
    real(8), parameter :: e = 0.2d0              ! coefficient of restitution
    real(8), parameter :: rho  = 2.685d3         ! density [kg m-3]
    real(8), parameter :: mu_s = 0.26            ! coefficient of sliding friction [-]
    real(8), parameter :: mu_r = 0.26            ! coefficient of rolling friction [-]
    real(8), parameter :: mu_w = 0.36            ! coefficient of particle-wall friction [-]
    !=========================!
    !  system parameter       !
    !=========================!
    real(8), parameter :: g  = 9.81d0            ! gravitational acceleration [m s-2]
    real(8), parameter :: Lx = 1.0d-1            ! system width  (along x axis) [m]
    real(8), parameter :: Ly = 1.0d-1            ! system height (along y axis) [m]
    real(8), parameter :: W  = 2.5d-2            ! system width  (along x axis) [m]
    real(8), parameter :: H  = 5.0d-2            ! system height (along y axis) [m]
    real(8), parameter :: v_lift = 1.0d-1        ! lifting speed [m s-1]


    !=========================!
    !  schematic illustration !
    !=========================!

    !           ^
    !           ^ v_lift
    !     ----- ^ ---------------
    !     |     ^               |  ^
    !     |     |               |  |
    !     |     |               |  | 
    !     |     |               |  | Ly
    !     |*****| ^             |  |
    !     |*****| | H           |  | 
    !     |*****| v             |  v
    !     -----------------------
    !      <--->
    !        W
    !      <------------------->
    !               Lx

end module input

! END !
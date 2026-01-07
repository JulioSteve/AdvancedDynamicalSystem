program main
    implicit none
    integer :: i
    integer, parameter :: kind=4
    real(kind=kind), parameter :: delta=0.25, omega=1., F=0.4, Tmax=1000., dt=0.1
    real(kind=kind) :: t, pos1, pos2, vel1, vel2

    pos1 = 0.5
    vel1 = 0.
    pos2 = pos1
    vel2 = vel1

    t = 0
    open(unit=10, file='x1.bin', access='stream', form="unformatted", status="replace")
    open(unit=11, file='v1.bin', access='stream', form="unformatted", status="replace")
    do i=1,int(Tmax/dt)
        t = i*dt
        call RK4(t,pos1,vel1,dt)
        if (mod(i,1)==0) then
            write(10) pos1
            write(11) vel1
        endif
    enddo
    close(10)
    close(11)

    contains
        function accel(t,x,y)
            real(kind=kind), intent(in) :: t,x,y
            real(kind=kind) :: accel

            accel = F*COS(omega*t)-delta*y+x-x*x*x
        end function accel


        subroutine RK4(t,x,y,h)
            real(kind=kind), intent(in) :: t, h
            real(kind=kind), intent(inout) :: x,y
            real(kind=kind) :: k1,k2,k3,k4

            k1 = accel(t,x,y)
            k2 = accel(t+0.5*h, x+0.5*h*y, y+0.5*h*k1)
            k3 = accel(t+0.5*h, x+0.5*h*y+h*h*0.25*k1, y+0.5*h*k2)
            k4 = accel(t+h, x+h*y+0.5*h*h*k2, y+0.5*h*k3)

            x = x + h*y+h*h/6.*(k1+k2+k3)
            y = y + h/6.*(k1+2*k2+2*k3+k4)
        end subroutine RK4
    end program 
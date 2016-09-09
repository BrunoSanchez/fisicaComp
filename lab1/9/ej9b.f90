!
! ej9a.f90
!
! Copyright 2016 Bruno S <bruno@oac.unc.edu.ar>
!
! This program is free software; you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation; either version 2 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
program ej9b
use precision, pr => dp

implicit none
integer                 :: i, j, k, n
real(pr), parameter     :: e = 5._pr, h = 1e-4
real(pr)                :: alpha, t0, tf, t, et, d
real(pr), dimension(:)  :: xi(4), xi_1(4), k1(4), k2(4), k3(4), k4(4), x0(4)


open(unit=10, file='ej9b_e5.dat', status='UNKNOWN', action='WRITE')
write(10, *) "#  t   q1   q2   p1   p2   e"

! x0 = (/ 2._pr, 0._pr, 0._pr, sqrt(2._pr*e - 4._pr) /)
alpha = 0.05_pr
t0 = 0._pr
tf = 15000._pr
n = int((tf-t0)/h)
x0(2) = 0  ! elijo q_2 == 0
t = 0._pr

d = 2._pr * sqrt(e)/10._pr  ! ancho barrido de espacio de fase
do k = 0, 10
    x0(3) = -sqrt(e) + real(k, pr) * d
    do j = 0, 10
        x0(1) = -sqrt(e) + real(j, pr) * d

        x0(4) = 2._pr * e - x0(3)*x0(3) - x0(1)*x0(1)
        if (x0(4) < 0) cycle
        x0(4) = sqrt(x0(4))
        xi = x0
        do i =1, n
            xi_1 = xi
            k1 = h * f(xi_1, alpha)
            k2 = h * f(xi_1 + k1*0.5_pr, alpha)
            k3 = h * f(xi_1 + k2*0.5_pr, alpha)
            k4 = h * f(xi_1 + k3, alpha)

            xi = xi_1 + (k1 + 2._pr * k2 + 2._pr * k3 + k4) / 6._pr
            t = t0 + i * h

            et = 0.5_pr*(xi(1)*xi(1)+xi(2)*xi(2)+xi(3)*xi(3)+xi(4)*xi(4)) + &
                & alpha * xi(1)*xi(1)*xi(2)*xi(2)

            if (xi(2)*xi_1(2) <= 0._pr) then
                if (xi(4) > 0._pr) then
                    write(10, *) t, xi(1), xi(2), xi(3), xi(4), et
                end if
            end if

        end do
    end do
end do
contains

function f(x, alpha)
integer(kind=8), parameter :: n = 4
real (pr) :: f(n)
real (pr), intent(in) :: x(n), alpha

    f(1) = x(3)
    f(2) = x(4)
    f(3) = -x(1) - alpha*x(1)*x(2)*x(2)
    f(4) = -x(2) - alpha*x(1)*x(1)*x(2)

end function f


end program ej9b

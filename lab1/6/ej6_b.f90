!
! ej6_b.f90
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
! You should have received a copy of the GNU General Public License
! along with this program; if not, write to the Free Software
! Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
! MA 02110-1301, USA.
!
!
!
PROGRAM ej6_b

use precision, pr => dp

IMPLICIT NONE

integer :: i, j, k
integer, parameter :: n = 1000
real(pr) :: h, t0, tf, x0, v0, t, error, exacta, vexacta
real(pr) :: k1(2), k2(2), xi(2), xi_1(2)

open(unit=10, file='ej6_b.dat', status='UNKNOWN', action='WRITE')

write(10, *) "#  t   x   v   err   exact   vexact"

!condiciones iniciales
t0 = 0._pr
tf = 10._pr
x0 = 1._pr
v0 = 1._pr

h = (tf - t0)/real(n, pr)

! para t == 0
xi(1) = x0
xi(2) = v0

write(10, *) t0, x0, v0, 0._pr, x0, v0

do i = 1, n
    xi_1 = xi

    k1 = h * f(xi_1)
    k2 = h * f(xi_1 + k1)

    xi = xi_1 + (k1 + k2)/2._pr
    t = t0 + i * h

    exacta = sin(t) + cos(t)
    vexacta = cos(t) - sin(t)
    error = abs(xi(1) - exacta)
    write(10, *) t, xi(1), xi(2), error, exacta, vexacta
end do


CONTAINS

function f(x)
integer(kind=8), parameter :: k = 1, n = 2
real (pr) :: f(n)
real (pr), intent(in) :: x(n)

    f(1) = x(2)
    f(2) = -k*x(1)

end function f


END PROGRAM ej6_b

!
! ej6_a.f90
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

PROGRAM ej6_a

use precision, pr => dp

IMPLICIT NONE

integer :: i, j, k, n
real(pr) :: x, v, a, h, t0, tf, x0, v0, t

open(unit=10, file='ej6_a.dat', status='UNKNOWN', action='WRITE')

write(10, *) "#  t   x   v"

t0 = 0._pr
tf = 10._pr

!condiciones iniciales
x0 = 1._pr
v0 = 1._pr
n = 10000

h = (tf - t0)/real(n, pr)

! para t == 0
v = v0
x = x0
do i = 1, n
    v = v + h * f(x)
    x = x + h * v
    t = t0 + i * h
    write(10, *) t, x, v
end do


CONTAINS

function f(x)
real (pr) :: f
real (pr), intent(in) :: x
integer(kind=8), parameter :: k = 1

    f = -k*x

end function f

END PROGRAM ej6_a

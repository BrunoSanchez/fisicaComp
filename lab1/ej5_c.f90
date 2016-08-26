!
! ej6_c.f90
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
PROGRAM ej5_c

use precision, pr => dp

IMPLICIT NONE

integer :: i, j, k, n
real(pr) :: x, y, h, x0, xf, y0, error, exacta
real(pr) :: f1, f2, f3, f4, start_time, finish_time

open(unit=10, file='ej5_c.dat', status='UNKNOWN', action='WRITE')

write(10, *) "#  x   y   exacta   err"

x0 = 0._pr
xf = 1._pr

!condiciones iniciales
y0 = 1._pr

n = 100000
h = (xf - x0)/real(n, pr)

! para t == 0
y = y0
x = x0
call cpu_time(start_time)
do i = 1, n
    ! integro en v
    f1 = h * f(x, y)
    f2 = h * f(x + h * 0.5_pr, y + f1*0.5_pr)
    f3 = h * f(x + h * 0.5_pr, y + f2*0.5_pr)
    f4 = h * f(x + h, y + f3)
    y = y + (f1 + 2._pr * f2 + 2._pr * f3 + f4) / 6._pr

    exacta = exp(-x*x*0.5_pr)
    error = abs(y - exacta)
    write(10, *) x, y, exacta, error

    x = x0 + h * i  ! ya que f no depende de t
end do
call cpu_time(finish_time)


CONTAINS
function f(x, y)
real (pr) :: f
real (pr), intent(in) :: x, y

    f = -y*x

end function f

END PROGRAM ej5_c

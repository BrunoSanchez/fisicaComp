!
! lab1_7.f90
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
PROGRAM lab1_7

use precision, pr => dp

IMPLICIT NONE

!include "/usr/include/fftw3.f"
integer(kind=8) :: plan_rc, plan_cr

integer :: i, j, k
integer, parameter :: n=1024
real(pr) :: start_time, finish_time
real(pr) :: pi, ti, tf, L
real(pr), dimension(n) :: f, t

open(unit=10, file='f_t_ej7.dat', status='UNKNOWN', action='WRITE')
write(10, *) "#  t  f"

pi = 4._pr*atan(1._pr)
ti = 0._pr
tf = 4._pr
L = (tf - ti)/real(n, pr)

t(1:n) = (/ (i, i=1, n) /)
t = t*L

f = sin(pi/2._pr * t) + cos(20._pr* pi * t)

do i=1, n
    write(10, *) t(i), f(i)
end do


END PROGRAM lab1_7

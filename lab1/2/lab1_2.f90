!
! lab1_2.f90
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
PROGRAM lab1_2

USE precision, pr => dp
IMPLICIT NONE
INTEGER :: i, j, k
REAL(pr) :: h, x, e, er, cal

open(unit=10, file='salida_ej2.dat', status='UNKNOWN', action='WRITE')
write(10, *) "# h Fp er"

x = 1._pr
e = exp(x)
h = 1._pr

do i=1, 15, 1
    h = h * 0.1_pr
    cal = fp(h, x)
    er = cal - e

    write(10, *) h, cal, abs(er)
end do


CONTAINS

FUNCTION f(x)
REAL (pr) :: f
REAL (pr), INTENT(IN) :: x

    f = exp(x)

END FUNCTION f

FUNCTION fp(h, x)
REAL (pr) :: fp
REAL (pr), INTENT(IN) :: h, x

    fp = f(x + h) - f(x - h)
    fp = fp/(2._pr*h)

END FUNCTION fp

END PROGRAM lab1_2

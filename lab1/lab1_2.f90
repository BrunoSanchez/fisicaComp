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
IMPLICIT NONE

INTEGER :: i, j, k
REAL (KIND=8) :: h, x, e, er, cal

!33 FORMAT(F10.9, F10.9, F10.9)
OPEN(UNIT=10, FILE='salida_ej2.dat', STATUS='UNKNOWN', ACTION='WRITE')


WRITE(*,*) "EJERCICIO 2 LABORATORIO 1"
WRITE(10, *) "# h Fp er"

x = 1.d0
e = DEXP(x)
h = 1.d0
DO i=1, 15, 1
    h = h * 0.1d0
    cal = fp(h, x)
    er = cal - e

    WRITE(10, *) h, cal, ABS(er)
    WRITE(*,*) h, cal, ABS(er)

END DO

CONTAINS

FUNCTION f(x)
REAL (KIND=8) :: f
REAL (KIND=8), INTENT(IN) :: x

    f = EXP(x)

END FUNCTION f


FUNCTION fp(h, x)
REAL (KIND=8) :: fp
REAL (KIND=8), INTENT(IN) :: h, x

    fp = f(x + h) - f(x - h)
    fp = fp/(2*h)

END FUNCTION fp


END PROGRAM lab1_2

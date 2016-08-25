!
! lab1_3_a.f90
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
PROGRAM lab1_3_a
IMPLICIT NONE

INTEGER :: i, j, k, n
REAL(KIND=8) :: h, x0, xf, xi, integ, I_exact, er
OPEN(UNIT=10, FILE='salida_ej3_a.dat', STATUS='UNKNOWN', ACTION='WRITE')

x0 = 0.d0
xf = 1.d0

WRITE(*,*) "EJERCICIO 3 a LABORATORIO 1"
WRITE(10, *) "# I  n  k  err   I_exact"

I_exact = f(1.d0) - 1.d0

do k = 2, 8, 1
    n = 2**k
    h = (xf - x0)/n

    xi = x0
    integ = f(xi) / 2.d0
    do i=1, n-1, 1                          ! INTEGRO DADO N
        xi = x0 + (h * i)
        integ = integ + f(xi)
    end do

    integ = integ + f(xf) / 2.d0
    integ = integ * h

    er = ABS(integ - I_exact)
    WRITE(10, *) integ, n, k, er, I_exact

end do

CONTAINS

FUNCTION f(x)
REAL (KIND=8) :: f
REAL (KIND=8), INTENT(IN) :: x

    f = DEXP(x)

END FUNCTION f



END PROGRAM

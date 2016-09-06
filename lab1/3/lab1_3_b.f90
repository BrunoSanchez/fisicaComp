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
PROGRAM lab1_3_b
IMPLICIT NONE

INTEGER :: i, j, k, n
REAL(KIND=8) :: h, x0, xf, xi, I_par, I_impar, I_tot, I_exact, er
OPEN(UNIT=10, FILE='salida_ej3_b.dat', STATUS='UNKNOWN', ACTION='WRITE')

x0 = 0.d0
xf = 1.d0

WRITE(*,*) "EJERCICIO 3 b LABORATORIO 1"
WRITE(10, *) "# I  n  k  err   I_exact"

I_exact = f(1.d0) - 1.d0

do k = 2, 16, 1
    I_par = 0.d0
    I_impar = 0.d0
    I_tot = 0.d0

    n = 2**k
    h = (xf - x0)/n

    do i=2, n-2, 2                          ! INTEGRO PARES
        xi = x0 + (h * i)
        I_par = I_par + f(xi)
    end do

    do i=1, n-1, 2                          ! INTEGRO IMPARES
        xi = x0 + (h * i)
        I_impar = I_impar + f(xi)
    end do

    I_tot = f(x0) + I_par*2.d0 + I_impar*4.d0 + f(xf)
    I_tot = I_tot * h/3.d0

    er = ABS(I_tot - I_exact)
    WRITE(10, *) I_tot, n, k, er, I_exact

end do

CONTAINS

FUNCTION f(x)
REAL (KIND=8) :: f
REAL (KIND=8), INTENT(IN) :: x

    f = DEXP(x)

END FUNCTION f

END PROGRAM

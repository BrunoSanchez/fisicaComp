PROGRAM lab1_1

IMPLICIT NONE

INTEGER :: i, j, k, l

REAL(KIND=8) :: a, b, c


PRINT *, "37 / 3 = ", 37/3
PRINT *, "37 + 17 / 3 = ", 37 + 17/3
PRINT *, "28 / 3 / 4 = ", 28 / 3 / 4
PRINT *, "(28 / 3)/4 = ", (28 / 3) / 4
PRINT *, "-3. ** 4. / 2. = ", -3. ** 4. / 2.
PRINT *, "3. ** (-4. / 2.) =  ", 3. ** (-4. / 2.)
!PRINT *, "4. ** -3 = ",  4. ** -3  ! expresion no valida
PRINT *, "2. ** 2. ** 3. = ", 2. ** 2. ** 3.
PRINT *, "2. ** (-2.) = ", 2. ** (-2.)
PRINT *, "(-2) ** 2 = ", (-2) ** 2
!PRINT *, "(-2.) ** (-2.2) = ", (-2.) ** (-2.2)  ! expresion no valida
PRINT *, "(-2.) ** NINT (-2.2) = ", (-2.) ** NINT (-2.2)
PRINT *, "1 + 1/4 = ", 1 + 1/4
PRINT *, "1. + 1/4 = ", 1. + 1/4
PRINT *, "1 * 1./4 = ", 1 * 1./4


END PROGRAM

PROGRAM lab1_1

USE precision, pr => dp

IMPLICIT NONE

print *, "37 / 3 = ", 37/3
print *, "37 + 17 / 3 = ", 37 + 17/3
print *, "28 / 3 / 4 = ", 28 / 3 / 4
print *, "(28 / 3)/4 = ", (28 / 3) / 4
print *, "-3. ** 4. / 2. = ", -3. ** 4. / 2.
print *, "3. ** (-4. / 2.) =  ", 3. ** (-4. / 2.)
!print *, "4. ** -3 = ",  4. ** -3  ! expresion no valida
print *, "2. ** 2. ** 3. = ", 2. ** 2. ** 3.
print *, "2. ** (-2.) = ", 2. ** (-2.)
print *, "(-2) ** 2 = ", (-2) ** 2
!print *, "(-2.) ** (-2.2) = ", (-2.) ** (-2.2)  ! expresion no valida
print *, "(-2.) ** NINT (-2.2) = ", (-2.) ** NINT (-2.2)
print *, "1 + 1/4 = ", 1 + 1/4
print *, "1. + 1/4 = ", 1. + 1/4
print *, "1 * 1./4 = ", 1 * 1./4


END PROGRAM

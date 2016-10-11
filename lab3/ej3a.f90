!
! ej3a.f90
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
program integralMC
use precision, pr => dp
use mtmod

implicit none
integer                     :: i, j, k
real(pr)                    :: x, Imc, exact, error, cum


open(unit=10, file='ej3a.dat', status='UNKNOWN', action='WRITE')
write(10, *) "#   n   Imc  err   "

exact=0.25
cum = 0
do i = 1, 100000
    x = grnd()
    cum = cum + f(x)
    if (mod(i, 10)==0) then
        Imc = cum/real(i, pr)
        error = abs(exact - Imc)
        write(10, *) i, Imc, error
    end if
end do



contains

function f(x)
implicit none
real(pr)                    :: f, x

f = x**3.
end function f

end program

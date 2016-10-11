!
! ej3b.f90
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
program MCImpSampling
use precision, pr => dp
use ran2mod

implicit none
integer                     :: i, j, k, seed=102012
real(pr), parameter         :: exact=0.25_pr
real(pr)                    :: x, y2, Imc2, error2, cum2
real(pr)                    ::    y3, Imc3, error3, cum3


open(unit=10, file='ej3b.dat', status='UNKNOWN', action='WRITE')
write(10, *) "#   n   Imc2  err2   Imc3   err3"

cum2 = 0._pr
cum3 = 0._pr
do i = 1, 100000
    x = ran2(seed)
    y2 = phi_inv(x, 2)
    y3 = phi_inv(x, 3)
    cum2 = cum2 + f(y2)/p(y2, 2)
    cum3 = cum3 + f(y3)/p(y3, 3)
    if (mod(i, 10)==0) then
        Imc2 = cum2/real(i, pr)
        Imc3 = cum3/real(i, pr)
        error2 = abs(exact - Imc2)
        error3 = abs(exact - Imc3)
        write(10, *) i, Imc2, error2, Imc3, error3
    end if
end do
close(10)

contains

function p(x, k)
implicit none
integer                     :: k
real(pr)                    :: p, x

p = (k + 1) * x**k

end function p


function phi_inv(x, k)
implicit none
integer                     :: k
real(pr)                    :: phi_inv, x

phi_inv = x**(1._pr/(real(k, pr)+1._pr))

end function phi_inv


function f(x)
implicit none
real(pr)                    :: f, x

f = x**3.

end function f

end program

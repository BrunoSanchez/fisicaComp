!
! ej8e.f90
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
program lyapunov

use precision, pr => dp

implicit none
integer, parameter      :: N = 10000000, K = 2100
integer                 :: i, j, t
real(pr)                :: xat, xat_1, x0, xbt, xbt_1
real(pr)                :: r_0, r_f, r, dr, dx, dx0, lavg, tol, navg


open(unit=10, file='ej8e.dat', status='UNKNOWN', action='WRITE')
write(10, *) "#  t   xat   xbt   dx  lam r "

tol = 1.e-3_pr
r_0 = 2._pr
r_f = 4.0_pr
dr = (r_f - r_0)/real(K, pr)
x0 = 0.6_pr
dx0 = 1.e-3_pr

do j = K, 1, -1
    lavg = 0._pr
    t = 0
    r = r_0 + dr * real(j, pr)
    xat_1 = x0
    xbt_1 = x0 + dx0
    !write(10, *) t + i, x0, r
    do i = 1, N
        xat = r * xat_1 * (1._pr - xat_1)
        xbt = r * xbt_1 * (1._pr - xbt_1)
        dx = abs(xat - xbt)
        navg = log(dx/dx0)
        if (i > 300) then
            if (abs(navg) < tol) then
                write(10, *) t + i, xat, xbt, dx, lavg/real(i,pr) , r
                exit
            end if
        end if
        lavg = lavg + navg
        xat_1 = xat
        xbt_1 = xbt
    end do
end do

close(10)

end program lyapunov

!
! ej8d.f90
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
program orbitmap2

use precision, pr => dp

implicit none
integer, parameter      :: N = 2000, K = 2500
integer                 :: i, j, t
real(pr)                :: xt, xt_1, x0, r_0, r_f, r, dr
character(len=4)        :: rj


open(unit=10, file='ej8d_2.dat', status='UNKNOWN', action='WRITE')
write(10, *) "#  t   xt   r"

r_0 = 3.847_pr
r_f = 3.856_pr
dr = (r_f - r_0)/real(K, pr)
x0 = 0.6_pr

do j = 1, K
    t = 0
    r = r_0 + dr * j
    xt_1 = x0
    !write(10, *) t + i, x0, r
    do i = 1, N
        xt = r * xt_1 * (1._pr - xt_1)
        if (i > 300) then
            write(10, *) t + i, xt, r
        end if
        xt_1 = xt
    end do

end do

close(10)
end program orbitmap2

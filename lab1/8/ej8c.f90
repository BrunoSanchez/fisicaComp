!
! ej8c.f90
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
program orbitmap

use precision, pr => dp

implicit none
integer, parameter      :: N = 10300, nbins = 16
integer                 :: i, j, k, t, ibin
real(pr)                :: xt, xt_1, x0, r, dbin
real(pr), dimension(:)  :: counts(nbins)

open(unit=10, file='ej8c.dat', status='UNKNOWN', action='WRITE')
write(10, *) "#  t   xt   r"

x0 = 0.6_pr
t = 0
r = 4._pr
xt_1 = x0
dbin = 1._pr/nbins
counts = (/ (0, i = 1, nbins) /)
print*, counts, dbin, nbins
do i = 1, N
    !print *, i
    xt = r * xt_1 * (1._pr - xt_1)

    if (i > 300) then
        write(10, *) t + i, xt, r
    end if

    xt_1 = xt

    ibin = int(xt*nbins)
    counts(ibin) = counts(ibin) + 1
end do

close(10)

print *, "========================================================"
print *, counts

end program orbitmap

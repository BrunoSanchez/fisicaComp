!
! fcc.f90
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
program fcc

use precision, pr=>dp

implicit none
integer                         :: i, j, k
integer                         :: ix, iy, iz
integer, parameter              :: n=256
real(pr), allocatable           :: part(:)
real(pr), parameter             :: a=1._pr

allocate(part(1:3*n))

36 format(I12, 2X, 3(F8.4, 2X))

! cubica simple de n/4
i = 1
do ix = 0, 3, 1
    do iy = 0, 3, 1
        do iz = 0, 3, 1

            if (i > n) exit

            ! coloco una cubica
            part(3*i - 2) = ix*a
            part(3*i - 1) = iy*a
            part(3*i)     = iz*a

            ! coloco tres mas para el fcc
            i = i + 1
            part(3*i - 2) = ix + a/2.
            part(3*i - 1) = iy + a/2.
            part(3*i)     = iz

            i = i + 1
            part(3*i - 2) = ix + a/2.
            part(3*i - 1) = iy
            part(3*i)     = iz + a/2.

            i = i + 1
            part(3*i - 2) = ix
            part(3*i - 1) = iy + a/2.
            part(3*i)     = iz + a/2.

            i = i + 1
        end do
    end do
end do

open(unit=10, file='fcc_part.dat', status='unknown')
!write(10, *) '#  i  x  y  z'
do i = 1, n
    write(10, 36) i, part(i*3-2), part(i*3-1), part(i*3)
end do


end program

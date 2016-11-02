!
! ljones.f90
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
module ljones

use precision, pr => dp
use mtmod, only                 : grnd

implicit none
integer                         :: i, j, k

contains

subroutine fcc_init(n, a, part)
integer                         :: n, ln
integer                         :: ix, iy, iz
real(pr), allocatable           :: part(:)
real(pr)                        :: a

    allocate(part(1:3*n))

    ln = (n/4)**(1./3.)

    i = 1
    do ix = 0, ln, 1
        do iy = 0, ln, 1
            do iz = 0, ln, 1

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

end subroutine fcc_init


subroutine force(part, npart, a, f, r_cut2, e_cut)
integer                         :: npart
real(pr)                        :: r, r_cut2, a, ff, r2i, r6i
real(pr)                        :: en, e_cut
real(pr)                        :: dx, dy, dz
real(pr), allocatable           :: part(:), f(:)

    allocate(f(1:3*npart))

    f = 0
    en = 0

    do i = 1, npart-1
        do j = i+1, npart
            dx = part(3*i - 2) - part(3*j - 2)
            dy = part(3*i - 1) - part(3*j - 1)
            dz = part(3*i) - part(3*j)

            dx = dx - 2._pr*a*nint(dx/2._pr*a)
            dy = dy - 2._pr*a*nint(dy/2._pr*a)
            dz = dz - 2._pr*a*nint(dz/2._pr*a)

            r = dx*dx + dy*dy + dz*dz

            if (r > r_cut2) then
                r2i = 1._pr/r
                r6i = r2i**3

                ff  = 48._pr * r2i * r6i * (r6i - 0.5_pr)

                f(3*i - 2) = f(3*i - 2) + ff*dx
                f(3*i - 1) = f(3*i - 1) + ff*dy
                f(3*i)     = f(3*i)     + ff*dz

                f(3*j - 2) = f(3*j - 2) - ff*dx
                f(3*j - 1) = f(3*j - 1) - ff*dy
                f(3*j)     = f(3*j)     - ff*dz

                en = en + 4._pr*r6i*(r6i-1._pr) - e_cut
            end if
        end do
    end do

end subroutine force


subroutine vel_init(n, temp, vel)
integer                         :: i, j, n
real(pr), allocatable           :: vel(:)
real(pr)                        :: sumv(1:3), sumv2(1:3), fs, temp

    allocate(vel(1:3*n))

    sumv = 0._pr !(/ (0._pr, i = 1, 3)/)
    sumv2= 0._pr !(/ (0._pr, i = 1, 3)/)

    do i = 1, 3*(n-1), 3
        do j = 0, 2
            vel(i+j) = grnd() - 0.5_pr
            sumv(j+1) = sumv(j+1) + vel(i+j)
            sumv2(j+1) = sumv2(j+1) + vel(i+j)*vel(i+j)
        end do
    end do

    sumv = sumv/n
    sumv2 = sumv2/n

    fs = sqrt(3*temp/(sumv2(1)+sumv2(2)+sumv2(3)) )

    do i = 1, 3*(n-1), 3
        do j = 0, 2
            vel(i+j) = fs*(vel(i+j) - sumv(j+1))
        end do
    end do

end subroutine vel_init


subroutine integrate(f, en)

sumv  = 0
sumv2 = 0

do i = 1, npart


end subroutine integrate



end module

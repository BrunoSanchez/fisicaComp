!
! leonardjones.f90
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
program leonardjones

use precision, pr => dp
use ljones

implicit none
!integer                         :: i, j, k
integer, parameter              :: npart=256
real(pr)                        :: e_cut, r_cut2
real(pr), parameter             :: temp=1.1_pr, a=5._pr**(1._pr/3._pr)
real(pr), parameter             :: dt=0.005
real(pr), allocatable           :: vel(:), part(:), f(:)


r_cut2 = 2.5_pr*2.5_pr
e_cut = (4._pr/r_cut2**3) * (1._pr/(r_cut2**3) - 1._pr)


call fcc_init(npart, a, part)

call vel_init(npart, temp, vel, dt, part)

36 format(I12, 2X, 3(F8.4, 2X))

open(unit=10, file='vel_init.dat', status='unknown')
write(10, *) '# i   vx    vy    vz   '
do i = 1, npart
    write(10, 36) i, vel(i*3-2), vel(i*3-1), vel(i*3)
end do
close(10)


open(unit=10, file='fcc_part.dat', status='unknown')
write(10, *) '# i   x    y    z   '
do i = 1, npart
    write(10, 36) i, part(i*3-2), part(i*3-1), part(i*3)
end do
close(10)


call force(part, npart, a, f, r_cut2, e_cut)

!~ do i = 1, 3*npart
!~     print*, f(i)
!~ end do

end program

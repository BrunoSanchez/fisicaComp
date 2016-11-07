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
integer                         :: nstep
integer, parameter              :: npart=256
real(pr)                        :: e_cut, r_cut2, en, e_tot, temp_k
real(pr), parameter             :: temp=1.1_pr, a=5._pr**(1._pr/3._pr)
real(pr), parameter             :: dt=0.005, tf=100., t0 = 0.
real(pr), allocatable           :: vel(:), part(:), f(:), x_old(:)


36 format(I12, 2X, 4(ES14.6e2, 2X))

print*, 'Starting'
nstep = nint((tf-t0)/dt)
r_cut2 = 2.5_pr*2.5_pr
e_cut = (4._pr/r_cut2**3) * (1._pr/(r_cut2**3) - 1._pr)
en = 0._pr
e_tot = 0._pr

print*, 'fcc init'
call fcc_init(npart, a, part)
open(unit=10, file='fcc_part.dat', status='unknown')
write(10, *) '# i   x    y    z   '
do i = 1, npart
    write(10, 36) i, part(i*3-2), part(i*3-1), part(i*3)
end do
close(10)
print*, 'vel init'

call vel_init(npart, temp, vel, dt, part, x_old)
open(unit=10, file='vel_init.dat', status='unknown')
write(10, *) '# i   vx    vy    vz   '
do i = 1, npart
    write(10, 36) i, vel(i*3-2), vel(i*3-1), vel(i*3)
end do
close(10)

!~ open(unit=10, file='x_old.dat', status='unknown')
!~ write(10, *) '# i   x    y    z   '
!~ do i = 1, npart
!~     write(10, 36) i, x_old(i*3-2), x_old(i*3-1), x_old(i*3)
!~ end do
!~ close(10)

allocate(f(1:3*npart))
call force(part, npart, a, f, r_cut2, e_cut, en)


open(11, file='energies_temp.dat', status='unknown')
write(11, *) '# step   e_pot   ek    etot   temp'
do k =1, nstep
    call integrate(f, en, part, vel, npart, a, r_cut2, e_cut, dt, x_old, e_tot, temp_k)
    write(11, 36) k, en, e_tot-en, e_tot, temp_k
end do

end program

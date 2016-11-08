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
integer                         :: nstep, j, i, k
integer, parameter              :: npart=256
real(pr)                        :: l, ln, t, a, r_cut2
real(pr), parameter             :: temp=1.1_pr
real(pr), parameter             :: dt=0.005, tf=100., t0 = 0.
real(pr)                        :: eu, ek, temp_k, e_tot, e_cut
real(pr), dimension(1:3*npart)  :: f_old, x_new, v_new
real(pr), dimension(1:3*npart)  :: part, f, vel

34 format(I12, 2X, 3(ES14.6e2, 2X))
36 format(F12.6, 2X, 4(ES14.6e2, 2X))
38 format(F12.6, 2X, 6(ES14.6e2, 2X))

print*, 'Starting'
a=5._pr**(1._pr/3._pr)
nstep = nint((tf-t0)/dt)
r_cut2 = 2.5_pr*2.5_pr
e_cut = (4._pr/r_cut2**3) * (1._pr/(r_cut2**3) - 1._pr)
eu = 0._pr
ek = 0._pr
e_tot = 0._pr
ln = real(npart/4, pr)**(1./3.)
l = ln * a


print*, 'fcc init'
call fcc_init(npart, a, part)
part = part - l * nint(part/l)
open(unit=10, file='fcc_part.dat', status='unknown')
write(10, *) '# i   x    y    z   '
do i = 1, npart
    write(10, 34) i, part(i*3-2), part(i*3-1), part(i*3)
end do
close(10)

print*, 'vel init'
call vel_init(npart, temp, vel, dt, part)
open(unit=10, file='vel_init.dat', status='unknown')
write(10, *) '# i   vx    vy    vz   '
do i = 1, npart
    write(10, 34) i, vel(i*3-2), vel(i*3-1), vel(i*3)
end do
close(10)


call force(part, npart, a, f, r_cut2, e_cut, eu)

open(11, file='energies_temp.dat', status='unknown')
write(11, *) '# step   ek   eu    etot   temp'
open(12, file='trayectoria42.dat', status='unknown')
write(12, *) '# step   x   y   z   vx   vy   vz'
open(13, file='trayectoria1.dat', status='unknown')
write(13, *) '# step   x   y   z   vx   vy   vz'


do k = 1, 1000
    call integrate(f, eu, ek, part, vel, npart, a, r_cut2, e_cut, dt, e_tot, temp_k)

    part = part - l * nint(part/l)
    if (mod(k, 50)==0) then
        print*, temp_k
        vel = vel * sqrt(temp/temp_k)
    end if
end do


do k =1, nstep
    t = t0 + dt * k
    call integrate(f, eu, ek, part, vel, npart, a, r_cut2, e_cut, dt, e_tot, temp_k)

    part = part - l * nint(part/l)

    write(11, 36) t, ek, eu, e_tot, temp_k
    write(12, 38) t, part(3*42-2), part(3*42-1), part(3*42), vel(3*42-2), vel(3*42-1), vel(3*42)
    write(13, 38) t, part(1), part(2), part(3), vel(1), vel(2), vel(3)
end do


close(11)
close(12)
close(13)

end program

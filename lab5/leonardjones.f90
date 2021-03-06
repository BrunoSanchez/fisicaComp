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
integer                         :: nstep, i, k
integer, parameter              :: npart=256, nbins=20
real(pr)                        :: l, ln, t, a, r_cut2, delta, lo_lim, hi_lim
real(pr), parameter             :: temp=1.1_pr
real(pr), parameter             :: dt=0.005, tf=100., t0 = 0.
real(pr)                        :: eu, ek, temp_k, e_tot, e_cut, P_t, p
!real(pr), dimension(1:3*npart)  :: f_old, x_new, v_new
real(pr), dimension(1:3*npart)  :: part, f, vel
integer, dimension(1:nbins)     :: countsvx, countsvy, countsvz
real(pr), dimension(0:nbins)    :: bins


!!!!!!!!!!!!!!!!!!!!  Formats for printing !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
34 format(I12, 2X, 3(ES14.6e2, 2X))
38 format(F12.6, 2X, 3(I12, 2X))
36 format(F12.6, 2X, 5(ES14.6e2, 2X))
!38 format(F12.6, 2X, 6(ES14.6e2, 2X))

!!!!!!!!!!!!!!!!!!!!  Initial conditions and settings!!!!!!!!!!!!!!!!!!!!!!!!!!
print*, 'Starting'
a=5._pr**(1._pr/3._pr)
nstep = nint((tf-t0)/dt)
r_cut2 = 2.5_pr*2.5_pr
e_cut = (4._pr/r_cut2**3) * (1._pr/(r_cut2**3) - 1._pr)
eu = 0._pr
ek = 0._pr
e_tot = 0._pr
P_t = 0._pr
p = 0._pr
ln = real(npart/4, pr)**(1./3.)
l = ln * a

!!!!!!!!!!!!!!!!!!!!  Accumulators for statistics  !!!!!!!!!!!!!!!!!!!!!!!!!!!!
!~ cum_eu = 0._pr
!~ cum_ek = 0._pr
!~ cum_et = 0._pr
!~ cum_pt = 0._pr
!~ cum_te = 0._pr
!~ cum_eu2 = 0._pr
!~ cum_ek2 = 0._pr
!~ cum_et2 = 0._pr
!~ cum_pt2 = 0._pr
!~ cum_te2 = 0._pr
lo_lim = -10._pr
hi_lim =  10._pr

!!!!!!!!!!!!!!!!!!!!  Putting a FCC Lattice  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
print*, 'fcc init'
call fcc_init(npart, a, part)
open(unit=10, file='fcc_part.dat', status='unknown')
write(10, *) '# i   x    y    z   '
do i = 1, npart
    write(10, 34) i, part(i*3-2), part(i*3-1), part(i*3)
end do
close(10)


!!!!!!!!!!!!!!!!!!!  Starting with velocities  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
print*, 'vel init'
call vel_init(npart, temp, vel)
open(unit=10, file='vel_init.dat', status='unknown')
write(10, *) '# i   vx    vy    vz   '
do i = 1, npart
    write(10, 34) i, vel(i*3-2), vel(i*3-1), vel(i*3)
end do
close(10)


!!!!!!!!!!!!!!!!!!  Beggining termalization !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
call force(part, npart, a, f, r_cut2, e_cut, eu, p)

open(11, file='energies_temp.dat', status='unknown')
write(11, *) '# step   ek   eu    etot   temp   P'

!!!!!!!!!!!!!!!!!!  Termalization !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
do k = 1, 1000
    call integrate(f, eu, ek, part, vel, npart, a, r_cut2, e_cut, dt, e_tot, temp_k, P_t)
    part = part - l * nint(part/l)

    if (mod(k, 50)==0) then
        vel = vel * sqrt(temp/temp_k)
    end if
end do

call histo_init(bins, countsvx, nbins, lo_lim, hi_lim, delta)
call histo_init(bins, countsvy, nbins, lo_lim, hi_lim, delta)
call histo_init(bins, countsvz, nbins, lo_lim, hi_lim, delta)


!!!!!!!!!!!!!!!!!  Integration of motion   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
do k =1, 10000
    t = t0 + dt * k
    call integrate(f, eu, ek, part, vel, npart, a, r_cut2, e_cut, dt, e_tot, temp_k, P_t)
    part = part - l * nint(part/l)

    call hist_vel(vel, nbins, countsvx, countsvy, countsvz, npart, bins, delta)
    write(11, 36) t, ek, eu, e_tot, temp_k, P_t

end do
close(11)


open(12, file='histogram_v.dat', status='unknown')
write(12, *) '# bin   countsvx   countsvy    countsvz   '
do i = 1, nbins
    write(12, 38) lo_lim+delta/2._pr*i, countsvx(i), countsvy(i), countsvz(i)
end do
close(12)
print*, nbins

end program

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

contains

subroutine fcc_init(npart, a, part)
integer                         :: i
integer                         :: npart, ln
integer                         :: ix, iy, iz
real(pr), dimension(1:3*npart)  :: part
real(pr)                        :: a, l

    ln = int((real(npart, pr)/4._pr)**(1./3.))

    i = 1
    do ix = 0, ln-1, 1
        do iy = 0, ln-1, 1
            do iz = 0, ln-1, 1

                if (i > npart) exit
                ! coloco una cubica
                part(3*i - 2) = ix
                part(3*i - 1) = iy
                part(3*i)     = iz

                ! coloco tres mas para el fcc
                i = i + 1
                part(3*i - 2) = ix + 1./2.
                part(3*i - 1) = iy + 1./2.
                part(3*i)     = iz

                i = i + 1
                part(3*i - 2) = ix + 1./2.
                part(3*i - 1) = iy
                part(3*i)     = iz + 1./2.

                i = i + 1
                part(3*i - 2) = ix
                part(3*i - 1) = iy + 1./2.
                part(3*i)     = iz + 1./2.

                i = i + 1
            end do
        end do
    end do

    part = part * a
    l = real(ln, pr) * a
    part = part - l * nint(part/l)
end subroutine fcc_init


subroutine vel_init(npart, temp, vel)
integer                         :: i, j, npart
real(pr), dimension(1:3*npart)  :: vel
real(pr)                        :: sumv(1:3), sumv2(1:3), fs, temp

    sumv = 0._pr !(/ (0._pr, i = 1, 3)/)
    sumv2= 0._pr !(/ (0._pr, i = 1, 3)/)

    do i = 1, 3*npart-2, 3
        do j = 0, 2
            vel(i+j) = grnd() - 0.5_pr
            sumv(j+1) = sumv(j+1) + vel(i+j)
            sumv2(j+1) = sumv2(j+1) + vel(i+j)*vel(i+j)
        end do
    end do

    sumv = sumv/real(npart, pr)
    sumv2 = sumv2/real(npart, pr)

    fs = sqrt(3._pr*temp/(sumv2(1)+sumv2(2)+sumv2(3)) )

    do i = 1, 3*npart-2, 3
        do j = 0, 2
            vel(i+j) = fs*(vel(i+j) - sumv(j+1))
        end do
    end do

end subroutine vel_init


subroutine force(part, npart, a, f, r_cut2, e_cut, eu, p)
integer                         :: i, j
integer                         :: npart
real(pr)                        :: r2, r_cut2, a, ff, r2i, r6i
real(pr)                        :: eu, e_cut, l, ln
real(pr)                        :: dx, dy, dz, p
real(pr), dimension(1:3*npart)  :: part, f

    f = 0
    p = 0
    eu = 0._pr
    ln = real(npart/4, pr)**(1./3.)
    l = ln * a

    do i = 1, npart-1
        do j = i+1, npart
            dx = part(3*i - 2) - part(3*j - 2)
            dy = part(3*i - 1) - part(3*j - 1)
            dz = part(3*i) - part(3*j)

            dx = dx - l * nint(dx/l)
            dy = dy - l * nint(dy/l)
            dz = dz - l * nint(dz/l)

            r2 = dx*dx + dy*dy + dz*dz
            if (r2<10E-12) print *, r2

            if (r2 < r_cut2) then
                r2i = 1._pr/r2
                r6i = r2i*r2i*r2i

                ff  = 48._pr * r2i * r6i * (r6i - 0.5_pr)

                f(3*i - 2) = f(3*i - 2) + ff*dx
                f(3*i - 1) = f(3*i - 1) + ff*dy
                f(3*i)     = f(3*i)     + ff*dz

                f(3*j - 2) = f(3*j - 2) - ff*dx
                f(3*j - 1) = f(3*j - 1) - ff*dy
                f(3*j)     = f(3*j)     - ff*dz

                p = p + ff*r2

                eu = eu + (4._pr*r6i*(r6i-1._pr) - e_cut)
            end if
        end do
    end do

    p = p/real(3*64*a*a*a, pr)
end subroutine force


subroutine integrate(f, eu, ek, part, vel, npart, a, r_cut2, e_cut, dt, e_tot, temp_k, P_t)
integer                         :: npart
real(pr)                        :: r_cut2, a, p, P_t
real(pr)                        :: eu, ek, e_cut, temp_k, e_tot
real(pr)                        :: sumvv, sumvv2, dt
real(pr), dimension(1:3*npart)  :: f_old, x_new, v_new
real(pr), dimension(1:3*npart)  :: part, f, vel

    sumvv  = 0
    sumvv2 = 0

    ! nuevas posiciones
    x_new = part + vel * dt + (f/2._pr) * dt * dt

    ! nuevas fuerzas
    f_old = f
    call force(x_new, npart, a, f, r_cut2, e_cut, eu, p)

    !nuevas velocidades
    v_new  = vel + dt * (f + f_old)/2._pr
    sumvv2 = sum(v_new**2)

    ! calculo temperatura, presion y energia
    temp_k = sumvv2/real(3*npart, pr)
    P_t = 0.8_pr * temp_k + p

    ek = 0.5_pr * sumvv2
    e_tot  = eu + ek

    ! actualizo
    part = x_new
    vel  = v_new

end subroutine integrate


subroutine hist_vel(vel, nbins, countsvx, countsvy, countsvz, npart, bins, delta)
integer                         :: i
integer                         :: nbins, npart
integer, dimension(1:nbins)     :: countsvx, countsvy, countsvz
real(pr), dimension(1:3*npart)  :: vel
real(pr), dimension(0:nbins)    :: bins
real(pr)                        :: vx, vy, vz, delta

    do i = 1, npart
        vx = vel(3*i - 2)
        vy = vel(3*i - 1)
        vz = vel(3*i)

        call histogram(bins, vx, countsvx, nbins, delta)
        call histogram(bins, vy, countsvy, nbins, delta)
        call histogram(bins, vz, countsvz, nbins, delta)

    end do

end subroutine


subroutine histo_init(bins, counts, nbins, lo_lim, hi_lim, delta)
integer                             :: j
integer, intent(in)                 :: nbins
integer, intent(inout)              :: counts(1:nbins)
real(pr), intent(inout)             :: bins(0:nbins), delta
real(pr), intent(in)                :: lo_lim, hi_lim

    counts = 0
    delta = (hi_lim - lo_lim)/real(nbins, pr)
    do j = 0, nbins
        bins(j) = lo_lim + j * delta
    end do

end subroutine



subroutine histogram(bins, datapoint, counts, nbins, delta)
integer                             :: ibin
integer, intent(in)                 :: nbins
integer, intent(inout)              :: counts(1:nbins)
real(pr), intent(in)                :: bins(0:nbins), delta
real(pr), intent(in)                :: datapoint

    ibin = int( (datapoint - bins(0))/delta ) + 1
    counts(ibin) = counts(ibin) + 1

end subroutine


end module

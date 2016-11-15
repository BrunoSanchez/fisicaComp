!
! gr.f90
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
module gr
use precision, pr=>dp

implicit none
integer                         :: nhis, switch
integer, allocatable            :: g(:)
real(pr)                        :: box

contains

subroutine gr(switch)
integer                         :: i, j, k
integer                         :: ngr
real(pr)                        :: delg

    if (switch==0) then
        ngr = 0
        delg = l/(2._pr * nhis)
        do i = 0, nhis
            g(i) = 0
            end do
    else if (switch==1) then
        ngr = ngr + 1
        do i = 1, npart-1
            do j = i+1, npart
                xr = x(3*i-2) - x(j*3-2)
                yr = x(3*i-1) - x(j*3-1)
                zr = x(3*i) - x(j*3)

                r = sqrt(xr*xr + yr*yr + zr*zr)
                if (r < (box/2)) then
                    ig = int(r/delg)
                    g(ig) = g(ig) + 1
                end if
            end do
        end do
    else if (switc == 2) then
        do i = 1, nhis
            r = delg*(i+0.5)
            vb = ((i+1)**3 - i**3)*delg**3
            nid = (4./3.)*pi*vb*rho
            g(i) = g(i)/(ngr*npart*nid)
        end do
    end if
end subroutine gr

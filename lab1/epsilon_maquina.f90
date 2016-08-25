!
! epsilon_maquina.f90
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
! You should have received a copy of the GNU General Public License
! along with this program; if not, write to the Free Software
! Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
! MA 02110-1301, USA.
!
!
!
PROGRAM eps
IMPLICIT NONE

INTEGER :: i, j, k
REAL(KIND=8) :: d, x, x_p

x = 1.d0
d = 0.5

do i = 1, 40
    x_p = x + d
    if (x_p.eq.x) exit
    d = d/2.d0
end do

print *, d

END PROGRAM eps

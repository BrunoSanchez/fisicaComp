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
use precision, pr => dp
IMPLICIT NONE

INTEGER :: i, j, k
REAL(pr) :: d, x, x_p

x = 1._pr
d = 2._pr

do i = 1, 2000
    x_p = x + d
    if (x_p == x) exit
    d = d/2._pr
end do

print *, i, d, epsilon(1._pr)

END PROGRAM eps

!
! ej2ab.f90
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
program ej2ab

use precision, pr => dp
use ran2mod
use mzranmod
use mtmod


implicit none
integer             :: i, j, k, quad(100,5)
integer, parameter  :: Nc=1e6
integer             :: x(2), idum1=-130103
real(dp)            :: r, r2(100)


open(unit=10, file='ej2ab_mstw.dat', status='UNKNOWN', action='WRITE')
write(10, *) "#   n   rms  quad1   quad2   quad3   quad4   quad5"

do i = 1, 5
    do j = 1, 100
        quad(j, i) = 0
    end do
end do

r2 = (/ (0, i=1, 100) /)

do j = 1, Nc
    x = (/0, 0/)
    do i=1, 1000   ! largo de las cadenas
        !r = ran2(idum1)
        r = grnd()
        x = x + step(r)

        if (mod(i, 10) == 0 ) then
            r2(int(i/10.)) = r2(int(i/10.)) + x(1) * x(1) + x(2) * x(2)
            call quadrant(int(i/10.), x, quad)
        end if
    end do
end do


do i = 1, 100
write(10, *) i*10, r2(i)/Nc, (/(quad(i, j), j=1, 5)/)
end do


contains

function step(r)
real (pr)                   :: dr, step(2)
real (pr), intent(in)       :: r

    dr = int(r * 4._dp)

    if (dr==0) then
        step = (/1, 0/)
    else if (dr==1) then
        step = (/-1, 0/)
    else if (dr==2) then
        step = (/0, 1/)
    else if (dr==3) then
        step = (/0, -1/)
    end if

end function step


subroutine quadrant(i, x, quad)
implicit none

integer, intent(in)         :: x(2), i
integer, intent(inout)      :: quad(100,5)


if (x(1) > 0 .and. x(2) >= 0) then
    quad(i,1) = quad(i,1) + 1
else if (x(1) <= 0 .and. x(2) > 0) then
    quad(i,2) = quad(i,2) + 1
else if (x(1) < 0 .and. x(2) <= 0) then
    quad(i,3) = quad(i,3) + 1
else if (x(1) >= 0 .and. x(2) < 0) then
    quad(i,4) = quad(i,4) + 1
else if (x(1) == 0 .and. x(2) == 0) then
    quad(i,5) = quad(i,5) + 1
end if

end subroutine quadrant

end program ej2ab

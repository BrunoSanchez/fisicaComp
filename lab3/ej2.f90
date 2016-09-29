!
! ej2.f90
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
program ej2

use precision, pr => dp
use ran2mod
use mzranmod
use mtmod

implicit none
integer                     :: i, j, k
integer                     :: idum1=-130103, m, p, quad(4), Nc=10000
real(dp)                    :: r2, r, x(2)

open(unit=10, file='ej2_.dat', status='UNKNOWN', action='WRITE')
write(10, *) "#   n     rms  quad1   quad2   quad3   quad4"

!
! Programa que realiza caminatas al azar
! Utilizando generadores de numeros random
!

do i = 1, 60                ! loop sobre los distintos longitudes
    m = 10 * i
    r2 = 0
    quad = (/0, 0, 0, 0/)
    do k = 1, Nc
        x = (/ 0, 0 /)
        do j = 1, m         ! loop para dar los pasos
            r = ran2(idum1)
            x = x + step(r)
        end do
        r2 = r2 + x(1) * x(1) + x(2) * x(2)

        ! eleccion del cuadrante
        ! 1 --> III
        ! 2 --> II
        ! 3 --> IV
        ! 4 --> I
        p = 1
        if (x(1) >= 0) then
            p = p + 1
        end if

        if (x(2) >= 0) then
                p = p + 2
        end if
        quad(p) = quad(p) + 1

    end do
    r2 = r2/Nc
    write(10, *) m, r2, quad(4), quad(2), quad(1), quad(3)
end do
close(10)

contains

function step(r)
integer(pr), parameter      :: d = 2
real (pr)                   :: dr, step(d)
real (pr), intent(in)       :: r

dr = int(r * 4._dp)


if (dr.eq.0) then
    step = (/1, 0/)
end if
if (dr.eq.1) then
step = (/-1, 0/)
end if
if (dr.eq.2) then
step = (/0, 1/)
end if
if (dr.eq.3) then
step = (/0, -1/)
end if

end function step

end program ej2

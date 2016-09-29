!
! ej1.f90
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
program ej1

use precision, pr => dp
use ran2mod
use mzranmod
use mtmod

implicit none
integer             :: i, j, k
integer             :: idum = -11313
real(dp)            :: r

print *, "ran2"
do i=1, 5, 1

    r = ran2(idum)
    print *, r

end do

print *, "mzran"
do i=1, 5, 1

    r = rmzran()
    print *, r

end do

print *, "mtran"
do i=1, 5, 1

    r = grnd()
    print *, r

end do


end program

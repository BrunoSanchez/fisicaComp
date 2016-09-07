!
! ej8a.f90
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
program logimap

use precision, pr => dp

implicit none
integer, parameter      :: N = 500
integer                 :: i, j, k, t
real(pr), dimension(:)  :: xt(4), xt_1(4), x0(4), r(5)
character(len=4)        :: rj

x0 = (/0.06_pr, 0.3_pr, 0.6_pr, 0.9_pr/)
r = (/1.5_pr, 3.3_pr, 3.5_pr, 3.55_pr, 4._pr/)

do j =1, 5
    write(rj, '(F4.2)') r(j)
    print *, 'ej8a_r_'//trim(rj)//'.dat'
    open(unit=10, file='ej8a_r_'//trim(rj)//'.dat', status='UNKNOWN',&
         &action='WRITE')
    write(10, *) "#  t   xt_006   xt_03   xt_06  xt_09  r"

    t = 0
    xt_1 = x0

    do i = 1, N
        xt = r(j) * xt_1 * (1._pr - xt_1)
        write(10, *) t + i, xt(1), xt(2), xt(3), xt(4), r(j)
        xt_1 = xt
    end do

    close(10)
end do

end program logimap

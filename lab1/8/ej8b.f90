!
! ej8b.f90
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
program powspec

use precision, pr => dp

IMPLICIT NONE

include "/usr/include/fftw3.f"
integer                 :: plan_rc, plan_cr

integer, parameter      :: N = 500
integer                 :: i, j, k, t
real(pr)                :: rr, trash1, trash2, trash3, fre, fim
real(pr), dimension(:)  :: xc(200), x(200), d(N), r(5)
complex(pr), dimension(101) :: x_hat, xc_hat
character(len=4)        :: rj


r = (/1.5_pr, 3.3_pr, 3.5_pr, 3.55_pr, 4._pr/)

print '(F4.2)', r(1), r(2), r(3), r(4), r(5)

do j = 1, 5

    write(rj, '(F4.2)') r(j)
    print *, 'ej8a_r_'//trim(rj)//'.dat'

    open(unit=10, file='ej8a_r_'//trim(rj)//'.dat', action='READ')
    read(10, *)

    do i = 1, N
        read(10, *) t, trash1, trash2, d(i), trash3, rr
    end do
    close(10)

    call dfftw_plan_dft_r2c_1d(plan_rc, 200, xc, xc_hat, FFTW_MEASURE)
    xc = d(301:500)
    call dfftw_execute_dft_r2c(plan_rc, xc, xc_hat)
    x_hat = xc_hat

    call dfftw_destroy_plan(plan_rc)

    open(unit=11, file='fourier'//'ej8a_r_'//trim(rj)//'.dat', action='write',&
        & status='unknown')
    write(11, *) "#  freq    real    imag"

    do k = -100, 100, 1
        if (k < 0) then
            fre = real(conjg(x_hat(-k+1) )/real(200, pr))
            fim = imag(conjg(x_hat(-k+1) )/real(200, pr))
            write(11,*) real(k, pr),  fre, fim
        else
            fre = real(x_hat(k+1) /real(200, pr))
            fim = imag(x_hat(k+1) /real(200, pr))
            write(11,*) real(k, pr), fre, fim
        end if
    end do
    close(11)
end do

end program powspec

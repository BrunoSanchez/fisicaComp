!
! ej1a.f90
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
program ej1a

use precision, pr => dp
use mtmod

implicit none
integer                             :: i, j, k
integer, parameter                  :: u_max=1500
integer, dimension(:), allocatable  :: s
integer                             :: tmc, n_down, n_up, n_left, n_right
integer                             :: spinadd, loc, L
real(pr),dimension(0:u_max)         :: corr_e, corr_m, e_c, m_c
real(pr)                            :: e, m, d_e, r, T, Rp, e_w
real(pr)                            :: prob(-4:4, -1:1)
character (30)                      :: Lchar, Tchar, L1, T1
character (30)                      :: outfile, corr_file
character (30)                      :: outf, corr_f


print *, "getting variables"
call get_command_argument(1, Tchar)
call get_command_argument(2, Lchar)
call get_command_argument(3, outf)
call get_command_argument(4, corr_f)

read(Tchar, *) T1
read(Lchar, *) L1
read(T1, *) T
read(L1, *) L
read(outf, *) outfile
read(corr_f, *) corr_file

print*,'T=',T
print*,'L=',L
print*,'out=', outfile
print*,'corr_out=', corr_file

allocate(s(0:(L*L)-1))

36 format(F8.4, 4X, F8.4, 4X, F8.4, 4X, F8.4, 4X)
38 format(F6.4, 4X, F6.4, 4X, I8)

open(unit=10, file=outfile, status='unknown')
write(10, *) "#m    e    m2    e2    "

! Inicializo la red de spines.
!  1 = up
! -1 = down
s = (/ (1, i=0, (L*L) - 1) /)

! energia del estado fundamental, en unidades de J
e = -2._pr * real(L*L, pr)

! correlaciones
corr_e = (/ (0, i=0, u_max) /)
corr_m = (/ (0, i=0, u_max) /)
loc = 0

m = sum(s)
write(10, 36) m/real(L*L,pr), e/real(L*L, pr), (m/real(L*L, pr))**2, (e/real(L*L, pr))**2

! posibles deltas de energia
do k = -4, 4, 2
    prob(k, +1) = exp( (-2._pr * real(k, pr)) / (2.2692_pr * T) )
    prob(k, -1) = exp( ( 2._pr * real(k, pr)) / (2.2692_pr * T) )
end do

! dar vuelta la red por completo una vez
! de forma ordenada
do tmc =1, 100000
    do k = 0, (L * L) -1
        i = mod(k, L)
        j = int(k/L)
        n_up    = mod(j-1+L, L) * L  +  i
        n_down  = mod(j+1  , L) * L  +  i
        n_left  = mod(i-1+L, L)  +  L * j
        n_right = mod(i+1  , L)  +  L * j
        ! calculo el delta de energia
        spinadd = s(n_up) + s(n_down) + s(n_left) + s(n_right)
        d_e = 2_pr * s(k) * spinadd
        if (d_e < 0) then
            s(k) = -1 * s(k)
            e = e + d_e
        else
            ! sorteo un numero random
            r = grnd()
            Rp = prob(spinadd, s(k))
            if ( Rp > r) then
                s(k) = -1 * s(k)
                e = e + d_e
            end if
        end if
    end do

    if (mod(tmc, 100)==0) then
        m = sum(s)/real(L*L, pr)
        e_w = e/real(L*L, pr)
        write(10, 36) m, e_w, m*m, e_w*e_w
    end if

    if (tmc > 10000) then  ! descarto transitorio
        ! actualizo e_c, m_c y calculo correlaciones corr_m,e
        e_c(mod(loc, u_max+1)) = e_w
        m_c(mod(loc, u_max+1)) = m

        if (loc>u_max) then
            do i = 0, u_max
                corr_e(i) = corr_e(i) + e_w*e_c(mod(loc-i, u_max+1))
                corr_m(i) = corr_m(i) + m * m_c(mod(loc-i, u_max+1))
            end do
        else
            do i = 0, loc
                corr_e(i) = corr_e(i) + e_w*e_c(loc-i)
                corr_m(i) = corr_m(i) + m * m_c(loc-i)
            end do
        end if
        loc = loc + 1

    end if
end do
close(10)

open(unit=11, file=corr_file, status='unknown')
write(11, *) "#   corr_m    corr_e   u_corr"
do i = 0, u_max
    write(11, 38) corr_m(i)/real(loc-i, pr), corr_e(i)/real(loc-i, pr), i
end do
close(11)

open(unit=17, file='spins_transaction.dat', status='unknown')
do j = 0, (L*L)-1
    write(17, *) s(j)
end do
close(17)

end program

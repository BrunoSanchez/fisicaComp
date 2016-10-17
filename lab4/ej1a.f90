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
integer                     :: i, j, k
integer, parameter          :: L=40, u_max=100
integer                     :: s(0:(L*L)-1), tmc
integer                     :: n_down, n_up, n_left, n_right, spinadd
! real(dp), parameter       :: k_b=1.3806488e-23
real(pr)                    :: e, m, d_e, r, T, Rp, e_w
real(pr),dimension(0:u_max) :: corr_e, corr_m, e_c, m_c
real(pr)                    :: prob(-4:4, -1:1)


36 format(F6.4, 4X, F6.4, 4X, F6.4, 4X)

open(unit=10, file='L_40-T_1_01.dat', status='unknown')
write(10, *) "#   m    e    m2    e2    "

! Inicializo la red de spines.
!  1 = up
! -1 = down
s = (/ (1, i=0, (L*L) - 1) /)

! energia del estado fundamental, en unidades de J
e = -2._pr * real(L*L, pr)

! correlaciones
corr_e = (/ (0, i=1, u_max) /)
corr_m = (/ (0, i=1, u_max) /)

write(10, 36) sum(s)/real(L*L,pr), e/real(L*L, pr)
T = 1.01_pr

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
            if ( Rp >= r) then
                s(k) = -1 * s(k)
                e = e + d_e
            end if
        end if
    end do

    if (tmc > 1000) then  ! descarto transitorio
        ! actualizo e_c, m_c y calculo correlaciones corr_m,e

        if (mod(tmc, 100)==0) then
            m = sum(s)/real(L*L, pr)
            e_w = e/real(L*L, pr)
            write(10, 36) m, e_w, m*m, e_w*e_w
        end if
    end if
end do

close(10)


end program
!
! ej1b.f90
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

use precision,  pr => dp
use mtmod

implicit none
integer                             :: i, j, k, ii
integer, parameter                  :: u_max=1500
integer, dimension(:), allocatable  :: s
integer                             :: tmc, n_down, n_up, n_left, n_right
integer                             :: spinadd, loc, L, ntot, ntermal=10000
real(pr),dimension(0:u_max)         :: corr_e, corr_m, e_c, m_c
real(pr)                            :: e, m, d_e, r, T, Rp, e_w, m2, m4, dm, e2
real(pr)                            :: prob(-4:4, -1:1), L2
character (30)                      :: L1, Lchar

print *, "getting variables"

call get_command_argument(1, Lchar)
read(Lchar, *) L1
read(L1, *) L
print*,'L=',L
L2 = real(L*L, pr)
allocate(s(0:(L*L)-1))

36 format(6(ES14.6e2, 4X))
38 format(F6.4, 4X, F6.4, 4X, I8)

open(unit=10, file='L_'//trim(Lchar)//'_Tvar.dat', status='unknown')
write(10, *) "#m    m2    m4    e    e2    T"

! Inicializo la red de spines.
!  1 = up
! -1 = down
print*, 'Initializing spins'
s = (/ (1, i=0, (L*L) - 1) /)

! energia del estado fundamental, en unidades de J
e = -2._pr * real(L*L, pr)
e_w = 0._pr
e2 = 0._pr

! correlaciones
corr_e = (/ (0, i=0, u_max) /)
corr_m = (/ (0, i=0, u_max) /)
loc = 0

m = sum(s)
m2 = m*m
m4 = m2*m2

write(10, 36) m/L2, m2/L2**2, m4/L2**4, e/L2, e2/L2**2, 0.01

! dar vuelta la red por completo una vez
! de forma ordenada
do ii = 999, 0, -1
    T = 0.01_pr + (ii/1000._pr)*1.8_pr

    ! posibles deltas de energia
    do k = -4, 4, 2
        prob(k, +1) = exp( (-2._pr * real(k, pr)) / (2.2692_pr * T) )
        prob(k, -1) = exp( ( 2._pr * real(k, pr)) / (2.2692_pr * T) )
    end do

    ! pasos de montecarlo
    do tmc =1, 100000
        ! recorro la red
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

        if (tmc > ntermal) then  ! descarto transitorio
            dm = sum(s)/L2
            m = m + dm
            m2 = m2 + dm*dm
            m4 = m4 + dm**4
            e_w = e_w + e/L2
            e2 = e2 + (e/L2)*(e/L2)
        end if

    end do

    ! calculo y guardo promedios
    ntot = real(tmc - ntermal, pr)

    write(10, 36) m/(L2*ntot), m2/(L2*ntot)**2, m4/(L2*ntot)**4, e_w/(L2*ntot), e2/(L2*ntot)**2, T
    m = 0
    m2 = 0
    m4 = 0
    e_w = 0
    e2 = 0

end do
close(10)



end program

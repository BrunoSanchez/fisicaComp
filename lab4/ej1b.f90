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
use ising

implicit none
integer                             :: i, j, k, ii
integer, parameter                  :: u_max=1500
integer, dimension(:), allocatable  :: s
integer                             :: tmc, n_down, n_up, n_left, n_right
integer                             :: spinadd, loc, L, ntot, ntermal=10000
real(pr),dimension(0:u_max)         :: corr_e, corr_m, e_c, m_c
real(pr)                            :: e, m, d_e, r, T, Rp, e_w, m2, m4, dm, e2
real(pr)                            :: prob(-4:4, -1:1), L2, cv, xi
character (30)                      :: L1, Lchar

print *, "getting variables"

call get_command_argument(1, Lchar)
read(Lchar, *) L1
read(L1, *) L
print*,'L=',L
L2 = real(L*L, pr)
allocate(s(0:(L*L)-1))

36 format(8(ES14.6e2, 4X))

open(unit=10, file='neg_modL_'//trim(Lchar)//'_Tvar.dat', status='unknown')
write(10, *) "#m    m2    m4    e    e2    cv    xi    T"

! Inicializo la red de spines.
!  1 = up
! -1 = down
print*, 'Iniciando spins'
call spin_initialize(s, L)
s = -1*s
! energia del estado fundamental, en unidades de J
e = -2._pr * real(L*L, pr)
e_w = 0._pr
e2 = 0._pr

!magnetizacion inicial
m = 0
m2 = 0
m4 = 0

! dar vuelta la red por completo
! de forma ordenada
do ii = 99, 0, -1
    T = 0.01_pr + (ii/100._pr)*2.8_pr

    ! posibles deltas de energia
    call probability(prob, T)

    ! pasos de montecarlo
    do tmc =1, 100000

        ! recorro la red
        do k = 0, (L*L) -1
            call metropolis_pbc(k, L, s, e, prob)
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
    m = m/ntot
    m2 = m2/ntot
    m4 = m4/ntot
    e_w = e_w/ntot
    e2 = e2/ntot

    xi = (-L2*(m*m - m2))/(2.2693*T)
    cv = (-L2*(e_w*e_w - e2))/(2.2693*T**2)

    write(10, 36) m, m2, m4, e_w, e2, cv, xi, T
    ! borro los acumuladores
    m = 0
    m2 = 0
    m4 = 0
    e_w = 0
    e2 = 0

end do
close(10)



end program

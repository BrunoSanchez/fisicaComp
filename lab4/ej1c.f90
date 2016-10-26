!
! ej1c.f90
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
program ej1c

use precision,  pr => dp
use mtmod
use ising

implicit none
integer :: i, j, k
integer, dimension(:), allocatable  :: s
integer                             :: tmc, n_down, n_up, n_left, n_right
integer                             :: spinadd, loc, L, ntermal=10e4, nmtc=10e6
real(pr)                            :: e, m, d_e, r, T, Rp
real(pr)                            :: prob(-4:4, -1:1)
! histogram
integer, parameter                  :: nbins=16
integer                             :: counts(1:nbins)
real(pr)                            :: bins(0:nbins), lo_lim, hi_lim, delta


36 format(I12, ES14.6e2)

T = 1.05

! posibles deltas de energia
call probability(prob, T)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
L = 10
allocate(s(0:(L*L)-1))

open(unit=10, file='ej1c_L10_T_hi.dat', status='unknown')
write(10, *) "#counts    center"

! Inicializo la red de spines.
!  1 = up
! -1 = down
print*, 'Iniciando spins up'
call spin_initialize(s, L)
! energia del estado fundamental, en unidades de J
e = -2._pr * real(L*L, pr)
!inicio histograma
lo_lim = -1.1
hi_lim =  1.1
call histo_init(bins, counts, nbins, lo_lim, hi_lim, delta)
! pasos de montecarlo
do tmc =1, nmtc
    ! recorro la red
    do k = 0, (L*L) -1
        call metropolis_pbc(k, L, s, e, prob)
    end do
    if (tmc > ntermal) then  ! descarto transitorio
        m = sum(s)/real(L*L, pr)
        call histogram(bins, m, counts, nbins, delta)
    end if
end do
! Inicializo la red de spines.
!  1 = up
! -1 = down
print*, 'Iniciando spins down'
call spin_initialize(s, L)
s = -1*s
! energia del estado fundamental, en unidades de J
e = -2._pr * real(L*L, pr)
! pasos de montecarlo
do tmc =1, nmtc
    ! recorro la red
    do k = 0, (L*L) -1
        call metropolis_pbc(k, L, s, e, prob)
    end do
    if (tmc > ntermal) then  ! descarto transitorio
        m = sum(s)/real(L*L, pr)
        call histogram(bins, m, counts, nbins, delta)
    end if
end do

do j = 1, nbins
    write(10, 36) counts(j), lo_lim + j*(delta/2._pr)
end do

close(10)
deallocate(s)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
L = 20
allocate(s(0:(L*L)-1))

open(unit=10, file='ej1c_L20_T_hi.dat', status='unknown')
write(10, *) "#counts    center"

! Inicializo la red de spines.
!  1 = up
! -1 = down
print*, 'Iniciando spins up'
call spin_initialize(s, L)
! energia del estado fundamental, en unidades de J
e = -2._pr * real(L*L, pr)
!inicio histograma
lo_lim = -1.1
hi_lim =  1.1
call histo_init(bins, counts, nbins, lo_lim, hi_lim, delta)
! pasos de montecarlo
do tmc =1, nmtc
    ! recorro la red
    do k = 0, (L*L) -1
        call metropolis_pbc(k, L, s, e, prob)
    end do
    if (tmc > ntermal) then  ! descarto transitorio
        m = sum(s)/real(L*L, pr)
        call histogram(bins, m, counts, nbins, delta)
    end if
end do
! Inicializo la red de spines.
!  1 = up
! -1 = down
print*, 'Iniciando spins down'
call spin_initialize(s, L)
s = -1*s
! energia del estado fundamental, en unidades de J
e = -2._pr * real(L*L, pr)
! pasos de montecarlo
do tmc =1, nmtc
    ! recorro la red
    do k = 0, (L*L) -1
        call metropolis_pbc(k, L, s, e, prob)
    end do
    if (tmc > ntermal) then  ! descarto transitorio
        m = sum(s)/real(L*L, pr)
        call histogram(bins, m, counts, nbins, delta)
    end if
end do

do j = 1, nbins
    write(10, 36) counts(j), lo_lim + j*(delta/2._pr)
end do

close(10)
deallocate(s)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
L = 40
allocate(s(0:(L*L)-1))

open(unit=10, file='ej1c_L40_T_hi.dat', status='unknown')
write(10, *) "#counts    center"

! Inicializo la red de spines.
!  1 = up
! -1 = down
print*, 'Iniciando spins up'
call spin_initialize(s, L)
! energia del estado fundamental, en unidades de J
e = -2._pr * real(L*L, pr)
!inicio histograma
lo_lim = -1.1
hi_lim =  1.1
call histo_init(bins, counts, nbins, lo_lim, hi_lim, delta)
! pasos de montecarlo
do tmc =1, nmtc
    ! recorro la red
    do k = 0, (L*L) -1
        call metropolis_pbc(k, L, s, e, prob)
    end do
    if (tmc > ntermal) then  ! descarto transitorio
        m = sum(s)/real(L*L, pr)
        call histogram(bins, m, counts, nbins, delta)
    end if
end do
! Inicializo la red de spines.
!  1 = up
! -1 = down
print*, 'Iniciando spins down'
call spin_initialize(s, L)
s = -1*s
! energia del estado fundamental, en unidades de J
e = -2._pr * real(L*L, pr)
! pasos de montecarlo
do tmc =1, nmtc
    ! recorro la red
    do k = 0, (L*L) -1
        call metropolis_pbc(k, L, s, e, prob)
    end do
    if (tmc > ntermal) then  ! descarto transitorio
        m = sum(s)/real(L*L, pr)
        call histogram(bins, m, counts, nbins, delta)
    end if
end do

do j = 1, nbins
    write(10, 36) counts(j), lo_lim + (j-0.5)*delta/2._pr)
end do

close(10)
deallocate(s)

end program

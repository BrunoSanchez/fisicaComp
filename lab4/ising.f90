!
! metropolis.f90
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
MODULE ising

use precision,  pr => dp
use mtmod

implicit none
contains

subroutine spin_initialize(s, L)
integer, intent(in)                 :: L
integer, intent(inout)              :: s(0:(L*L)-1)
integer                             :: i

    s = (/ (1, i=0, (L*L) - 1) /)
end subroutine


! metropolis subroutine, uses the s spin array and runs a MC step
subroutine metropolis_pbc(k, L, s, e, prob)
integer                             :: i, j
integer, intent(in)                 :: k, L
integer, intent(inout)                 :: s(0:(L*L)-1)
integer                             :: spinadd, n_up, n_down, n_left, n_right
real(pr), intent(in)                :: prob(-4:4, -1:1)
real(pr), intent(inout)             :: e
real(pr)                            :: d_e, Rp, r

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

end subroutine

subroutine probability(prob, T)
real(pr), intent(inout)             :: prob(-4:4,-1:1)
real(pr), intent(in)                :: T
integer                             :: k

    do k = -4, 4, 2
        prob(k, +1) = exp( (-2._pr * real(k, pr)) / (2.2692_pr * T) )
        prob(k, -1) = exp( ( 2._pr * real(k, pr)) / (2.2692_pr * T) )
    end do
end subroutine


END MODULE ising

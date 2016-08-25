        program gau
        implicit none
!
        real (kind(0.d0))     :: a,b,fx,exacto,gerror,serror,terror  ! conservar doble prec.
        real (kind(0.d0))     :: gcuad,h
        real (kind(0.d0))     :: simpson,trapezoid
        real (kind(0.d0)), allocatable  :: x(:),w(:)                 ! conservar doble prec.
        integer              :: i,j,np,npts,in,n_max
!
        a = 0.d0   ! limite inferior de integracion
        b = 1.d0   ! limite superior de integracion
!
        exacto = 1.d0 - exp(-1.d0)   !  valor exacto de la integral
!
!
        open(37,file='err_gau.d',status='replace')
!
!       calculo para diferentes valores de n
        n_max = 30
!
        do in=3,n_max,2
          npts = in-1
!
          call gausscuad(npts,a,b,gcuad)
          gerror = abs(gcuad - exacto)
          write(37,'(I5,2x,3(E15.6,2x))') in,gerror
        enddo
        close(37)
!
        CONTAINS
!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
!
        subroutine gausscuad(n,a,b,gau)
!       calcula la integral de la funcion Func, entre a y b
!       utilizando n puntos de evaluacion, mediante 
!       la cuadratura de Gauss-Legendre (gau)
!
        use gaussmod, only : gauss
        implicit none
        real (kind(0.d0)), INTENT(IN)  :: a,b
        integer, INTENT(IN)            :: n
        real (kind(0.d0)), INTENT(OUT) :: gau
        real (kind(0.d0))              :: w(0:n),x(0:n)
        integer                        :: j
!
        call gauss(npts,0,a,b,x(0:npts),w(0:npts))  ! calculo nodos y pesos para Gauss
!  
!       calculo la integral
          gau  = 0.d0
!
          do j=0,n
            call func(x(j),fx)
            gau = gau + fx*w(j)
          enddo      
        return
        end subroutine gausscuad
!
!
!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
!
!
        subroutine func(x,fx)
        implicit none
        real (kind(0.d0)), INTENT(IN)  :: x
        real (kind(0.d0)), INTENT(OUT) :: fx
!
        fx = exp(-x)
        return
        end subroutine func
!
!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
!
!
        end program 

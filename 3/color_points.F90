! part 1
module color_points  ! This is the ancestor module
   type color_point
      private
      real :: x, y
      integer :: color
   end type color_point

   ! Below is the interface declaration of the separate module procedures. 
   ! No IMPORT statement is used in the interface bodies.
   ! The separate module procedures are implemented in the two submodules.
   Interface
      module subroutine color_point_del ( p ) 
        type(color_point), allocatable :: p
      end subroutine color_point_del

      real module function color_point_dist ( a, b )
        type(color_point), intent(in) :: a, b
      end function color_point_dist

      module subroutine color_point_draw ( p )
        type(color_point), intent(in) :: p
      end subroutine color_point_draw

      module subroutine color_point_new ( p )
        type(color_point), allocatable :: p
      end subroutine color_point_new
   end interface
end module color_points

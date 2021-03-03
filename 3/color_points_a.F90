! part 2
submodule ( color_points ) color_points_a  ! submodule of color_points
   integer :: instance_count = 0

   ! Below is the interface declaration of the separate module procedure
   !   inquire_palette, which is implemented in the submodule color_points_b.
   interface 
   module subroutine inquire_palette ( pt, pal )
   use palette_stuff 
   ! Later you will see that module palette_stuff uses color_points.
   ! This use of palette_stuff however does not cause a circular
   !   dependence because this use is not in the module.
         type(color_point), intent(in) :: pt
         type(palette), intent(out) :: pal
      end subroutine inquire_palette
   end interface

contains  
   ! Here are the implementations of three of the four separate module
   !   procedures declared in module color_point. 
   module subroutine color_point_del ( p )
     type(color_point), allocatable :: p
     instance_count = instance_count - 1
     deallocate ( p )
   end subroutine color_point_del

   real module function color_point_dist ( a, b ) result ( dist )
     type(color_point), intent(in) :: a, b
     dist = sqrt( (b%x - a%x)**2 + (b%y - a%y)**2 )
   end function color_point_dist

   module subroutine color_point_new ( p )
     type(color_point), allocatable :: p
     instance_count = instance_count + 1
     allocate ( p )
   end subroutine color_point_new

end submodule color_points_a

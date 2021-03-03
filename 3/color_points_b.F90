! part 3
submodule ( color_points:color_points_a ) color_points_b
! submodule of color_point_a
contains
   ! Implementation of a module procedure declared in the ancestor module
   module subroutine color_point_draw ( p )
   use palette_stuff, only: palette
   type(color_point), intent(in) :: p
   type(palette) :: MyPalette

   end subroutine color_point_draw

   ! Implementation of a module procedure declared in the parent submodule
   module procedure inquire_palette

   end procedure inquire_palette

   ! A procedure only accessible from color_points_b and its submodules
   subroutine private_stuff 

   end subroutine private_stuff

end submodule color_points_b

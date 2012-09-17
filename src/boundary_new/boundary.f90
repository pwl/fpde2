module class_boundary

  use class_platonic
  use class_passive_icicles
  use constants_module

  private

  type, public, abstract, extends(platonic) :: boundary
     private
     character(len=:), allocatable :: param_names(:)
   contains
     ! procedure :: init
     procedure(gen_val), deferred :: generate_values
     procedure, non_overridable :: get_param_names
     procedure, non_overridable :: set_param_names
  end type boundary

  interface
     subroutine gen_val(self, ic, fin, fout, xin, error)
       import boundary, passive_icicles
       class(boundary) :: self
       class(passive_icicles), intent(in) :: ic
       integer, intent(out), optional :: error
       real, intent(in) :: fin(:,:), xin(:,:)
       real, intent(out) :: fout(:,:)
     end subroutine gen_val
  end interface

contains

  function get_param_names(self)
    class(boundary) :: self
    ! character(len=:), allocatable :: get_param_names(:)
    character(len=:), allocatable :: get_param_names(:)

    get_param_names = self%param_names
  end function get_param_names

  subroutine set_param_names(self, names)
    class(boundary) :: self
    character(len=*) :: names(:)

    self%param_names = names
  end subroutine set_param_names


end module class_boundary

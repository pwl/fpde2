module class_function

  use constants_module
  use class_platonic
  use class_boundary
  use flu_get_module
  use flu_module

  private

  integer, parameter, public :: &
       FUNC_EVOLVED = 1

  character(len=NAME_LEN), parameter, public :: &
       TAG_FUNC_EVOLVED = "evolved",&
       TAG_FUNC_DERIVATIVE = "derivatives"

  integer, parameter :: &
       MAX_PARAMETERS = 10

  type, public, extends(platonic) :: func
     integer :: len = 0
     character(len=NAME_LEN) :: parameters(MAX_PARAMETERS) = ""
     class(boundary), pointer :: boundary => null()
     real, pointer :: val(:) => null()
     integer :: derivatives(5,10) = -1
     ! integer, pointer :: derivatives(:,:) => null()
   contains
     procedure :: from_lua
  end type func

contains

  subroutine from_lua(p, l, error)
    class(func) :: p
    type(flu) :: l
    integer, optional, intent(out) :: error

    integer :: err = FPDE_STATUS_ERROR
    character(len=100) :: name

    ! get name
    call flu_get_atomic( l,&
         char = p%name,&
         key = TAG_NAME,&
         error = err )

    ! get derivatives vector
    call flu_get_atomic( l,&
         val2d = p%derivatives,&
         key = TAG_FUNC_DERIVATIVE,&
         error = err )

    ! if( err /= FPDE_STATUS_OK ) then
    !    if(present(error)) error = err
    !    call p%log(FPDE_LOG_ERROR, "Function name not set")
    ! end if

    ! ! get parameters
    ! call flu_get_atomic( l,&
    !      val = p%parameters(FUNC_EVOLVED),&
    !      key = TAG_FUNC_EVOLVED,&
    !      error = err )

    ! ! get derivative table
    ! call lua_getfield(l,-1,TAG_FUNC_DERIVATIVE)
    ! ! get length of derivative table
    ! n_der = lua_len(l,-1)
    ! call lua_pop(l,1)
    ! ! allocate space for derivative table
    ! allocate(p%derivatives(FUNC_MAX_DERIVATIVE_RK,n_der))
    ! ! traverse lua table and get all derivatives to p%derivatives
    ! call lua_pushnil(l)

    ! do i = 1, n_der
    !    call lua_pushinteger(l,i)
    !    call lua_rawget(l,-2)
    !    call flu_get_table_integer(l,&
    !         p%derivatives(:,i), default = FUNC_DERIVATIVE_DEFAULT)
    !    call lua_pop(l,1)
    ! end do

    if(present(error)) error = err

  end subroutine from_lua

end module class_function

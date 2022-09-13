"! <p class="shorttext synchronized" lang="EN">Dynamic structure</p>
"! Inherits from {@link ZCL_DYNAMIC_COMPLEX_DATA_OBJ}
class zcl_dynamic_structure definition
                            public
                            create public
                            inheriting from zcl_dynamic_complex_data_obj.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Specialization of super constructor</p>
    "!
    "! @parameter i_structure | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_structure type any.

    "! <p class="shorttext synchronized" lang="EN">Specialization of {@link ZCL_DYNAMIC_VARIABLE.METH:_TYPE}</p>
    "!
    "! @parameter r_type | <p class="shorttext synchronized" lang="EN"></p>
    methods type
              returning
                value(r_type) type ref to cl_abap_structdescr.

    "! <p class="shorttext synchronized" lang="EN">Specialization of {@link ZCL_DYNAMIC_VARIABLE.METH:_FROM}</p>
    "!
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_dyn_var | <p class="shorttext synchronized" lang="EN"></p>
    class-methods from
                    importing
                      i_type type ref to cl_abap_structdescr
                    returning
                      value(r_dyn_var) type ref to zcl_dynamic_structure.

ENDCLASS.



CLASS ZCL_DYNAMIC_STRUCTURE IMPLEMENTATION.


  method constructor.

    super->constructor( i_structure ).

    if not ( me->type( )->kind eq cl_abap_typedescr=>kind_struct ).

      raise shortdump type instantiation_error.

    endif.

  endmethod.


  method from.

    r_dyn_var = cast #( zcl_dynamic_variable=>_from( i_type ) ).

  endmethod.


  method type.

    r_type = cast #( me->_type( ) ).

  endmethod.
ENDCLASS.

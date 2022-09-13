"! <p class="shorttext synchronized" lang="EN">Dynamic internal table</p>
"! Inherits from {@link ZCL_DYNAMIC_COMPLEX_DATA_OBJ}
class zcl_dynamic_internal_table definition
                                 public
                                 create public
                                 inheriting from zcl_dynamic_complex_data_obj.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Specialization of super constructor</p>
    "!
    "! @parameter i_internal_table | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_internal_table type any.

    "! <p class="shorttext synchronized" lang="EN">Specialization of {@link ZCL_DYNAMIC_VARIABLE.METH:_TYPE}</p>
    "!
    "! @parameter r_type | <p class="shorttext synchronized" lang="EN"></p>
    methods type
              returning
                value(r_type) type ref to cl_abap_tabledescr.

    "! <p class="shorttext synchronized" lang="EN">Specialization of {@link ZCL_DYNAMIC_VARIABLE.METH:_FROM}</p>
    "!
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_dyn_var | <p class="shorttext synchronized" lang="EN"></p>
    class-methods from
                    importing
                      i_type type ref to cl_abap_tabledescr
                    returning
                      value(r_dyn_var) type ref to zcl_dynamic_internal_table.

ENDCLASS.



CLASS ZCL_DYNAMIC_INTERNAL_TABLE IMPLEMENTATION.


  method constructor.

    super->constructor( i_internal_table ).

    if not ( me->type( )->kind eq cl_abap_typedescr=>kind_table ).

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

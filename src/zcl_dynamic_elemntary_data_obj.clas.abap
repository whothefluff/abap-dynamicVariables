"! <p class="shorttext synchronized" lang="EN">Dynamic elementary data object</p>
"! Inherits from {@link ZCL_DYNAMIC_DATA_OBJECT}
class zcl_dynamic_elemntary_data_obj definition
                                     public
                                     create public
                                     inheriting from zcl_dynamic_data_object.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Specialization of super constructor</p>
    "!
    "! @parameter i_elementary_data_object | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_elementary_data_object type any.

    "! <p class="shorttext synchronized" lang="EN">Specialization of {@link ZCL_DYNAMIC_VARIABLE.METH:_TYPE}</p>
    "!
    "! @parameter r_type | <p class="shorttext synchronized" lang="EN"></p>
    methods type
              returning
                value(r_type) type ref to cl_abap_elemdescr.

    "! <p class="shorttext synchronized" lang="EN">Specialization of {@link ZCL_DYNAMIC_VARIABLE.METH:_FROM}</p>
    "!
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_dyn_var | <p class="shorttext synchronized" lang="EN"></p>
    class-methods from
                    importing
                      i_type type ref to cl_abap_elemdescr
                    returning
                      value(r_dyn_var) type ref to zcl_dynamic_elemntary_data_obj.

ENDCLASS.



CLASS ZCL_DYNAMIC_ELEMNTARY_DATA_OBJ IMPLEMENTATION.


  method constructor.

    super->constructor( i_elementary_data_object ).

    if not ( me->type( )->kind eq cl_abap_typedescr=>kind_elem ).

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

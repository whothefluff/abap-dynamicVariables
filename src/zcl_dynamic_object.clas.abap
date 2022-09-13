"! <p class="shorttext synchronized" lang="EN">Dynamic object</p>
"! Inherits from {@link ZCL_DYNAMIC_VARIABLE}
class zcl_dynamic_object definition
                         public
                         create public
                         inheriting from zcl_dynamic_variable.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Specialization of super constructor</p>
    "!
    "! @parameter i_object | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_object type ref to object.

    "! <p class="shorttext synchronized" lang="EN">Specialization of {@link ZCL_DYNAMIC_VARIABLE.METH:_VALUE}</p>
    "!
    "! @parameter r_value | <p class="shorttext synchronized" lang="EN"></p>
    methods value
              returning
                value(r_value) type ref to object.

    "! <p class="shorttext synchronized" lang="EN">Specialization of {@link ZCL_DYNAMIC_VARIABLE.METH:_TYPE}</p>
    "!
    "! @parameter r_type | <p class="shorttext synchronized" lang="EN"></p>
    methods type
              returning
                value(r_type) type ref to cl_abap_classdescr.

    "! <p class="shorttext synchronized" lang="EN">Specialization of {@link ZCL_DYNAMIC_VARIABLE.METH:_FROM}</p>
    "!
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_constructor_parameters | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter e_constructor_exceptions | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_dyn_var | <p class="shorttext synchronized" lang="EN"></p>
    class-methods from
                    importing
                      i_type type ref to cl_abap_classdescr
                      i_constructor_parameters type abap_parmbind_tab optional
                    exporting
                      value(e_constructor_exceptions) type abap_excpbind_tab
                    returning
                      value(r_dyn_var) type ref to zcl_dynamic_object
                    raising
                      cx_sy_dyn_call_parameter_error
                      cx_sy_create_object_error
                      zcx_dynamic_object.

    "! <p class="shorttext synchronized" lang="EN">Specializ. of {@link ZCL_DYNAMIC_VARIABLE.METH:_DUPLICATE}</p>
    "!
    "! @parameter i_object | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_dyn_object | <p class="shorttext synchronized" lang="EN"></p>
    class-methods duplicate
                    importing
                      i_object type ref to object
                    returning
                      value(r_dyn_object) type ref to zcl_dynamic_object.

ENDCLASS.



CLASS ZCL_DYNAMIC_OBJECT IMPLEMENTATION.


  method constructor.

    super->constructor( i_object ).

  endmethod.


  method duplicate.

    r_dyn_object = cast #( zcl_dynamic_variable=>_duplicate( i_object ) ).

  endmethod.


  method from.

    r_dyn_var = cast #( zcl_dynamic_variable=>_from( i_type ) ).

  endmethod.


  method type.

    r_type = cast #( me->_type( ) ).

  endmethod.


  method value.

    r_value = me->a_class_object.

  endmethod.
ENDCLASS.

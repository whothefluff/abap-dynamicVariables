class zcl_dynamic_object definition
                         public
                         create public
                         inheriting from zcl_dynamic_variable.

  public section.

    methods constructor
              importing
                i_object type ref to object.

    methods value
              returning
                value(r_value) type ref to object.

    methods type
              returning
                value(r_type) type ref to cl_abap_classdescr.

    class-methods from_type
                    importing
                      i_type type ref to cl_abap_typedescr
                    returning
                      value(r_dyn_var) type ref to zcl_dynamic_object.

ENDCLASS.



CLASS ZCL_DYNAMIC_OBJECT IMPLEMENTATION.


  method constructor.

    super->constructor( i_object ).

  endmethod.


  method type.

    cl_abap_typedescr=>describe_by_object_ref( exporting p_object_ref = me->value( )
                                               receiving p_descr_ref = data(object_type)
                                               exceptions others = 0 ).

    r_type = cast #( object_type ).

  endmethod.


  method value.

    r_value = me->object.

  endmethod.


  method from_type.

    r_dyn_var = cast #( zcl_dynamic_variable=>_from( i_type ) ).

  endmethod.
ENDCLASS.

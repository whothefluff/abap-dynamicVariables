class zcl_dynamic_elemntary_data_obj definition
                                     public
                                     create public
                                     inheriting from zcl_dynamic_data_object.

  public section.

    methods type
              returning
                value(r_type) type ref to cl_abap_elemdescr.

    class-methods from_type
                    importing
                      i_type type ref to cl_abap_typedescr
                    returning
                      value(r_dyn_var) type ref to zcl_dynamic_elemntary_data_obj.

ENDCLASS.



CLASS ZCL_DYNAMIC_ELEMNTARY_DATA_OBJ IMPLEMENTATION.


  method type.

    cl_abap_typedescr=>describe_by_data( exporting p_data = me->value( )
                                         receiving p_descr_ref = data(element_type)
                                         exceptions others = 0 ).

    r_type = cast #( element_type ).

  endmethod.


  method from_type.

    r_dyn_var = cast #( zcl_dynamic_variable=>_from( i_type ) ).

  endmethod.
ENDCLASS.

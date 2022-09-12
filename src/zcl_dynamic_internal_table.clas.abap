class zcl_dynamic_internal_table definition
                                 public
                                 create public
                                 inheriting from zcl_dynamic_complex_data_obj.

  public section.

    methods type
              returning
                value(r_type) type ref to cl_abap_tabledescr.

    class-methods from_type
                    importing
                      i_type type ref to cl_abap_typedescr
                    returning
                      value(r_dyn_var) type ref to zcl_dynamic_internal_table.

ENDCLASS.



CLASS ZCL_DYNAMIC_INTERNAL_TABLE IMPLEMENTATION.


  method from_type.

    r_dyn_var = cast #( zcl_dynamic_variable=>_from( i_type ) ).

  endmethod.


  method type.

    cl_abap_typedescr=>describe_by_data( exporting p_data = me->value( )
                                         receiving p_descr_ref = data(itab_type)
                                         exceptions others = 0 ).

    r_type = cast #( itab_type ).

  endmethod.
ENDCLASS.

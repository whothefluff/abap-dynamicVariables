"! <p class="shorttext synchronized" lang="EN">Dynamic structure</p>
"! Inherits from {@link zcl_dynamic_complex_data_obj}
class zcl_dynamic_structure definition
                            public
                            create public
                            inheriting from zcl_dynamic_complex_data_obj.

  public section.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "!
    "! @parameter r_type | <p class="shorttext synchronized" lang="EN"></p>
    methods type
              returning
                value(r_type) type ref to cl_abap_structdescr.

    "! <p class="shorttext synchronized" lang="EN"></p>
    "! Like {@link zcl_dynamic_complex_data_obj.METH:_from }, but with a more specific type
    "!
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_dyn_var | <p class="shorttext synchronized" lang="EN"></p>
    class-methods from
                    importing
                      i_type type ref to cl_abap_typedescr
                    returning
                      value(r_dyn_var) type ref to zcl_dynamic_structure.

ENDCLASS.



CLASS ZCL_DYNAMIC_STRUCTURE IMPLEMENTATION.


  method type.

    cl_abap_typedescr=>describe_by_data( exporting p_data = me->value( )
                                         receiving p_descr_ref = data(structure_type)
                                         exceptions others = 0 ).

    r_type = cast #( structure_type ).

  endmethod.


  method from.

    r_dyn_var = cast #( zcl_dynamic_variable=>_from( i_type ) ).

  endmethod.
ENDCLASS.

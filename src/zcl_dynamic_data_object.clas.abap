class zcl_dynamic_data_object definition
                              public
                              create public
                              inheriting from zcl_dynamic_variable.

  public section.

    methods constructor
              importing
                i_data_object type ref to data.

    methods value
              returning
                value(r_value) type ref to data.

ENDCLASS.



CLASS ZCL_DYNAMIC_DATA_OBJECT IMPLEMENTATION.


  method constructor.

    super->constructor( i_data_object ).

  endmethod.


  method value.

    r_value = me->data.

  endmethod.
ENDCLASS.

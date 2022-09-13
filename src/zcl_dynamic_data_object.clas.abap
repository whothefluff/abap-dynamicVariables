"! <p class="shorttext synchronized" lang="EN">Dynamic data object</p>
"! Inherits from {@link ZCL_DYNAMIC_VARIABLE}
"! <br/>Has specialized subclasses {@link ZCL_DYNAMIC_ELEMNTARY_DATA_OBJ} and {@link ZCL_DYNAMIC_COMPLEX_DATA_OBJ}
class zcl_dynamic_data_object definition
                              public
                              create public
                              inheriting from zcl_dynamic_variable.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Specialization of {@link ZCL_DYNAMIC_VARIABLE.METH:_VALUE}</p>
    "!
    "! @parameter r_value | <p class="shorttext synchronized" lang="EN"></p>
    methods value
              returning
                value(r_value) type ref to data.

ENDCLASS.



CLASS ZCL_DYNAMIC_DATA_OBJECT IMPLEMENTATION.





  method value.

    r_value = me->a_data_object.

  endmethod.
ENDCLASS.

"! <p class="shorttext synchronized" lang="EN">Dynamic variable</p>
class zcl_dynamic_variable definition
                           public
                           create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Use the provided variable to instantiate the class</p>
    "! The <em>variable</em> may be an object reference, a data object reference, or a regular data object (including internal tables, structures, etc.)
    "! <br/> For not-referenced data objects, a reference to the original variable is created (with all the consequences this entails)
    "!
    "! @parameter i_variable | <p class="shorttext synchronized" lang="EN">Any kind of variable</p>
    methods constructor
              importing
                i_variable type any.

    "! <p class="shorttext synchronized" lang="EN">Duplicates the supplied variable and returns it</p>
    "! In case of a reference variable, it creates a new reference in the heap and assigns the value of the original reference.
    "! If the supplied variable is a data reference, subsequent calls are made until reaching a non-reference variable and then assigning this value to the new reference.
    "! This is done mainly because 1) duplicating a variable of this sort is as easy as assigning the original reference and 2) consistency with the FROM method
    "! <br/><strong>Warning</strong> Only objects that implement the interface {@link if_serializable_object} can be duplicated, and this requisite applies to its attributes too
    "! <br/><strong>Important!</strong> If objects to be duplicated contain stack references, these must not have been freed, otherwise a runtime error will occur
    "!
    "! @parameter i_variable | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_dyn_var_duplicate | <p class="shorttext synchronized" lang="EN"></p>
    "! @raising cx_transformation_error | Error when trying to copy a class using an ID transformation
    class-methods _duplicate
                    importing
                      i_variable type any
                    returning
                      value(r_dyn_var_duplicate) type ref to zcl_dynamic_variable
                    raising
                      cx_transformation_error.

    "! <p class="shorttext synchronized" lang="EN">Returns a variable of the supplied type or referenced type</p>
    "! If the supplied type is a data reference type (and create data doesn't work for these variables), subsequent calls are made until reaching a non-reference type.
    "! The variable is then created with that type
    "! <br/>For object references, constructor parameters can be provided
    "!
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter i_object_construct_parameters | <p class="shorttext synchronized" lang="EN"></p>
    "! @parameter r_new_dyn_var | <p class="shorttext synchronized" lang="EN"></p>
    "! @raising cx_sy_create_data_error | The type of the data object is generic to some degree
    "! @raising cx_sy_dyn_call_parameter_error | The provided parameters to instantiate the object were not correct
    "! @raising cx_sy_create_object_error | The class cannot be instantiated for some reason (private, abstract, etc.)
    class-methods _from
                    importing
                      i_type type ref to cl_abap_typedescr
                      i_object_construct_parameters type abap_parmbind_tab optional
                    returning
                      value(r_new_dyn_var) type ref to zcl_dynamic_variable
                    raising
                      cx_sy_create_data_error
                      cx_sy_dyn_call_parameter_error
                      cx_sy_create_object_error.

    methods _type
              returning
                value(r_type) type ref to cl_abap_typedescr.

    methods _value
              exporting
                value(e_value) type any.

  protected section.

    data data type ref to data.

    data object type ref to object.

    data a_type type ref to cl_abap_typedescr.

ENDCLASS.



CLASS ZCL_DYNAMIC_VARIABLE IMPLEMENTATION.


  method constructor.

    data(supplied_var_type) = cl_abap_typedescr=>describe_by_data( i_variable ).

    try.

      if cast cl_abap_refdescr( supplied_var_type )->get_referenced_type( ) is instance of cl_abap_datadescr.

        me->data = i_variable.

      else.

        me->object = i_variable.

      endif.

    catch cx_sy_move_cast_error into data(cast_error).

      me->data = ref #( i_variable ).

    endtry.

    me->a_type = supplied_var_type.

  endmethod.


  method _duplicate.

    data duplicated_object type ref to object.

    field-symbols <dyn_var> type any.

    data(var_type) = cl_abap_typedescr=>describe_by_data( i_variable ).

    if var_type->kind eq cl_abap_typedescr=>kind_ref "the method 'describe_by_data' returns a reference type in general (including objects)
       and cast cl_abap_refdescr( var_type )->get_referenced_type( )->kind eq cl_abap_typedescr=>kind_class.

      data(writer) = cast if_sxml_writer( cl_sxml_string_writer=>create( if_sxml=>co_xt_json ) ).

      call transformation id
        source oref = i_variable
        result xml writer
        options data_refs = 'heap-or-create'
                initial_components = 'include'
                technical_types = 'error'
                value_handling = 'default'
                xml_header = 'full'.

      data(reader) = cast if_sxml_reader( cl_sxml_string_reader=>create( cast cl_sxml_string_writer( writer )->get_output( ) ) ).

      call transformation id
        source xml reader
        result oref = duplicated_object
        options clear = 'none'
                value_handling = 'reject_illegal_characters'.

      data(new_var) = new zcl_dynamic_variable( duplicated_object ).

*      "no activa en cloud
*      system-call objmgr clone i_variable to duplicated_object.

    else.

      new_var = zcl_dynamic_variable=>_from( var_type ).

      if var_type is instance of cl_abap_refdescr.

        new_var->data = zcl_dynamic_variable=>_duplicate( i_variable->* )->data.

      else.

        assign new_var->data->* to <dyn_var>.

        <dyn_var> = i_variable.

      endif.

    endif.

    r_dyn_var_duplicate = new_var.

  endmethod.


  method _from.

    data data type ref to data.

    data object type ref to object.

    field-symbols <dyn_var> type any.

    try.

      data(data_type) = cast cl_abap_datadescr( i_type ).

      create data data type handle data_type.

      assign data->* to <dyn_var>.

    catch cx_sy_move_cast_error.

      data(class_type) = cast cl_abap_classdescr( i_type )."interfaces are never instantiable

      data(non_class_exceptions) = value abap_excpbind_tab( ).

      create object object
        type (class_type->absolute_name)
        parameter-table i_object_construct_parameters
        exception-table non_class_exceptions.

      assign object to <dyn_var>.

    endtry.

    r_new_dyn_var = switch #( i_type->kind
                              when cl_abap_typedescr=>kind_class
                              then new zcl_dynamic_object( object )
                              when cl_abap_typedescr=>kind_struct
                              then new zcl_dynamic_structure( data )
                              when cl_abap_typedescr=>kind_table
                              then new zcl_dynamic_internal_table( data )
                              when cl_abap_typedescr=>kind_elem
                              then new zcl_dynamic_elemntary_data_obj( data )
                              when cl_abap_typedescr=>kind_ref
                              then zcl_dynamic_variable=>_from( cast cl_abap_refdescr( i_type )->get_referenced_type( ) ) ).

  endmethod.


  method _type.

*    data value type ref to any.
*
*    me->_value( importing e_value = data(test) ).

  endmethod.


  method _value.

    e_value = cond #( when me->data is not initial
                      then me->data
                      else me->object ).

  endmethod.

ENDCLASS.

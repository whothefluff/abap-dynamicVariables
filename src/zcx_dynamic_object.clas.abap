"! <p class="shorttext synchronized" lang="EN">Dynamic object error</p>
class zcx_dynamic_object definition
                         public
                         inheriting from cx_no_check
                         create public.

  public section.

    Interfaces: if_t100_dyn_msg.

    "! <p class="shorttext synchronized" lang="EN">Create an exception. Can use either a t100 msg or a text ID</p>
    "! Providing <strong>both</strong> text parameters will result in a <strong>short dump</strong>
    "!
    "! @parameter i_t100_message | <p class="shorttext synchronized" lang="EN">t100 message</p>
    "! @parameter i_textid | <p class="shorttext synchronized" lang="EN">t100 message key</p>
    "! @parameter i_previous | <p class="shorttext synchronized" lang="EN"></p>
    methods constructor
              importing
                i_t100_message type ref to if_t100_dyn_msg optional
                i_textid like if_t100_message=>t100key optional
                i_previous like previous optional
                preferred parameter i_t100_message.

ENDCLASS.



CLASS ZCX_DYNAMIC_OBJECT IMPLEMENTATION.


  method constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = i_previous ).

    if not ( i_t100_message is supplied
             and i_textid is supplied ).

      me->textid = value #( ).

      if i_t100_message is supplied.

        me->if_t100_dyn_msg~msgv1 = i_t100_message->msgv1.

        me->if_t100_dyn_msg~msgv2 = i_t100_message->msgv2.

        me->if_t100_dyn_msg~msgv3 = i_t100_message->msgv3.

        me->if_t100_dyn_msg~msgv4 = i_t100_message->msgv4.

        me->if_t100_dyn_msg~msgty = 'E'.

        me->if_t100_message~t100key = i_t100_message->if_t100_message~t100key.

      else.

        me->if_t100_message~t100key = cond #( when i_textid is not initial
                                              then i_textid
                                              else if_t100_message=>default_textid ).

      endif.

    else.

      raise shortdump type zcx_dynamic_object exporting i_t100_message = new zcl_free_msg( conv #( 'Call not allowed'(000) ) ).

    endif.

  endmethod.
ENDCLASS.

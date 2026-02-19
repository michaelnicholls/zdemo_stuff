CLASS lsc_zmn_i_cdsparams DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_zmn_i_cdsparams IMPLEMENTATION.

  METHOD adjust_numbers.
    loop at mapped-zmn_i_cdsparams asSIGNING FIELD-SYMBOL(<rec>).
   select single  @abap_true from zmn_cdsparams into @data(exists) where uname = @sy-uname.
   if exists = abap_false.
    <rec>-Uname = sy-uname.

    endif.
     endloop.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_zmn_i_cdsparams DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zmn_i_cdsparams RESULT result.
    METHODS checkuname FOR VALIDATE ON SAVE
      IMPORTING keys FOR zmn_i_cdsparams~checkuname.

ENDCLASS.

CLASS lhc_zmn_i_cdsparams IMPLEMENTATION.

  METHOD get_instance_authorizations.



  ENDMETHOD.


  METHOD checkUname.

     READ ENTITY  in LOCAL MODE zmn_i_cdsparams  FIELDS ( uname )
         WITH CORRESPONDING #( keys )
         RESULT DATA(recs).
    LOOP AT recs ASSIGNING FIELD-SYMBOL(<rec>).
    select single  @abap_true from zmn_cdsparams into @data(exists) where uname = @sy-uname.
      IF exists = abap_true.
        APPEND VALUE #( %tky = <rec>-%tky ) TO failed-zmn_i_cdsparams.
        APPEND VALUE #( %tky            = <rec>-%tky
                        %msg            = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                 text     = 'You alreafy have a parameters record' )
                        )
               TO reported-zmn_i_cdsparams.
      ENDIF.
    ENDLOOP.



  ENDMETHOD.

ENDCLASS.

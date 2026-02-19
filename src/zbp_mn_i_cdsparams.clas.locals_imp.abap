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

ENDCLASS.

CLASS lhc_zmn_i_cdsparams IMPLEMENTATION.

  METHOD get_instance_authorizations.



  ENDMETHOD.


ENDCLASS.

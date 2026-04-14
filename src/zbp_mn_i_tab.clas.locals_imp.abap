CLASS lsc_zmn_i_tab DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zmn_i_tab IMPLEMENTATION.

  METHOD save_modified.
  data rec type zmntab.
  rec = value #( id = sy-uname
  name = zbp_mn_i_tab=>name
  carrid = zbp_mn_i_tab=>carrid ).

modify zmntab from @rec.



  ENDMETHOD.
ENDCLASS.

CLASS lhc_zmn_i_tab DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zmn_i_tab RESULT result.

    METHODS set FOR MODIFY
      IMPORTING keys FOR ACTION zmn_i_tab~set.

ENDCLASS.

CLASS lhc_zmn_i_tab IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD set.

  " can be invoked as POST to /sap/opu/odata/sap/ZMNTAB/set?Name='My name is Michael'
  " where ZMNTAB is the service binding
    LOOP AT keys INTO DATA(key).
      DATA(name) = key-%param-name.
      data(carrid) = key-%param-carrid.
      zbp_mn_i_tab=>name = name.
      zbp_mn_i_tab=>carrid = carrid.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

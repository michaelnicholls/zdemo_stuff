CLASS lhc_z_i_employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR z_i_employee RESULT result.

    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE z_i_employee.

ENDCLASS.

CLASS lhc_z_i_employee IMPLEMENTATION.
METHOD get_instance_authorizations.
    DATA(check_activity) = '02'. " modify
    IF requested_authorizations-%delete = if_abap_behv=>mk-on.
      check_activity = '06'. " delete
    ENDIF.

    READ ENTITY IN LOCAL MODE z_i_employee

         ALL FIELDS  WITH CORRESPONDING #( keys )
         RESULT DATA(employees).

    LOOP AT employees ASSIGNING FIELD-SYMBOL(<employee>).
      AUTHORITY-CHECK OBJECT 'M_MATE_BUK'
                      ID 'BUKRS' FIELD <employee>-CompanyCode
                      ID 'ACTVT' FIELD check_activity.
      IF   sy-subrc > 0.
        IF requested_authorizations-%delete = if_abap_behv=>mk-on.
          APPEND VALUE #( %tky    = <employee>-%tky
                          %delete = if_abap_behv=>auth-unauthorized     ) TO result.
        ELSE.
          APPEND VALUE #( %tky    = <employee>-%tky
                          %update = if_abap_behv=>auth-unauthorized     ) TO result.
        ENDIF.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD precheck_create.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<employee>).

      AUTHORITY-CHECK OBJECT 'M_MATE_BUK'
                      ID 'BUKRS' FIELD <employee>-CompanyCode
                      ID 'ACTVT' FIELD '01'. " check create
      IF sy-subrc > 0.
        APPEND VALUE #( %key = <employee>-%key  ) TO failed-z_i_employee.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

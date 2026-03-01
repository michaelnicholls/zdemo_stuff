CLASS lsc_zmn_i_cdsparams DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_zmn_i_cdsparams IMPLEMENTATION.

  METHOD adjust_numbers.
    LOOP AT mapped-zmn_i_cdsparams ASSIGNING FIELD-SYMBOL(<rec>).
      SELECT SINGLE  @abap_true FROM zmn_cdsparams INTO @DATA(exists) WHERE uname = @sy-uname.
      IF exists = abap_false.
        <rec>-Uname = sy-uname.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_zmn_i_cdsparams DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

*    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
*      IMPORTING keys REQUEST requested_authorizations FOR zmn_i_cdsparams RESULT result.
    METHODS checkuname FOR VALIDATE ON SAVE
      IMPORTING keys FOR zmn_i_cdsparams~checkuname.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zmn_i_cdsparams RESULT result.
    METHODS get_global_features FOR GLOBAL FEATURES
      IMPORTING REQUEST requested_features FOR zmn_i_cdsparams RESULT result.
    METHODS checkdate FOR VALIDATE ON SAVE
      IMPORTING keys FOR zmn_i_cdsparams~checkdate.
    METHODS settoday FOR MODIFY
      IMPORTING keys FOR ACTION zmn_i_cdsparams~settoday.
      METHODS adjust FOR MODIFY
      IMPORTING keys FOR ACTION zmn_i_cdsparams~adjust.

ENDCLASS.

CLASS lhc_zmn_i_cdsparams IMPLEMENTATION.

*  METHOD get_instance_authorizations.
*
*
*  ENDMETHOD.


  METHOD checkUname.

    READ ENTITY  IN LOCAL MODE zmn_i_cdsparams  FIELDS ( uname )
        WITH CORRESPONDING #( keys )
        RESULT DATA(recs).
    LOOP AT recs ASSIGNING FIELD-SYMBOL(<rec>).
      SELECT SINGLE  @abap_true FROM zmn_cdsparams INTO @DATA(exists) WHERE uname = @sy-uname.
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

  METHOD get_global_authorizations.
    "  IF requested_authorizations-%create = if_abap_behv=>mk-on.
    SELECT SINGLE @abap_true FROM zmn_cdsparams INTO @DATA(exists) WHERE uname = @sy-uname.
    IF exists = abap_true.
      result-%create = if_abap_behv=>fc-o-disabled.
    ENDIF.
    " ENDIF.
  ENDMETHOD.

  METHOD get_global_features.
    SELECT SINGLE @abap_true FROM zmn_cdsparams INTO @DATA(exists) WHERE uname = @sy-uname.
    IF exists = abap_true.
      result-%create = if_abap_behv=>auth-unauthorized.
    ENDIF.
  ENDMETHOD.

  METHOD checkDate.
    READ ENTITY  IN LOCAL MODE zmn_i_cdsparams  FIELDS ( start_date end_date )
        WITH CORRESPONDING #( keys )
        RESULT DATA(recs).
    LOOP AT recs ASSIGNING FIELD-SYMBOL(<rec>).
      IF <rec>-start_date IS INITIAL OR <rec>-end_date IS INITIAL OR ( <rec>-start_date > <rec>-end_date ).
        APPEND VALUE #( %tky = <rec>-%tky ) TO failed-zmn_i_cdsparams.
        APPEND VALUE #( %tky            = <rec>-%tky
                        %msg            = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                 text     = 'Please provide a valid start and end date, with end date after start date' )
                        )
               TO reported-zmn_i_cdsparams.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD setToday.
    READ ENTITY IN LOCAL MODE zmn_i_cdsparams FIELDS ( start_date end_date )
         WITH CORRESPONDING #( keys )
         RESULT DATA(recs).
    LOOP AT recs ASSIGNING FIELD-SYMBOL(<rec>).
      MODIFY ENTITY IN LOCAL MODE zmn_i_cdsparams
             UPDATE FIELDS
             ( start_date end_date ) WITH VALUE #(
                 (  %tky-Uname = <rec>-Uname start_date = sy-datum end_date = sy-datum ) ).

    ENDLOOP.
  ENDMETHOD.


  METHOD adjust.


    READ ENTITY IN LOCAL MODE zmn_i_cdsparams ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(recs).

    LOOP AT recs ASSIGNING FIELD-SYMBOL(<rec>).
        data(year) = sy-datum(4).
       " data(month) = sy-datum+4(2).
        data(nextmonth) = sy-datum+4(2) + 1.
        if nextmonth > 12. nextmonth = 1. year += 1. endif.
        data(last) = conv d(  |{ year }{ nextmonth paD = '0' align = right width = 2 }01| )  .
        last -= 1.
        LOOP AT keys INTO DATA(ls_adjust).
        if ls_adjust-%param-range = 'MTD'.
             <rec>-start_date = |{ sy-datum(6) }01|.
              <rec>-end_date = sy-datum.
            ENDIF.
            IF ls_adjust-%param-range = 'YTD'.
                <rec>-start_date = |{ sy-datum(4) }0101|.
                <rec>-end_date = sy-datum.
            ENDIF.
            IF ls_adjust-%param-range = 'MONTH'.
                <rec>-start_date = |{ sy-datum(6) }01|.
                <rec>-end_date = |{ last }|.
            ENDIF.
            IF ls_adjust-%param-range = 'YEAR'.
                <rec>-start_date = |{ sy-datum(4) }0101|.
                <rec>-end_date = |{ sy-datum(4) }1231|.
            ENDIF.
            <rec>-start_date = <rec>-start_date + ls_adjust-%param-start_adjust.
            <rec>-end_date = <rec>-end_date + ls_adjust-%param-end_adjust.

        ENDLOOP.
        MODIFY ENTITY IN LOCAL MODE zmn_i_cdsparams
             UPDATE FIELDS
             ( start_date end_date ) WITH VALUE #(
                 (  %tky-Uname = <rec>-Uname start_date = <rec>-start_date  end_date = <rec>-end_date ) ).

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

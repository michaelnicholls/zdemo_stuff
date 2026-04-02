CLASS lsc_zmn_return_flights DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zmn_return_flights IMPLEMENTATION.
  METHOD save_modified.
    DATA mess_lines TYPE TABLE OF swr_messag.
    DATA params     TYPE TABLE OF swr_cont.

    LOOP AT update-zmn_return_flights INTO DATA(flight).
     read entity in LOCAL MODE zmn_return_flights all FIELDS WITH value #(
     ( outcarr = flight-outcarr
        outconn = flight-outconn
        outbounddate = flight-outbounddate
        inboundcarr = flight-inboundcarr
        inconn = flight-inconn
        inbounddate = flight-inbounddate ) )
     result data(ftab).
     loop at ftab into data(f).
    params = VALUE #( ( element = 'Request'
    value = | { f-airpfrom } <=> { f-airpto } on flights { f-outboundflight } <=> { f-inboundflight }| &&
            | leaving { flight-outbounddate  date = user }| ) ).
      CALL FUNCTION 'SAP_WAPI_START_WORKFLOW' IN BACKGROUND TASK
        EXPORTING task            = 'WS99700001'
                  do_commit       = 'X'
                  user            = sy-uname
                  check_authority = ''

        TABLES    input_container = params
                  message_lines   = mess_lines.

    ENDLOOP.
    endloop.
    APPEND VALUE #( %msg = new_message_with_text( text     = 'Workflow started'
                                                  severity = if_abap_behv_message=>severity-information ) ) TO reported-zmn_return_flights.
  ENDMETHOD.

ENDCLASS.






CLASS lhc_zmn_return_flights DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zmn_return_flights RESULT result.
    METHODS request FOR MODIFY
      IMPORTING keys FOR ACTION zmn_return_flights~request.
    METHODS get_global_features FOR GLOBAL FEATURES
      IMPORTING REQUEST requested_features FOR zmn_return_flights RESULT result." RESULT result.


ENDCLASS.

CLASS lhc_zmn_return_flights IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD request.
    READ ENTITY IN LOCAL MODE zmn_return_flights ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(flights).
    LOOP AT flights ASSIGNING FIELD-SYMBOL(<flight>).
      MODIFY ENTITY IN LOCAL MODE zmn_return_flights
             UPDATE FIELDS ( airpto )
             WITH VALUE #( ( outcarr      = <flight>-outcarr
                             outconn      = <flight>-outconn
                             outbounddate = <flight>-outbounddate
                             inboundcarr  = <flight>-inboundcarr
                             inconn       = <flight>-inconn
                             inbounddate  = <flight>-inbounddate
                             airpto       = <flight>-airpto ) ).

    ENDLOOP.
  ENDMETHOD.



  METHOD get_global_features.
  result-%update = if_abap_behv=>fc-o-disabled.

  ENDMETHOD.

ENDCLASS.

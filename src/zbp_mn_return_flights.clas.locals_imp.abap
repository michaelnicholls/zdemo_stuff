CLASS lsc_zmn_return_flights DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zmn_return_flights IMPLEMENTATION.
  METHOD save_modified.
    DATA mess_lines TYPE TABLE OF swr_messag.
    data params type table of swr_cont.

    " TODO: variable is assigned but never used (ABAP cleaner)
    params = value #( ( element = 'Request' value = 'Hello world' ) ).
    LOOP AT update-zmn_return_flights INTO DATA(flight).
      CALL FUNCTION 'SAP_WAPI_START_WORKFLOW' in BACKGROUND TASK
        EXPORTING task          = 'WS99700001'
                  do_commit     = 'X'
                  user          = sy-uname


        TABLES
        input_container = params
         message_lines = mess_lines.

    ENDLOOP.
    append value  #( %msg = new_message_with_text( text = 'OK'  severity = if_abap_behv_message=>severity-information ) ) to reported-zmn_return_flights.
  ENDMETHOD.

ENDCLASS.






CLASS lhc_zmn_return_flights DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zmn_return_flights RESULT result.
    METHODS request FOR MODIFY
      IMPORTING keys FOR ACTION zmn_return_flights~request." RESULT result.


ENDCLASS.

CLASS lhc_zmn_return_flights IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD request.
  read entity in LOCAL MODE zmn_return_flights all FIELDS WITH corrESPONDING #( keys )
  result data(flights).
  loop at flights assiGNING fIELD-SYMBOL(<flight>).
    modiFY entity in LOCAL MODE zmn_return_flights
     upDATE fields ( airpto )
    WITH VALUE #( ( outcarr = <flight>-outcarr
                   outconn = <flight>-outconn
                    outbounddate = <flight>-outbounddate
                    inboundcarr = <flight>-inboundcarr
                    inconn = <flight>-inconn
                    inbounddate = <flight>-inbounddate
                    airpto = <flight>-airpto ) ).

  endloop.

  ENDMETHOD.



ENDCLASS.

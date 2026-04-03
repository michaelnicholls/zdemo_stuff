CLASS lsc_zmn_return_flights DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.
    METHODS save_modified REDEFINITION.

ENDCLASS.


CLASS lsc_zmn_return_flights IMPLEMENTATION.
  METHOD save_modified.
    DATA mess_lines TYPE TABLE OF swr_messag.
    DATA params     TYPE TABLE OF swr_cont.


    LOOP AT zbp_mn_return_flights=>requests INTO DATA(request).
    params = VALUE #( ( element = 'Request'
    value = | { request-airpfrom } <=> { request-airpto } on flights { request-outboundflight } <=> { request-inboundflight }| &&
            | leaving { request-outbounddate  date = user }| ) ).
      CALL FUNCTION 'SAP_WAPI_START_WORKFLOW'  IN BACKGROUND TASK
        EXPORTING task            = request-wfid
                  do_commit       = 'X'
                  user            = sy-uname
                  check_authority = ''

        TABLES    input_container = params
                  message_lines   = mess_lines.

    ENDLOOP.
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


ENDCLASS.

CLASS lhc_zmn_return_flights IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD request.
    READ ENTITY IN LOCAL MODE zmn_return_flights ALL FIELDS WITH CORRESPONDING #( keys )
    result zbp_mn_return_flights=>requests.
  ENDMETHOD.



ENDCLASS.

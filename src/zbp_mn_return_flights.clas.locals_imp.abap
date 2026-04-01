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
  ENDMETHOD.

ENDCLASS.

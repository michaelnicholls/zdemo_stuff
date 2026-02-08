CLASS zuse_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zuse_amdp IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    SELECT FROM usr02 FIELDS COUNT( * ) INTO @DATA(c_abap). " traditional

    zamdp_example=>get_count( IMPORTING num_recs = DATA(c_amdp)   ). " use AMDP

    out->write( |User count from ABAP: { c_abap }, user count from AMDP: { c_amdp }| ).

    zamdp_example=>get_flights( IMPORTING et_flights = DATA(flights) ).

    LOOP AT flights ASSIGNING FIELD-SYMBOL(<myfs>).
      AUTHORITY-CHECK OBJECT 'S_CARRID' ID 'CARRID' FIELD <myfs>-carrid ID 'ACTVT' FIELD '03'.
      IF sy-subrc = 0.
        out->write( <myfs> ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

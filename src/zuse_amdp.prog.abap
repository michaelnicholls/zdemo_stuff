*&---------------------------------------------------------------------*
*& Report zuse_amdp
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zuse_amdp.

   SELECT FROM usr02 FIELDS COUNT( * ) INTO @DATA(c_abap). " traditional

    zamdp_example=>get_count( IMPORTING num_recs = DATA(c_amdp)   ). " use AMDP

    write: / |User count from ABAP: { c_abap }, user count from AMDP: { c_amdp }| .

    zamdp_example=>get_flights( IMPORTING et_flights = DATA(flights) ).

    LOOP AT flights ASSIGNING FIELD-SYMBOL(<myfs>).
      AUTHORITY-CHECK OBJECT 'S_CARRID' ID 'CARRID' FIELD <myfs>-carrid ID 'ACTVT' FIELD '03'.
      IF sy-subrc = 0.
  "      write: / | {  <myfs>-carrid  } {  <myfs>-connid } |.
      ENDIF.
    ENDLOOP.

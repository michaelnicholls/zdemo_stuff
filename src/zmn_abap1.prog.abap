*&---------------------------------------------------------------------*
*& Report ZMN_ABAP1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_abap1.
"PARAMETERS pa_carr TYPE s_carr_id.
SELECT FROM spfli FIELDS *
" WHERE carrid = @pa_carr
   ORDER BY carrid INTO TABLE @DATA(mytab).

LOOP AT mytab ASSIGNING FIELD-SYMBOL(<flight>).
  AUTHORITY-CHECK OBJECT 'S_CARRID'
     ID 'CARRID' FIELD <flight>-carrid
     ID 'ACTVT' FIELD '03'.
  "  IF sy-subrc  = 0. "this checks if we can access this carrier
  WRITE: / | { <flight>-carrid } { <flight>-connid } { <flight>-cityfrom } { <flight>-cityto } |.
  "  ENDIF.
ENDLOOP.

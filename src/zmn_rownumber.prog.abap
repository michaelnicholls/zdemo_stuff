*&---------------------------------------------------------------------*
*& Report zmn_rownumber
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_rownumber.

SELECT FROM spfli
  FIELDS ROW_NUMBER(  ) OVER( ORDER BY carrid,connid )                     AS overall_count,
         ROW_NUMBER(  ) OVER( PARTITION BY carrid ORDER BY carrid ) AS count_within_carrier,
         carrid,
         connid

  ORDER BY carrid, connid
  INTO TABLE @DATA(mytab).
DATA go_alv_table TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
                            CHANGING  t_table      = mytab ).
  CATCH cx_root.
ENDTRY.
go_alv_table->display( ).

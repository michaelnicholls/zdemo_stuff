*&---------------------------------------------------------------------*
*& Report zmn_rownumber
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_rownumber.

SELECT FROM scarr
  FIELDS ROW_NUMBER(  ) OVER( ORDER BY carrid ) AS row_count,
         carrid,
         carrname
  ORDER BY carrid
  INTO TABLE @DATA(mytab).
DATA go_alv_table TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
                            CHANGING  t_table      = mytab ).
  CATCH cx_root.
ENDTRY.
go_alv_table->display( ).

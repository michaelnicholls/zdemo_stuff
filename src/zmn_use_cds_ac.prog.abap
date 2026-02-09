*&---------------------------------------------------------------------*
*& Report ZMN_TMP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_use_cds_ac.
" automatically filtered by the zspfli access control
SELECT FROM zspfli FIELDS * ORDER BY carrid, connid INTO TABLE @DATA(mytab).

DATA go_alv_table TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
                            CHANGING  t_table      = mytab ).
  CATCH cx_root.
ENDTRY.
go_alv_table->display( ).

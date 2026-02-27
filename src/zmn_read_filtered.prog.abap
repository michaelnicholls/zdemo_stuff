*&---------------------------------------------------------------------*
*& Report zmn_read_filtered
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_read_filtered.

select from zmn_filtered_flights fields * into table @data(mytab).
DATA go_alv_table TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
                            CHANGING  t_table      = mytab ).
  CATCH cx_root.
ENDTRY.
go_alv_table->display( ).

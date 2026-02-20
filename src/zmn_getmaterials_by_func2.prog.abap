*&---------------------------------------------------------------------*
*& Report zmn_getmaterials
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_getmaterials_by_func2.

select  * from zmn_findmaterials2( ) into table @data(mytab).

DATA go_alv_table TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
                            CHANGING  t_table      = mytab ).
  CATCH cx_root.
ENDTRY.
go_alv_table->display( ).

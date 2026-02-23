*&---------------------------------------------------------------------*
*& Report zmn_employee_list
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_employee_list.

select from zmn_i_employee_full fields * order by id into table @data(mytab).

   DATA go_alv_table TYPE REF TO cl_salv_table.
    TRY.
        cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
          CHANGING t_table = mytab ).
      CATCH cx_root.
    ENDTRY.
    go_alv_table->display( ).

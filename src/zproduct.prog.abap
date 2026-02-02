*&---------------------------------------------------------------------*
*& Report zproduct
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zproduct.

select from I_Product fields Product, productgroup, \_text[ language = @sy-langu ]-productname
where product like '%FL3%10%' into table @data(mytab).

   DATA go_alv_table TYPE REF TO cl_salv_table.
    TRY.
        cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
          CHANGING t_table = mytab ).
      CATCH cx_root.
    ENDTRY.
    go_alv_table->display( ).

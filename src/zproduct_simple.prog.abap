*&---------------------------------------------------------------------*
*& Report zproduct
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zproduct_simple.

SELECT FROM zmn_product_simple
  FIELDS Product,
         ProductGroup,
    description
  ORDER BY Product
  INTO TABLE @DATA(mytab)
  UP TO 100 ROWS.

DATA go_alv_table TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
                            CHANGING  t_table      = mytab ).
  CATCH cx_root.
ENDTRY.
go_alv_table->display( ).

*&---------------------------------------------------------------------*
*& Report zproduct
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zproduct.

SELECT FROM I_Product
  FIELDS Product,
         ProductGroup,
         \_text[ MANY TO ONE WHERE language = @sy-langu ]-ProductName            AS desc1, " using logon language
         coalesce( \_text[ MANY TO ONE WHERE language = @sy-langu ]-ProductName,
            'No description found' )                                             AS desc2, " hardcoded if no value
         coalesce( \_text[ MANY TO ONE WHERE language = @sy-langu ]-ProductName,
             \_text[ MANY TO ONE WHERE language = 'E' ]-ProductName )            AS desc3 " use E if no description
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

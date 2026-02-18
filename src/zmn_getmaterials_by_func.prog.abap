*&---------------------------------------------------------------------*
*& Report zmn_getmaterials
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_getmaterials_by_func.
PARAMETERS: search LOWER CASE TYPE string DEFAULT 'control',
            fuzzy  TYPE p LENGTH 3 DECIMALS 2 DEFAULT '0.7'.
DATA fuzziness TYPE f.
fuzziness = fuzzy.
select  * from zmn_findmaterials( sounds_like = @search, fuzziness = @fuzzy ) into table @data(mytab).

DATA go_alv_table TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
                            CHANGING  t_table      = mytab ).
  CATCH cx_root.
ENDTRY.
go_alv_table->display( ).

*&---------------------------------------------------------------------*
*& Report zmn_getmaterials
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_getmaterials.
PARAMETERS: search LOWER CASE TYPE string DEFAULT 'control',
            fuzzy  TYPE p LENGTH 3 DECIMALS 2 DEFAULT '0.7'.
DATA fuzziness TYPE f.
fuzziness = fuzzy.
zamdp_material_search=>find_materials( EXPORTING sounds_like  = search
                                                 fuzziness    = fuzziness
                                       IMPORTING et_materials = DATA(mytab) ).

DATA go_alv_table TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
                            CHANGING  t_table      = mytab ).
  CATCH cx_root.
ENDTRY.
go_alv_table->display( ).

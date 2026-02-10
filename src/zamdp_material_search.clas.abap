CLASS zamdp_material_search DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb .
    TYPES: ty_materials TYPE STANDARD TABLE OF zmn_product.
    CLASS-METHODS find_materials
      IMPORTING VALUE(sounds_like)  TYPE string
                VALUE(fuzziness)    TYPE float
      EXPORTING VALUE(et_materials) TYPE ty_materials .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zamdp_material_search IMPLEMENTATION.
  METHOD find_materials BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING mara makt.
    et_materials = select mara.matnr as product, mara.matkl as productgroup, makt.maktx as description from mara join makt on mara.matnr = makt.matnr
    where mara.mandt = session_context( 'CLIENT' )
    and makt.spras = SESSION_CONTEXT('LOCALE_SAP')
    and ( contains(mara.matnr, :sounds_like, FUZZY( :fuzziness ) )
    or contains(makt.maktx, :sounds_like, FUZZY(  :fuzziness ) ) )
    order by mara.matnr;
  ENDMETHOD.

ENDCLASS.

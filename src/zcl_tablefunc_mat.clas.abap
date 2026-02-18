CLASS zcl_tablefunc_mat DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
      TYPES: ty_materials TYPE STANDARD TABLE OF zmn_product.
    class-METHODS search for tABLE FUNCTION zmn_findmaterials .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tablefunc_mat IMPLEMENTATION.
  METHOD search BY DATABASE function FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING mara makt.
    return select mara.mandt, mara.matnr as product, mara.matkl as productgroup, makt.maktx as description
    from mara join makt on mara.matnr = makt.matnr and mara.mandt = makt.mandt
    where mara.mandt = session_context( 'CLIENT' )
    and makt.spras = SESSION_CONTEXT('LOCALE_SAP')
    and ( contains(mara.matnr, :sounds_like, FUZZY( :fuzziness ) )
    or contains(makt.maktx, :sounds_like, FUZZY(  :fuzziness ) ) )
    order by mara.matnr;

  ENDMETHOD.

ENDCLASS.

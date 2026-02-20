CLASS zcl_tablefunc_mat2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
      TYPES: ty_materials TYPE STANDARD TABLE OF zmn_product.
    class-METHODS search for tABLE FUNCTION zmn_findmaterials2 .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tablefunc_mat2 IMPLEMENTATION.
  METHOD search BY DATABASE function FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING mara makt zmn_cdsparams.
   begin
   declare soundslike nvarchar( 30 );
   declare fuzziness float;
   declare numrecs integer;
   select count(*) into numrecs from zmn_cdsparams where uname = session_context( 'APPLICATIONUSER' ) and
       client = session_context( 'CLIENT' );
   if :numrecs > 0 then
    select soundslike,fuzziness into soundslike, fuzziness from zmn_cdsparams where uname = session_context( 'APPLICATIONUSER' )
    and client = session_context( 'CLIENT' ) ;
    end if;
    return

    select mara.mandt, mara.matnr as product, mara.matkl as productgroup, makt.maktx as description
    from mara join makt on mara.matnr = makt.matnr and mara.mandt = makt.mandt
    where mara.mandt = session_context( 'CLIENT' )
    and makt.spras = SESSION_CONTEXT('LOCALE_SAP')
    and ( contains(mara.matnr,:soundslike, FUZZY( :fuzziness ) )
    or contains(makt.maktx, :soundslike, FUZZY(  :fuzziness ) ) )
    order by mara.matnr;
    end;
  ENDMETHOD.

ENDCLASS.

@EndUserText.label: 'as a function'
define table function zmn_findmaterials
with parameters sounds_like : abap.char( 30 ), fuzziness : abap.fltp
returns {
  mandt : abap.clnt;
  product : abap.char( 20 );
  productgroup : abap.char(20);
  description : abap.char(60);
  
}
implemented by method zcl_tablefunc_mat=>search;

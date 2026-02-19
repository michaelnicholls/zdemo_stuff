@EndUserText.label: 'as a function'
define table function ZMN_FINDMATERIALS2
returns {
  mandt : abap.clnt;
  product : abap.char( 20 );
  productgroup : abap.char(20);
  description : abap.char(60);
  
}
implemented by method zcl_tablefunc_mat2=>search;

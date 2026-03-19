@EndUserText.label: 'gets date ranges for a date'
define table function zmn_calc_daterange
//with parameters p_date : abap.dats
returns {
  mandt : abap.clnt;
  search_date : abap.dats;
  range_name : abap.char(10);
  
  
}
implemented by method zcl_calc_ranges=>calc;

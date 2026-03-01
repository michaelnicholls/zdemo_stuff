@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'params'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZMN_C_CDSPARAMS as projection on zmn_i_cdsparams

{
    key Uname,
    Soundslike,
    Fuzziness,
  //  start_date,
  //  end_date ,
    goto_material_list
  //  goto_flight_list,
   // filler_today,
  //  filler_adjust
}

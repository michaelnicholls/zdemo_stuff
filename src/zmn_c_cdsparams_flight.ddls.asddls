@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'params'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZMN_C_CDSPARAMS_FLIGHT as projection on zmn_i_cdsparams

{
    key Uname,
 //   Soundslike,
  //  Fuzziness,
    start_date,
    end_date ,
    currency_code,
  //  goto_material_list
    goto_flight_list,
    action_today,
    action_adjust
}

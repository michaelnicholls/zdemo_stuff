@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'params'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZMN_C_CDSPARAMS as projection on zmn_i_cdsparams

{
    key Uname,
    Soundslike,
    Fuzziness
}

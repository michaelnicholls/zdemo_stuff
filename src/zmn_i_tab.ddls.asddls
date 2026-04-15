@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'root view of extras'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMN_I_TAB as select from zmntab
{
  
    key id as Id,
    name as Name,
    carrid as Carrid
}

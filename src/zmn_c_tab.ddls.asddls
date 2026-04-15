@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'consumption view of extras'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZMN_C_TAB as projection on ZMN_I_TAB
{
    key Id,
    Name,
    Carrid
} where Id = $session.user

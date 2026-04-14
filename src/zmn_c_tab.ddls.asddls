@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'view'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZMN_C_TAB as projection on ZMN_I_TAB
{
    key Id,
    Name,
    Carrid,
    xx
} where Id = $session.user

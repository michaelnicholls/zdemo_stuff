@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMN_I_VIEW as select from zmntab
{
    key id as Id,
    name as Name
}

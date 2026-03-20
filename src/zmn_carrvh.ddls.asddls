@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'value help for carriers'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMN_CARRVH as select from scarr
{
    @EndUserText.label: 'Carrier'
    key carrid as Carrid,
    @Semantics.text: true
    carrname as Carrname
}

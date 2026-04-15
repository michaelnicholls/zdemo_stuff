@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'value help for carriers'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMN_CARRVH as select from scarr
association to zmntab as _defaults on _defaults.id = $session.user
{
    @EndUserText.label: 'Carrier'
    key carrid as Carrid,
    @Semantics.text: true
    carrname as Carrname,
    cast(case  when _defaults.carrid = scarr.carrid then 'X' else '' end  as boolean) as default_carrier
}

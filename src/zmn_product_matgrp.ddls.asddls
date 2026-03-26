@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'product with default mat group'
@Metadata.ignorePropagatedAnnotations: true
define view entity Zmn_Product_Matgrp as select from I_Product
association to I_UserParameter_F2200 as _params on _params.UserParameter = 'MKL'
{
     @UI.lineItem: [{position: 10}]
   key Product,
     @UI.lineItem: [{position: 20}]
   _Text[Language = $session.system_language].ProductName,
     @UI.lineItem: [{position: 30}]
   _ProductGroup.MaterialGroup as matgrp,
    @UI.lineItem: [{position: 50}]
   _ProductGroupText[Language = $session.system_language].MaterialGroupText,
    @UI.selectionField: [{position: 10}]
    @Consumption.filter.defaultValue: 'X' // X means true
    @EndUserText.label: 'Matches default product group'
   cast( case when $projection.matgrp = _params.UserParameterValue then 'X' else ' ' end  as boolean ) as matches
   
}

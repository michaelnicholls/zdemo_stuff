@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'spfli'
@Metadata.ignorePropagatedAnnotations: false
define view entity zspfli as select from spfli
{
    @UI.lineItem: [{position: 10}]
    @UI.selectionField: [{position: 10}]
    key carrid as Carrid,
    @UI.lineItem: [{position: 20}]
    key connid as Connid,
    countryfr as Countryfr,
    @UI.lineItem: [{position: 30}]
    cityfrom as Cityfrom,
    airpfrom as Airpfrom,
    countryto as Countryto,
    @UI.lineItem: [{position: 40}]
    cityto as Cityto,
    airpto as Airpto,
 //   fltime as Fltime,
    deptime as Deptime,
    arrtime as Arrtime
 
}

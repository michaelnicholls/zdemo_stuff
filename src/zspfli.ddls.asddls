@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'spfli'
@Metadata.ignorePropagatedAnnotations: false
define  root view entity zspfli as select from spfli as s join scarr as c on c.carrid = s.carrid
left outer join I_UserParameter_F2200 as p on p.UserParameter = 'CAR'
{
    
    @UI.lineItem: [{position: 10}]
    @UI.selectionField: [{position: 10}]
    
    @Consumption.valueHelpDefinition: [{ entity: {name: 'ZMN_CARRVH', element: 'Carrid'}}]
    key s.carrid as Carrid,
    @UI.lineItem: [{position: 20}]
    key s.connid as Connid,
    c.carrname as carrname,
    @UI.selectionField: [{position: 30}]
    @Consumption.filter.defaultValue: 'X'
    @EndUserText.label: 'Use default carrier'
    cast(case when p.UserParameterValue = c.carrid then 'X' else '' end as boolean) as user_default,
    s.countryfr as Countryfr,
    @UI.lineItem: [{position: 30}]
    s.cityfrom as Cityfrom,
    s.airpfrom as Airpfrom,
    s.countryto as Countryto,
    @UI.lineItem: [{position: 40}]
    s.cityto as Cityto,
    s.airpto as Airpto,
 //   fltime as Fltime,
    s.deptime as Deptime,
    s.arrtime as Arrtime
 
}

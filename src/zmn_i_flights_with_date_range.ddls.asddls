@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'flights with date range'
@Metadata.ignorePropagatedAnnotations: false
define root view entity zmn_i_flights_with_date_range as select from sflight
join zmn_calc_daterange on zmn_calc_daterange.search_date = sflight.fldate
{
    @UI.lineItem: [{ position: 10 }]
    @UI.selectionField: [{position: 20}]
    key sflight.carrid as Carrid,
    @UI.lineItem: [{ position: 20 }]
    key sflight.connid as Connid,
    @UI.lineItem: [{ position: 30 }]
    key sflight.fldate as Fldate,
    @UI.lineItem: [{ position: 40 }]
    sflight.price as Price,
    @UI.lineItem: [{ position: 50 }]
    sflight.currency as Currency,
    @UI.lineItem: [{ position: 60 }]
    sflight.planetype as Planetype,
    @UI.lineItem: [{ position: 70 }]
    sflight.seatsmax as Seatsmax,
    @UI.lineItem: [{ position: 80 }]
    sflight.seatsocc as Seatsocc,
    @UI.lineItem: [{ position: 90 }]
    sflight.paymentsum as Paymentsum,
 //   @UI.lineItem: [{ position: 10 , label: 'Date range'}]
    @EndUserText.label: 'Date range'
    @UI.selectionField: [{position: 10}]
     @Consumption.valueHelpDefinition: [{ entity: {name: 'ZMN_DATE_RANGE_VH', element: 'Value' }}]
   
    zmn_calc_daterange.range_name
}

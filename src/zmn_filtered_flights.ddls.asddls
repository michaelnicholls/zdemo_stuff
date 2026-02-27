@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'filter flights by paramaeters'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zmn_filtered_flights as select from sflight
left outer join zmn_cdsparams on zmn_cdsparams.uname = $session.user
{
@UI.lineItem: [{ position: 10 }]
    key sflight.carrid as Carrid,
    @UI.lineItem: [{ position: 20 }]
    key sflight.connid as Connid,
    @UI.lineItem: [{ position: 30 }]
    key sflight.fldate as Fldate,
    @UI.lineItem: [{ position: 40 }]
    sflight.planetype as Planetype,
    @UI.lineItem: [{ position: 50 }]
    @Semantics.amount.currencyCode: 'currency'
    sflight.price,
    @UI.lineItem: [{ position: 60 }]
    sflight.currency,
    @UI.lineItem: [{ position: 70 }]
    sflight.seatsmax as Seatsmax,
    @UI.lineItem: [{ position: 80 }]
    sflight.seatsocc as Seatsocc,
    @UI.lineItem: [{ position: 90 }]
    sflight.seatsmax_b as SeatsmaxB,
    @UI.lineItem: [{ position: 100 }]
    sflight.seatsocc_b as SeatsoccB,
    @UI.lineItem: [{ position: 110 }]
    sflight.seatsmax_f as SeatsmaxF,
    @UI.lineItem: [{ position: 120 }]
    sflight.seatsocc_f as SeatsoccF
} where zmn_cdsparams.uname = $session.user and  sflight.fldate between 
coalesce(zmn_cdsparams.start_date,dats_add_days($session.system_date, -30,'INITIAL')) and 
coalesce(zmn_cdsparams.end_date,$session.system_date)

// default to the last 30 days

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'filter flights by paramaeters'
@Metadata.ignorePropagatedAnnotations: true
define view entity zmn_filtered_flights as select from sflight
left outer join zmn_cdsparams on zmn_cdsparams.uname = $session.user
{
    key sflight.carrid as Carrid,
    key sflight.connid as Connid,
    key sflight.fldate as Fldate,
    sflight.planetype as Planetype,
    @Semantics.amount.currencyCode: 'currency'
    sflight.price,
    sflight.currency,
    sflight.seatsmax as Seatsmax,
    sflight.seatsocc as Seatsocc,
    sflight.seatsmax_b as SeatsmaxB,
    sflight.seatsocc_b as SeatsoccB,
    sflight.seatsmax_f as SeatsmaxF,
    sflight.seatsocc_f as SeatsoccF
} where sflight.fldate between 
coalesce(zmn_cdsparams.start_date,dats_add_days($session.system_date, -30,'INITIAL')) and 
coalesce(zmn_cdsparams.end_date,$session.system_date)

// default to the last 30 days

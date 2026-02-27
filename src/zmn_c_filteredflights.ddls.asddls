@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'flights filtered by passed param'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZMN_C_FILTEREDFLIGHTS as projection on zmn_filtered_flights
{
    key Carrid,
    key Connid,
    key Fldate,
    Planetype,
    price,
    currency,
    Seatsmax,
    Seatsocc,
    SeatsmaxB,
    SeatsoccB,
    SeatsmaxF,
    SeatsoccF
}

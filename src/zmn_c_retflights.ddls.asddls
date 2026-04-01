@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'return flights'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZMN_C_RETFLIGHTS as projection on zmn_return_flights
{
   
    key outcarr,
    key outconn,
    key outbounddate,
    airpfrom,
    airpto,
    outboundtime,
    outboundflight,
    inboundcarr,
    samecarr,
    inboundflight,
    inbounddate,
    inboundtime,
    tripdays,
    outboundfree,
    inboundfree
    
  
}

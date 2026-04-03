@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'return flights'

@Metadata.ignorePropagatedAnnotations: false

define root view entity ZMN_C_RETFLIGHTS
  as projection on zmn_return_flights

{
  key outcarr,
  key outconn,
  key outbounddate,
  key inboundcarr,
  key inconn,
  key inbounddate,

      airpfrom,
      airpto,
      outboundtime,
      outboundflight,
      samecarr,
      inboundflight,
      inboundtime,
      tripdays,
      outboundfree,
      inboundfree,
      minfreeseats,
      xx,
      wfid
}

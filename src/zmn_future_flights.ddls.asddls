@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'duture floghts'
@Metadata.ignorePropagatedAnnotations: true
define view entity zmn_future_flights as select from sflight join spfli on sflight.carrid = spfli.carrid   and sflight.connid = spfli.connid
  
 
{
    key sflight.carrid as Carrid,
    key sflight.connid as Connid,
    key sflight.fldate as Fldate,
    spfli.airpfrom,
    spfli.airpto,
    spfli.deptime,
    spfli.arrtime,
    sflight.seatsmax - sflight.seatsocc as seatsfree
}
  where sflight.fldate > $session.system_date

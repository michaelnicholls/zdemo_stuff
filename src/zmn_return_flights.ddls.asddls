@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'return flights'
@Metadata.ignorePropagatedAnnotations: true
define view entity zmn_return_flights as select from zmn_future_flights as o join zmn_future_flights as i
on o.airpfrom = i.airpto and o.airpto = i.airpfrom
and i.Fldate > o.Fldate
{
    key o.Carrid as outcarr,
    key o.Connid as outconn,
    key o.Fldate as outdate,
    o.deptime as outdeptime,
    concat(o.Carrid,concat('/',cast(o.Connid as abap.char(4)))) as outbound,
    o.airpfrom,
    o.airpto,
    i.Carrid as retcarr,
    case when o.Carrid = i.Carrid then 'X'  else '' end as samecarr,
    concat(i.Carrid,concat('/',cast(i.Connid as abap.char(4)))) as inbound,
    i.Fldate as retdate,
    i.deptime as retdeptime,
    dats_days_between( o.Fldate, i.Fldate) as tripdays
    
}

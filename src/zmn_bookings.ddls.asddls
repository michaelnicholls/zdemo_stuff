@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED@EndUserText.label: 'bookings by class by flight'@Metadata.ignorePropagatedAnnotations: true
define view entity ZMN_BOOKINGS
  as select from sbook

{
  key carrid   as Carrid,
  key connid   as Connid,
  key fldate   as Fldate,
  key class    as Class,

      count(*) as bookings
}

where cancelled <> 'X'

group by carrid,
         connid,
         fldate,
         class

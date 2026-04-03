@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'return flights'

@Metadata.ignorePropagatedAnnotations: true

define root view entity zmn_return_flights
  as select from zmn_future_flights as o

    join         zmn_future_flights as i
      on  i.airpfrom = o.airpto and i.airpto = o.airpfrom
      and i.Fldate   > o.Fldate

{
  key o.Carrid                                                                                                          as outcarr,

  key o.Connid                                                                                                          as outconn,

      @UI.lineItem: [ { position: 30, label: 'Outbound date;' } ]
      @UI.selectionField: [ { position: 30 } ]
  key o.Fldate                                                                                                          as outbounddate,

  key i.Carrid                                                                                                          as inboundcarr,
  key i.Connid                                                                                                          as inconn,

      @UI.lineItem: [ { position: 70, label: 'Inbound date' } ]
  key i.Fldate                                                                                                          as inbounddate,

      @UI.lineItem: [ { position: 10, label: 'Departure' } ]
      @UI.selectionField: [ { position: 10 } ]
      o.airpfrom,

      @UI.lineItem: [ { position: 20, label: 'Arrival' } ]
      @UI.selectionField: [ { position: 20 } ]

      o.airpto,
      //     @UI.lineItem: [{ position: 40, label: 'Outbound dep time' }]

      o.deptime                                                                                                         as outboundtime,

      @UI.lineItem: [ { position: 50, label: 'Outbound flight' } ]
      concat(o.Carrid, concat('/', cast(o.Connid as abap.char(4))))                                                     as outboundflight,


      @EndUserText.label: 'Same carrier'
      @UI.lineItem: [ { position: 65, label: 'Same carrier' } ]
      @UI.selectionField: [ { position: 50 } ]

      cast(case when o.Carrid = i.Carrid then 'X'  else '' end  as boolean)                                             as samecarr,

      @UI.lineItem: [ { position: 60, label: 'Inbound flight' } ]

      concat(i.Carrid, concat('/', cast(i.Connid as abap.char(4))))                                                     as inboundflight,

      //       @UI.lineItem: [{ position: 80, label: 'Inbound dep time' }] // hidden by default

      i.deptime                                                                                                         as inboundtime,

      @EndUserText.label: 'Trip days'
      @UI.lineItem: [ { position: 90, label: 'Trip days' } ]
      @UI.selectionField: [ { position: 60 } ]
      dats_days_between(o.Fldate, i.Fldate)                                                                             as tripdays,

      //    @UI.lineItem: [ { position: 100, label: 'Free seats out' } ]

      o.seatsfree                                                                                                       as outboundfree,

      //    @UI.lineItem: [ { position: 110, label: 'Free seats inbound' } ]

      i.seatsfree                                                                                                       as inboundfree,

      @EndUserText.label: 'Min free seats'
      @UI.lineItem: [ { position: 115, label: 'Minumum free seats' } ]
      @UI.selectionField: [ { position: 70 } ]

      case when $projection.outboundfree > $projection.inboundfree then $projection.inboundfree else $projection.outboundfree end
                                                                                                                        as minfreeseats,

      @UI.lineItem: [ { position: 120,
                        type: #FOR_ACTION,
                        inline: true,
                        dataAction: 'request',
                        label: 'Request booking' } ]
      'Request'                                                                                                         as xx,
      'WS99700001' as wfid
}

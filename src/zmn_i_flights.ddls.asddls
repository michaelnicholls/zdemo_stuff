@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'flights'

@Metadata.ignorePropagatedAnnotations: false

define root view entity zmn_i_flights
  as select from sflight
  association to I_UserParameter_F2200 as _params on _params.UserParameter = 'CUR'

{
      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZMN_CARRVH', element: 'Carrid' } } ]
      @UI.lineItem: [ { position: 10 } ]
      @UI.selectionField: [ { position: 10 } ]
  key carrid                                                           as Carrid,

      @UI.lineItem: [ { position: 20 } ]
  key connid                                                           as Connid,

      @UI.lineItem: [ { position: 30 } ]
      @UI.selectionField: [ { position: 20 } ]
  key fldate                                                           as Fldate,

      @UI.lineItem: [ { position: 40 } ]
      paymentsum                                                           as Paymentsum,

      currency                                                         as Currency,
 //     cast('LEK' as abap.cuky(5))                                      as repcurr,
    cast (_params.UserParameterValue as abap.cuky(5)) as repcurr,
      @Semantics.amount.currencyCode: 'repcurr'
      @UI.lineItem: [ { position: 50, label: 'Converted airfare' } ]
      currency_conversion(amount             => paymentsum,
                          exchange_rate_date => $session.system_date,
                          source_currency    => currency,
  //                        target_currency => $projection.repcurr ) as repamount,
                          target_currency    => $projection.repcurr,
                          error_handling     => 'SET_TO_NULL')         as repamount,

      @UI.lineItem: [ { position: 60, label: 'Conversion status' } ]
      case when $projection.repamount is null then 'Error' else '' end as conversion_status
}

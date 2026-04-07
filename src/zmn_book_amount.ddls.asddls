@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'summary of bookings'

@Metadata.ignorePropagatedAnnotations: false

define view entity zmn_book_amount
  as select from sbook

{
  key carrid        as Carrid,
  key connid        as Connid,
  key fldate        as Fldate,

      @Semantics.amount.currencyCode: 'Loccurkey'
      sum(loccuram) as Loccuram,

      loccurkey     as Loccurkey
}

group by carrid,
         connid,
         fldate,
         loccurkey

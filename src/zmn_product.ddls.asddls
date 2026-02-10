@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'product'

@Metadata.ignorePropagatedAnnotations: false

@Search.searchable: true

define view entity zmn_product
  as select from mara

    join         makt on mara.matnr = makt.matnr

{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @UI.lineItem: [ { position: 10, label: 'Product' } ]
  key mara.matnr as Product,

      @UI.lineItem: [ { position: 20, label: 'Product Group' } ]
      mara.matkl as ProductGroup,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      @UI.lineItem: [ { position: 30, label: 'Description' } ]
      makt.maktx as description
}

where makt.spras = $session.system_language

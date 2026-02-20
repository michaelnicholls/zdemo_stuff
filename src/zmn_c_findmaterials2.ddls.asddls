@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'find materials via parameter table'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZMN_C_FINDMATERIALS2 as select from ZMN_FINDMATERIALS2

{
   @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
      @UI.lineItem: [ { position: 10, label: 'Product' } ]
      @UI.identification: [ { position: 10, label: 'Product' } ]
   key product,
        @UI.lineItem: [ { position: 20, label: 'Product Group' } ]
        @UI.identification: [ { position: 20, label: 'Product Group' } ]
    productgroup,
         @UI.lineItem: [ { position: 30, label: 'Description' } ]
         @UI.identification: [ { position: 30, label: 'Description' } ]
    description
}

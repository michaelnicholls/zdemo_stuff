@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'c view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMN_C_VIEW 
provider contract transactional_query as projection on zmn_i_view
 
{
     @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
   @UI.identification: [{ position : 10 , label : 'id'}]
   @UI.lineItem: [{ position : 10 , label : 'id'  }]
    key Id,
    @UI.identification: [{ position: 20, label : 'name' }]
    @UI.lineItem: [{  position : 20 , label : 'name' }]
    Name
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMN_I_TAB as select from zmntab
{
  
    key id as Id,
    name as Name,
    carrid as Carrid,
    @UI.lineItem: [ { position: 20,
                        type: #FOR_ACTION,
                        
                        dataAction: 'set',
                        label: 'Set' } ]
                        'set' as xx
}

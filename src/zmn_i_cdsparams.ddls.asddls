@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'params'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zmn_i_cdsparams as select from zmn_cdsparams

{

      @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
      @UI.identification: [ { position: 10, label: 'Username' } ]
      @UI.lineItem: [ { position: 10, label: 'Username' } ]
    key uname as Uname,
    @UI.lineItem: [{ position: 20, label: 'Sounds like' }]
    @UI.identification: [{ position: 20, label: 'Sounds like' }]
    soundslike as Soundslike,
    @UI.lineItem: [{ position: 30, label: 'Fuzziness' }]
    @UI.identification: [{ position: 30, label: 'Fuzziness' }]
    fuzziness as Fuzziness
}  where uname = $session.user

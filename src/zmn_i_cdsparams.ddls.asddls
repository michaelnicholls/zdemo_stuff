@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'params'

@Metadata.ignorePropagatedAnnotations: true

define root view entity zmn_i_cdsparams
  as select from zmn_cdsparams

{
      @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
      @UI.identification: [ { position: 10, label: 'Username' } ]
      @UI.lineItem: [ { position: 10, label: 'Username' } ]
  key uname                    as Uname,

      @UI.identification: [ { position: 20, label: 'Sounds like' } ]
      @UI.lineItem: [ { position: 20, label: 'Sounds like' } ]
      soundslike               as Soundslike,

      @UI.identification: [ { position: 30, label: 'Fuzziness' } ]
      @UI.lineItem: [ { position: 30, label: 'Fuzziness' } ]
      fuzziness                as Fuzziness,
/////// navigation below //////
      @Consumption.semanticObject: 'demo'
       @UI.identification: [ { position: 40} ]
       @UI.lineItem: [ { position: 40, type: #WITH_INTENT_BASED_NAVIGATION, semanticObjectAction: 'showmaterials' } ]
      'see matching materials' as go_tolist
}

where uname = $session.user

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
      @UI.identification: [ { position: 40, label: 'Start date' } ]
      @UI.lineItem: [ { position: 40, label: 'Start date' } ]
      start_date,
      @UI.identification: [ { position: 50, label: 'End date' } ]
      @UI.lineItem: [ { position: 50, label: 'End date' } ]
      
      end_date,
      @UI.identification: [ { position: 60, label: 'Currency' } ]
      @UI.lineItem: [ { position:60 , label: 'Currency' } ]
      @Consumption.valueHelpDefinition: [{ entity: {name: 'I_CurrencyStdVH', element: 'Currency' }, useForValidation: true }]
      currency,
      @UI.lineItem: [ { position: 90, type: #FOR_ACTION, dataAction: 'setToday', label: 'Set today' }]
      '' as action_today,
           @UI.lineItem: [ { position: 91, type: #FOR_ACTION, dataAction: 'adjust', label: 'Adjust start and end' }]
      '' as action_adjust,
      
/////// navigation below //////
      @Consumption.semanticObject: 'matdemo'
       @UI.identification: [ { position: 100} ]
       @UI.lineItem: [ { position: 100, type: #WITH_INTENT_BASED_NAVIGATION, semanticObjectAction: 'showmaterials' } ]
      'see matching materials' as goto_material_list,
            @Consumption.semanticObject: 'flightdemo'
       @UI.identification: [ { position: 110} ]
       @UI.lineItem: [ { position: 110, type: #WITH_INTENT_BASED_NAVIGATION, semanticObjectAction: 'showflights' } ]
      'see matching flights' as goto_flight_list
      
}

where uname = $session.user

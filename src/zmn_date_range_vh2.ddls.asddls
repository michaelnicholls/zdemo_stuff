
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'value help for date range'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMN_DATE_RANGE_VH2 as select from dd07t
{
    @UI.hidden: true
    key domname as domain_name,
    @UI.hidden: true
    key valpos as value_position,
    @UI.hidden: true
    key ddlanguage as language,
   // @UI.hidden: true
   @EndUserText.label: 'Value'
    domvalue_l as Value,
    @Semantics.text: true
    ddtext as Description
}
where domname = 'ZMN_DATE_TYPES' and dd07t.as4local = 'A'

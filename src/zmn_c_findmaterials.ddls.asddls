@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'expose find materials function'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZMN_C_FINDMATERIALS 
with parameters p_soundslike : abap.char(30), p_fuzziness :abap.fltp
as select from zmn_findmaterials( sounds_like :$parameters.p_soundslike, fuzziness :$parameters.p_fuzziness)

{
   key  product,
    productgroup,
    description}

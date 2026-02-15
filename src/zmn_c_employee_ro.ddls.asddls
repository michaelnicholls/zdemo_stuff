@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'read only'

@Metadata.ignorePropagatedAnnotations: false

define root view entity ZMN_C_EMPLOYEE_RO
  as projection on zmn_i_employee

{
  key Id,

      Firstname,
      Lastname,
      SalaryBand,
      AgeRange
}

@AccessControl.authorizationCheck: #CHECK

@EndUserText.label: 'admin access'

@Metadata.ignorePropagatedAnnotations: false

define root view entity ZMN_C_EMPLOYEE_ADMIN
  as projection on zmn_i_employee

{
  key Id,

      Firstname,
      Lastname,
      Dob,
      Salary
}

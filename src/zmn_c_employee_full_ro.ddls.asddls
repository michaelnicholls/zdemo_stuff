@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'admin from union'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZMN_C_EMPLOYEE_FULL_RO as projection on ZMN_I_EMPLOYEE_FULL
{
    key Id,
    key adminflag,
    Firstname,
    Lastname,
    SalaryBand,
    AgeRange
}
where adminflag = 'N'

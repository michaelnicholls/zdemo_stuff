@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'admin from union'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZMN_C_EMPLOYEE_FULL_ADMIN as projection on ZMN_I_EMPLOYEE_FULL
{
    key Id,
    key adminflag,
    Firstname,
    Lastname,
    Dob,
    Salary,
    SalaryBand,
    AgeRange
}
where adminflag = 'Y'

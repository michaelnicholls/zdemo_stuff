@AccessControl.authorizationCheck: #CHECK

@EndUserText.label: 'employee'

@Metadata.ignorePropagatedAnnotations: true

///  union of restricted/admin fields and enduser/read-only fields
define root view entity ZMN_I_EMPLOYEE_FULL
  as select from zmn_employee

/////  first we add the full set of non-derived fields, plus set the flag
///////  to show it's the administrator details
/////
{
      @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
      @UI.identification: [ { position: 10, label: 'Id' } ]
      @UI.lineItem: [ { position: 10, label: 'Id' } ]
  key id            as Id,

  key 'Y'           as adminflag,

      @UI.identification: [ { position: 20, label: 'First name' } ]
      @UI.lineItem: [ { position: 20, label: 'First name' } ]
      firstname     as Firstname,

      @UI.identification: [ { position: 30, label: 'Last name' } ]
      @UI.lineItem: [ { position: 30, label: 'Last name' } ]
      lastname      as Lastname,

      @UI.identification: [ { position: 40, label: 'DOB' } ]
      @UI.lineItem: [ { position: 40, label: 'DOB' } ]
      dob           as Dob,

      @UI.identification: [ { position: 50, label: 'Salary' } ]
      @UI.lineItem: [ { position: 50, label: 'Salary' } ]
      salary        as Salary,

      @UI.identification: [ { position: 60, label: 'Salary band' } ]
      @UI.lineItem: [ { position: 60, label: 'Salary band' } ]
      cast('' as abap.char( 25) ) as SalaryBand,

      @UI.identification: [ { position: 70, label: 'Age range' } ]
      @UI.lineItem: [ { position: 70, label: 'Age range' } ]
     cast('' as abap.char(25)) as AgeRange
}

union
  //// now just the masked fields, with the flag set to show it's non-admin
  ////
  //// we set some default values for things like birth date and salary
  ////
  select from zmn_employee

{
  key id                                             as Id,
  key 'N'                                            as adminflag,

      firstname                                      as Firstname,
      lastname                                       as Lastname,
      dats_to_datn('00010101', 'INITIAL', 'INITIAL') as Dob,
      0                                              as Salary,

      case when salary > 100000 then 'High'
         when salary > 50000 then 'Medium'
        else 'Low' end                               as SalaryBand,

      case when dats_days_between(dats_from_datn(dob, 'INITIAL'), $session.system_date) > 11000 then 'Over 30'
      else 'Under 30' end                            as AgeRange
}

@AccessControl.authorizationCheck: #CHECK

@EndUserText.label: 'employee'

@Metadata.ignorePropagatedAnnotations: true

define root view entity zmn_i_employee
  as select from zmn_employee

{
      @UI.facet: [ { id: 'details',
                     purpose: #STANDARD,
                     position: 10,
                     label: 'Details',
                     type: #IDENTIFICATION_REFERENCE } ]
      @UI.identification: [ { position: 10, label: 'Id' } ]
      @UI.lineItem: [ { position: 10, label: 'Id' } ]
  key id                  as Id,

      @UI.identification: [ { position: 20, label: 'First name' } ]
      @UI.lineItem: [ { position: 20, label: 'First name' } ]
      firstname           as Firstname,

      @UI.identification: [ { position: 30, label: 'Last name' } ]
      @UI.lineItem: [ { position: 30, label: 'Last name' } ]
      lastname            as Lastname,

      @UI.identification: [ { position: 40, label: 'DOB' } ]
      @UI.lineItem: [ { position: 40, label: 'DOB' } ]
      dob                 as Dob,

      @UI.identification: [ { position: 50, label: 'Salary' } ]
      @UI.lineItem: [ { position: 50, label: 'Salary' } ]
      salary              as Salary,

      @UI.identification: [ { position: 60, label: 'Salary band' } ]
      @UI.lineItem: [ { position: 60, label: 'Salary band' } ]
      case when salary > 100000 then 'High'
      when salary > 50000 then 'Medium'
     else 'Low' end       as SalaryBand,

      @UI.identification: [ { position: 70, label: 'Age range' } ]
      @UI.lineItem: [ { position: 70, label: 'Age range' } ]
      case when dats_days_between(dats_from_datn(dob, 'INITIAL'), $session.system_date) > 11000 then 'Over 30'
      else 'Under 30' end as AgeRange
}

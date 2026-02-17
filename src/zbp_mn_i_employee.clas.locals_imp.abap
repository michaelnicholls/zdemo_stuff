CLASS lhc_zmn_i_employee DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zmn_i_employee RESULT result.
    METHODS validatesalary FOR VALIDATE ON SAVE
      IMPORTING keys FOR zmn_i_employee~validatesalary.
    METHODS validatedob FOR VALIDATE ON SAVE
      IMPORTING keys FOR zmn_i_employee~validatedob.
    METHODS validatename FOR VALIDATE ON SAVE
      IMPORTING keys FOR zmn_i_employee~validatename.

ENDCLASS.

CLASS lhc_zmn_i_employee IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validateSalary.
    READ ENTITY zmn_i_employee FIELDS ( Salary )
         WITH CORRESPONDING #( keys )
         RESULT DATA(recs).
    LOOP AT recs ASSIGNING FIELD-SYMBOL(<rec>).
      IF <rec>-Salary <= 0.
        APPEND VALUE #( %tky = <rec>-%tky ) TO failed-zmn_i_employee.
        APPEND VALUE #( %tky            = <rec>-%tky
                        %msg            = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                 text     = 'Salary must be positive' )
                        %element-salary = if_abap_behv=>mk-on )
               TO reported-zmn_i_employee.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDOB.
    READ ENTITY zmn_i_employee FIELDS ( Dob )
         WITH CORRESPONDING #( keys )
         RESULT DATA(recs).
    LOOP AT recs ASSIGNING FIELD-SYMBOL(<rec>).
      IF    <rec>-Dob >= cl_abap_context_info=>get_system_date( )
         OR <rec>-dob IS INITIAL.
        APPEND VALUE #( %tky = <rec>-%tky ) TO failed-zmn_i_employee.
        APPEND VALUE #( %tky         = <rec>-%tky
                        %msg         = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = 'Date of birth must be in the past' )
                        %element-dob = if_abap_behv=>mk-on )
               TO reported-zmn_i_employee.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateName.
    READ ENTITY zmn_i_employee FIELDS ( Firstname Lastname )
         WITH CORRESPONDING #( keys )
         RESULT DATA(recs).
    LOOP AT recs ASSIGNING FIELD-SYMBOL(<rec>).
      IF <rec>-Firstname IS INITIAL.
        APPEND VALUE #( %tky = <rec>-%tky ) TO failed-zmn_i_employee.
        APPEND VALUE #(
            %tky               = <rec>-%tky
            %msg               = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                        text     = 'Please supply first name and last name' )
            %element-firstname = if_abap_behv=>mk-on )
               TO reported-zmn_i_employee.
      ENDIF.
      IF <rec>-Lastname IS INITIAL.
        APPEND VALUE #( %tky = <rec>-%tky ) TO failed-zmn_i_employee.
        APPEND VALUE #(
            %tky               = <rec>-%tky
            %msg               = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                        text     = 'Please supply first name and last name' )
            %element-lastname = if_abap_behv=>mk-on )
               TO reported-zmn_i_employee.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

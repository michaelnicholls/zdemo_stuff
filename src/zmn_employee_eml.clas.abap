CLASS zmn_employee_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmn_employee_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA newemp TYPE TABLE FOR CREATE zmn_i_employee.

    " try some different values

    DATA(id) = 327.
    DATA(last) = 'Smith'.
    DATA(first) = 'Patricia'.
    DATA(dob) = sy-datum - 10.
    DATA(sal) = 0.

    newemp = VALUE #( ( %cid               = 'new'
                        id                 = id
                        lastname           = last
                        firstname          = first
                        dob                = dob
                        salary             = sal
                        %control-dob       = if_abap_behv=>mk-on
                        %control-Salary    = if_abap_behv=>mk-on
                        %control-Firstname = if_abap_behv=>mk-on
                        %control-Lastname  = if_abap_behv=>mk-on
                        %control-id        = if_abap_behv=>mk-on ) ).
    out->write( name = |About to create using |
                data = newemp ).
    MODIFY ENTITY zmn_i_employee
           CREATE FROM newemp
           FAILED DATA(failed).
    IF failed IS NOT INITIAL.
      out->write( name = 'Failed to create'
                  data = failed ).
    ELSE.
      COMMIT ENTITIES
             RESPONSE OF zmn_i_employee
             REPORTED DATA(reported_commit)
             FAILED DATA(failed_commit).

      IF failed_commit IS NOT INITIAL.
        out->write( name = |Failed to commit|
                    data = reported_commit ).
      ELSE.
        out->write( |Record added| ).
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

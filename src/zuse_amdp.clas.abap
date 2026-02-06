CLASS zuse_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zuse_amdp IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    zamdp_example=>get_count( IMPORTING num_recs = DATA(c_amdp)
        num_all_recs = data(c_amdp_all)   ).
    SELECT FROM usr02 FIELDS COUNT( * ) INTO @DATA(c_abap).

    out->write( |Count from ABAP: { c_abap }, count from AMDP: { c_amdp }, count from AMDP(all): { c_amdp_all }| ).
  ENDMETHOD.

ENDCLASS.

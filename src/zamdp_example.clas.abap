CLASS zamdp_example DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .

    CLASS-METHODS get_count
      EXPORTING VALUE(num_recs)     TYPE int4
                VALUE(num_all_recs) TYPE int4.
  PROTECTED SECTION.
ENDCLASS.


CLASS zamdp_example IMPLEMENTATION.
  METHOD get_count BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING usr02.

    select count(*) into num_all_recs from usr02 ; -- will find from all clients - probably not what we want
    select count(*) into num_recs from usr02 where mandt = session_context( 'CLIENT' ) ;  -- just our logon client

  ENDMETHOD.

ENDCLASS.

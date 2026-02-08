CLASS zamdp_example DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
    TYPES: ty_spfli TYPE STANDARD TABLE OF spfli.
    CLASS-METHODS get_count
      EXPORTING VALUE(num_recs) TYPE int4.
    CLASS-METHODS get_flights
      EXPORTING VALUE(et_flights) TYPE ty_spfli .
  PROTECTED SECTION.
ENDCLASS.


CLASS zamdp_example IMPLEMENTATION.
  METHOD get_count BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING usr02.


    select count(*) into num_recs from usr02 where mandt = session_context( 'CLIENT' ) ;  -- just our logon client
    select count(*) into num_recs from usr02 ;

  ENDMETHOD.

  METHOD get_flights  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING spfli.

    et_flights = select * from spfli where mandt = session_context( 'CLIENT' ) orDER BY carrid, connid;

  ENDMETHOD.

ENDCLASS.

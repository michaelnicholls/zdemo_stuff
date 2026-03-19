CLASS zcl_calc_ranges DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
    TYPES: ty_ranges TYPE STANDARD TABLE OF zmn_calc_daterange.
    CLASS-METHODS calc FOR TABLE FUNCTION zmn_calc_daterange .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_calc_ranges IMPLEMENTATION.
  METHOD calc BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY USING sflight.
    RETURN
        select  sflight.mandt,fldate as search_date, 'ALL' as range_name
    from sflight
    union
    select sflight.mandt, fldate as search_date, 'TODAY' as range_name
    from sflight
    where sflight.mandt = session_context( 'CLIENT' ) and fldate = current_date

    union
    SELECT sflight.mandt, fldate as search_date, 'MONTH' from sflight
    where sflight.mandt = session_context( 'CLIENT' ) and EXTRACT (month from fldate ) = extract(month from current_date)
    and EXTRACT (year from fldate) = extract(year from current_date)

    union
    SELECT sflight.mandt, fldate as search_date, 'MTD' from sflight
    where sflight.mandt = session_context( 'CLIENT' ) and EXTRACT (month from fldate ) = extract(month from current_date)
       and EXTRACT (year from fldate) = extract(year from current_date)   and fldate <= current_date

    union
    SELECT sflight.mandt, fldate as search_date, 'YTD' from sflight
    where sflight.mandt = session_context( 'CLIENT' )
       and EXTRACT (year from fldate) = extract(year from current_date)   and fldate <= current_date

    union
    SELECT sflight.mandt, fldate as search_date, 'YEAR' from sflight
    where sflight.mandt = session_context( 'CLIENT' ) and EXTRACT (year from fldate ) = extract(year from current_date);
  ENDMETHOD.

ENDCLASS.

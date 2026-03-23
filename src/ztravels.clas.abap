CLASS ztravels DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ztravels IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(airport_from) = 'FRA'.
    DATA(airport_to) = 'JFK'.
    DATA(maxtrip) = 14. " maximum length of trip
    DATA(searchfrom) = sy-datum. " starting date
    DATA(nextdays) = 30. " days until trip
    DATA(searchto) = searchfrom + nextdays.
    DATA(seatsreq) = 2.
    DATA(samecarrier) = abap_false. " do we need teh same carrier each way
    SELECT FROM zmn_return_flights
      FIELDS outdate, outdeptime, outbound, retdate, retdeptime, inbound, tripdays, outseatsfree, retseatsfree
      WHERE airpfrom = @airport_from AND airpto = @airport_to
        AND ( @samecarrier = @abap_false OR ( @samecarrier = @abap_true AND samecarr = 'X' ) )
        AND outdate      >= @searchfrom AND outdate      <= @searchto
        AND outseatsfree >= @seatsreq   AND retseatsfree >= @seatsreq
        AND tripdays      < @maxtrip
      ORDER BY outdate, outdeptime, tripdays
      INTO TABLE @DATA(mytab).
    out->write(
        name = |Return flights of { maxtrip } days duration or less after { searchfrom DATE = USER } within { nextdays } days,| &&
        | with { seatsreq } free seats, from { airport_from } to {  airport_to } | &&
        | - same carrier { COND string( WHEN samecarrier = abap_false THEN 'not required' ELSE 'required'  )  } |
        data = mytab ).
  ENDMETHOD.
ENDCLASS.

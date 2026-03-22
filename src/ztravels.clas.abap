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
  data(airport_from) = 'FRA'.
  data(airport_to) = 'JFK'.
  data(maxtrip) = 14. "maximum length of tro[
  data(nextdays) = 30. "days until trip
  data(samecarrier) = abap_false. " do we need teh same carrier each way
    select from zmn_return_flights
    fields outdate, outdeptime, outbound, retdate, retdeptime, inbound, tripdays
    where airpfrom = @airport_from and airpto = @airport_to
    and (  @samecarrier = @abap_false  or ( @samecarrier = @abap_true and samecarr = 'X' ) )
    and DAYS_BETWEEN( @sy-datum,  outdate ) <= @nextdays
    and tripdays < @maxtrip
  order by outdate, outdeptime, tripdays
  into tABLE @data(mytab).
  out->write(
  name = |Return flights in the next { nextdays } days of { maxtrip } days duration or less  from { airport_from } to {  airport_to } | &&
  | - same carrier { cond string( when samecarrier = abap_false then 'not required' else 'required'  )  } |
   data = mytab ).

  ENDMETHOD.
ENDCLASS.

CLASS zmn_reducedloop DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zmn_reducedloop IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    SELECT FROM sbook
      FIELDS bookid, forcuram
      INTO TABLE @DATA(mytab)
      UP TO 10 ROWS.

    DATA(lv_total_amount) = REDUCE s_price(
        INIT total = CONV s_price( 0 ) " Initialize total
        FOR wa IN mytab                           " Loop through table
        NEXT total = total + wa-forcuram ).       " Summation logic

    out->write( | {  lv_total_amount DECIMALS = 2 } | ).
  ENDMETHOD.
ENDCLASS.

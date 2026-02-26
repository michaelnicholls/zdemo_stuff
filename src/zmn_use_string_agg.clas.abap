CLASS zmn_use_string_agg DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS main.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZMN_USE_STRING_AGG IMPLEMENTATION.


  METHOD main.
   " get string off connections for a carrier
    SELECT
      FROM scarr
             JOIN
                spfli ON scarr~carrid = spfli~carrid
      FIELDS scarr~carrid,
             STRING_AGG( spfli~connid, ',' order by connid ) AS connections
      GROUP BY scarr~carrid
      order by scarr~carrid

      INTO TABLE @DATA(mytab)  .


  ENDMETHOD.
ENDCLASS.

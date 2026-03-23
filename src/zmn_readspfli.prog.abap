*&---------------------------------------------------------------------*
*& Report zmn_readspfli
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_readspfli.

SELECT * FROM spfli ORDER BY carrid, connid INTO TABLE @DATA(seltable).

SELECT * FROM zspfli ORDER BY carrid, connid INTO TABLE @DATA(selview).

READ ENTITY zspfli
     ALL FIELDS WITH VALUE #( ( carrid = 'LH' Connid = '0400' )
                              ( carrid = 'XX' connid = '1234' )
                              ( carrid = 'AA'  connid = '0064' ) ) " need primary key
     RESULT DATA(selentity)
     FAILED DATA(failed)
     REPORTED DATA(reported).

LOOP AT seltable INTO DATA(sel).
  WRITE: / 'SELECT from table',sel-carrid, sel-connid, sel-airpfrom.
ENDLOOP.
LOOP AT selview INTO DATA(view).
  WRITE: / 'SELECT from view',view-carrid, view-carrname,view-connid, view-airpfrom.
ENDLOOP.
LOOP AT selentity INTO DATA(entity).
  WRITE: / 'READ ENTITY ',entity-carrid, entity-connid, entity-airpfrom, entity-carrname.
ENDLOOP.
LOOP AT failed-zspfli INTO DATA(fail).
  WRITE: / 'FAILED READ', fail-Carrid, fail-connid.
ENDLOOP.
WRITE / | Entities reads: { lines( selentity ) } , failed: { lines( failed-zspfli  ) } , reported: { lines(
                                                                                                         reported-zspfli ) } |.

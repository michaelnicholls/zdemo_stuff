CLASS zmara_multi_col DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmara_multi_col IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " TODO: variable is assigned but never used (ABAP cleaner)
    SELECT FROM mara FIELDS * ORDER BY matnr INTO TABLE @DATA(big) BYPASSING BUFFER.
    " TODO: variable is assigned but never used (ABAP cleaner)
    SELECT FROM mara FIELDS matnr, matfi, saisj, hazmat ORDER BY matnr INTO TABLE @DATA(tab4) BYPASSING BUFFER.
    " TODO: variable is assigned but never used (ABAP cleaner)
    SELECT FROM mara
      FIELDS matnr, matfi, saisj, hazmat, kosch, tempb, retdelc, weora
      ORDER BY matnr
      INTO TABLE @DATA(tab8)
      BYPASSING BUFFER.
    SELECT FROM mara
      FIELDS matnr, matfi, saisj, hazmat, kosch, tempb, retdelc, weora,
             " TODO: variable is assigned but never used (ABAP cleaner)
             bbtyp, begru, bflme, breit, blanz, bismt, bmatn, blatt
      ORDER BY matnr
      INTO TABLE @DATA(tab16)
      BYPASSING BUFFER.
    SELECT FROM mara
      FIELDS matnr, matfi, saisj, hazmat, kosch, tempb, retdelc, weora, bbtyp, begru, bflme, breit, blanz, bismt, bmatn,
             blatt, cmeth, cmrel,compl, tragr, disst, vhart, voleh, volto, volum,pmata, prod_shape, productoid, qgrp,
             qmpur,zeinr,rmatp
      " TODO: variable is assigned but never used (ABAP cleaner)
      ORDER BY matnr
      INTO TABLE @DATA(tab32)
      BYPASSING BUFFER.

    out->write( |done| ).
  ENDMETHOD.
ENDCLASS.

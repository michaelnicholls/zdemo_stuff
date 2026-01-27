*&---------------------------------------------------------------------*
*& Report zmn_use_po_cds
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_use_po_cds.

DATA lv_ebeln TYPE ebeln.
SELECT-OPTIONS: s_ebeln FOR lv_ebeln.
INITIALIZATION.
select from ekpo fields distinct ebeln order by ebeln into TABLE @data(top10) up to 10 rows.
if top10 is not INITIAL.
s_ebeln[] = VALUE #( ( sign = 'I' option = 'BT' low = top10[  1 ]-ebeln high = top10[ lines(  top10  ) ]-ebeln ) ).
endif.
START-OF-SELECTION.
WRITE: / |From raw tables|.
IF s_ebeln IS NOT INITIAL.
  SELECT FROM ekpo JOIN ekko ON ekpo~ebeln = ekko~ebeln
     FIELDS ekpo~ebeln,ekpo~ebelp, ekpo~matnr , ekpo~menge, ekpo~txz01, ekko~waers, ekko~bedat
    WHERE ekpo~ebeln IN @s_ebeln
    ORDER BY ekpo~ebeln, ekpo~ebelp
    INTO TABLE @DATA(ls_orders).

  LOOP AT ls_orders INTO DATA(lt_order).
    WRITE: / |{ lt_order-ebeln WIDTH = 15 }{ lt_order-ebelp width = 4 }{ lt_order-matnr  WIDTH = 15 } | &&
    |{ lt_order-menge WIDTH = 15  } { lt_order-txz01 WIDTH = 30  }   | &&
    |{ lt_order-waers  WIDTH = 30 } { lt_order-bedat WIDTH = 15 DATE = USER }|.
  ENDLOOP.
  WRITE: / |From a CDS view|.

  SELECT FROM i_purchaseorderitemapi01
    FIELDS purchaseorder, PurchaseOrderItem, material, orderquantity, purchaseorderitemtext, \_purchaseorder-documentcurrency, \_purchaseorder-creationdate
    WHERE purchaseorder IN @s_ebeln
    ORDER BY purchaseorder, PurchaseOrderItem
    INTO TABLE @DATA(ls_orders2).
  LOOP AT ls_orders2 INTO DATA(lt_order2).

    WRITE: / |{ lt_order2-purchaseorder WIDTH = 15 }{  lt_order2-PurchaseOrderItem width = 4 }{ lt_order2-material  WIDTH = 15 } | &&
   |{ lt_order2-orderquantity WIDTH = 15  } { lt_order2-purchaseorderitemtext WIDTH = 30  }   | &&
   |{ lt_order2-documentcurrency  WIDTH = 30 } { lt_order2-creationdate WIDTH = 15 DATE = USER }|.
  ENDLOOP.

ENDIF.

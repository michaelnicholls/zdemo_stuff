*&---------------------------------------------------------------------*
*& Report zmn_joins
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmn_joins.



DATA lv_erdat TYPE erdat.
PARAMETERS: p_ernam TYPE ernam.
SELECT-OPTIONS s_erdat FOR lv_erdat..

INITIALIZATION.
  SELECT FROM vbak
    FIELDS ernam,
           COUNT( * ) AS num
    GROUP BY ernam
    ORDER BY num DESCENDING
    INTO TABLE @DATA(counts)
    UP TO 1 ROWS.
  if lines( counts ) <> 0.
    p_ernam = counts[ 1 ]-ernam. " user with most orders
    SELECT SINGLE FROM vbak
        FIELDS MIN( erdat ) AS earliest,
               MAX( erdat ) AS latest
        WHERE ernam = @p_ernam
        INTO ( @DATA(earliest), @DATA(latest) ). " earliest and latest dates
    s_erdat[] = VALUE #( ( sign = 'I' option = 'BT' low = earliest high = latest ) ).
  endif.
START-OF-SELECTION.
 IF p_ernam IS NOT INITIAL ."AND s_erdat IS NOT INITIAL.
    SELECT FROM vbak JOIN vbap ON vbak~vbeln = vbap~vbeln JOIN makt ON makt~matnr = vbap~matnr
       FIELDS vbak~vbeln AS DocNum, vbap~posnr AS LineNumber, vbak~ernam AS Creationdate,  vbap~matnr AS Material,
      vbap~kwmeng AS OrderQuantity, vbap~vrkme AS UoM, makt~maktx AS MaterialDescription
      WHERE  vbak~erdat IN @s_erdat AND vbak~ernam  = @p_ernam AND makt~spras = @sy-langu
      ORDER BY vbap~vbeln, vbap~posnr
    INTO TABLE @DATA(ls_orders).

*  LOOP AT ls_orders INTO DATA(lt_order).
*    WRITE: /
*      | { lt_order-DocNum } | &&
*      | { lt_order-LineNumber } | &&
*      | { lt_order-Material WIDTH = 15 } | &&
*      | { lt_order-MaterialDescription  WIDTH = 30 } | &&
*      | { lt_order-OrderQuantity  WIDTH = 15 } | &&
*      | { lt_order-UoM  WIDTH = 15 } |.
*
*  ENDLOOP.
    DATA go_alv_table TYPE REF TO cl_salv_table.
    TRY.
        cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
          CHANGING t_table = ls_orders ).
      CATCH cx_root.
    ENDTRY.
    go_alv_table->display( ).
  else.
    write: / |No matching records found|.
  ENDIF.

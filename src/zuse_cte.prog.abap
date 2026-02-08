*&---------------------------------------------------------------------*
*& Report zuse_cte
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zuse_cte.

*&---------------------------------------------------------------------*
*& Report ZMN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*


WITH +cte_sales AS ( SELECT FROM vbak

                       FIELDS kunnr,
                              vbeln,
                              netwr,
                              SUM( netwr ) OVER( PARTITION BY kunnr )                  AS total_sales,
                              ROW_NUMBER( ) OVER(  PARTITION BY kunnr ORDER BY netwr ) AS rank )

SELECT FROM +cte_sales AS a
  FIELDS kunnr,
         rank,
         vbeln,
         netwr,
         total_sales,
         CASE WHEN total_sales > 100000 THEN 'High'
         WHEN total_sales > 50000 THEN 'Medium' ELSE 'Low' END AS performance
  WHERE rank <= 3
  INTO TABLE @DATA(mytab).
DATA go_alv_table TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
                            CHANGING  t_table      = mytab ).
  CATCH cx_root.
ENDTRY.
go_alv_table->display( ).

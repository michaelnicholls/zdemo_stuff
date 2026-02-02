*&---------------------------------------------------------------------*
*& Report ZEQUIP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZEQUIP.

SELECT FROM I_Equipment
  FIELDS Equipment,
         CreatedByUser,
         CreationDate,
         \_EquipmentText[ MANY TO ONE WHERE Language = @sy-langu ]-EquipmentName,
         EquipmentCategory, AuthorizationGroup
  WHERE Equipment LIKE '%100'
  ORDER BY Equipment
  INTO TABLE @DATA(mytab).

DATA go_alv_table TYPE REF TO cl_salv_table.
TRY.
    cl_salv_table=>factory( IMPORTING r_salv_table = go_alv_table
                            CHANGING  t_table      = mytab ).
  CATCH cx_root.
ENDTRY.
go_alv_table->display( ).

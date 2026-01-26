CLASS lhc_zmn_i_view DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zmn_i_view RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zmn_i_view RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zmn_i_view RESULT result.

    METHODS myaction FOR MODIFY
      IMPORTING keys FOR ACTION zmn_i_view~myaction.

ENDCLASS.

CLASS lhc_zmn_i_view IMPLEMENTATION.

   METHOD get_instance_features.
    " use EML to get the instance values into an internal table
    READ ENTITY IN LOCAL MODE zmn_i_view
         ALL FIELDS  WITH CORRESPONDING #( keys )
         RESULT DATA(mytable).

    " do we want delete  (or %update or %action-xxx ) to appear in the UI
    LOOP AT mytable ASSIGNING FIELD-SYMBOL(<myrow>).
      APPEND CORRESPONDING #( <myrow> ) TO result ASSIGNING FIELD-SYMBOL(<result>).
      " if some sort of condition is not met...
      <result>-%delete = if_abap_behv=>fc-o-disabled.
      <result>-%action-myaction = if_abap_behv=>fc-o-disabled.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_authorizations.
    " use EML to get the instance values into an internal table
    READ ENTITY IN LOCAL MODE zmn_i_view
         ALL FIELDS  WITH CORRESPONDING #( keys )
         RESULT DATA(mytable).

    " can we do a delete  (or %update or %action-xxx ) on this instance of an entity
    " either through an OData HTTP call or through EML
    LOOP AT mytable ASSIGNING FIELD-SYMBOL(<myrow>).
      APPEND CORRESPONDING #( <myrow> ) TO result ASSIGNING FIELD-SYMBOL(<result>).
      " if some sort of condition is not met....
      <result>-%delete = if_abap_behv=>auth-unauthorized.
      <result>-%action-myaction = if_abap_behv=>auth-unauthorized.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_global_authorizations.
    " can we do a delete (or %create, or %update) on this entity at all
    " either through an OData HTTP call or through EML
    " if some sort of condition is not met...
    result-%delete = if_abap_behv=>auth-unauthorized.
  ENDMETHOD.

  METHOD myaction.
  ENDMETHOD.

ENDCLASS.

CLASS zmn_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmn_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA key TYPE TABLE FOR DELETE zmn_i_view.

    key = VALUE #( ( %tky-%key-id = 10 ) ).
    MODIFY ENTITY zmn_i_view
           DELETE FROM key
           FAILED DATA(failed)
           " TODO: variable is assigned but never used (ABAP cleaner)
           REPORTED DATA(reported).
    IF failed IS NOT INITIAL.
      out->write( |Something went wrong| ).
    ELSE.
      COMMIT ENTITIES.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

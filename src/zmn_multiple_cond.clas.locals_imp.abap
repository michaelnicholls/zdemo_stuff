CLASS mn DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS checkA IMPORTING io_out          TYPE REF TO if_oo_adt_classrun_out
                                   a_string        TYPE string
                         RETURNING VALUE(a_number) TYPE i.
    CLASS-METHODS checkB IMPORTING io_out          TYPE REF TO if_oo_adt_classrun_out
                                   a_string        TYPE string
                         RETURNING VALUE(a_number) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS mn IMPLEMENTATION.

  METHOD checka.

    a_number = 10.
    io_out->write( |Check A { a_string }| ).

  ENDMETHOD.
    METHOD checkb.

    a_number = 10.
    io_out->write( |Check B { a_string }| ).

  ENDMETHOD.

ENDCLASS.

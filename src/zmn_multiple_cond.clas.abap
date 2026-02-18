CLASS zmn_multiple_cond DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zmn_multiple_cond IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( 'Testing AND and OR optimizations in ABAP' ).
    out->write( '' ).
    IF     mn=>checkA( a_string = 'test1'
                       io_out   = out ) > 0
       AND mn=>checkB( a_string = 'test1'
                       io_out   = out ).
      out->write( 'test1 using A and B successful' ).
      out->write( '' ).
    ENDIF.
    IF    mn=>checkA( a_string = 'test2'
                      io_out   = out ) > 0
       OR mn=>checkB( a_string = 'test2'
                      io_out   = out ).
      out->write( 'test2 using A or B successful' ).
      out->write( '' ).
    ENDIF.
    IF    mn=>checkB( a_string = 'test3'
                      io_out   = out ) > 0
       OR mn=>checkA( a_string = 'test3'
                      io_out   = out ).
      out->write( 'test3 using B or A successful' ).
      out->write( '' ).

    ENDIF.
  ENDMETHOD.
ENDCLASS.

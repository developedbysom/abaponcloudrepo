CLASS zcl_fill_boolean DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_fill_boolean IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lt_boolean TYPE STANDARD TABLE OF ztboolean.
    lt_boolean = VALUE #(
                                        ( type = 'Y' value = 'Yes' )
                                        ( type = 'N' value = 'No')
                     ).

    INSERT  ztboolean FROM TABLE @lt_boolean.
    IF sy-subrc EQ 0.
      COMMIT WORK.
      out->write( 'Successsuly updated' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.

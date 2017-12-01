&if 1 eq 0 &then
/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : field_property.i
    Author(s)   : pjudge
    Created     : 2017-10-26
    Notes       :
  ---------------------------------------------------------------------*/
&endif  
&if defined(FIELD_NAME) eq 0 &then
    &SCOPED-DEFINE FIELD_NAME {1} 
&endif
&if defined(DATA_TYPE) eq 0 &then
    &SCOPED-DEFINE DATA_TYPE {2} 
&endif
  
define public property {&FIELD_NAME} as {&DATA_TYPE} no-undo
    get():
        define variable pVal as {&DATA_TYPE} no-undo.
        GetVal('{&FIELD_NAME}', output pVal).
        return pVal.
    end get.
    set(input pVal as {&DATA_TYPE}):
        SetVal('{&FIELD_NAME}', pVal).
    end set.

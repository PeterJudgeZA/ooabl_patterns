/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
 /*------------------------------------------------------------------------
    File        : EmployeeMapper
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : pjudge
    Created     : 2017-10-30
    Notes       : * 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using data.s2k.EmployeeRecord.
using data.shared.BufferMapper.

class data.s2k.EmployeeMapper inherits BufferMapper:
    
    constructor public EmployeeMapper(input pBuffer as handle):
        super(pBuffer, 
              // we want to create department records
              get-class(EmployeeRecord)).
    end constructor.
    
    constructor public EmployeeMapper():
        this-object(buffer Employee:handle). 
    end constructor.
    
end class.

/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : EmployeeRecord
    Author(s)   : pjudge
    Created     : 2017-10-23
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using data.shared.IRecord.

class data.s2k.EmployeeRecord implements IRecord:    
    define public property EmpNum             as         integer   no-undo get. set.
    define public property LastName           as         character no-undo get. set.
    define public property FirstName          as         character no-undo get. set.
    define public property Address            as         character no-undo get. set.
    define public property Address2           as         character no-undo get. set.
    define public property City               as         character no-undo get. set.
    define public property State              as         character no-undo get. set.
    define public property PostalCode         as         character no-undo get. set.
    define public property HomePhone          as         character no-undo get. set.
    define public property WorkPhone          as         character no-undo get. set.
    define public property DeptCode           as         character no-undo get. set.
    define public property Position           as         character no-undo get. set.
    define public property Birthdate          as         date      no-undo get. set.
    define public property StartDate          as         date      no-undo get. set.
    define public property VacationDaysLeft   as         integer   no-undo get. set.
    define public property SickDaysLeft       as         integer   no-undo get. set.
    
end class.

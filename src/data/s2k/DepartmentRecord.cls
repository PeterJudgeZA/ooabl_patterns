/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : DepartmentRecord
    Author(s)   : pjudge
    Created     : 2017-10-23
    Notes       : 
        
        DeptCode                    char       i   x(3)
        DeptName                    char           x(15)
        
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using OpenEdge.Core.Collections.ICollection.
using OpenEdge.Core.Collections.IIterator.
using data.s2k.EmployeeRecord.
using data.shared.IRecord.

class data.s2k.DepartmentRecord implements IRecord:
    // database table.field
    define public property DeptCode as character no-undo get. set.
    // database table.field
    define public property DeptName as character no-undo get. set.
    
    define public property Employees as ICollection no-undo get. set.

    // The average employee age/time
    define public property AvgEmpTenure as decimal no-undo 
        get():
            return CalculateTenure('months').
        end get. 
    
    method protected decimal CalculateTenure(input pUnit as character):
        define variable totTenure as integer no-undo.
        define variable iterator as IIterator no-undo.
        
        if this-object:Employees:Size eq 0 then
            return 0.00.
        else
        do:
            iterator = this-object:Employees:Iterator().
            do while iterator:HasNext():
                totTenure = totTenure
                          + interval(today, cast(iterator:Next(), EmployeeRecord):StartDate, pUnit).
            end.
            return (totTenure / this-object:Employees:Size). 
        end.
    end method.
    
end class.

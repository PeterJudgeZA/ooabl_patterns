/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
 /*------------------------------------------------------------------------
    File        : DepartmentMapper
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : pjudge
    Created     : 2017-10-30
    Notes       : * 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using data.s2k.DepartmentRecord.
using data.shared.BufferMapper.
using data.shared.IRecord.

class data.s2k.DepartmentMapper inherits BufferMapper:
    
    method override public class IRecord Find(input pWhere as character):        
        define variable dept as class DepartmentRecord no-undo.
        define variable numEmps as integer no-undo.
        define variable totAge as integer no-undo.
        
        dept = cast(super:Find(pWhere), DepartmentRecord).
        
        for each Employee where
                 Employee.DeptCode eq dept:DeptCode                     
                 no-lock:
            assign numEmps = numEmps + 1
                   totAge  = totAge + interval(today, Employee.StartDate, 'months')
                   .
        end.
        assign dept:AvgEmpTenure = (totAge / numEmps) no-error.
        
        return dept.
    end method.
    
    constructor public DepartmentMapper():
        super(buffer Department:handle).
        
        // we want to create department records
        assign this-object:RecordType = get-class(DepartmentRecord).
    end constructor.
    
end class.

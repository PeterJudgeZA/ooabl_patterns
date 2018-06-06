/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
 /*------------------------------------------------------------------------
    File        : DepartmentDAO
    Description : Data access layer: knows where to get data for a DepartmentRecord
                  and how to build one 
    Author(s)   : pjudge
    Created     : 20017-11-06
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using data.s2k.DepartmentMapper.
using data.s2k.DepartmentRecord.
using data.s2k.EmployeeMapper.
using data.shared.IMapper.

class data.s2k.DepartmentDAO:
    define public property DepartmentMapper as IMapper no-undo get. private set.
    define public property EmployeeMapper   as IMapper no-undo get. private set.
    
    // Injectables
    constructor public DepartmentDAO(input pDeptMapper as IMapper,
                                     input pEmpMapper  as IMapper):
        assign this-object:DepartmentMapper = pDeptMapper
               this-object:EmployeeMapper   = pEmpMapper
               . 
    end constructor.
    
    // Defaults: probably not a good idea for real life
    constructor public DepartmentDAO():
        this-object(new DepartmentMapper(), new EmployeeMapper() ).
    end constructor.
    
    method public DepartmentRecord Load(input pWhere as character):
        define variable recDept as DepartmentRecord no-undo.
        
        recDept = cast(DepartmentMapper:Get(pWhere), DepartmentRecord).
        recDept:Employees = EmployeeMapper:GetAll(pWhere).
        
        return recDept.                    
    end method.
    
    method public void Update(input pData as class DepartmentRecord):
        DepartmentMapper:Update(pData).
    end method.
    
end class.
/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : runner.p
    Purpose     : 
    Author(s)   : pjudge
    Created     : 2017-10-26
    Notes       :
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using data.s2k.DepartmentDAO.
using data.s2k.DepartmentRecord.
using data.shared.IRecord.

session:error-stack-trace = true.
session:debug-alert = true.

/* ***************************  Main Block  *************************** */

define variable record as class IRecord.
define variable deptRecord as class DepartmentRecord.
define variable dao as DepartmentDAO no-undo.
 
assign dao = new DepartmentDAO()
       deptRecord = dao:Load(' where DeptCode eq "100" ')
       .
 
// application/business logic does Stuff
message deptRecord:DeptCode       skip // 100
        deptRecord:DeptName       skip // Consulting
        deptRecord:AvgEmpTenure   skip // 236.29
        deptRecord:Employees:Size skip // 7
        .
// update the name         
assign deptRecord:DeptName = 'Department of One Hundred'.
 
// write any changes to the DB
dao:Update(deptRecord).

message deptRecord:DeptCode       skip // 100
        deptRecord:AvgEmpTenure   skip // 236.29
        deptRecord:Employees:Size skip // 7
        deptRecord:DeptName       skip // Department of One Hundred
        .

catch e as Progress.Lang.Error :
    message 
    e:GetMessage(1) skip
    e:CallStack
    view-as alert-box.
          
  end catch.
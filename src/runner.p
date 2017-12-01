
/*------------------------------------------------------------------------
    File        : runner.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : pjudge
    Created     : Thu Oct 26 15:43:39 EDT 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.

/* ***************************  Main Block  *************************** */
using data.s2k.DepartmentRecord.

define variable dept as class DepartmentRecord no-undo.
define buffer localDep for Department.

find first localDep.

dept = new DepartmentRecord(buffer localDep).
message dept:DeptCode       // 100
        dept:AvgEmpTenure   // 236.29
        .

assign dept:AvgEmpTenure = 19.

  
find first localDep where localDep.DeptCode eq dept:DeptCode exclusive-lock.
  

  
// read the data from the DB
assign mapper  = new data.s2k.department.Record().
       dept    = mapper:Find('where DeptCode eq 100').

// application/business logic does Stuff
message dept:DeptCode       // 100
        dept:AvgEmpTenure   // 236.29

assign dept:DeptName = 'Department of One Hundred'.

// write any changes to the DB
mapper:Update(dept).

  

/*------------------------------------------------------------------------
    File        : department_dao.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : pjudge
    Created     : Mon Nov 06 11:38:18 EST 2017
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.

using data.s2k.DepartmentRecord.
using data.s2k.EmployeeRecord.
using data.shared.BufferMapper.
using data.shared.IMapper.
using data.shared.IRecord.

/* ***************************  Main Block  *************************** */
define variable recDept as DepartmentRecord no-undo.
define variable deptMapper as IMapper no-undo.
define variable empMapper as IMapper no-undo.

// Generic Mapper
deptMapper = new BufferMapper(buffer Department:handle,
                             get-class(DepartmentRecord) ).

// Generic Mapper
empMapper = new BufferMapper(buffer Employee:handle,
                             get-class(EmployeeRecord) ).

recDept = cast(deptMapper:Get('DeptCode eq "100"'), DepartmentRecord).
recDept:Employees = empMapper:GetAll('DeptCode eq "100"').

message recDept:DeptCode.           // 100
message recDept:AvgEmpTenure.       // 239.6

 


        
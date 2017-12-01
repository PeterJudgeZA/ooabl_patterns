
/*------------------------------------------------------------------------
    File        : DataAccess
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : pjudge
    Created     : Mon Nov 06 22:45:35 EST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

using data.s2k.DepartmentRecord.
using data.shared.RecordCollection.

interface data.shared.DataAccess:  
    
    method public void Update(input pData as class DepartmentRecord):
    method public void Update(input pData as class RecordCollection):
    
    method public void Create(input pData as class DepartmentRecord):
    method public void Create(input pData as class RecordCollection):
    
    method public void Delete(input pData as class DepartmentRecord):
    method public void Delete(input pData as class RecordCollection):
    
    method public DepartmentRecord Read(input pWhere as character):
    method public RecordCollection ReadAll(input pWhere as character):
    
end interface.
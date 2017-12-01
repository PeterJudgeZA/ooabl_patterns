/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : IMapper
    Description : 
    Author(s)   : pjudge
    Created     : 2017-11-02
    Notes       : 
  ----------------------------------------------------------------------*/

using OpenEdge.Core.Collections.ICollection.
using data.shared.IRecord.

interface data.shared.IMapper:
    // what type of IRecord should we create
    define public property RecordType as class Progress.Lang.Class no-undo get.
    
    /* Read from the persistent store/database
       
       @param character a filter string
       @return IRecord A single record */ 
    method public class ICollection GetAll(input pWhere as character):
    
    /* Read from the persistent store/database
       
       @param character a filter string
       @return IRecord A single record */ 
    method public class IRecord Get(input pWhere as character):
    
    /* Creates a new record in the persistent store/database
       
       @param  IRecord A single record */ 
    method public void Create(input pData as class IRecord):
    
    /* Creates a new record in the persistent store/database
       
       @param  ICollection A set of records */ 
    method public void Create(input pData as class ICollection):
    
    /* Deletes a record from the persistent store/database
       
       @param  IRecord A single record */ 
    method public void Delete(input pData as class IRecord). 
    
    /* Deletes a record from the persistent store/database
       
       @param  ICollection A set of records to delete */ 
    method public void Delete(input pData as class ICollection). 

    /* Updates a record in the the persistent store/database
       
       @param  IRecord A single record */ 
    method public void Update(input pData as class IRecord).
    
    /* Updates a record in the the persistent store/database
       
       @param  ICollection A set of records to update single record */ 
    method public void Update(input pData as class ICollection).
    
end interface.
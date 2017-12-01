/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
 /*------------------------------------------------------------------------
    File        : DAO
    Description : 
    Author(s)   : pjudge
    Created     : 2017-10-23
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using Progress.Lang.AppError.
using data.shared.LockEnum.

class data.shared.DAO abstract:
    
    define protected property Buffer as handle no-undo get. private set.
    define public property Available as logical no-undo
        get():
            return this-object:Buffer:available.
        end get.
    
    constructor protected DAO(input pBuffer as handle):
        assign this-object:Buffer = pBuffer.
    end constructor.
    
    method public void New():
    end method.
    
    method public void Remove():
    end method.
    
    method public void Commit():
    end method.
    
    method public void Find(input pWhere as character,
                            input pLock  as LockEnum):
    end method.

    method protected void SetVal(input pName as character, input pVal as character):
        define variable currentField as handle no-undo.
        
        if not this-object:Available then
            return error new AppError(substitute('Record not available for buffer &1', this-object:Buffer:name), 0).        
        
        assign currentField = this-object:Buffer:buffer-field(pName).
        if not valid-handle(currentField) then
            return error new AppError(substitute('Field &1 does not exist in buffer &2', pName, this-object:Buffer:name), 0).
        
        if not currentField:data-type eq 'character' then
            return error new AppError(substitute('Field &1 is not a CHARACTER', pName), 0). 
        
        assign currentField:buffer-value = pVal.
    end method.
    
    method protected void GetVal(input pName as character, output pVal as character):
        define variable currentField as handle no-undo.
        
        if not this-object:Available then
            return error new AppError(substitute('Record not available for buffer &1', this-object:Buffer:name), 0).        
        
        assign currentField = this-object:Buffer:buffer-field(pName).
        if not valid-handle(currentField) then
            return error new AppError(substitute('Field &1 does not exist in buffer &2', pName, this-object:Buffer:name), 0).
        
        if not currentField:data-type eq 'character' then
            return error new AppError(substitute('Field &1 is not a CHARACTER', pName), 0). 
        
        assign pVal = currentField:buffer-value. 
    end method.

    method protected void GetVal(input pName as character, output pVal as integer):
        define variable currentField as handle no-undo.
        
        if not this-object:Available then
            return error new AppError(substitute('Record not available for buffer &1', this-object:Buffer:name), 0).        
        
        assign currentField = this-object:Buffer:buffer-field(pName).
        if not valid-handle(currentField) then
            return error new AppError(substitute('Field &1 does not exist in buffer &2', pName, this-object:Buffer:name), 0).
        
        if not currentField:data-type eq 'character' then
            return error new AppError(substitute('Field &1 is not a CHARACTER', pName), 0). 
        
        assign pVal = currentField:buffer-value. 
    end method.
    
    method protected void SetVal(input pName as character, input pVal as integer):
        define variable currentField as handle no-undo.
        
        if not this-object:Available then
            return error new AppError(substitute('Record not available for buffer &1', this-object:Buffer:name), 0).        
        
        assign currentField = this-object:Buffer:buffer-field(pName).
        if not valid-handle(currentField) then
            return error new AppError(substitute('Field &1 does not exist in buffer &2', pName, this-object:Buffer:name), 0).
        
        if not currentField:data-type eq 'character' then
            return error new AppError(substitute('Field &1 is not a CHARACTER', pName), 0). 
        
        assign currentField:buffer-value = pVal.
    end method.
    
end class.
/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : BufferMapper
    Description : 
    Author(s)   : pjudge
    Created     : 2017-11-02
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using OpenEdge.Core.Collections.ICollection.
using Progress.Reflect.AccessMode.
using Progress.Reflect.Flags.
using Progress.Reflect.Property.
using data.shared.IMapper.
using data.shared.IRecord.
using data.shared.RecordCollection.
using OpenEdge.Core.Collections.IIterator.
using Progress.Lang.AppError.

class data.shared.BufferMapper implements IMapper:
    // what type of IRecord should we create
    define public property RecordType as class Progress.Lang.Class no-undo
        get.
        protected set(input pType as class Progress.Lang.Class):
            if pType:IsA(get-class(IRecord)) then
                assign this-object:RecordType = pType.
        end method.
    
    // the underlying buffer
    define protected property DataBuffer as handle no-undo get. private set.
    
    //Read from the persistent store/database
    method public class ICollection GetAll(input pWhere as character):
        define variable data as ICollection no-undo.
        define variable record as IRecord no-undo.
        define variable dataQuery as handle no-undo.
        define variable props as Property extent no-undo.
        define variable cnt as integer no-undo.
        define variable loop as integer no-undo.
        define variable fld as handle no-undo.
        
        assign pWhere = trim(pWhere, 'where ').
        
        create query dataQuery.
        dataQuery:set-buffers(this-object:DataBuffer).
        dataQuery:query-prepare(substitute('for each &1 where &2 no-lock',
                                    this-object:DataBuffer:name,
                                    pWhere)).
        dataQuery:query-open().
        
        data = new RecordCollection().
        
        dataQuery:get-first().
        do:
            record = cast(this-object:RecordType:New(), IRecord).   
            props = this-object:RecordType:GetProperties((Flags:Public or Flags:Instance)).
            cnt = extent(props).
            do loop = 1 to cnt:
                if not props[loop]:SetterAccessMode eq AccessMode:Public then
                    next.
                // assumes no arrays, names are identical
                assign fld = this-object:DataBuffer:buffer-field(props[loop]:Name) no-error.
                if valid-handle(fld) then
                    dynamic-property(record, props[loop]:Name) = this-object:DataBuffer:buffer-field(props[loop]:Name):buffer-value.
            end.
            //
            data:Add(record). 
            dataQuery:get-first().
        end. 
        
        return data.
        finally:
            fld = ?.
            dataQuery:query-close().
            delete object dataQuery. 
        end finally.
    end method.
    
    //Read from the persistent store/database
    method public class IRecord Get(input pWhere as character):
        define variable data as IRecord no-undo.
        define variable props as Property extent no-undo.
        define variable cnt as integer no-undo.
        define variable loop as integer no-undo.
        define variable fld as handle no-undo.
        
        this-object:DataBuffer:find-first(pWhere, no-lock).
        
        data = cast(this-object:RecordType:New(), IRecord).
        props = this-object:RecordType:GetProperties((Flags:Public or Flags:Instance)).
        cnt = extent(props).
        do loop = 1 to cnt:
            if not props[loop]:SetterAccessMode eq AccessMode:Public then
                next.
            // assumes no arrays, names are identical
            assign fld = this-object:DataBuffer:buffer-field(props[loop]:Name) no-error.
            if valid-handle(fld) then
                dynamic-property(data, props[loop]:Name) = this-object:DataBuffer:buffer-field(props[loop]:Name):buffer-value.
        end.
        
        return data.
        finally:
            fld = ?.
        end finally.
    end method.
    
    //Create example
    method public void Create(input pData as class ICollection):
        define variable iterator as IIterator no-undo.
        
        iterator = pData:Iterator().
        do while iterator:HasNext():
            this-object:Create(cast(iterator:Next(), IRecord)).
        end.
    end method.
    
    method public void Create(input pData as class IRecord):
        define variable props as Property extent no-undo.
        define variable cnt as integer no-undo.
        define variable loop as integer no-undo.
        define variable fld as handle no-undo.
        
        do transaction:
            this-object:DataBuffer:buffer-create().
            
            props = this-object:RecordType:GetProperties((Flags:Public or Flags:Instance)).
            cnt = extent(props).
            do loop = 1 to cnt:
                if not props[loop]:GetterAccessMode eq AccessMode:Public then
                    next.
                // assumes no arrays, names are identical
                assign fld = this-object:DataBuffer:buffer-field(props[loop]:Name) no-error.
                if valid-handle(fld) then
                    assign fld:buffer-value = dynamic-property(pData, props[loop]:Name). 
            end.
            finally:
                this-object:DataBuffer:buffer-release().
                fld = ?.
            end finally.
        end.    // trans
    end method.
    
    //Other CRUD methods
    method public void Delete(input pData as class ICollection):
        define variable iterator as IIterator no-undo.
        
        iterator = pData:Iterator().
        do while iterator:HasNext():
            this-object:Delete(cast(iterator:Next(), IRecord)).
        end.
    end method.
    
    method public void Delete(input pData as class IRecord):
        do transaction:
            // simplified FIND. Doesn't deal with multiple keys and non-char values
            this-object:DataBuffer:find-first(substitute('where &1.&2 = "&3"',
                                             this-object:DataBuffer:name,
                                             this-object:DataBuffer:keys), 
                               exclusive-lock).
            
            this-object:DataBuffer:buffer-delete().
            finally:
                this-object:DataBuffer:buffer-release().
            end finally.
        end.    // trans
    end method.

    method public void Update(input pData as class ICollection):
        define variable iterator as IIterator no-undo.
        
        iterator = pData:Iterator().
        do while iterator:HasNext():
            this-object:Update(cast(iterator:Next(), IRecord)).
        end.
    end method.
    
    method public void Update(input pData as class IRecord):
        define variable props as Property extent no-undo.
        define variable cnt as integer no-undo.
        define variable loop as integer no-undo.
        define variable fld as handle no-undo.
        
        if num-entries(this-object:DataBuffer:keys) ne 1 then
            undo, throw new AppError(substitute('BufferMapper currently only supported single-field keys. &1 has &2',
                                        this-object:DataBuffer:name,
                                        this-object:DataBuffer:keys)
                                     , 0).
        
        do transaction:
            fld = this-object:DataBuffer:buffer-field(this-object:DataBuffer:keys).
            // simplified FIND. Doesn't deal with multiple keys and non-char values
            this-object:DataBuffer:find-first(substitute('where &1.&2 = "&3"',
                                             this-object:DataBuffer:name,
                                             fld:name,
                                             dynamic-property(pData, fld:Name)  ), 
                                   exclusive-lock).
            
            props = this-object:RecordType:GetProperties((Flags:Public or Flags:Instance)).
            cnt = extent(props).
            do loop = 1 to cnt:
                if not props[loop]:GetterAccessMode eq AccessMode:Public then
                    next.
                // assumes no arrays, names are identical
                assign fld = this-object:DataBuffer:buffer-field(props[loop]:Name) no-error.
                if valid-handle(fld) then
                    assign fld:buffer-value = dynamic-property(pData, props[loop]:Name). 
            end.
            finally:
                this-object:DataBuffer:buffer-release().
                fld = ?.
            end finally.
        end.    // trans
    end method.
    
    /* Constructor
       
       @param handle The table buffer 
       @param Progress.Lang.Class The type of the record should create */
    constructor public BufferMapper(input pBuffer as handle,
                                    input pRecordType as class Progress.Lang.Class):
        assign this-object:DataBuffer = pBuffer
               this-object:RecordType = pRecordType
               .
    end constructor.
    
end class.


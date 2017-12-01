/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
 /*------------------------------------------------------------------------
    File        : MapperDecorator
    Description : 
    Author(s)   : pjudge
    Created     : 2017-11-07
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using OpenEdge.Core.Assert.
using OpenEdge.Core.Collections.ICollection.
using OpenEdge.Core.IAdaptable.
using data.shared.IMapper.
using data.shared.IRecord.

class data.shared.MapperDecorator abstract implements IMapper, IAdaptable: 
    // the IMapper being decorated
    define protected property DecoratedMapper as IMapper no-undo get. private set.
    
    define public property RecordType as class Progress.Lang.Class no-undo 
        get():
            return DecoratedMapper:RecordType.
        end get.
    
    constructor public MapperDecorator(input pMapper as IMapper):
        Assert:NotNull(pMapper, 'Mapper').
        assign DecoratedMapper = pMapper.
    end constructor.
    
    method public void Create(input pData as IRecord):
        DecoratedMapper:Create(pData).
    end method.
    
    method public void Create(input pData as ICollection):
        DecoratedMapper:Create(pData).
    end method.
    
    method public void Delete(input pData as IRecord):
        DecoratedMapper:Delete(pData).
    end method.
    
    method public void Delete(input pData as ICollection):
        DecoratedMapper:Delete(pData).
    end method.
    
    method public IRecord Get(input pWhere as character):
        return DecoratedMapper:Get(pWhere).
    end method.
    
    method public ICollection GetAll(input pWhere as character):
        return DecoratedMapper:GetAll(pWhere).
    end method.
    
    method public void Update(input pData as IRecord):
        DecoratedMapper:Update(pData).
    end method.
    
    method public void Update(input pData as ICollection):
        DecoratedMapper:Update(pData).
    end method.
    
    /* Returns an adapter for this message 
       
       @param P.L.Class The type we want to adapt this message to
       @return P.L.Object The adapter. Will typically be of the type specified by the input argument */
    method public Progress.Lang.Object GetAdapter(input poAdaptTo as class Progress.Lang.Class):
        Assert:NotNull(poAdaptTo, 'Adapter').
        
        if this-object:GetClass():IsA(poAdaptTo) then
            return this-object.
        
        if valid-object(DecoratedMapper) and
           type-of(DecoratedMapper, IAdaptable) then
            return cast(DecoratedMapper, IAdaptable):GetAdapter(poAdaptTo).
        
        return ?.            
    end method.
    
end class.
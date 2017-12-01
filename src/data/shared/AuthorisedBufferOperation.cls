 /** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
 /*------------------------------------------------------------------------
    File        : AuthorisedBufferOperation
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : pjudge
    Created     : Mon Nov 06 22:22:34 EST 2017
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using common.shared.IAuthorizationManager.
using common.shared.ISupportAuthorization.
using data.shared.IRecord.
using data.shared.MapperDecorator.
using data.shared.IMapper.

class data.shared.AuthorisedBufferOperation 
               inherits   MapperDecorator               // behaviour from Mapper
               implements ISupportAuthorization:        // Adds an Authorization Manager
    
    define public property AuthManager as IAuthorizationManager no-undo get. set. 
    
    constructor public AuthorisedBufferOperation (input pMapper as IMapper):
        super (input pMapper).
    end constructor.
    
    method override public void Delete( input pData as IRecord ):
        if AuthManager:AuthorizeOperation('delete+' + pData:GetClass():TypeName) then
            super:Delete(input pData).
    end method.
    
end class.

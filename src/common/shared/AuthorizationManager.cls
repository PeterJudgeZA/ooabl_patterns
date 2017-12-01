/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : AuthorizationManager
    Purpose     : Dummy auth manager implementation
    Author(s)   : pjudge
    Created     : 2017-11-07
    Notes       : 
  ----------------------------------------------------------------------*/
class common.shared.AuthorizationManager:  

    method public logical AuthorizeOperation(input pOperation as character):
        message 'pOperation=' pOperation.
        
        if pOperation begins 'delete' then
            return false.
            
        return false.
    end method.
    
end class.
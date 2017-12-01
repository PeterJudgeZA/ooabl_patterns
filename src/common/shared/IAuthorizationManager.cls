/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : IAuthorizationManager
    Purpose     : Empty interface for illustrator purposes 
    Syntax      : 
    Description : 
    Author(s)   : pjudge
    Created     : Mon Nov 06 22:23:06 EST 2017
    Notes       : 
  ----------------------------------------------------------------------*/
interface common.shared.IAuthorizationManager:  

    method public logical AuthorizeOperation(input pOperation as character).
    
end interface.
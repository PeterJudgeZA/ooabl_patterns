/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : ISupportAuthorization
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : pjudge
    Created     : Mon Nov 06 22:22:51 EST 2017
    Notes       : 
  ----------------------------------------------------------------------*/
using common.shared.IAuthorizationManager.

interface common.shared.ISupportAuthorization:  
    define public property AuthManager as IAuthorizationManager no-undo get. set.
end interface.
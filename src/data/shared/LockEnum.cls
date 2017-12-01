/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : LockEnum
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : pjudge
    Created     : Mon Oct 23 09:59:58 EDT 2017
    Notes       : 
  ----------------------------------------------------------------------*/
enum data.shared.LockEnum :  
    define enum None    = 6209
                no-lock = None
                
                Share      = 6208
                share-lock = Share
                
                Exclusive      = 6207
                exclusive-lock = Exclusive
                
                Default = None
                .
end enum.
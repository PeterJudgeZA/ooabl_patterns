/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : LoggingMapper
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : pjudge
    Created     : 2017-11-07
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using OpenEdge.Core.Collections.ICollection.
using OpenEdge.Logging.ILogWriter.
using OpenEdge.Logging.ISupportLogging.
using data.shared.IMapper.
using data.shared.IRecord.
using data.shared.MapperDecorator.

class data.shared.LoggingMapper inherits MapperDecorator
                implements ISupportLogging:
    // we need to set this value
    define public property Logger as ILogWriter no-undo get. set. 

    constructor public LoggingMapper(input pMapper as IMapper):
        super(pMapper).
    end constructor.

    method override public void Create( input pData as ICollection ):
        Logger:Info(substitute('Creating &1 new records', pData:Size)).
            
        super:Create(input pData).
    end method.
    
    method override public void Create( input pData as IRecord ):
        Logger:Info('Creating new ' + pData:GetClass():TypeName).
        
        super:Create(input pData).
    end method.
    
end class.
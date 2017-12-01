 /** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
 /*------------------------------------------------------------------------
    File        : CollectionTransactionScope
    Description : 
    Author(s)   : pjudge
    Created     : 2017-11-06
    Notes       : 
  ----------------------------------------------------------------------*/
block-level on error undo, throw.

using data.shared.IMapper.
using data.shared.MapperDecorator.
using OpenEdge.Core.Collections.ICollection.

class data.shared.CollectionTransactionScope inherits MapperDecorator: 

    constructor public CollectionTransactionScope (input pMapper as IMapper):
        super(pMapper).
    end constructor.
    
    method override public void Create(input pData as ICollection):
        // Make all of the creates a single transaction 
        DO TRANSACTION:           
            super:Create(pData).
        END.
    end method.

    method override public void Delete(input pData as ICollection):
        // Make all of the deletes a single transaction 
        DO TRANSACTION:
            super:Delete(pData).
        END.
    end method.

    method override public void Update(input pData as ICollection):
        // Make all of the updates a single transaction 
        DO TRANSACTION:           
            super:Update(pData).
        END.
    end method.

end class.
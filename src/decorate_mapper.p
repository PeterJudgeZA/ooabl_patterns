/*------------------------------------------------------------------------
    File        : decorate_mapper.p
    Description : 
    Author(s)   : pjudge
    Created     : 2017-11-07
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

block-level on error undo, throw.

using common.shared.IAuthorizationManager.
using common.shared.ISupportAuthorization.
using data.s2k.DepartmentRecord.
using data.shared.AuthorisedBufferOperation.
using data.shared.BufferMapper.
using data.shared.CollectionTransactionScope.
using data.shared.IMapper.
using data.shared.IRecord.
using data.shared.LoggingMapper.

/* ***************************  Main Block  *************************** */
define variable mapper as IMapper no-undo.
define variable deptRecord as IRecord no-undo.

// base IMapper
mapper = new BufferMapper(buffer Department:handle,
                          get-class(DepartmentRecord)).
// add auth on deletes
mapper = new AuthorisedBufferOperation(mapper).

// add logging
mapper = new LoggingMapper(mapper).
// make all updates in a collection a single trx
mapper = new CollectionTransactionScope(mapper).

/**
// Alternate representation
mapper = new CollectionTransactionScope(
                new LoggingMapper(
                    new AuthorisedBufferOperation(
                        new BufferMapper(buffer Department:handle,
                                         get-class(DepartmentRecord))
                    )
                )
            ).
**/

// Get me some data!
deptRecord  = mapper:Get('where DeptCode eq "100"').

mapper:Delete(deptRecord).

define variable authMgr as IAuthorizationManager no-undo.
 
function BuildMapper returns IMapper():
    // base IMapper
    mapper = new BufferMapper(buffer Department:handle, get-class(DepartmentRecord)).
    mapper = new AuthorisedBufferOperation(mapper).
    mapper = new LoggingMapper(mapper).
    mapper = new CollectionTransactionScope(mapper).
    return mapper.
end function.
// Set the AuthManager in the mapper
cast(mapper, ISupportAuthorization):AuthManager = authMgr.
 
// Delete this department 
deptRecord  = mapper:Get('DeptCode eq "100"').
mapper:Delete(deptRecord).

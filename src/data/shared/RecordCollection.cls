/** This is free and unencumbered software released into the public domain.
    Anyone is free to copy, modify, publish, use, compile, sell, or
    distribute this software, either in source code form or as a compiled
    binary, for any purpose, commercial or non-commercial, and by any
    means.  **/
/*------------------------------------------------------------------------
    File        : RecordCollection
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : pjudge
    Created     : Mon Nov 06 11:30:43 EST 2017
    Notes       : 
  ----------------------------------------------------------------------*/

block-level on error undo, throw.

using data.shared.IRecord.

{OpenEdge/Core/Collections/typedcollectionclass.i
    &CollectionType = RecordCollection
    &ValueType      = IRecord
    &Package        = data.shared
}


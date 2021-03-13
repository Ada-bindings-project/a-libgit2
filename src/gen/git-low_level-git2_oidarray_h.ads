pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
limited with Git.Low_Level.git2_oid_h;


package Git.Low_Level.git2_oidarray_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --* Array of object ids  
   type git_oidarray is record
      ids : access Git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/oidarray.h:17
      count : aliased unsigned_long;  -- /usr/include/git2/oidarray.h:18
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/oidarray.h:16

  --*
  -- * Free the OID array
  -- *
  -- * This method must (and must only) be called on `git_oidarray`
  -- * objects where the array is allocated by the library. Not doing so,
  -- * will result in a memory leak.
  -- *
  -- * This does not free the `git_oidarray` itself, since the library will
  -- * never allocate that object directly itself (it is more commonly embedded
  -- * inside another struct or created on the stack).
  -- *
  -- * @param array git_oidarray from which to free oid data
  --  

   procedure git_oidarray_free (c_array : access git_oidarray)  -- /usr/include/git2/oidarray.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "git_oidarray_free";

  --* @}  
end Git.Low_Level.git2_oidarray_h;

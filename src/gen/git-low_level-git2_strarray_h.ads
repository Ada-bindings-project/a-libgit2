pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;


package Git.Low_Level.git2_strarray_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/strarray.h
  -- * @brief Git string array routines
  -- * @defgroup git_strarray Git string array routines
  -- * @ingroup Git
  -- * @{
  --  

  --* Array of strings  
   type git_strarray is record
      strings : System.Address;  -- /usr/include/git2/strarray.h:23
      count : aliased unsigned_long;  -- /usr/include/git2/strarray.h:24
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/strarray.h:22

  --*
  -- * Close a string array object
  -- *
  -- * This method should be called on `git_strarray` objects where the strings
  -- * array is allocated and contains allocated strings, such as what you
  -- * would get from `git_strarray_copy()`.  Not doing so, will result in a
  -- * memory leak.
  -- *
  -- * This does not free the `git_strarray` itself, since the library will
  -- * never allocate that object directly itself (it is more commonly embedded
  -- * inside another struct or created on the stack).
  -- *
  -- * @param array git_strarray from which to free string data
  --  

   procedure git_strarray_free (c_array : access git_strarray)  -- /usr/include/git2/strarray.h:41
   with Import => True, 
        Convention => C, 
        External_Name => "git_strarray_free";

  --*
  -- * Copy a string array object from source to target.
  -- *
  -- * Note: target is overwritten and hence should be empty, otherwise its
  -- * contents are leaked.  Call git_strarray_free() if necessary.
  -- *
  -- * @param tgt target
  -- * @param src source
  -- * @return 0 on success, < 0 on allocation failure
  --  

   function git_strarray_copy (tgt : access git_strarray; src : access constant git_strarray) return int  -- /usr/include/git2/strarray.h:53
   with Import => True, 
        Convention => C, 
        External_Name => "git_strarray_copy";

  --* @}  
end Git.Low_Level.git2_strarray_h;

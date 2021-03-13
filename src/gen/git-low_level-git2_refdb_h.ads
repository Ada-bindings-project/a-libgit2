pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
limited with git.Low_Level.git2_types_h;

package git.Low_Level.git2_refdb_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/refdb.h
  --  * @brief Git custom refs backend functions
  --  * @defgroup git_refdb Git custom refs backend API
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Create a new reference database with no backends.
  --  *
  --  * Before the Ref DB can be used for read/writing, a custom database
  --  * backend must be manually set using `git_refdb_set_backend()`
  --  *
  --  * @param out location to store the database pointer, if opened.
  --  *                  Set to NULL if the open failed.
  --  * @param repo the repository
  --  * @return 0 or an error code
  --

   function git_refdb_new (c_out : System.Address; repo : access git.Low_Level.git2_types_h.git_repository) return int  -- /usr/include/git2/refdb.h:35
      with Import   => True,
      Convention    => C,
      External_Name => "git_refdb_new";

  --*
  --  * Create a new reference database and automatically add
  --  * the default backends:
  --  *
  --  *  - git_refdb_dir: read and write loose and packed refs
  --  *      from disk, assuming the repository dir as the folder
  --  *
  --  * @param out location to store the database pointer, if opened.
  --  *                  Set to NULL if the open failed.
  --  * @param repo the repository
  --  * @return 0 or an error code
  --

   function git_refdb_open (c_out : System.Address; repo : access git.Low_Level.git2_types_h.git_repository) return int  -- /usr/include/git2/refdb.h:49
      with Import   => True,
      Convention    => C,
      External_Name => "git_refdb_open";

  --*
  --  * Suggests that the given refdb compress or optimize its references.
  --  * This mechanism is implementation specific.  For on-disk reference
  --  * databases, for example, this may pack all loose references.
  --

   function git_refdb_compress (refdb : access git.Low_Level.git2_types_h.git_refdb) return int  -- /usr/include/git2/refdb.h:56
      with Import   => True,
      Convention    => C,
      External_Name => "git_refdb_compress";

  --*
  --  * Close an open reference database.
  --  *
  --  * @param refdb reference database pointer or NULL
  --

   procedure git_refdb_free (refdb : access git.Low_Level.git2_types_h.git_refdb)  -- /usr/include/git2/refdb.h:63
        with Import => True,
      Convention    => C,
      External_Name => "git_refdb_free";

  --* @}
end git.Low_Level.git2_refdb_h;

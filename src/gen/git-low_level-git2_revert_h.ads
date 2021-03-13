pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Git.Low_Level.git2_merge_h;
with Git.Low_Level.git2_checkout_h;
with System;
limited with Git.Low_Level.git2_types_h;

package Git.Low_Level.git2_revert_h is

   GIT_REVERT_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/revert.h:36
   --  unsupported macro: GIT_REVERT_OPTIONS_INIT {GIT_REVERT_OPTIONS_VERSION, 0, GIT_MERGE_OPTIONS_INIT, GIT_CHECKOUT_OPTIONS_INIT}

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/revert.h
  -- * @brief Git revert routines
  -- * @defgroup git_revert Git revert routines
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Options for revert
  --  

   --  skipped anonymous struct anon_anon_112

   type git_revert_options is record
      version : aliased unsigned;  -- /usr/include/git2/revert.h:27
      mainline : aliased unsigned;  -- /usr/include/git2/revert.h:30
      merge_opts : aliased Git.Low_Level.git2_merge_h.git_merge_options;  -- /usr/include/git2/revert.h:32
      checkout_opts : aliased Git.Low_Level.git2_checkout_h.git_checkout_options;  -- /usr/include/git2/revert.h:33
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/revert.h:34

  --* For merge commits, the "mainline" is treated as the parent.  
  --*< Options for the merging  
  --*< Options for the checkout  
  --*
  -- * Initialize git_revert_options structure
  -- *
  -- * Initializes a `git_revert_options` with default values. Equivalent to
  -- * creating an instance with `GIT_REVERT_OPTIONS_INIT`.
  -- *
  -- * @param opts The `git_revert_options` struct to initialize.
  -- * @param version The struct version; pass `GIT_REVERT_OPTIONS_VERSION`.
  -- * @return Zero on success; -1 on failure.
  --  

   function git_revert_options_init (opts : access git_revert_options; version : unsigned) return int  -- /usr/include/git2/revert.h:49
   with Import => True, 
        Convention => C, 
        External_Name => "git_revert_options_init";

  --*
  -- * Reverts the given commit against the given "our" commit, producing an
  -- * index that reflects the result of the revert.
  -- *
  -- * The returned index must be freed explicitly with `git_index_free`.
  -- *
  -- * @param out pointer to store the index result in
  -- * @param repo the repository that contains the given commits
  -- * @param revert_commit the commit to revert
  -- * @param our_commit the commit to revert against (eg, HEAD)
  -- * @param mainline the parent of the revert commit, if it is a merge
  -- * @param merge_options the merge options (or null for defaults)
  -- * @return zero on success, -1 on failure.
  --  

   function git_revert_commit
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      revert_commit : access Git.Low_Level.git2_types_h.git_commit;
      our_commit : access Git.Low_Level.git2_types_h.git_commit;
      mainline : unsigned;
      merge_options : access constant Git.Low_Level.git2_merge_h.git_merge_options) return int  -- /usr/include/git2/revert.h:67
   with Import => True, 
        Convention => C, 
        External_Name => "git_revert_commit";

  --*
  -- * Reverts the given commit, producing changes in the index and working directory.
  -- *
  -- * @param repo the repository to revert
  -- * @param commit the commit to revert
  -- * @param given_opts the revert options (or null for defaults)
  -- * @return zero on success, -1 on failure.
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   function git_revert
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      commit : access Git.Low_Level.git2_types_h.git_commit;
      given_opts : access constant git_revert_options) return int  -- /usr/include/git2/revert.h:83
   with Import => True, 
        Convention => C, 
        External_Name => "git_revert";

end Git.Low_Level.git2_revert_h;

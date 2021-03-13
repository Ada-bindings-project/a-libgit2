pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with git.Low_Level.git2_merge_h;
with git.Low_Level.git2_checkout_h;
with System;
limited with git.Low_Level.git2_types_h;

package git.Low_Level.git2_cherrypick_h is

   GIT_CHERRYPICK_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/cherrypick.h:36
   --  unsupported macro: GIT_CHERRYPICK_OPTIONS_INIT {GIT_CHERRYPICK_OPTIONS_VERSION, 0, GIT_MERGE_OPTIONS_INIT, GIT_CHECKOUT_OPTIONS_INIT}

   --  * Copyright (C) the libgit2 contributors. All rights reserved.
   --  *
   --  * This file is part of libgit2, distributed under the GNU GPL v2 with
   --  * a Linking Exception. For full terms see the included COPYING file.
  --

   --*
  -- * @file git2/cherrypick.h
  --  * @brief Git cherry-pick routines
  --  * @defgroup git_cherrypick Git cherry-pick routines
  --  * @ingroup Git
  --  * @{
  --

   --*
  -- * Cherry-pick options
  --

   --  skipped anonymous struct anon_anon_87

   type git_cherrypick_options is record
      version       : aliased unsigned;  -- /usr/include/git2/cherrypick.h:27
      mainline      : aliased unsigned;  -- /usr/include/git2/cherrypick.h:30
      merge_opts    : aliased git.Low_Level.git2_merge_h.git_merge_options;  -- /usr/include/git2/cherrypick.h:32
      checkout_opts : aliased git.Low_Level.git2_checkout_h.git_checkout_options;  -- /usr/include/git2/cherrypick.h:33
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/cherrypick.h:34

  --* For merge commits, the "mainline" is treated as the parent.
  --*< Options for the merging
  --*< Options for the checkout
  --*
  --  * Initialize git_cherrypick_options structure
  --  *
  --  * Initializes a `git_cherrypick_options` with default values. Equivalent to creating
  --  * an instance with GIT_CHERRYPICK_OPTIONS_INIT.
  --  *
  --  * @param opts The `git_cherrypick_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_CHERRYPICK_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_cherrypick_options_init (opts : access git_cherrypick_options; version : unsigned) return int  -- /usr/include/git2/cherrypick.h:49
      with Import   => True,
      Convention    => C,
      External_Name => "git_cherrypick_options_init";

  --*
  --  * Cherry-picks the given commit against the given "our" commit, producing an
  --  * index that reflects the result of the cherry-pick.
  --  *
  --  * The returned index must be freed explicitly with `git_index_free`.
  --  *
  --  * @param out pointer to store the index result in
  --  * @param repo the repository that contains the given commits
  --  * @param cherrypick_commit the commit to cherry-pick
  --  * @param our_commit the commit to cherry-pick against (eg, HEAD)
  --  * @param mainline the parent of the `cherrypick_commit`, if it is a merge
  --  * @param merge_options the merge options (or null for defaults)
  --  * @return zero on success, -1 on failure.
  --

   function git_cherrypick_commit
     (c_out             : System.Address;
      repo              : access git.Low_Level.git2_types_h.git_repository;
      cherrypick_commit : access git.Low_Level.git2_types_h.git_commit;
      our_commit        : access git.Low_Level.git2_types_h.git_commit;
      mainline          : unsigned;
      merge_options : access constant git.Low_Level.git2_merge_h.git_merge_options) return int  -- /usr/include/git2/cherrypick.h:67
      with Import   => True,
      Convention    => C,
      External_Name => "git_cherrypick_commit";

  --*
  --  * Cherry-pick the given commit, producing changes in the index and working directory.
  --  *
  --  * @param repo the repository to cherry-pick
  --  * @param commit the commit to cherry-pick
  --  * @param cherrypick_options the cherry-pick options (or null for defaults)
  --  * @return zero on success, -1 on failure.
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

   function git_cherrypick
     (repo               : access git.Low_Level.git2_types_h.git_repository;
      commit             : access git.Low_Level.git2_types_h.git_commit;
      cherrypick_options : access constant git_cherrypick_options) return int  -- /usr/include/git2/cherrypick.h:83
      with Import   => True,
      Convention    => C,
      External_Name => "git_cherrypick";

end git.Low_Level.git2_cherrypick_h;

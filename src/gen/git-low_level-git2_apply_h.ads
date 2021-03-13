pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
limited with git.Low_Level.git2_diff_h;
with System;
limited with git.Low_Level.git2_types_h;

package git.Low_Level.git2_apply_h is

   GIT_APPLY_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/apply.h:89
   --  unsupported macro: GIT_APPLY_OPTIONS_INIT {GIT_APPLY_OPTIONS_VERSION}

   --  * Copyright (C) the libgit2 contributors. All rights reserved.
   --  *
   --  * This file is part of libgit2, distributed under the GNU GPL v2 with
   --  * a Linking Exception. For full terms see the included COPYING file.
  --

   --*
  -- * @file git2/apply.h
  --  * @brief Git patch application routines
  --  * @defgroup git_apply Git patch application routines
  --  * @ingroup Git
  --  * @{
  --

   --*
  --  * When applying a patch, callback that will be made per delta (file).
  --  *
  --  * When the callback:
  --  * - returns < 0, the apply process will be aborted.
  --  * - returns > 0, the delta will not be applied, but the apply process
  --  *      continues
  --  * - returns 0, the delta is applied, and the apply process continues.
  --  *
  --  * @param delta The delta to be applied
  --  * @param payload User-specified payload
  --

   type git_apply_delta_cb is access function (arg1 : access constant git.Low_Level.git2_diff_h.git_diff_delta; arg2 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/apply.h:36

  --*
  --  * When applying a patch, callback that will be made per hunk.
  --  *
  --  * When the callback:
  --  * - returns < 0, the apply process will be aborted.
  --  * - returns > 0, the hunk will not be applied, but the apply process
  --  *      continues
  --  * - returns 0, the hunk is applied, and the apply process continues.
  --  *
  --  * @param hunk The hunk to be applied
  --  * @param payload User-specified payload
  --

   type git_apply_hunk_cb is access function (arg1 : access constant git.Low_Level.git2_diff_h.git_diff_hunk; arg2 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/apply.h:52

  --* Flags controlling the behavior of git_apply
  --*
  --     * Don't actually make changes, just test that the patch applies.
  --     * This is the equivalent of `git apply --check`.
  --

   subtype git_apply_flags_t is unsigned;
   GIT_APPLY_CHECK : constant unsigned := 1;  -- /usr/include/git2/apply.h:63

  --*
  -- * Apply options structure
  -- *
  --  * Initialize with `GIT_APPLY_OPTIONS_INIT`. Alternatively, you can
  --  * use `git_apply_options_init`.
  --  *
  --  * @see git_apply_to_tree, git_apply
  --

  --*< The version
   --  skipped anonymous struct anon_anon_60

   type git_apply_options is record
      version  : aliased unsigned;  -- /usr/include/git2/apply.h:74
      delta_cb : git_apply_delta_cb;  -- /usr/include/git2/apply.h:77
      hunk_cb  : git_apply_hunk_cb;  -- /usr/include/git2/apply.h:80
      payload  : System.Address;  -- /usr/include/git2/apply.h:83
      flags    : aliased unsigned;  -- /usr/include/git2/apply.h:86
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/apply.h:87

  --* When applying a patch, callback that will be made per delta (file).
  --* When applying a patch, callback that will be made per hunk.
  --* Payload passed to both delta_cb & hunk_cb.
  --* Bitmask of git_apply_flags_t
   function git_apply_options_init (opts : access git_apply_options; version : unsigned) return int  -- /usr/include/git2/apply.h:92
      with Import   => True,
      Convention    => C,
      External_Name => "git_apply_options_init";

  --*
  --  * Apply a `git_diff` to a `git_tree`, and return the resulting image
  --  * as an index.
  --  *
  --  * @param out the postimage of the application
  --  * @param repo the repository to apply
  --  * @param preimage the tree to apply the diff to
  --  * @param diff the diff to apply
  --  * @param options the options for the apply (or null for defaults)
  --

   function git_apply_to_tree
     (c_out    : System.Address;
      repo     : access git.Low_Level.git2_types_h.git_repository;
      preimage : access git.Low_Level.git2_types_h.git_tree;
      diff     : access git.Low_Level.git2_diff_h.git_diff;
      options  : access constant git_apply_options) return int  -- /usr/include/git2/apply.h:104
      with Import   => True,
      Convention    => C,
      External_Name => "git_apply_to_tree";

  --* Possible application locations for git_apply
  --*
  --     * Apply the patch to the workdir, leaving the index untouched.
  --     * This is the equivalent of `git apply` with no location argument.
  --

  --*
  --     * Apply the patch to the index, leaving the working directory
  --     * untouched.  This is the equivalent of `git apply --cached`.
  --

  --*
  --     * Apply the patch to both the working directory and the index.
  --     * This is the equivalent of `git apply --index`.
  --

   type git_apply_location_t is
     (GIT_APPLY_LOCATION_WORKDIR,
      GIT_APPLY_LOCATION_INDEX,
      GIT_APPLY_LOCATION_BOTH)
      with Convention => C;  -- /usr/include/git2/apply.h:130

  --*
  --  * Apply a `git_diff` to the given repository, making changes directly
  --  * in the working directory, the index, or both.
  --  *
  --  * @param repo the repository to apply to
  --  * @param diff the diff to apply
  --  * @param location the location to apply (workdir, index or both)
  --  * @param options the options for the apply (or null for defaults)
  --

   function git_apply
     (repo     : access git.Low_Level.git2_types_h.git_repository;
      diff     : access git.Low_Level.git2_diff_h.git_diff;
      location : git_apply_location_t;
      options  : access constant git_apply_options) return int  -- /usr/include/git2/apply.h:141
      with Import   => True,
      Convention    => C,
      External_Name => "git_apply";

  --* @}
end git.Low_Level.git2_apply_h;

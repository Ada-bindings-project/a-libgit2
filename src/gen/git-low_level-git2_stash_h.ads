pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
limited with git.Low_Level.git2_oid_h;
limited with git.Low_Level.git2_types_h;
with Interfaces.C.Strings;

with System;
with git.Low_Level.git2_checkout_h;


package git.Low_Level.git2_stash_h is

   GIT_STASH_APPLY_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/stash.h:140
   --  unsupported macro: GIT_STASH_APPLY_OPTIONS_INIT { GIT_STASH_APPLY_OPTIONS_VERSION, GIT_STASH_APPLY_DEFAULT, GIT_CHECKOUT_OPTIONS_INIT }

   --  * Copyright (C) the libgit2 contributors. All rights reserved.
   --  *
   --  * This file is part of libgit2, distributed under the GNU GPL v2 with
   --  * a Linking Exception. For full terms see the included COPYING file.
  --

   --*
  -- * @file git2/stash.h
  --  * @brief Git stash management routines
  --  * @ingroup Git
  --  * @{
  --

   --*
  -- * Stash flags
  --

   --*
  --     * No option, default
  --

   --*
  --     * All changes already added to the index are left intact in
  --     * the working directory
  --

   --*
  --     * All untracked files are also stashed and then cleaned up
  --     * from the working directory
  --

   --*
  --     * All ignored files are also stashed and then cleaned up from
  --     * the working directory
  --

   subtype git_stash_flags is unsigned;
   GIT_STASH_DEFAULT           : constant unsigned := 0;
   GIT_STASH_KEEP_INDEX        : constant unsigned := 1;
   GIT_STASH_INCLUDE_UNTRACKED : constant unsigned := 2;
   GIT_STASH_INCLUDE_IGNORED   : constant unsigned := 4;  -- /usr/include/git2/stash.h:48

  --*
  --  * Save the local modifications to a new stash.
  --  *
  --  * @param out Object id of the commit containing the stashed state.
  --  * This commit is also the target of the direct reference refs/stash.
  --  *
  --  * @param repo The owning repository.
  --  *
  --  * @param stasher The identity of the person performing the stashing.
  --  *
  --  * @param message Optional description along with the stashed state.
  --  *
  --  * @param flags Flags to control the stashing process. (see GIT_STASH_* above)
  --  *
  --  * @return 0 on success, GIT_ENOTFOUND where there's nothing to stash,
  --  * or error code.
  --

   function git_stash_save
     (c_out   : access git.Low_Level.git2_oid_h.git_oid;
      repo    : access git.Low_Level.git2_types_h.git_repository;
      stasher : access constant git.Low_Level.git2_types_h.git_signature;
      message : Interfaces.C.Strings.chars_ptr;
      flags   : unsigned) return int  -- /usr/include/git2/stash.h:67
      with Import   => True,
      Convention    => C,
      External_Name => "git_stash_save";

  --* Stash application flags.
  --  Try to reinstate not only the working tree's changes,
  --     * but also the index's changes.
  --

   type git_stash_apply_flags is
     (GIT_STASH_APPLY_DEFAULT,
      GIT_STASH_APPLY_REINSTATE_INDEX)
      with Convention => C;  -- /usr/include/git2/stash.h:82

  --* Stash apply progression states
  --* Loading the stashed data from the object database.
  --* The stored index is being analyzed.
  --* The modified files are being analyzed.
  --* The untracked and ignored files are being analyzed.
  --* The untracked files are being written to disk.
  --* The modified files are being written to disk.
  --* The stash was applied successfully.
   type git_stash_apply_progress_t is
     (GIT_STASH_APPLY_PROGRESS_NONE,
      GIT_STASH_APPLY_PROGRESS_LOADING_STASH,
      GIT_STASH_APPLY_PROGRESS_ANALYZE_INDEX,
      GIT_STASH_APPLY_PROGRESS_ANALYZE_MODIFIED,
      GIT_STASH_APPLY_PROGRESS_ANALYZE_UNTRACKED,
      GIT_STASH_APPLY_PROGRESS_CHECKOUT_UNTRACKED,
      GIT_STASH_APPLY_PROGRESS_CHECKOUT_MODIFIED,
      GIT_STASH_APPLY_PROGRESS_DONE)
      with Convention => C;  -- /usr/include/git2/stash.h:108

  --*
  --  * Stash application progress notification function.
  --  * Return 0 to continue processing, or a negative value to
  --  * abort the stash application.
  --

   type git_stash_apply_progress_cb is access function (arg1 : git_stash_apply_progress_t; arg2 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/stash.h:115

  --*
  --  * Stash application options structure
  --  *
  --  * Initialize with `GIT_STASH_APPLY_OPTIONS_INIT`. Alternatively, you can
  --  * use `git_stash_apply_options_init`.
  --  *
  --

   type git_stash_apply_options is record
      version          : aliased unsigned;  -- /usr/include/git2/stash.h:127
      flags            : aliased unsigned;  -- /usr/include/git2/stash.h:130
      checkout_options : aliased git.Low_Level.git2_checkout_h.git_checkout_options;  -- /usr/include/git2/stash.h:133
      progress_cb      : git_stash_apply_progress_cb;  -- /usr/include/git2/stash.h:136
      progress_payload : System.Address;  -- /usr/include/git2/stash.h:137
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/stash.h:126

  --* See `git_stash_apply_flags`, above.
  --* Options to use when writing files to the working directory.
  --* Optional callback to notify the consumer of application progress.
  --*
  --  * Initialize git_stash_apply_options structure
  --  *
  --  * Initializes a `git_stash_apply_options` with default values. Equivalent to
  --  * creating an instance with `GIT_STASH_APPLY_OPTIONS_INIT`.
  --  *
  --  * @param opts The `git_stash_apply_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_STASH_APPLY_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_stash_apply_options_init (opts : access git_stash_apply_options; version : unsigned) return int  -- /usr/include/git2/stash.h:156
      with Import   => True,
      Convention    => C,
      External_Name => "git_stash_apply_options_init";

  --*
  --  * Apply a single stashed state from the stash list.
  --  *
  --  * If local changes in the working directory conflict with changes in the
  --  * stash then GIT_EMERGECONFLICT will be returned.  In this case, the index
  --  * will always remain unmodified and all files in the working directory will
  --  * remain unmodified.  However, if you are restoring untracked files or
  --  * ignored files and there is a conflict when applying the modified files,
  --  * then those files will remain in the working directory.
  --  *
  --  * If passing the GIT_STASH_APPLY_REINSTATE_INDEX flag and there would be
  --  * conflicts when reinstating the index, the function will return
  --  * GIT_EMERGECONFLICT and both the working directory and index will be left
  --  * unmodified.
  --  *
  --  * Note that a minimum checkout strategy of `GIT_CHECKOUT_SAFE` is implied.
  --  *
  --  * @param repo The owning repository.
  --  * @param index The position within the stash list. 0 points to the
  --  *              most recent stashed state.
  --  * @param options Optional options to control how stashes are applied.
  --  *
  --  * @return 0 on success, GIT_ENOTFOUND if there's no stashed state for the
  --  *         given index, GIT_EMERGECONFLICT if changes exist in the working
  --  *         directory, or an error code
  --

   function git_stash_apply
     (repo    : access git.Low_Level.git2_types_h.git_repository;
      index   : unsigned_long;
      options : access constant git_stash_apply_options) return int  -- /usr/include/git2/stash.h:185
      with Import   => True,
      Convention    => C,
      External_Name => "git_stash_apply";

  --*
  --  * This is a callback function you can provide to iterate over all the
  --  * stashed states that will be invoked per entry.
  --  *
  --  * @param index The position within the stash list. 0 points to the
  --  *              most recent stashed state.
  --  * @param message The stash message.
  --  * @param stash_id The commit oid of the stashed state.
  --  * @param payload Extra parameter to callback function.
  --  * @return 0 to continue iterating or non-zero to stop.
  --

   type git_stash_cb is access function
     (arg1 : unsigned_long;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : access constant git.Low_Level.git2_oid_h.git_oid;
      arg4 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/stash.h:201

  --*
  --  * Loop over all the stashed states and issue a callback for each one.
  --  *
  --  * If the callback returns a non-zero value, this will stop looping.
  --  *
  --  * @param repo Repository where to find the stash.
  --  *
  --  * @param callback Callback to invoke per found stashed state. The most
  --  *                 recent stash state will be enumerated first.
  --  *
  --  * @param payload Extra parameter to callback function.
  --  *
  --  * @return 0 on success, non-zero callback return value, or error code.
  --

   function git_stash_foreach
     (repo     : access git.Low_Level.git2_types_h.git_repository;
      callback : git_stash_cb;
      payload  : System.Address) return int  -- /usr/include/git2/stash.h:221
      with Import   => True,
      Convention    => C,
      External_Name => "git_stash_foreach";

  --*
  --  * Remove a single stashed state from the stash list.
  --  *
  --  * @param repo The owning repository.
  --  *
  --  * @param index The position within the stash list. 0 points to the
  --  * most recent stashed state.
  --  *
  --  * @return 0 on success, GIT_ENOTFOUND if there's no stashed state for the given
  --  * index, or error code.
  --

   function git_stash_drop (repo : access git.Low_Level.git2_types_h.git_repository; index : unsigned_long) return int  -- /usr/include/git2/stash.h:237
      with Import   => True,
      Convention    => C,
      External_Name => "git_stash_drop";

  --*
  --  * Apply a single stashed state from the stash list and remove it from the list
  --  * if successful.
  --  *
  --  * @param repo The owning repository.
  --  * @param index The position within the stash list. 0 points to the
  --  *              most recent stashed state.
  --  * @param options Optional options to control how stashes are applied.
  --  *
  --  * @return 0 on success, GIT_ENOTFOUND if there's no stashed state for the given
  --  * index, or error code. (see git_stash_apply() above for details)
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

   function git_stash_pop
     (repo    : access git.Low_Level.git2_types_h.git_repository;
      index   : unsigned_long;
      options : access constant git_stash_apply_options) return int  -- /usr/include/git2/stash.h:253
      with Import   => True,
      Convention    => C,
      External_Name => "git_stash_pop";

end git.Low_Level.git2_stash_h;

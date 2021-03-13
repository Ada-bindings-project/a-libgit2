pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;

with Interfaces.C.Strings;
limited with Git.Low_Level.git2_diff_h;
with System;
with Git.Low_Level.git2_strarray_h;
limited with Git.Low_Level.git2_types_h;

package Git.Low_Level.git2_checkout_h is

   GIT_CHECKOUT_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/checkout.h:328
   --  unsupported macro: GIT_CHECKOUT_OPTIONS_INIT {GIT_CHECKOUT_OPTIONS_VERSION, GIT_CHECKOUT_SAFE}

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/checkout.h
  -- * @brief Git checkout routines
  -- * @defgroup git_checkout Git checkout routines
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Checkout behavior flags
  -- *
  -- * In libgit2, checkout is used to update the working directory and index
  -- * to match a target tree.  Unlike git checkout, it does not move the HEAD
  -- * commit for you - use `git_repository_set_head` or the like to do that.
  -- *
  -- * Checkout looks at (up to) four things: the "target" tree you want to
  -- * check out, the "baseline" tree of what was checked out previously, the
  -- * working directory for actual files, and the index for staged changes.
  -- *
  -- * You give checkout one of three strategies for update:
  -- *
  -- * - `GIT_CHECKOUT_NONE` is a dry-run strategy that checks for conflicts,
  -- *   etc., but doesn't make any actual changes.
  -- *
  -- * - `GIT_CHECKOUT_FORCE` is at the opposite extreme, taking any action to
  -- *   make the working directory match the target (including potentially
  -- *   discarding modified files).
  -- *
  -- * - `GIT_CHECKOUT_SAFE` is between these two options, it will only make
  -- *   modifications that will not lose changes.
  -- *
  -- *                         |  target == baseline   |  target != baseline  |
  -- *    ---------------------|-----------------------|----------------------|
  -- *     workdir == baseline |       no action       |  create, update, or  |
  -- *                         |                       |     delete file      |
  -- *    ---------------------|-----------------------|----------------------|
  -- *     workdir exists and  |       no action       |   conflict (notify   |
  -- *       is != baseline    | notify dirty MODIFIED | and cancel checkout) |
  -- *    ---------------------|-----------------------|----------------------|
  -- *      workdir missing,   | notify dirty DELETED  |     create file      |
  -- *      baseline present   |                       |                      |
  -- *    ---------------------|-----------------------|----------------------|
  -- *
  -- * To emulate `git checkout`, use `GIT_CHECKOUT_SAFE` with a checkout
  -- * notification callback (see below) that displays information about dirty
  -- * files.  The default behavior will cancel checkout on conflicts.
  -- *
  -- * To emulate `git checkout-index`, use `GIT_CHECKOUT_SAFE` with a
  -- * notification callback that cancels the operation if a dirty-but-existing
  -- * file is found in the working directory.  This core git command isn't
  -- * quite "force" but is sensitive about some types of changes.
  -- *
  -- * To emulate `git checkout -f`, use `GIT_CHECKOUT_FORCE`.
  -- *
  -- *
  -- * There are some additional flags to modify the behavior of checkout:
  -- *
  -- * - GIT_CHECKOUT_ALLOW_CONFLICTS makes SAFE mode apply safe file updates
  -- *   even if there are conflicts (instead of cancelling the checkout).
  -- *
  -- * - GIT_CHECKOUT_REMOVE_UNTRACKED means remove untracked files (i.e. not
  -- *   in target, baseline, or index, and not ignored) from the working dir.
  -- *
  -- * - GIT_CHECKOUT_REMOVE_IGNORED means remove ignored files (that are also
  -- *   untracked) from the working directory as well.
  -- *
  -- * - GIT_CHECKOUT_UPDATE_ONLY means to only update the content of files that
  -- *   already exist.  Files will not be created nor deleted.  This just skips
  -- *   applying adds, deletes, and typechanges.
  -- *
  -- * - GIT_CHECKOUT_DONT_UPDATE_INDEX prevents checkout from writing the
  -- *   updated files' information to the index.
  -- *
  -- * - Normally, checkout will reload the index and git attributes from disk
  -- *   before any operations.  GIT_CHECKOUT_NO_REFRESH prevents this reload.
  -- *
  -- * - Unmerged index entries are conflicts.  GIT_CHECKOUT_SKIP_UNMERGED skips
  -- *   files with unmerged index entries instead.  GIT_CHECKOUT_USE_OURS and
  -- *   GIT_CHECKOUT_USE_THEIRS to proceed with the checkout using either the
  -- *   stage 2 ("ours") or stage 3 ("theirs") version of files in the index.
  -- *
  -- * - GIT_CHECKOUT_DONT_OVERWRITE_IGNORED prevents ignored files from being
  -- *   overwritten.  Normally, files that are ignored in the working directory
  -- *   are not considered "precious" and may be overwritten if the checkout
  -- *   target contains that file.
  -- *
  -- * - GIT_CHECKOUT_DONT_REMOVE_EXISTING prevents checkout from removing
  -- *   files or folders that fold to the same name on case insensitive
  -- *   filesystems.  This can cause files to retain their existing names
  -- *   and write through existing symbolic links.
  --  

  --*< default is a dry run, no actual updates  
  --*
  --	 * Allow safe updates that cannot overwrite uncommitted data.
  --	 * If the uncommitted changes don't conflict with the checked out files,
  --	 * the checkout will still proceed, leaving the changes intact.
  --	 *
  --	 * Mutually exclusive with GIT_CHECKOUT_FORCE.
  --	 * GIT_CHECKOUT_FORCE takes precedence over GIT_CHECKOUT_SAFE.
  --	  

  --*
  --	 * Allow all updates to force working directory to look like index.
  --	 *
  --	 * Mutually exclusive with GIT_CHECKOUT_SAFE.
  --	 * GIT_CHECKOUT_FORCE takes precedence over GIT_CHECKOUT_SAFE.
  --	  

  --* Allow checkout to recreate missing files  
  --* Allow checkout to make safe updates even if conflicts are found  
  --* Remove untracked files not in index (that are not ignored)  
  --* Remove ignored files not in index  
  --* Only update existing files, don't create new ones  
  --*
  --	 * Normally checkout updates index entries as it goes; this stops that.
  --	 * Implies `GIT_CHECKOUT_DONT_WRITE_INDEX`.
  --	  

  --* Don't refresh index/config/etc before doing checkout  
  --* Allow checkout to skip unmerged files  
  --* For unmerged files, checkout stage 2 from index  
  --* For unmerged files, checkout stage 3 from index  
  --* Treat pathspec as simple list of exact match file paths  
  --* Ignore directories in use, they will be left empty  
  --* Don't overwrite ignored files that exist in the checkout target  
  --* Write normal merge files for conflicts  
  --* Include common ancestor data in diff3 format files for conflicts  
  --* Don't overwrite existing files or folders  
  --* Normally checkout writes the index upon completion; this prevents that.  
  --*
  --	 * THE FOLLOWING OPTIONS ARE NOT YET IMPLEMENTED
  --	  

  --* Recursively checkout submodules with same options (NOT IMPLEMENTED)  
  --* Recursively checkout submodules if HEAD moved in super repo (NOT IMPLEMENTED)  
   subtype git_checkout_strategy_t is unsigned;
   GIT_CHECKOUT_NONE : constant unsigned := 0;
   GIT_CHECKOUT_SAFE : constant unsigned := 1;
   GIT_CHECKOUT_FORCE : constant unsigned := 2;
   GIT_CHECKOUT_RECREATE_MISSING : constant unsigned := 4;
   GIT_CHECKOUT_ALLOW_CONFLICTS : constant unsigned := 16;
   GIT_CHECKOUT_REMOVE_UNTRACKED : constant unsigned := 32;
   GIT_CHECKOUT_REMOVE_IGNORED : constant unsigned := 64;
   GIT_CHECKOUT_UPDATE_ONLY : constant unsigned := 128;
   GIT_CHECKOUT_DONT_UPDATE_INDEX : constant unsigned := 256;
   GIT_CHECKOUT_NO_REFRESH : constant unsigned := 512;
   GIT_CHECKOUT_SKIP_UNMERGED : constant unsigned := 1024;
   GIT_CHECKOUT_USE_OURS : constant unsigned := 2048;
   GIT_CHECKOUT_USE_THEIRS : constant unsigned := 4096;
   GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH : constant unsigned := 8192;
   GIT_CHECKOUT_SKIP_LOCKED_DIRECTORIES : constant unsigned := 262144;
   GIT_CHECKOUT_DONT_OVERWRITE_IGNORED : constant unsigned := 524288;
   GIT_CHECKOUT_CONFLICT_STYLE_MERGE : constant unsigned := 1048576;
   GIT_CHECKOUT_CONFLICT_STYLE_DIFF3 : constant unsigned := 2097152;
   GIT_CHECKOUT_DONT_REMOVE_EXISTING : constant unsigned := 4194304;
   GIT_CHECKOUT_DONT_WRITE_INDEX : constant unsigned := 8388608;
   GIT_CHECKOUT_UPDATE_SUBMODULES : constant unsigned := 65536;
   GIT_CHECKOUT_UPDATE_SUBMODULES_IF_CHANGED : constant unsigned := 131072;  -- /usr/include/git2/checkout.h:189

  --*
  -- * Checkout notification flags
  -- *
  -- * Checkout will invoke an options notification callback (`notify_cb`) for
  -- * certain cases - you pick which ones via `notify_flags`:
  -- *
  -- * - GIT_CHECKOUT_NOTIFY_CONFLICT invokes checkout on conflicting paths.
  -- *
  -- * - GIT_CHECKOUT_NOTIFY_DIRTY notifies about "dirty" files, i.e. those that
  -- *   do not need an update but no longer match the baseline.  Core git
  -- *   displays these files when checkout runs, but won't stop the checkout.
  -- *
  -- * - GIT_CHECKOUT_NOTIFY_UPDATED sends notification for any file changed.
  -- *
  -- * - GIT_CHECKOUT_NOTIFY_UNTRACKED notifies about untracked files.
  -- *
  -- * - GIT_CHECKOUT_NOTIFY_IGNORED notifies about ignored files.
  -- *
  -- * Returning a non-zero value from this callback will cancel the checkout.
  -- * The non-zero return value will be propagated back and returned by the
  -- * git_checkout_... call.
  -- *
  -- * Notification callbacks are made prior to modifying any files on disk,
  -- * so canceling on any notification will still happen prior to any files
  -- * being modified.
  --  

   subtype git_checkout_notify_t is unsigned;
   GIT_CHECKOUT_NOTIFY_NONE : constant unsigned := 0;
   GIT_CHECKOUT_NOTIFY_CONFLICT : constant unsigned := 1;
   GIT_CHECKOUT_NOTIFY_DIRTY : constant unsigned := 2;
   GIT_CHECKOUT_NOTIFY_UPDATED : constant unsigned := 4;
   GIT_CHECKOUT_NOTIFY_UNTRACKED : constant unsigned := 8;
   GIT_CHECKOUT_NOTIFY_IGNORED : constant unsigned := 16;
   GIT_CHECKOUT_NOTIFY_ALL : constant unsigned := 65535;  -- /usr/include/git2/checkout.h:226

  --* Checkout performance-reporting structure  
   --  skipped anonymous struct anon_anon_71

   type git_checkout_perfdata is record
      mkdir_calls : aliased unsigned_long;  -- /usr/include/git2/checkout.h:230
      stat_calls : aliased unsigned_long;  -- /usr/include/git2/checkout.h:231
      chmod_calls : aliased unsigned_long;  -- /usr/include/git2/checkout.h:232
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/checkout.h:233

  --* Checkout notification callback function  
   type git_checkout_notify_cb is access function
        (arg1 : git_checkout_notify_t;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : access constant Git.Low_Level.git2_diff_h.git_diff_file;
         arg4 : access constant Git.Low_Level.git2_diff_h.git_diff_file;
         arg5 : access constant Git.Low_Level.git2_diff_h.git_diff_file;
         arg6 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/checkout.h:236

  --* Checkout progress notification function  
   type git_checkout_progress_cb is access procedure
        (arg1 : Interfaces.C.Strings.chars_ptr;
         arg2 : unsigned_long;
         arg3 : unsigned_long;
         arg4 : System.Address)
   with Convention => C;  -- /usr/include/git2/checkout.h:245

  --* Checkout perfdata notification function  
   type git_checkout_perfdata_cb is access procedure (arg1 : access constant git_checkout_perfdata; arg2 : System.Address)
   with Convention => C;  -- /usr/include/git2/checkout.h:252

  --*
  -- * Checkout options structure
  -- *
  -- * Initialize with `GIT_CHECKOUT_OPTIONS_INIT`. Alternatively, you can
  -- * use `git_checkout_options_init`.
  -- *
  --  

  --*< The version  
   type git_checkout_options is record
      version : aliased unsigned;  -- /usr/include/git2/checkout.h:264
      checkout_strategy : aliased unsigned;  -- /usr/include/git2/checkout.h:266
      disable_filters : aliased int;  -- /usr/include/git2/checkout.h:268
      dir_mode : aliased unsigned;  -- /usr/include/git2/checkout.h:269
      file_mode : aliased unsigned;  -- /usr/include/git2/checkout.h:270
      file_open_flags : aliased int;  -- /usr/include/git2/checkout.h:271
      notify_flags : aliased unsigned;  -- /usr/include/git2/checkout.h:273
      notify_cb : git_checkout_notify_cb;  -- /usr/include/git2/checkout.h:279
      notify_payload : System.Address;  -- /usr/include/git2/checkout.h:282
      progress_cb : git_checkout_progress_cb;  -- /usr/include/git2/checkout.h:285
      progress_payload : System.Address;  -- /usr/include/git2/checkout.h:288
      paths : aliased Git.Low_Level.git2_strarray_h.git_strarray;  -- /usr/include/git2/checkout.h:299
      baseline : access Git.Low_Level.git2_types_h.git_tree;  -- /usr/include/git2/checkout.h:307
      baseline_index : access Git.Low_Level.git2_types_h.git_index;  -- /usr/include/git2/checkout.h:313
      target_directory : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/checkout.h:315
      ancestor_label : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/checkout.h:317
      our_label : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/checkout.h:318
      their_label : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/checkout.h:319
      perfdata_cb : git_checkout_perfdata_cb;  -- /usr/include/git2/checkout.h:322
      perfdata_payload : System.Address;  -- /usr/include/git2/checkout.h:325
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/checkout.h:263

  --*< default will be a safe checkout  
  --*< don't apply filters like CRLF conversion  
  --*< default is 0755  
  --*< default is 0644 or 0755 as dictated by blob  
  --*< default is O_CREAT | O_TRUNC | O_WRONLY  
  --*< see `git_checkout_notify_t` above  
  --*
  --	 * Optional callback to get notifications on specific file states.
  --	 * @see git_checkout_notify_t
  --	  

  --* Payload passed to notify_cb  
  --* Optional callback to notify the consumer of checkout progress.  
  --* Payload passed to progress_cb  
  --*
  --	 * A list of wildmatch patterns or paths.
  --	 *
  --	 * By default, all paths are processed. If you pass an array of wildmatch
  --	 * patterns, those will be used to filter which paths should be taken into
  --	 * account.
  --	 *
  --	 * Use GIT_CHECKOUT_DISABLE_PATHSPEC_MATCH to treat as a simple list.
  --	  

  --*
  --	 * The expected content of the working directory; defaults to HEAD.
  --	 *
  --	 * If the working directory does not match this baseline information,
  --	 * that will produce a checkout conflict.
  --	  

  --*
  --	 * Like `baseline` above, though expressed as an index.  This
  --	 * option overrides `baseline`.
  --	  

  --*< alternative checkout path to workdir  
  --*< the name of the common ancestor side of conflicts  
  --*< the name of the "our" side of conflicts  
  --*< the name of the "their" side of conflicts  
  --* Optional callback to notify the consumer of performance data.  
  --* Payload passed to perfdata_cb  
  --*
  -- * Initialize git_checkout_options structure
  -- *
  -- * Initializes a `git_checkout_options` with default values. Equivalent to creating
  -- * an instance with GIT_CHECKOUT_OPTIONS_INIT.
  -- *
  -- * @param opts The `git_checkout_options` struct to initialize.
  -- * @param version The struct version; pass `GIT_CHECKOUT_OPTIONS_VERSION`.
  -- * @return Zero on success; -1 on failure.
  --  

   function git_checkout_options_init (opts : access git_checkout_options; version : unsigned) return int  -- /usr/include/git2/checkout.h:341
   with Import => True, 
        Convention => C, 
        External_Name => "git_checkout_options_init";

  --*
  -- * Updates files in the index and the working tree to match the content of
  -- * the commit pointed at by HEAD.
  -- *
  -- * Note that this is _not_ the correct mechanism used to switch branches;
  -- * do not change your `HEAD` and then call this method, that would leave
  -- * you with checkout conflicts since your working directory would then
  -- * appear to be dirty.  Instead, checkout the target of the branch and
  -- * then update `HEAD` using `git_repository_set_head` to point to the
  -- * branch you checked out.
  -- *
  -- * @param repo repository to check out (must be non-bare)
  -- * @param opts specifies checkout options (may be NULL)
  -- * @return 0 on success, GIT_EUNBORNBRANCH if HEAD points to a non
  -- *         existing branch, non-zero value returned by `notify_cb`, or
  -- *         other error code < 0 (use git_error_last for error details)
  --  

   function git_checkout_head (repo : access Git.Low_Level.git2_types_h.git_repository; opts : access constant git_checkout_options) return int  -- /usr/include/git2/checkout.h:362
   with Import => True, 
        Convention => C, 
        External_Name => "git_checkout_head";

  --*
  -- * Updates files in the working tree to match the content of the index.
  -- *
  -- * @param repo repository into which to check out (must be non-bare)
  -- * @param index index to be checked out (or NULL to use repository index)
  -- * @param opts specifies checkout options (may be NULL)
  -- * @return 0 on success, non-zero return value from `notify_cb`, or error
  -- *         code < 0 (use git_error_last for error details)
  --  

   function git_checkout_index
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      index : access Git.Low_Level.git2_types_h.git_index;
      opts : access constant git_checkout_options) return int  -- /usr/include/git2/checkout.h:375
   with Import => True, 
        Convention => C, 
        External_Name => "git_checkout_index";

  --*
  -- * Updates files in the index and working tree to match the content of the
  -- * tree pointed at by the treeish.
  -- *
  -- * @param repo repository to check out (must be non-bare)
  -- * @param treeish a commit, tag or tree which content will be used to update
  -- * the working directory (or NULL to use HEAD)
  -- * @param opts specifies checkout options (may be NULL)
  -- * @return 0 on success, non-zero return value from `notify_cb`, or error
  -- *         code < 0 (use git_error_last for error details)
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   function git_checkout_tree
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      treeish : access constant Git.Low_Level.git2_types_h.git_object;
      opts : access constant git_checkout_options) return int  -- /usr/include/git2/checkout.h:391
   with Import => True, 
        Convention => C, 
        External_Name => "git_checkout_tree";

end Git.Low_Level.git2_checkout_h;

pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Git.Low_Level.git2_types_h;
with Interfaces.C.Strings;
with System;
with Git.Low_Level.git2_checkout_h;
with Git.Low_Level.git2_remote_h;
limited with Git.Low_Level.git2_buffer_h;
limited with Git.Low_Level.git2_oid_h;

package Git.Low_Level.git2_submodule_h is

   GIT_SUBMODULE_STATUS_u_IN_FLAGS : constant := 16#000F#;  --  /usr/include/git2/submodule.h:91
   GIT_SUBMODULE_STATUS_u_INDEX_FLAGS : constant := 16#0070#;  --  /usr/include/git2/submodule.h:92
   GIT_SUBMODULE_STATUS_u_WD_FLAGS : constant := 16#3F80#;  --  /usr/include/git2/submodule.h:93
   --  arg-macro: function GIT_SUBMODULE_STATUS_IS_UNMODIFIED (S)
   --    return ((S) and ~GIT_SUBMODULE_STATUS__IN_FLAGS) = 0;
   --  arg-macro: function GIT_SUBMODULE_STATUS_IS_INDEX_UNMODIFIED (S)
   --    return ((S) and GIT_SUBMODULE_STATUS__INDEX_FLAGS) = 0;
   --  arg-macro: function GIT_SUBMODULE_STATUS_IS_WD_UNMODIFIED (S)
   --    return ((S) and (GIT_SUBMODULE_STATUS__WD_FLAGS and ~GIT_SUBMODULE_STATUS_WD_UNINITIALIZED)) = 0;
   --  arg-macro: function GIT_SUBMODULE_STATUS_IS_WD_DIRTY (S)
   --    return ((S) and (GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED or GIT_SUBMODULE_STATUS_WD_WD_MODIFIED or GIT_SUBMODULE_STATUS_WD_UNTRACKED)) /= 0;

   GIT_SUBMODULE_UPDATE_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/submodule.h:155
   --  unsupported macro: GIT_SUBMODULE_UPDATE_OPTIONS_INIT { GIT_SUBMODULE_UPDATE_OPTIONS_VERSION, { GIT_CHECKOUT_OPTIONS_VERSION, GIT_CHECKOUT_SAFE }, GIT_FETCH_OPTIONS_INIT, 1 }

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/submodule.h
  -- * @brief Git submodule management utilities
  -- *
  -- * Submodule support in libgit2 builds a list of known submodules and keeps
  -- * it in the repository.  The list is built from the .gitmodules file, the
  -- * .git/config file, the index, and the HEAD tree.  Items in the working
  -- * directory that look like submodules (i.e. a git repo) but are not
  -- * mentioned in those places won't be tracked.
  -- *
  -- * @defgroup git_submodule Git submodule management routines
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Return codes for submodule status.
  -- *
  -- * A combination of these flags will be returned to describe the status of a
  -- * submodule.  Depending on the "ignore" property of the submodule, some of
  -- * the flags may never be returned because they indicate changes that are
  -- * supposed to be ignored.
  -- *
  -- * Submodule info is contained in 4 places: the HEAD tree, the index, config
  -- * files (both .git/config and .gitmodules), and the working directory.  Any
  -- * or all of those places might be missing information about the submodule
  -- * depending on what state the repo is in.  We consider all four places to
  -- * build the combination of status flags.
  -- *
  -- * There are four values that are not really status, but give basic info
  -- * about what sources of submodule data are available.  These will be
  -- * returned even if ignore is set to "ALL".
  -- *
  -- * * IN_HEAD   - superproject head contains submodule
  -- * * IN_INDEX  - superproject index contains submodule
  -- * * IN_CONFIG - superproject gitmodules has submodule
  -- * * IN_WD     - superproject workdir has submodule
  -- *
  -- * The following values will be returned so long as ignore is not "ALL".
  -- *
  -- * * INDEX_ADDED       - in index, not in head
  -- * * INDEX_DELETED     - in head, not in index
  -- * * INDEX_MODIFIED    - index and head don't match
  -- * * WD_UNINITIALIZED  - workdir contains empty directory
  -- * * WD_ADDED          - in workdir, not index
  -- * * WD_DELETED        - in index, not workdir
  -- * * WD_MODIFIED       - index and workdir head don't match
  -- *
  -- * The following can only be returned if ignore is "NONE" or "UNTRACKED".
  -- *
  -- * * WD_INDEX_MODIFIED - submodule workdir index is dirty
  -- * * WD_WD_MODIFIED    - submodule workdir has modified files
  -- *
  -- * Lastly, the following will only be returned for ignore "NONE".
  -- *
  -- * * WD_UNTRACKED      - wd contains untracked files
  --  

   subtype git_submodule_status_t is unsigned;
   GIT_SUBMODULE_STATUS_IN_HEAD : constant unsigned := 1;
   GIT_SUBMODULE_STATUS_IN_INDEX : constant unsigned := 2;
   GIT_SUBMODULE_STATUS_IN_CONFIG : constant unsigned := 4;
   GIT_SUBMODULE_STATUS_IN_WD : constant unsigned := 8;
   GIT_SUBMODULE_STATUS_INDEX_ADDED : constant unsigned := 16;
   GIT_SUBMODULE_STATUS_INDEX_DELETED : constant unsigned := 32;
   GIT_SUBMODULE_STATUS_INDEX_MODIFIED : constant unsigned := 64;
   GIT_SUBMODULE_STATUS_WD_UNINITIALIZED : constant unsigned := 128;
   GIT_SUBMODULE_STATUS_WD_ADDED : constant unsigned := 256;
   GIT_SUBMODULE_STATUS_WD_DELETED : constant unsigned := 512;
   GIT_SUBMODULE_STATUS_WD_MODIFIED : constant unsigned := 1024;
   GIT_SUBMODULE_STATUS_WD_INDEX_MODIFIED : constant unsigned := 2048;
   GIT_SUBMODULE_STATUS_WD_WD_MODIFIED : constant unsigned := 4096;
   GIT_SUBMODULE_STATUS_WD_UNTRACKED : constant unsigned := 8192;  -- /usr/include/git2/submodule.h:89

  --*
  -- * Function pointer to receive each submodule
  -- *
  -- * @param sm git_submodule currently being visited
  -- * @param name name of the submodule
  -- * @param payload value you passed to the foreach function as payload
  -- * @return 0 on success or error code
  --  

   type git_submodule_cb is access function
        (arg1 : access Git.Low_Level.git2_types_h.git_submodule;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/submodule.h:118

  --*
  -- * Submodule update options structure
  -- *
  -- * Initialize with `GIT_SUBMODULE_UPDATE_OPTIONS_INIT`. Alternatively, you can
  -- * use `git_submodule_update_options_init`.
  -- *
  --  

   type git_submodule_update_options is record
      version : aliased unsigned;  -- /usr/include/git2/submodule.h:129
      checkout_opts : aliased Git.Low_Level.git2_checkout_h.git_checkout_options;  -- /usr/include/git2/submodule.h:138
      fetch_opts : aliased Git.Low_Level.git2_remote_h.git_fetch_options;  -- /usr/include/git2/submodule.h:146
      allow_fetch : aliased int;  -- /usr/include/git2/submodule.h:152
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/submodule.h:128

  --*
  --	 * These options are passed to the checkout step. To disable
  --	 * checkout, set the `checkout_strategy` to
  --	 * `GIT_CHECKOUT_NONE`. Generally you will want the use
  --	 * GIT_CHECKOUT_SAFE to update files in the working
  --	 * directory.
  --	  

  --*
  --	 * Options which control the fetch, including callbacks.
  --	 *
  --	 * The callbacks to use for reporting fetch progress, and for acquiring
  --	 * credentials in the event they are needed.
  --	  

  --*
  --	 * Allow fetching from the submodule's default remote if the target
  --	 * commit isn't found. Enabled by default.
  --	  

  --*
  -- * Initialize git_submodule_update_options structure
  -- *
  -- * Initializes a `git_submodule_update_options` with default values. Equivalent to
  -- * creating an instance with `GIT_SUBMODULE_UPDATE_OPTIONS_INIT`.
  -- *
  -- * @param opts The `git_submodule_update_options` struct to initialize.
  -- * @param version The struct version; pass `GIT_SUBMODULE_UPDATE_OPTIONS_VERSION`.
  -- * @return Zero on success; -1 on failure.
  --  

   function git_submodule_update_options_init (opts : access git_submodule_update_options; version : unsigned) return int  -- /usr/include/git2/submodule.h:171
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_update_options_init";

  --*
  -- * Update a submodule. This will clone a missing submodule and
  -- * checkout the subrepository to the commit specified in the index of
  -- * the containing repository. If the submodule repository doesn't contain
  -- * the target commit (e.g. because fetchRecurseSubmodules isn't set), then
  -- * the submodule is fetched using the fetch options supplied in options.
  -- *
  -- * @param submodule Submodule object
  -- * @param init If the submodule is not initialized, setting this flag to true
  -- *        will initialize the submodule before updating. Otherwise, this will
  -- *        return an error if attempting to update an uninitialzed repository.
  -- *        but setting this to true forces them to be updated.
  -- * @param options configuration options for the update.  If NULL, the
  -- *        function works as though GIT_SUBMODULE_UPDATE_OPTIONS_INIT was passed.
  -- * @return 0 on success, any non-zero return value from a callback
  -- *         function, or a negative value to indicate an error (use
  -- *         `git_error_last` for a detailed error message).
  --  

   function git_submodule_update
     (submodule : access Git.Low_Level.git2_types_h.git_submodule;
      init : int;
      options : access git_submodule_update_options) return int  -- /usr/include/git2/submodule.h:192
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_update";

  --*
  -- * Lookup submodule information by name or path.
  -- *
  -- * Given either the submodule name or path (they are usually the same), this
  -- * returns a structure describing the submodule.
  -- *
  -- * There are two expected error scenarios:
  -- *
  -- * - The submodule is not mentioned in the HEAD, the index, and the config,
  -- *   but does "exist" in the working directory (i.e. there is a subdirectory
  -- *   that appears to be a Git repository).  In this case, this function
  -- *   returns GIT_EEXISTS to indicate a sub-repository exists but not in a
  -- *   state where a git_submodule can be instantiated.
  -- * - The submodule is not mentioned in the HEAD, index, or config and the
  -- *   working directory doesn't contain a value git repo at that path.
  -- *   There may or may not be anything else at that path, but nothing that
  -- *   looks like a submodule.  In this case, this returns GIT_ENOTFOUND.
  -- *
  -- * You must call `git_submodule_free` when done with the submodule.
  -- *
  -- * @param out Output ptr to submodule; pass NULL to just get return code
  -- * @param repo The parent repository
  -- * @param name The name of or path to the submodule; trailing slashes okay
  -- * @return 0 on success, GIT_ENOTFOUND if submodule does not exist,
  -- *         GIT_EEXISTS if a repository is found in working directory only,
  -- *         -1 on other errors.
  --  

   function git_submodule_lookup
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/submodule.h:221
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_lookup";

  --*
  -- * Release a submodule
  -- *
  -- * @param submodule Submodule object
  --  

   procedure git_submodule_free (submodule : access Git.Low_Level.git2_types_h.git_submodule)  -- /usr/include/git2/submodule.h:231
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_free";

  --*
  -- * Iterate over all tracked submodules of a repository.
  -- *
  -- * See the note on `git_submodule` above.  This iterates over the tracked
  -- * submodules as described therein.
  -- *
  -- * If you are concerned about items in the working directory that look like
  -- * submodules but are not tracked, the diff API will generate a diff record
  -- * for workdir items that look like submodules but are not tracked, showing
  -- * them as added in the workdir.  Also, the status API will treat the entire
  -- * subdirectory of a contained git repo as a single GIT_STATUS_WT_NEW item.
  -- *
  -- * @param repo The repository
  -- * @param callback Function to be called with the name of each submodule.
  -- *        Return a non-zero value to terminate the iteration.
  -- * @param payload Extra data to pass to callback
  -- * @return 0 on success, -1 on error, or non-zero return value of callback
  --  

   function git_submodule_foreach
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      callback : git_submodule_cb;
      payload : System.Address) return int  -- /usr/include/git2/submodule.h:251
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_foreach";

  --*
  -- * Set up a new git submodule for checkout.
  -- *
  -- * This does "git submodule add" up to the fetch and checkout of the
  -- * submodule contents.  It preps a new submodule, creates an entry in
  -- * .gitmodules and creates an empty initialized repository either at the
  -- * given path in the working directory or in .git/modules with a gitlink
  -- * from the working directory to the new repo.
  -- *
  -- * To fully emulate "git submodule add" call this function, then open the
  -- * submodule repo and perform the clone step as needed (if you don't need
  -- * anything custom see `git_submodule_add_clone()`). Lastly, call
  -- * `git_submodule_add_finalize()` to wrap up adding the new submodule and
  -- * .gitmodules to the index to be ready to commit.
  -- *
  -- * You must call `git_submodule_free` on the submodule object when done.
  -- *
  -- * @param out The newly created submodule ready to open for clone
  -- * @param repo The repository in which you want to create the submodule
  -- * @param url URL for the submodule's remote
  -- * @param path Path at which the submodule should be created
  -- * @param use_gitlink Should workdir contain a gitlink to the repo in
  -- *        .git/modules vs. repo directly in workdir.
  -- * @return 0 on success, GIT_EEXISTS if submodule already exists,
  -- *         -1 on other errors.
  --  

   function git_submodule_add_setup
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      url : Interfaces.C.Strings.chars_ptr;
      path : Interfaces.C.Strings.chars_ptr;
      use_gitlink : int) return int  -- /usr/include/git2/submodule.h:282
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_add_setup";

  --*
  -- * Perform the clone step for a newly created submodule.
  -- *
  -- * This performs the necessary `git_clone` to setup a newly-created submodule.
  -- *
  -- * @param out The newly created repository object. Optional.
  -- * @param submodule The submodule currently waiting for its clone.
  -- * @param opts The options to use.
  -- *
  -- * @return 0 on success, -1 on other errors (see git_clone).
  --  

   function git_submodule_clone
     (c_out : System.Address;
      submodule : access Git.Low_Level.git2_types_h.git_submodule;
      opts : access constant git_submodule_update_options) return int  -- /usr/include/git2/submodule.h:300
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_clone";

  --*
  -- * Resolve the setup of a new git submodule.
  -- *
  -- * This should be called on a submodule once you have called add setup
  -- * and done the clone of the submodule.  This adds the .gitmodules file
  -- * and the newly cloned submodule to the index to be ready to be committed
  -- * (but doesn't actually do the commit).
  -- *
  -- * @param submodule The submodule to finish adding.
  --  

   function git_submodule_add_finalize (submodule : access Git.Low_Level.git2_types_h.git_submodule) return int  -- /usr/include/git2/submodule.h:315
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_add_finalize";

  --*
  -- * Add current submodule HEAD commit to index of superproject.
  -- *
  -- * @param submodule The submodule to add to the index
  -- * @param write_index Boolean if this should immediately write the index
  -- *            file.  If you pass this as false, you will have to get the
  -- *            git_index and explicitly call `git_index_write()` on it to
  -- *            save the change.
  -- * @return 0 on success, <0 on failure
  --  

   function git_submodule_add_to_index (submodule : access Git.Low_Level.git2_types_h.git_submodule; write_index : int) return int  -- /usr/include/git2/submodule.h:327
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_add_to_index";

  --*
  -- * Get the containing repository for a submodule.
  -- *
  -- * This returns a pointer to the repository that contains the submodule.
  -- * This is a just a reference to the repository that was passed to the
  -- * original `git_submodule_lookup()` call, so if that repository has been
  -- * freed, then this may be a dangling reference.
  -- *
  -- * @param submodule Pointer to submodule object
  -- * @return Pointer to `git_repository`
  --  

   function git_submodule_owner (submodule : access Git.Low_Level.git2_types_h.git_submodule) return access Git.Low_Level.git2_types_h.git_repository  -- /usr/include/git2/submodule.h:342
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_owner";

  --*
  -- * Get the name of submodule.
  -- *
  -- * @param submodule Pointer to submodule object
  -- * @return Pointer to the submodule name
  --  

   function git_submodule_name (submodule : access Git.Low_Level.git2_types_h.git_submodule) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/submodule.h:350
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_name";

  --*
  -- * Get the path to the submodule.
  -- *
  -- * The path is almost always the same as the submodule name, but the
  -- * two are actually not required to match.
  -- *
  -- * @param submodule Pointer to submodule object
  -- * @return Pointer to the submodule path
  --  

   function git_submodule_path (submodule : access Git.Low_Level.git2_types_h.git_submodule) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/submodule.h:361
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_path";

  --*
  -- * Get the URL for the submodule.
  -- *
  -- * @param submodule Pointer to submodule object
  -- * @return Pointer to the submodule url
  --  

   function git_submodule_url (submodule : access Git.Low_Level.git2_types_h.git_submodule) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/submodule.h:369
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_url";

  --*
  -- * Resolve a submodule url relative to the given repository.
  -- *
  -- * @param out buffer to store the absolute submodule url in
  -- * @param repo Pointer to repository object
  -- * @param url Relative url
  -- * @return 0 or an error code
  --  

   function git_submodule_resolve_url
     (c_out : access Git.Low_Level.git2_buffer_h.git_buf;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      url : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/submodule.h:379
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_resolve_url";

  --*
  --* Get the branch for the submodule.
  --*
  --* @param submodule Pointer to submodule object
  --* @return Pointer to the submodule branch
  -- 

   function git_submodule_branch (submodule : access Git.Low_Level.git2_types_h.git_submodule) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/submodule.h:387
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_branch";

  --*
  -- * Set the branch for the submodule in the configuration
  -- *
  -- * After calling this, you may wish to call `git_submodule_sync()` to
  -- * write the changes to the checked out submodule repository.
  -- *
  -- * @param repo the repository to affect
  -- * @param name the name of the submodule to configure
  -- * @param branch Branch that should be used for the submodule
  -- * @return 0 on success, <0 on failure
  --  

   function git_submodule_set_branch
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr;
      branch : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/submodule.h:400
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_set_branch";

  --*
  -- * Set the URL for the submodule in the configuration
  -- *
  -- *
  -- * After calling this, you may wish to call `git_submodule_sync()` to
  -- * write the changes to the checked out submodule repository.
  -- *
  -- * @param repo the repository to affect
  -- * @param name the name of the submodule to configure
  -- * @param url URL that should be used for the submodule
  -- * @return 0 on success, <0 on failure
  --  

   function git_submodule_set_url
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr;
      url : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/submodule.h:414
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_set_url";

  --*
  -- * Get the OID for the submodule in the index.
  -- *
  -- * @param submodule Pointer to submodule object
  -- * @return Pointer to git_oid or NULL if submodule is not in index.
  --  

   function git_submodule_index_id (submodule : access Git.Low_Level.git2_types_h.git_submodule) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/submodule.h:422
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_index_id";

  --*
  -- * Get the OID for the submodule in the current HEAD tree.
  -- *
  -- * @param submodule Pointer to submodule object
  -- * @return Pointer to git_oid or NULL if submodule is not in the HEAD.
  --  

   function git_submodule_head_id (submodule : access Git.Low_Level.git2_types_h.git_submodule) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/submodule.h:430
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_head_id";

  --*
  -- * Get the OID for the submodule in the current working directory.
  -- *
  -- * This returns the OID that corresponds to looking up 'HEAD' in the checked
  -- * out submodule.  If there are pending changes in the index or anything
  -- * else, this won't notice that.  You should call `git_submodule_status()`
  -- * for a more complete picture about the state of the working directory.
  -- *
  -- * @param submodule Pointer to submodule object
  -- * @return Pointer to git_oid or NULL if submodule is not checked out.
  --  

   function git_submodule_wd_id (submodule : access Git.Low_Level.git2_types_h.git_submodule) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/submodule.h:443
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_wd_id";

  --*
  -- * Get the ignore rule that will be used for the submodule.
  -- *
  -- * These values control the behavior of `git_submodule_status()` for this
  -- * submodule.  There are four ignore values:
  -- *
  -- *  - **GIT_SUBMODULE_IGNORE_NONE** will consider any change to the contents
  -- *    of the submodule from a clean checkout to be dirty, including the
  -- *    addition of untracked files.  This is the default if unspecified.
  -- *  - **GIT_SUBMODULE_IGNORE_UNTRACKED** examines the contents of the
  -- *    working tree (i.e. call `git_status_foreach()` on the submodule) but
  -- *    UNTRACKED files will not count as making the submodule dirty.
  -- *  - **GIT_SUBMODULE_IGNORE_DIRTY** means to only check if the HEAD of the
  -- *    submodule has moved for status.  This is fast since it does not need to
  -- *    scan the working tree of the submodule at all.
  -- *  - **GIT_SUBMODULE_IGNORE_ALL** means not to open the submodule repo.
  -- *    The working directory will be consider clean so long as there is a
  -- *    checked out version present.
  -- *
  -- * @param submodule The submodule to check
  -- * @return The current git_submodule_ignore_t valyue what will be used for
  -- *         this submodule.
  --  

   function git_submodule_ignore (submodule : access Git.Low_Level.git2_types_h.git_submodule) return Git.Low_Level.git2_types_h.git_submodule_ignore_t  -- /usr/include/git2/submodule.h:468
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_ignore";

  --*
  -- * Set the ignore rule for the submodule in the configuration
  -- *
  -- * This does not affect any currently-loaded instances.
  -- *
  -- * @param repo the repository to affect
  -- * @param name the name of the submdule
  -- * @param ignore The new value for the ignore rule
  -- * @return 0 or an error code
  --  

   function git_submodule_set_ignore
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr;
      ignore : Git.Low_Level.git2_types_h.git_submodule_ignore_t) return int  -- /usr/include/git2/submodule.h:481
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_set_ignore";

  --*
  -- * Get the update rule that will be used for the submodule.
  -- *
  -- * This value controls the behavior of the `git submodule update` command.
  -- * There are four useful values documented with `git_submodule_update_t`.
  -- *
  -- * @param submodule The submodule to check
  -- * @return The current git_submodule_update_t value that will be used
  -- *         for this submodule.
  --  

   function git_submodule_update_strategy (submodule : access Git.Low_Level.git2_types_h.git_submodule) return Git.Low_Level.git2_types_h.git_submodule_update_t  -- /usr/include/git2/submodule.h:496
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_update_strategy";

  --*
  -- * Set the update rule for the submodule in the configuration
  -- *
  -- * This setting won't affect any existing instances.
  -- *
  -- * @param repo the repository to affect
  -- * @param name the name of the submodule to configure
  -- * @param update The new value to use
  -- * @return 0 or an error code
  --  

   function git_submodule_set_update
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr;
      update : Git.Low_Level.git2_types_h.git_submodule_update_t) return int  -- /usr/include/git2/submodule.h:509
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_set_update";

  --*
  -- * Read the fetchRecurseSubmodules rule for a submodule.
  -- *
  -- * This accesses the submodule.<name>.fetchRecurseSubmodules value for
  -- * the submodule that controls fetching behavior for the submodule.
  -- *
  -- * Note that at this time, libgit2 does not honor this setting and the
  -- * fetch functionality current ignores submodules.
  -- *
  -- * @return 0 if fetchRecurseSubmodules is false, 1 if true
  --  

   function git_submodule_fetch_recurse_submodules (submodule : access Git.Low_Level.git2_types_h.git_submodule) return Git.Low_Level.git2_types_h.git_submodule_recurse_t  -- /usr/include/git2/submodule.h:525
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_fetch_recurse_submodules";

  --*
  -- * Set the fetchRecurseSubmodules rule for a submodule in the configuration
  -- *
  -- * This setting won't affect any existing instances.
  -- *
  -- * @param repo the repository to affect
  -- * @param name the submodule to configure
  -- * @param fetch_recurse_submodules Boolean value
  -- * @return old value for fetchRecurseSubmodules
  --  

   function git_submodule_set_fetch_recurse_submodules
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr;
      fetch_recurse_submodules : Git.Low_Level.git2_types_h.git_submodule_recurse_t) return int  -- /usr/include/git2/submodule.h:538
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_set_fetch_recurse_submodules";

  --*
  -- * Copy submodule info into ".git/config" file.
  -- *
  -- * Just like "git submodule init", this copies information about the
  -- * submodule into ".git/config".  You can use the accessor functions
  -- * above to alter the in-memory git_submodule object and control what
  -- * is written to the config, overriding what is in .gitmodules.
  -- *
  -- * @param submodule The submodule to write into the superproject config
  -- * @param overwrite By default, existing entries will not be overwritten,
  -- *                  but setting this to true forces them to be updated.
  -- * @return 0 on success, <0 on failure.
  --  

   function git_submodule_init (submodule : access Git.Low_Level.git2_types_h.git_submodule; overwrite : int) return int  -- /usr/include/git2/submodule.h:556
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_init";

  --*
  -- * Set up the subrepository for a submodule in preparation for clone.
  -- *
  -- * This function can be called to init and set up a submodule
  -- * repository from a submodule in preparation to clone it from
  -- * its remote.
  -- *
  -- * @param out Output pointer to the created git repository.
  -- * @param sm The submodule to create a new subrepository from.
  -- * @param use_gitlink Should the workdir contain a gitlink to
  -- *        the repo in .git/modules vs. repo directly in workdir.
  -- * @return 0 on success, <0 on failure.
  --  

   function git_submodule_repo_init
     (c_out : System.Address;
      sm : access constant Git.Low_Level.git2_types_h.git_submodule;
      use_gitlink : int) return int  -- /usr/include/git2/submodule.h:571
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_repo_init";

  --*
  -- * Copy submodule remote info into submodule repo.
  -- *
  -- * This copies the information about the submodules URL into the checked out
  -- * submodule config, acting like "git submodule sync".  This is useful if
  -- * you have altered the URL for the submodule (or it has been altered by a
  -- * fetch of upstream changes) and you need to update your local repo.
  --  

   function git_submodule_sync (submodule : access Git.Low_Level.git2_types_h.git_submodule) return int  -- /usr/include/git2/submodule.h:584
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_sync";

  --*
  -- * Open the repository for a submodule.
  -- *
  -- * This is a newly opened repository object.  The caller is responsible for
  -- * calling `git_repository_free()` on it when done.  Multiple calls to this
  -- * function will return distinct `git_repository` objects.  This will only
  -- * work if the submodule is checked out into the working directory.
  -- *
  -- * @param repo Pointer to the submodule repo which was opened
  -- * @param submodule Submodule to be opened
  -- * @return 0 on success, <0 if submodule repo could not be opened.
  --  

   function git_submodule_open (repo : System.Address; submodule : access Git.Low_Level.git2_types_h.git_submodule) return int  -- /usr/include/git2/submodule.h:598
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_open";

  --*
  -- * Reread submodule info from config, index, and HEAD.
  -- *
  -- * Call this to reread cached submodule information for this submodule if
  -- * you have reason to believe that it has changed.
  -- *
  -- * @param submodule The submodule to reload
  -- * @param force Force reload even if the data doesn't seem out of date
  -- * @return 0 on success, <0 on error
  --  

   function git_submodule_reload (submodule : access Git.Low_Level.git2_types_h.git_submodule; force : int) return int  -- /usr/include/git2/submodule.h:612
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_reload";

  --*
  -- * Get the status for a submodule.
  -- *
  -- * This looks at a submodule and tries to determine the status.  It
  -- * will return a combination of the `GIT_SUBMODULE_STATUS` values above.
  -- * How deeply it examines the working directory to do this will depend
  -- * on the `git_submodule_ignore_t` value for the submodule.
  -- *
  -- * @param status Combination of `GIT_SUBMODULE_STATUS` flags
  -- * @param repo the repository in which to look
  -- * @param name name of the submodule
  -- * @param ignore the ignore rules to follow
  -- * @return 0 on success, <0 on error
  --  

   function git_submodule_status
     (status : access unsigned;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr;
      ignore : Git.Low_Level.git2_types_h.git_submodule_ignore_t) return int  -- /usr/include/git2/submodule.h:628
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_status";

  --*
  -- * Get the locations of submodule information.
  -- *
  -- * This is a bit like a very lightweight version of `git_submodule_status`.
  -- * It just returns a made of the first four submodule status values (i.e.
  -- * the ones like GIT_SUBMODULE_STATUS_IN_HEAD, etc) that tell you where the
  -- * submodule data comes from (i.e. the HEAD commit, gitmodules file, etc.).
  -- * This can be useful if you want to know if the submodule is present in the
  -- * working directory at this point in time, etc.
  -- *
  -- * @param location_status Combination of first four `GIT_SUBMODULE_STATUS` flags
  -- * @param submodule Submodule for which to get status
  -- * @return 0 on success, <0 on error
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   function git_submodule_location (location_status : access unsigned; submodule : access Git.Low_Level.git2_types_h.git_submodule) return int  -- /usr/include/git2/submodule.h:648
   with Import => True, 
        Convention => C, 
        External_Name => "git_submodule_location";

end Git.Low_Level.git2_submodule_h;

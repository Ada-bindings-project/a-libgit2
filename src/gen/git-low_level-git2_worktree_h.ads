pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
limited with Git.Low_Level.git2_strarray_h;
limited with Git.Low_Level.git2_types_h;
with System;
with Interfaces.C.Strings;
limited with Git.Low_Level.git2_buffer_h;


package Git.Low_Level.git2_worktree_h is

   GIT_WORKTREE_ADD_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/worktree.h:91
   --  unsupported macro: GIT_WORKTREE_ADD_OPTIONS_INIT {GIT_WORKTREE_ADD_OPTIONS_VERSION,0,NULL}

   GIT_WORKTREE_PRUNE_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/worktree.h:204
   --  unsupported macro: GIT_WORKTREE_PRUNE_OPTIONS_INIT {GIT_WORKTREE_PRUNE_OPTIONS_VERSION,0}

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/worktrees.h
  -- * @brief Git worktree related functions
  -- * @defgroup git_commit Git worktree related functions
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * List names of linked working trees
  -- *
  -- * The returned list should be released with `git_strarray_free`
  -- * when no longer needed.
  -- *
  -- * @param out pointer to the array of working tree names
  -- * @param repo the repo to use when listing working trees
  -- * @return 0 or an error code
  --  

   function git_worktree_list (c_out : access Git.Low_Level.git2_strarray_h.git_strarray; repo : access Git.Low_Level.git2_types_h.git_repository) return int  -- /usr/include/git2/worktree.h:34
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_list";

  --*
  -- * Lookup a working tree by its name for a given repository
  -- *
  -- * @param out Output pointer to looked up worktree or `NULL`
  -- * @param repo The repository containing worktrees
  -- * @param name Name of the working tree to look up
  -- * @return 0 or an error code
  --  

   function git_worktree_lookup
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/worktree.h:44
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_lookup";

  --*
  -- * Open a worktree of a given repository
  -- *
  -- * If a repository is not the main tree but a worktree, this
  -- * function will look up the worktree inside the parent
  -- * repository and create a new `git_worktree` structure.
  -- *
  -- * @param out Out-pointer for the newly allocated worktree
  -- * @param repo Repository to look up worktree for
  --  

   function git_worktree_open_from_repository (c_out : System.Address; repo : access Git.Low_Level.git2_types_h.git_repository) return int  -- /usr/include/git2/worktree.h:56
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_open_from_repository";

  --*
  -- * Free a previously allocated worktree
  -- *
  -- * @param wt worktree handle to close. If NULL nothing occurs.
  --  

   procedure git_worktree_free (wt : access Git.Low_Level.git2_types_h.git_worktree)  -- /usr/include/git2/worktree.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_free";

  --*
  -- * Check if worktree is valid
  -- *
  -- * A valid worktree requires both the git data structures inside
  -- * the linked parent repository and the linked working copy to be
  -- * present.
  -- *
  -- * @param wt Worktree to check
  -- * @return 0 when worktree is valid, error-code otherwise
  --  

   function git_worktree_validate (wt : access constant Git.Low_Level.git2_types_h.git_worktree) return int  -- /usr/include/git2/worktree.h:75
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_validate";

  --*
  -- * Worktree add options structure
  -- *
  -- * Initialize with `GIT_WORKTREE_ADD_OPTIONS_INIT`. Alternatively, you can
  -- * use `git_worktree_add_options_init`.
  -- *
  --  

   type git_worktree_add_options is record
      version : aliased unsigned;  -- /usr/include/git2/worktree.h:85
      lock : aliased int;  -- /usr/include/git2/worktree.h:87
      ref : access Git.Low_Level.git2_types_h.git_reference;  -- /usr/include/git2/worktree.h:88
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/worktree.h:84

  --*< lock newly created worktree  
  --*< reference to use for the new worktree HEAD  
  --*
  -- * Initialize git_worktree_add_options structure
  -- *
  -- * Initializes a `git_worktree_add_options` with default values. Equivalent to
  -- * creating an instance with `GIT_WORKTREE_ADD_OPTIONS_INIT`.
  -- *
  -- * @param opts The `git_worktree_add_options` struct to initialize.
  -- * @param version The struct version; pass `GIT_WORKTREE_ADD_OPTIONS_VERSION`.
  -- * @return Zero on success; -1 on failure.
  --  

   function git_worktree_add_options_init (opts : access git_worktree_add_options; version : unsigned) return int  -- /usr/include/git2/worktree.h:104
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_add_options_init";

  --*
  -- * Add a new working tree
  -- *
  -- * Add a new working tree for the repository, that is create the
  -- * required data structures inside the repository and check out
  -- * the current HEAD at `path`
  -- *
  -- * @param out Output pointer containing new working tree
  -- * @param repo Repository to create working tree for
  -- * @param name Name of the working tree
  -- * @param path Path to create working tree at
  -- * @param opts Options to modify default behavior. May be NULL
  -- * @return 0 or an error code
  --  

   function git_worktree_add
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr;
      path : Interfaces.C.Strings.chars_ptr;
      opts : access constant git_worktree_add_options) return int  -- /usr/include/git2/worktree.h:121
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_add";

  --*
  -- * Lock worktree if not already locked
  -- *
  -- * Lock a worktree, optionally specifying a reason why the linked
  -- * working tree is being locked.
  -- *
  -- * @param wt Worktree to lock
  -- * @param reason Reason why the working tree is being locked
  -- * @return 0 on success, non-zero otherwise
  --  

   function git_worktree_lock (wt : access Git.Low_Level.git2_types_h.git_worktree; reason : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/worktree.h:135
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_lock";

  --*
  -- * Unlock a locked worktree
  -- *
  -- * @param wt Worktree to unlock
  -- * @return 0 on success, 1 if worktree was not locked, error-code
  -- *  otherwise
  --  

   function git_worktree_unlock (wt : access Git.Low_Level.git2_types_h.git_worktree) return int  -- /usr/include/git2/worktree.h:144
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_unlock";

  --*
  -- * Check if worktree is locked
  -- *
  -- * A worktree may be locked if the linked working tree is stored
  -- * on a portable device which is not available.
  -- *
  -- * @param reason Buffer to store reason in. If NULL no reason is stored.
  -- * @param wt Worktree to check
  -- * @return 0 when the working tree not locked, a value greater
  -- *  than zero if it is locked, less than zero if there was an
  -- *  error
  --  

   function git_worktree_is_locked (reason : access Git.Low_Level.git2_buffer_h.git_buf; wt : access constant Git.Low_Level.git2_types_h.git_worktree) return int  -- /usr/include/git2/worktree.h:158
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_is_locked";

  --*
  -- * Retrieve the name of the worktree
  -- *
  -- * @param wt Worktree to get the name for
  -- * @return The worktree's name. The pointer returned is valid for the
  -- *  lifetime of the git_worktree
  --  

   function git_worktree_name (wt : access constant Git.Low_Level.git2_types_h.git_worktree) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/worktree.h:167
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_name";

  --*
  -- * Retrieve the filesystem path for the worktree
  -- *
  -- * @param wt Worktree to get the path for
  -- * @return The worktree's filesystem path. The pointer returned
  -- *  is valid for the lifetime of the git_worktree.
  --  

   function git_worktree_path (wt : access constant Git.Low_Level.git2_types_h.git_worktree) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/worktree.h:176
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_path";

  --*
  -- * Flags which can be passed to git_worktree_prune to alter its
  -- * behavior.
  --  

  -- Prune working tree even if working tree is valid  
  -- Prune working tree even if it is locked  
  -- Prune checked out working tree  
   subtype git_worktree_prune_t is unsigned;
   GIT_WORKTREE_PRUNE_VALID : constant unsigned := 1;
   GIT_WORKTREE_PRUNE_LOCKED : constant unsigned := 2;
   GIT_WORKTREE_PRUNE_WORKING_TREE : constant unsigned := 4;  -- /usr/include/git2/worktree.h:189

  --*
  -- * Worktree prune options structure
  -- *
  -- * Initialize with `GIT_WORKTREE_PRUNE_OPTIONS_INIT`. Alternatively, you can
  -- * use `git_worktree_prune_options_init`.
  -- *
  --  

   type git_worktree_prune_options is record
      version : aliased unsigned;  -- /usr/include/git2/worktree.h:199
      flags : aliased unsigned;  -- /usr/include/git2/worktree.h:201
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/worktree.h:198

  --*
  -- * Initialize git_worktree_prune_options structure
  -- *
  -- * Initializes a `git_worktree_prune_options` with default values. Equivalent to
  -- * creating an instance with `GIT_WORKTREE_PRUNE_OPTIONS_INIT`.
  -- *
  -- * @param opts The `git_worktree_prune_options` struct to initialize.
  -- * @param version The struct version; pass `GIT_WORKTREE_PRUNE_OPTIONS_VERSION`.
  -- * @return Zero on success; -1 on failure.
  --  

   function git_worktree_prune_options_init (opts : access git_worktree_prune_options; version : unsigned) return int  -- /usr/include/git2/worktree.h:217
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_prune_options_init";

  --*
  -- * Is the worktree prunable with the given options?
  -- *
  -- * A worktree is not prunable in the following scenarios:
  -- *
  -- * - the worktree is linking to a valid on-disk worktree. The
  -- *   `valid` member will cause this check to be ignored.
  -- * - the worktree is locked. The `locked` flag will cause this
  -- *   check to be ignored.
  -- *
  -- * If the worktree is not valid and not locked or if the above
  -- * flags have been passed in, this function will return a
  -- * positive value.
  --  

   function git_worktree_is_prunable (wt : access Git.Low_Level.git2_types_h.git_worktree; opts : access git_worktree_prune_options) return int  -- /usr/include/git2/worktree.h:235
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_is_prunable";

  --*
  -- * Prune working tree
  -- *
  -- * Prune the working tree, that is remove the git data
  -- * structures on disk. The repository will only be pruned of
  -- * `git_worktree_is_prunable` succeeds.
  -- *
  -- * @param wt Worktree to prune
  -- * @param opts Specifies which checks to override. See
  -- *        `git_worktree_is_prunable`. May be NULL
  -- * @return 0 or an error code
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   function git_worktree_prune (wt : access Git.Low_Level.git2_types_h.git_worktree; opts : access git_worktree_prune_options) return int  -- /usr/include/git2/worktree.h:250
   with Import => True, 
        Convention => C, 
        External_Name => "git_worktree_prune";

end Git.Low_Level.git2_worktree_h;

pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
limited with Git.Low_Level.git2_types_h;
with Interfaces.C.Strings;
with Git.Low_Level.git2_checkout_h;
with Git.Low_Level.git2_remote_h;

package Git.Low_Level.git2_clone_h is

   GIT_CLONE_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/clone.h:166
   --  unsupported macro: GIT_CLONE_OPTIONS_INIT { GIT_CLONE_OPTIONS_VERSION, { GIT_CHECKOUT_OPTIONS_VERSION, GIT_CHECKOUT_SAFE }, GIT_FETCH_OPTIONS_INIT }

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/clone.h
  -- * @brief Git cloning routines
  -- * @defgroup git_clone Git cloning routines
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Options for bypassing the git-aware transport on clone. Bypassing
  -- * it means that instead of a fetch, libgit2 will copy the object
  -- * database directory instead of figuring out what it needs, which is
  -- * faster. If possible, it will hardlink the files to save space.
  --  

  --*
  --	 * Auto-detect (default), libgit2 will bypass the git-aware
  --	 * transport for local paths, but use a normal fetch for
  --	 * `file://` urls.
  --	  

  --*
  --	 * Bypass the git-aware transport even for a `file://` url.
  --	  

  --*
  --	 * Do no bypass the git-aware transport
  --	  

  --*
  --	 * Bypass the git-aware transport, but do not try to use
  --	 * hardlinks.
  --	  

   type git_clone_local_t is 
     (GIT_CLONE_LOCAL_AUTO,
      GIT_CLONE_LOCAL,
      GIT_CLONE_NO_LOCAL,
      GIT_CLONE_LOCAL_NO_LINKS)
   with Convention => C;  -- /usr/include/git2/clone.h:53

  --*
  -- * The signature of a function matching git_remote_create, with an additional
  -- * void* as a callback payload.
  -- *
  -- * Callers of git_clone may provide a function matching this signature to override
  -- * the remote creation and customization process during a clone operation.
  -- *
  -- * @param out the resulting remote
  -- * @param repo the repository in which to create the remote
  -- * @param name the remote's name
  -- * @param url the remote's url
  -- * @param payload an opaque payload
  -- * @return 0, GIT_EINVALIDSPEC, GIT_EEXISTS or an error code
  --  

   type git_remote_create_cb is access function
        (arg1 : System.Address;
         arg2 : access Git.Low_Level.git2_types_h.git_repository;
         arg3 : Interfaces.C.Strings.chars_ptr;
         arg4 : Interfaces.C.Strings.chars_ptr;
         arg5 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/clone.h:69

  --*
  -- * The signature of a function matchin git_repository_init, with an
  -- * aditional void * as callback payload.
  -- *
  -- * Callers of git_clone my provide a function matching this signature
  -- * to override the repository creation and customization process
  -- * during a clone operation.
  -- *
  -- * @param out the resulting repository
  -- * @param path path in which to create the repository
  -- * @param bare whether the repository is bare. This is the value from the clone options
  -- * @param payload payload specified by the options
  -- * @return 0, or a negative value to indicate error
  --  

   type git_repository_create_cb is access function
        (arg1 : System.Address;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : int;
         arg4 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/clone.h:90

  --*
  -- * Clone options structure
  -- *
  -- * Initialize with `GIT_CLONE_OPTIONS_INIT`. Alternatively, you can
  -- * use `git_clone_options_init`.
  -- *
  --  

   type git_clone_options is record
      version : aliased unsigned;  -- /usr/include/git2/clone.h:104
      checkout_opts : aliased Git.Low_Level.git2_checkout_h.git_checkout_options;  -- /usr/include/git2/clone.h:111
      fetch_opts : aliased Git.Low_Level.git2_remote_h.git_fetch_options;  -- /usr/include/git2/clone.h:119
      bare : aliased int;  -- /usr/include/git2/clone.h:125
      local : aliased git_clone_local_t;  -- /usr/include/git2/clone.h:130
      checkout_branch : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/clone.h:136
      repository_cb : git_repository_create_cb;  -- /usr/include/git2/clone.h:143
      repository_cb_payload : System.Address;  -- /usr/include/git2/clone.h:149
      remote_cb : git_remote_create_cb;  -- /usr/include/git2/clone.h:157
      remote_cb_payload : System.Address;  -- /usr/include/git2/clone.h:163
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/clone.h:103

  --*
  --	 * These options are passed to the checkout step. To disable
  --	 * checkout, set the `checkout_strategy` to
  --	 * `GIT_CHECKOUT_NONE`.
  --	  

  --*
  --	 * Options which control the fetch, including callbacks.
  --	 *
  --	 * The callbacks are used for reporting fetch progress, and for acquiring
  --	 * credentials in the event they are needed.
  --	  

  --*
  --	 * Set to zero (false) to create a standard repo, or non-zero
  --	 * for a bare repo
  --	  

  --*
  --	 * Whether to use a fetch or copy the object database.
  --	  

  --*
  --	 * The name of the branch to checkout. NULL means use the
  --	 * remote's default branch.
  --	  

  --*
  --	 * A callback used to create the new repository into which to
  --	 * clone. If NULL, the 'bare' field will be used to determine
  --	 * whether to create a bare repository.
  --	  

  --*
  --	 * An opaque payload to pass to the git_repository creation callback.
  --	 * This parameter is ignored unless repository_cb is non-NULL.
  --	  

  --*
  --	 * A callback used to create the git_remote, prior to its being
  --	 * used to perform the clone operation. See the documentation for
  --	 * git_remote_create_cb for details. This parameter may be NULL,
  --	 * indicating that git_clone should provide default behavior.
  --	  

  --*
  --	 * An opaque payload to pass to the git_remote creation callback.
  --	 * This parameter is ignored unless remote_cb is non-NULL.
  --	  

  --*
  -- * Initialize git_clone_options structure
  -- *
  -- * Initializes a `git_clone_options` with default values. Equivalent to creating
  -- * an instance with GIT_CLONE_OPTIONS_INIT.
  -- *
  -- * @param opts The `git_clone_options` struct to initialize.
  -- * @param version The struct version; pass `GIT_CLONE_OPTIONS_VERSION`.
  -- * @return Zero on success; -1 on failure.
  --  

   function git_clone_options_init (opts : access git_clone_options; version : unsigned) return int  -- /usr/include/git2/clone.h:181
   with Import => True, 
        Convention => C, 
        External_Name => "git_clone_options_init";

  --*
  -- * Clone a remote repository.
  -- *
  -- * By default this creates its repository and initial remote to match
  -- * git's defaults. You can use the options in the callback to
  -- * customize how these are created.
  -- *
  -- * @param out pointer that will receive the resulting repository object
  -- * @param url the remote repository to clone
  -- * @param local_path local directory to clone to
  -- * @param options configuration options for the clone.  If NULL, the
  -- *        function works as though GIT_OPTIONS_INIT were passed.
  -- * @return 0 on success, any non-zero return value from a callback
  -- *         function, or a negative value to indicate an error (use
  -- *         `git_error_last` for a detailed error message)
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   function git_clone
     (c_out : System.Address;
      url : Interfaces.C.Strings.chars_ptr;
      local_path : Interfaces.C.Strings.chars_ptr;
      options : access constant git_clone_options) return int  -- /usr/include/git2/clone.h:201
   with Import => True, 
        Convention => C, 
        External_Name => "git_clone";

end Git.Low_Level.git2_clone_h;

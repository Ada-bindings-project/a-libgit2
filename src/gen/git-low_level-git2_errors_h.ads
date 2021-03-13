pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package Git.Low_Level.git2_errors_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/errors.h
  -- * @brief Git error handling routines and variables
  -- * @ingroup Git
  -- * @{
  --  

  --* Generic return codes  
  --*< No error  
  --*< Generic error  
  --*< Requested object could not be found  
  --*< Object exists preventing operation  
  --*< More than one object matches  
  --*< Output buffer too short to hold data  
  --*
  --	 * GIT_EUSER is a special error that is never generated by libgit2
  --	 * code.  You can return it from a callback (e.g to stop an iteration)
  --	 * to know that it was generated by the callback and not by libgit2.
  --	  

  --*< Operation not allowed on bare repository  
  --*< HEAD refers to branch with no commits  
  --*< Merge in progress prevented operation  
  --*< Reference was not fast-forwardable  
  --*< Name/ref spec was not in a valid format  
  --*< Checkout conflicts prevented operation  
  --*< Lock file prevented operation  
  --*< Reference value does not match expected  
  --*< Authentication error  
  --*< Server certificate is invalid  
  --*< Patch/merge has already been applied  
  --*< The requested peel operation is not possible  
  --*< Unexpected EOF  
  --*< Invalid operation or input  
  --*< Uncommitted changes in index prevented operation  
  --*< The operation is not valid for a directory  
  --*< A merge conflict exists and cannot continue  
  --*< A user-configured callback refused to act  
  --*< Signals end of iteration with iterator  
  --*< Internal only  
  --*< Hashsum mismatch in object  
  --*< Unsaved changes in the index would be overwritten  
  --*< Patch application failed  
   subtype git_error_code is int;
   GIT_OK : constant int := 0;
   GIT_ERROR_C : constant int := -1;
   GIT_ENOTFOUND : constant int := -3;
   GIT_EEXISTS : constant int := -4;
   GIT_EAMBIGUOUS : constant int := -5;
   GIT_EBUFS : constant int := -6;
   GIT_EUSER : constant int := -7;
   GIT_EBAREREPO : constant int := -8;
   GIT_EUNBORNBRANCH : constant int := -9;
   GIT_EUNMERGED : constant int := -10;
   GIT_ENONFASTFORWARD : constant int := -11;
   GIT_EINVALIDSPEC : constant int := -12;
   GIT_ECONFLICT : constant int := -13;
   GIT_ELOCKED : constant int := -14;
   GIT_EMODIFIED : constant int := -15;
   GIT_EAUTH : constant int := -16;
   GIT_ECERTIFICATE : constant int := -17;
   GIT_EAPPLIED : constant int := -18;
   GIT_EPEEL : constant int := -19;
   GIT_EEOF : constant int := -20;
   GIT_EINVALID : constant int := -21;
   GIT_EUNCOMMITTED : constant int := -22;
   GIT_EDIRECTORY : constant int := -23;
   GIT_EMERGECONFLICT : constant int := -24;
   GIT_PASSTHROUGH : constant int := -30;
   GIT_ITEROVER : constant int := -31;
   GIT_RETRY : constant int := -32;
   GIT_EMISMATCH : constant int := -33;
   GIT_EINDEXDIRTY : constant int := -34;
   GIT_EAPPLYFAIL : constant int := -35;  -- /usr/include/git2/errors.h:61

  --*
  -- * Structure to store extra details of the last error that occurred.
  -- *
  -- * This is kept on a per-thread basis if GIT_THREADS was defined when the
  -- * library was build, otherwise one is kept globally for the library
  --  

   --  skipped anonymous struct anon_anon_106

   type git_error is record
      message : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/errors.h:70
      klass : aliased int;  -- /usr/include/git2/errors.h:71
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/errors.h:72

  --* Error classes  
   type git_error_t is 
     (GIT_ERROR_C_NONE,
      GIT_ERROR_C_NOMEMORY,
      GIT_ERROR_C_OS,
      GIT_ERROR_C_INVALID,
      GIT_ERROR_C_REFERENCE,
      GIT_ERROR_C_ZLIB,
      GIT_ERROR_C_REPOSITORY,
      GIT_ERROR_C_CONFIG,
      GIT_ERROR_C_REGEX,
      GIT_ERROR_C_ODB,
      GIT_ERROR_C_INDEX,
      GIT_ERROR_C_OBJECT,
      GIT_ERROR_C_NET,
      GIT_ERROR_C_TAG,
      GIT_ERROR_C_TREE,
      GIT_ERROR_C_INDEXER,
      GIT_ERROR_C_SSL,
      GIT_ERROR_C_SUBMODULE,
      GIT_ERROR_C_THREAD,
      GIT_ERROR_C_STASH,
      GIT_ERROR_C_CHECKOUT,
      GIT_ERROR_C_FETCHHEAD,
      GIT_ERROR_C_MERGE,
      GIT_ERROR_C_SSH,
      GIT_ERROR_C_FILTER,
      GIT_ERROR_C_REVERT,
      GIT_ERROR_C_CALLBACK,
      GIT_ERROR_C_CHERRYPICK,
      GIT_ERROR_C_DESCRIBE,
      GIT_ERROR_C_REBASE,
      GIT_ERROR_C_FILESYSTEM,
      GIT_ERROR_C_PATCH,
      GIT_ERROR_C_WORKTREE,
      GIT_ERROR_C_SHA1,
      GIT_ERROR_C_HTTP)
   with Convention => C;  -- /usr/include/git2/errors.h:111

  --*
  -- * Return the last `git_error` object that was generated for the
  -- * current thread.
  -- *
  -- * The default behaviour of this function is to return NULL if no previous error has occurred.
  -- * However, libgit2's error strings are not cleared aggressively, so a prior
  -- * (unrelated) error may be returned. This can be avoided by only calling
  -- * this function if the prior call to a libgit2 API returned an error.
  -- *
  -- * @return A git_error object.
  --  

   function git_error_last return access constant git_error  -- /usr/include/git2/errors.h:124
   with Import => True, 
        Convention => C, 
        External_Name => "git_error_last";

  --*
  -- * Clear the last library error that occurred for this thread.
  --  

   procedure git_error_clear  -- /usr/include/git2/errors.h:129
   with Import => True, 
        Convention => C, 
        External_Name => "git_error_clear";

  --*
  -- * Set the error message string for this thread.
  -- *
  -- * This function is public so that custom ODB backends and the like can
  -- * relay an error message through libgit2.  Most regular users of libgit2
  -- * will never need to call this function -- actually, calling it in most
  -- * circumstances (for example, calling from within a callback function)
  -- * will just end up having the value overwritten by libgit2 internals.
  -- *
  -- * This error message is stored in thread-local storage and only applies
  -- * to the particular thread that this libgit2 call is made from.
  -- *
  -- * @param error_class One of the `git_error_t` enum above describing the
  -- *                    general subsystem that is responsible for the error.
  -- * @param string The formatted error message to keep
  -- * @return 0 on success or -1 on failure
  --  

   function git_error_set_str (error_class : int; string : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/errors.h:148
   with Import => True, 
        Convention => C, 
        External_Name => "git_error_set_str";

  --*
  -- * Set the error message to a special value for memory allocation failure.
  -- *
  -- * The normal `git_error_set_str()` function attempts to `strdup()` the
  -- * string that is passed in.  This is not a good idea when the error in
  -- * question is a memory allocation failure.  That circumstance has a
  -- * special setter function that sets the error string to a known and
  -- * statically allocated internal value.
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   procedure git_error_set_oom  -- /usr/include/git2/errors.h:159
   with Import => True, 
        Convention => C, 
        External_Name => "git_error_set_oom";

end Git.Low_Level.git2_errors_h;
pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
limited with Git.Low_Level.git2_types_h;
limited with Git.Low_Level.git2_checkout_h;
limited with Git.Low_Level.git2_strarray_h;

package Git.Low_Level.git2_reset_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/reset.h
  -- * @brief Git reset management routines
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Kinds of reset operation
  --  

  --*< Move the head to the given commit  
  --*< SOFT plus reset index to the commit  
  --*< MIXED plus changes in working tree discarded  
   subtype git_reset_t is unsigned;
   GIT_RESET_SOFT : constant unsigned := 1;
   GIT_RESET_MIXED : constant unsigned := 2;
   GIT_RESET_HARD : constant unsigned := 3;  -- /usr/include/git2/reset.h:30

  --*
  -- * Sets the current head to the specified commit oid and optionally
  -- * resets the index and working tree to match.
  -- *
  -- * SOFT reset means the Head will be moved to the commit.
  -- *
  -- * MIXED reset will trigger a SOFT reset, plus the index will be replaced
  -- * with the content of the commit tree.
  -- *
  -- * HARD reset will trigger a MIXED reset and the working directory will be
  -- * replaced with the content of the index.  (Untracked and ignored files
  -- * will be left alone, however.)
  -- *
  -- * TODO: Implement remaining kinds of resets.
  -- *
  -- * @param repo Repository where to perform the reset operation.
  -- *
  -- * @param target Committish to which the Head should be moved to. This object
  -- * must belong to the given `repo` and can either be a git_commit or a
  -- * git_tag. When a git_tag is being passed, it should be dereferencable
  -- * to a git_commit which oid will be used as the target of the branch.
  -- *
  -- * @param reset_type Kind of reset operation to perform.
  -- *
  -- * @param checkout_opts Optional checkout options to be used for a HARD reset.
  -- * The checkout_strategy field will be overridden (based on reset_type).
  -- * This parameter can be used to propagate notify and progress callbacks.
  -- *
  -- * @return 0 on success or an error code
  --  

   function git_reset
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      target : access constant Git.Low_Level.git2_types_h.git_object;
      reset_type : git_reset_t;
      checkout_opts : access constant Git.Low_Level.git2_checkout_h.git_checkout_options) return int  -- /usr/include/git2/reset.h:62
   with Import => True, 
        Convention => C, 
        External_Name => "git_reset";

  --*
  -- * Sets the current head to the specified commit oid and optionally
  -- * resets the index and working tree to match.
  -- *
  -- * This behaves like `git_reset()` but takes an annotated commit,
  -- * which lets you specify which extended sha syntax string was
  -- * specified by a user, allowing for more exact reflog messages.
  -- *
  -- * See the documentation for `git_reset()`.
  -- *
  -- * @see git_reset
  --  

   function git_reset_from_annotated
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      commit : access constant Git.Low_Level.git2_types_h.git_annotated_commit;
      reset_type : git_reset_t;
      checkout_opts : access constant Git.Low_Level.git2_checkout_h.git_checkout_options) return int  -- /usr/include/git2/reset.h:80
   with Import => True, 
        Convention => C, 
        External_Name => "git_reset_from_annotated";

  --*
  -- * Updates some entries in the index from the target commit tree.
  -- *
  -- * The scope of the updated entries is determined by the paths
  -- * being passed in the `pathspec` parameters.
  -- *
  -- * Passing a NULL `target` will result in removing
  -- * entries in the index matching the provided pathspecs.
  -- *
  -- * @param repo Repository where to perform the reset operation.
  -- *
  -- * @param target The committish which content will be used to reset the content
  -- * of the index.
  -- *
  -- * @param pathspecs List of pathspecs to operate on.
  -- *
  -- * @return 0 on success or an error code < 0
  --  

   function git_reset_default
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      target : access constant Git.Low_Level.git2_types_h.git_object;
      pathspecs : access constant Git.Low_Level.git2_strarray_h.git_strarray) return int  -- /usr/include/git2/reset.h:104
   with Import => True, 
        Convention => C, 
        External_Name => "git_reset_default";

  --* @}  
end Git.Low_Level.git2_reset_h;

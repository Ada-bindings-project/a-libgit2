pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
limited with git.Low_Level.git2_types_h;
with Interfaces.C.Strings;

package git.Low_Level.git2_revparse_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/revparse.h
  --  * @brief Git revision parsing routines
  --  * @defgroup git_revparse Git revision parsing routines
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Find a single object, as specified by a revision string.
  --  *
  --  * See `man gitrevisions`, or
  --  * http://git-scm.com/docs/git-rev-parse.html#_specifying_revisions for
  --  * information on the syntax accepted.
  --  *
  --  * The returned object should be released with `git_object_free` when no
  --  * longer needed.
  --  *
  --  * @param out pointer to output object
  --  * @param repo the repository to search in
  --  * @param spec the textual specification for an object
  --  * @return 0 on success, GIT_ENOTFOUND, GIT_EAMBIGUOUS, GIT_EINVALIDSPEC or an error code
  --

   function git_revparse_single_f
     (c_out : System.Address;
      repo  : access git.Low_Level.git2_types_h.git_repository;
      spec  : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/revparse.h:37
      with Import   => True,
      Convention    => C,
      External_Name => "git_revparse_single";

  --*
  --  * Find a single object and intermediate reference by a revision string.
  --  *
  --  * See `man gitrevisions`, or
  --  * http://git-scm.com/docs/git-rev-parse.html#_specifying_revisions for
  --  * information on the syntax accepted.
  --  *
  --  * In some cases (`@{<-n>}` or `<branchname>@{upstream}`), the expression may
  --  * point to an intermediate reference. When such expressions are being passed
  --  * in, `reference_out` will be valued as well.
  --  *
  --  * The returned object should be released with `git_object_free` and the
  --  * returned reference with `git_reference_free` when no longer needed.
  --  *
  --  * @param object_out pointer to output object
  --  * @param reference_out pointer to output reference or NULL
  --  * @param repo the repository to search in
  --  * @param spec the textual specification for an object
  --  * @return 0 on success, GIT_ENOTFOUND, GIT_EAMBIGUOUS, GIT_EINVALIDSPEC
  --  * or an error code
  --

   function git_revparse_ext
     (object_out    : System.Address;
      reference_out : System.Address;
      repo          : access git.Low_Level.git2_types_h.git_repository;
      spec          : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/revparse.h:61
      with Import   => True,
      Convention    => C,
      External_Name => "git_revparse_ext";

  --*
  --  * Revparse flags.  These indicate the intended behavior of the spec passed to
  --  * git_revparse.
  --

  --* The spec targeted a single object.
  --* The spec targeted a range of commits.
  --* The spec used the '...' operator, which invokes special semantics.
   subtype git_revparse_mode_t is unsigned;
   GIT_REVPARSE_SINGLE     : constant unsigned := 1;
   GIT_REVPARSE_RANGE      : constant unsigned := 2;
   GIT_REVPARSE_MERGE_BASE : constant unsigned := 4;  -- /usr/include/git2/revparse.h:78

  --*
  --  * Git Revision Spec: output of a `git_revparse` operation
  --

  --* The left element of the revspec; must be freed by the user
   --  skipped anonymous struct anon_anon_131

   type git_revspec is record
      from  : access git.Low_Level.git2_types_h.git_object;  -- /usr/include/git2/revparse.h:85
      to    : access git.Low_Level.git2_types_h.git_object;  -- /usr/include/git2/revparse.h:87
      flags : aliased unsigned;  -- /usr/include/git2/revparse.h:89
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/revparse.h:90

  --* The right element of the revspec; must be freed by the user
  --* The intent of the revspec (i.e. `git_revparse_mode_t` flags)
  --*
  --  * Parse a revision string for `from`, `to`, and intent.
  --  *
  --  * See `man gitrevisions` or
  --  * http://git-scm.com/docs/git-rev-parse.html#_specifying_revisions for
  --  * information on the syntax accepted.
  --  *
  --  * @param revspec Pointer to an user-allocated git_revspec struct where
  --  *                the result of the rev-parse will be stored
  --  * @param repo the repository to search in
  --  * @param spec the rev-parse spec to parse
  --  * @return 0 on success, GIT_INVALIDSPEC, GIT_ENOTFOUND, GIT_EAMBIGUOUS or an error code
  --

   function git_revparse
     (revspec : access git_revspec;
      repo    : access git.Low_Level.git2_types_h.git_repository;
      spec    : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/revparse.h:105
      with Import   => True,
      Convention    => C,
      External_Name => "git_revparse";

  --* @}
end git.Low_Level.git2_revparse_h;

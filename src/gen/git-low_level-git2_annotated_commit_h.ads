pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
limited with Git.Low_Level.git2_types_h;
with Interfaces.C.Strings;
limited with Git.Low_Level.git2_oid_h;

package Git.Low_Level.git2_annotated_commit_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/annotated_commit.h
  -- * @brief Git annotated commit routines
  -- * @defgroup git_annotated_commit Git annotated commit routines
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Creates a `git_annotated_commit` from the given reference.
  -- * The resulting git_annotated_commit must be freed with
  -- * `git_annotated_commit_free`.
  -- *
  -- * @param out pointer to store the git_annotated_commit result in
  -- * @param repo repository that contains the given reference
  -- * @param ref reference to use to lookup the git_annotated_commit
  -- * @return 0 on success or error code
  --  

   function git_annotated_commit_from_ref
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      ref : access constant Git.Low_Level.git2_types_h.git_reference) return int  -- /usr/include/git2/annotated_commit.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "git_annotated_commit_from_ref";

  --*
  -- * Creates a `git_annotated_commit` from the given fetch head data.
  -- * The resulting git_annotated_commit must be freed with
  -- * `git_annotated_commit_free`.
  -- *
  -- * @param out pointer to store the git_annotated_commit result in
  -- * @param repo repository that contains the given commit
  -- * @param branch_name name of the (remote) branch
  -- * @param remote_url url of the remote
  -- * @param id the commit object id of the remote branch
  -- * @return 0 on success or error code
  --  

   function git_annotated_commit_from_fetchhead
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      branch_name : Interfaces.C.Strings.chars_ptr;
      remote_url : Interfaces.C.Strings.chars_ptr;
      id : access constant Git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/annotated_commit.h:50
   with Import => True, 
        Convention => C, 
        External_Name => "git_annotated_commit_from_fetchhead";

  --*
  -- * Creates a `git_annotated_commit` from the given commit id.
  -- * The resulting git_annotated_commit must be freed with
  -- * `git_annotated_commit_free`.
  -- *
  -- * An annotated commit contains information about how it was
  -- * looked up, which may be useful for functions like merge or
  -- * rebase to provide context to the operation.  For example,
  -- * conflict files will include the name of the source or target
  -- * branches being merged.  It is therefore preferable to use the
  -- * most specific function (eg `git_annotated_commit_from_ref`)
  -- * instead of this one when that data is known.
  -- *
  -- * @param out pointer to store the git_annotated_commit result in
  -- * @param repo repository that contains the given commit
  -- * @param id the commit object id to lookup
  -- * @return 0 on success or error code
  --  

   function git_annotated_commit_lookup
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      id : access constant Git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/annotated_commit.h:75
   with Import => True, 
        Convention => C, 
        External_Name => "git_annotated_commit_lookup";

  --*
  -- * Creates a `git_annotated_comit` from a revision string.
  -- *
  -- * See `man gitrevisions`, or
  -- * http://git-scm.com/docs/git-rev-parse.html#_specifying_revisions for
  -- * information on the syntax accepted.
  -- *
  -- * @param out pointer to store the git_annotated_commit result in
  -- * @param repo repository that contains the given commit
  -- * @param revspec the extended sha syntax string to use to lookup the commit
  -- * @return 0 on success or error code
  --  

   function git_annotated_commit_from_revspec
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      revspec : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/annotated_commit.h:92
   with Import => True, 
        Convention => C, 
        External_Name => "git_annotated_commit_from_revspec";

  --*
  -- * Gets the commit ID that the given `git_annotated_commit` refers to.
  -- *
  -- * @param commit the given annotated commit
  -- * @return commit id
  --  

   function git_annotated_commit_id (commit : access constant Git.Low_Level.git2_types_h.git_annotated_commit) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/annotated_commit.h:103
   with Import => True, 
        Convention => C, 
        External_Name => "git_annotated_commit_id";

  --*
  -- * Get the refname that the given `git_annotated_commit` refers to.
  -- *
  -- * @param commit the given annotated commit
  -- * @return ref name.
  --  

   function git_annotated_commit_ref (commit : access constant Git.Low_Level.git2_types_h.git_annotated_commit) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/annotated_commit.h:112
   with Import => True, 
        Convention => C, 
        External_Name => "git_annotated_commit_ref";

  --*
  -- * Frees a `git_annotated_commit`.
  -- *
  -- * @param commit annotated commit to free
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   procedure git_annotated_commit_free (commit : access Git.Low_Level.git2_types_h.git_annotated_commit)  -- /usr/include/git2/annotated_commit.h:120
   with Import => True, 
        Convention => C, 
        External_Name => "git_annotated_commit_free";

end Git.Low_Level.git2_annotated_commit_h;

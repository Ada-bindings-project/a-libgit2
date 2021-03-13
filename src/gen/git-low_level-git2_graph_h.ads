pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;

limited with git.Low_Level.git2_types_h;
limited with git.Low_Level.git2_oid_h;

package git.Low_Level.git2_graph_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/graph.h
  --  * @brief Git graph traversal routines
  --  * @defgroup git_revwalk Git graph traversal routines
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Count the number of unique commits between two commit objects
  --  *
  --  * There is no need for branches containing the commits to have any
  --  * upstream relationship, but it helps to think of one as a branch and
  --  * the other as its upstream, the `ahead` and `behind` values will be
  --  * what git would report for the branches.
  --  *
  --  * @param ahead number of unique from commits in `upstream`
  --  * @param behind number of unique from commits in `local`
  --  * @param repo the repository where the commits exist
  --  * @param local the commit for local
  --  * @param upstream the commit for upstream
  --

   function git_graph_ahead_behind
     (ahead    : access unsigned_long;
      behind   : access unsigned_long;
      repo     : access git.Low_Level.git2_types_h.git_repository;
      local    : access constant git.Low_Level.git2_oid_h.git_oid;
      upstream : access constant git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/graph.h:37
      with Import   => True,
      Convention    => C,
      External_Name => "git_graph_ahead_behind";

  --*
  --  * Determine if a commit is the descendant of another commit.
  --  *
  --  * Note that a commit is not considered a descendant of itself, in contrast
  --  * to `git merge-base --is-ancestor`.
  --  *
  --  * @param commit a previously loaded commit.
  --  * @param ancestor a potential ancestor commit.
  --  * @return 1 if the given commit is a descendant of the potential ancestor,
  --  * 0 if not, error code otherwise.
  --

   function git_graph_descendant_of
     (repo     : access git.Low_Level.git2_types_h.git_repository;
      commit   : access constant git.Low_Level.git2_oid_h.git_oid;
      ancestor : access constant git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/graph.h:51
      with Import   => True,
      Convention    => C,
      External_Name => "git_graph_descendant_of";

  --* @}
end git.Low_Level.git2_graph_h;

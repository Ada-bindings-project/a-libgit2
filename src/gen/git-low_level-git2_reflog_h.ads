pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
limited with git.Low_Level.git2_types_h;
with Interfaces.C.Strings;
limited with git.Low_Level.git2_oid_h;


package git.Low_Level.git2_reflog_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/reflog.h
  --  * @brief Git reflog management routines
  --  * @defgroup git_reflog Git reflog management routines
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Read the reflog for the given reference
  --  *
  --  * If there is no reflog file for the given
  --  * reference yet, an empty reflog object will
  --  * be returned.
  --  *
  --  * The reflog must be freed manually by using
  --  * git_reflog_free().
  --  *
  --  * @param out pointer to reflog
  --  * @param repo the repostiory
  --  * @param name reference to look up
  --  * @return 0 or an error code
  --

   function git_reflog_read
     (c_out : System.Address;
      repo  : access git.Low_Level.git2_types_h.git_repository;
      name  : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/reflog.h:38
      with Import   => True,
      Convention    => C,
      External_Name => "git_reflog_read";

  --*
  --  * Write an existing in-memory reflog object back to disk
  --  * using an atomic file lock.
  --  *
  --  * @param reflog an existing reflog object
  --  * @return 0 or an error code
  --

   function git_reflog_write (reflog : access git.Low_Level.git2_types_h.git_reflog) return int  -- /usr/include/git2/reflog.h:47
      with Import   => True,
      Convention    => C,
      External_Name => "git_reflog_write";

  --*
  --  * Add a new entry to the in-memory reflog.
  --  *
  --  * `msg` is optional and can be NULL.
  --  *
  --  * @param reflog an existing reflog object
  --  * @param id the OID the reference is now pointing to
  --  * @param committer the signature of the committer
  --  * @param msg the reflog message
  --  * @return 0 or an error code
  --

   function git_reflog_append
     (reflog    : access git.Low_Level.git2_types_h.git_reflog;
      id        : access constant git.Low_Level.git2_oid_h.git_oid;
      committer : access constant git.Low_Level.git2_types_h.git_signature;
      msg       : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/reflog.h:60
      with Import   => True,
      Convention    => C,
      External_Name => "git_reflog_append";

  --*
  -- * Rename a reflog
  -- *
  --  * The reflog to be renamed is expected to already exist
  --  *
  --  * The new name will be checked for validity.
  --  * See `git_reference_create_symbolic()` for rules about valid names.
  --  *
  --  * @param repo the repository
  --  * @param old_name the old name of the reference
  --  * @param name the new name of the reference
  --  * @return 0 on success, GIT_EINVALIDSPEC or an error code
  --

   function git_reflog_rename
     (repo     : access git.Low_Level.git2_types_h.git_repository;
      old_name : Interfaces.C.Strings.chars_ptr;
      name     : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/reflog.h:75
      with Import   => True,
      Convention    => C,
      External_Name => "git_reflog_rename";

  --*
  --  * Delete the reflog for the given reference
  --  *
  --  * @param repo the repository
  --  * @param name the reflog to delete
  --  * @return 0 or an error code
  --

   function git_reflog_delete (repo : access git.Low_Level.git2_types_h.git_repository; name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/reflog.h:84
      with Import   => True,
      Convention    => C,
      External_Name => "git_reflog_delete";

  --*
  --  * Get the number of log entries in a reflog
  --  *
  --  * @param reflog the previously loaded reflog
  --  * @return the number of log entries
  --

   function git_reflog_entrycount (reflog : access git.Low_Level.git2_types_h.git_reflog) return unsigned_long  -- /usr/include/git2/reflog.h:92
      with Import   => True,
      Convention    => C,
      External_Name => "git_reflog_entrycount";

  --*
  --  * Lookup an entry by its index
  --  *
  --  * Requesting the reflog entry with an index of 0 (zero) will
  --  * return the most recently created entry.
  --  *
  --  * @param reflog a previously loaded reflog
  --  * @param idx the position of the entry to lookup. Should be greater than or
  --  * equal to 0 (zero) and less than `git_reflog_entrycount()`.
  --  * @return the entry; NULL if not found
  --

   function git_reflog_entry_byindex (reflog : access constant git.Low_Level.git2_types_h.git_reflog; idx : unsigned_long) return access constant git.Low_Level.git2_types_h.git_reflog_entry  -- /usr/include/git2/reflog.h:105
     with Import    => True,
      Convention    => C,
      External_Name => "git_reflog_entry_byindex";

  --*
  --  * Remove an entry from the reflog by its index
  --  *
  --  * To ensure there's no gap in the log history, set `rewrite_previous_entry`
  --  * param value to 1. When deleting entry `n`, member old_oid of entry `n-1`
  --  * (if any) will be updated with the value of member new_oid of entry `n+1`.
  --  *
  --  * @param reflog a previously loaded reflog.
  --  *
  --  * @param idx the position of the entry to remove. Should be greater than or
  --  * equal to 0 (zero) and less than `git_reflog_entrycount()`.
  --  *
  --  * @param rewrite_previous_entry 1 to rewrite the history; 0 otherwise.
  --  *
  --  * @return 0 on success, GIT_ENOTFOUND if the entry doesn't exist
  --  * or an error code.
  --

   function git_reflog_drop
     (reflog                 : access git.Low_Level.git2_types_h.git_reflog;
      idx                    : unsigned_long;
      rewrite_previous_entry : int) return int  -- /usr/include/git2/reflog.h:124
      with Import   => True,
      Convention    => C,
      External_Name => "git_reflog_drop";

  --*
  -- * Get the old oid
  -- *
  --  * @param entry a reflog entry
  --  * @return the old oid
  --

   function git_reflog_entry_id_old (c_entry : access constant git.Low_Level.git2_types_h.git_reflog_entry) return access constant git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/reflog.h:135
     with Import    => True,
      Convention    => C,
      External_Name => "git_reflog_entry_id_old";

  --*
  -- * Get the new oid
  -- *
  --  * @param entry a reflog entry
  --  * @return the new oid at this time
  --

   function git_reflog_entry_id_new (c_entry : access constant git.Low_Level.git2_types_h.git_reflog_entry) return access constant git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/reflog.h:143
     with Import    => True,
      Convention    => C,
      External_Name => "git_reflog_entry_id_new";

  --*
  --  * Get the committer of this entry
  --  *
  --  * @param entry a reflog entry
  --  * @return the committer
  --

   function git_reflog_entry_committer (c_entry : access constant git.Low_Level.git2_types_h.git_reflog_entry) return access constant git.Low_Level.git2_types_h.git_signature  -- /usr/include/git2/reflog.h:151
     with Import    => True,
      Convention    => C,
      External_Name => "git_reflog_entry_committer";

  --*
  -- * Get the log message
  -- *
  --  * @param entry a reflog entry
  --  * @return the log msg
  --

   function git_reflog_entry_message (c_entry : access constant git.Low_Level.git2_types_h.git_reflog_entry) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/reflog.h:159
     with Import    => True,
      Convention    => C,
      External_Name => "git_reflog_entry_message";

  --*
  -- * Free the reflog
  -- *
  --  * @param reflog reflog to free
  --

   procedure git_reflog_free (reflog : access git.Low_Level.git2_types_h.git_reflog)  -- /usr/include/git2/reflog.h:166
        with Import => True,
      Convention    => C,
      External_Name => "git_reflog_free";

  --* @}
end git.Low_Level.git2_reflog_h;

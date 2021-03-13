pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
limited with git.Low_Level.git2_oid_h;
with System;
limited with git.Low_Level.git2_types_h;
with Interfaces.C.Strings;
limited with git.Low_Level.git2_buffer_h;

package git.Low_Level.git2_notes_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/notes.h
  --  * @brief Git notes management routines
  --  * @defgroup git_note Git notes management routines
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Callback for git_note_foreach.
  --  *
  --  * Receives:
  --  * - blob_id: Oid of the blob containing the message
  --  * - annotated_object_id: Oid of the git object being annotated
  --  * - payload: Payload data passed to `git_note_foreach`
  --

   type git_note_foreach_cb is access function
     (arg1 : access constant git.Low_Level.git2_oid_h.git_oid;
      arg2 : access constant git.Low_Level.git2_oid_h.git_oid;
      arg3 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/notes.h:29

  --*
  -- * note iterator
  --

   type git_iterator is null record;   -- incomplete struct

   subtype git_note_iterator is git_iterator;  -- /usr/include/git2/notes.h:35

  --*
  --  * Creates a new iterator for notes
  --  *
  --  * The iterator must be freed manually by the user.
  --  *
  --  * @param out pointer to the iterator
  --  * @param repo repository where to look up the note
  --  * @param notes_ref canonical name of the reference to use (optional); defaults to
  --  *                  "refs/notes/commits"
  --  *
  --  * @return 0 or an error code
  --

   function git_note_iterator_new
     (c_out     : System.Address;
      repo      : access git.Low_Level.git2_types_h.git_repository;
      notes_ref : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/notes.h:49
      with Import   => True,
      Convention    => C,
      External_Name => "git_note_iterator_new";

  --*
  --  * Creates a new iterator for notes from a commit
  --  *
  --  * The iterator must be freed manually by the user.
  --  *
  --  * @param out pointer to the iterator
  --  * @param notes_commit a pointer to the notes commit object
  --  *
  --  * @return 0 or an error code
  --

   function git_note_commit_iterator_new (c_out : System.Address; notes_commit : access git.Low_Level.git2_types_h.git_commit) return int  -- /usr/include/git2/notes.h:64
      with Import   => True,
      Convention    => C,
      External_Name => "git_note_commit_iterator_new";

  --*
  --  * Frees an git_note_iterator
  --  *
  --  * @param it pointer to the iterator
  --

   procedure git_note_iterator_free (it : access git_note_iterator)  -- /usr/include/git2/notes.h:73
     with Import    => True,
      Convention    => C,
      External_Name => "git_note_iterator_free";

  --*
  --  * Return the current item (note_id and annotated_id) and advance the iterator
  --  * internally to the next value
  --  *
  --  * @param note_id id of blob containing the message
  --  * @param annotated_id id of the git object being annotated
  --  * @param it pointer to the iterator
  --  *
  --  * @return 0 (no error), GIT_ITEROVER (iteration is done) or an error code
  --  *         (negative value)
  --

   function git_note_next
     (note_id      : access git.Low_Level.git2_oid_h.git_oid;
      annotated_id : access git.Low_Level.git2_oid_h.git_oid;
      it           : access git_note_iterator) return int  -- /usr/include/git2/notes.h:86
      with Import   => True,
      Convention    => C,
      External_Name => "git_note_next";

  --*
  --  * Read the note for an object
  --  *
  --  * The note must be freed manually by the user.
  --  *
  --  * @param out pointer to the read note; NULL in case of error
  --  * @param repo repository where to look up the note
  --  * @param notes_ref canonical name of the reference to use (optional); defaults to
  --  *                  "refs/notes/commits"
  --  * @param oid OID of the git object to read the note from
  --  *
  --  * @return 0 or an error code
  --

   function git_note_read
     (c_out     : System.Address;
      repo      : access git.Low_Level.git2_types_h.git_repository;
      notes_ref : Interfaces.C.Strings.chars_ptr;
      oid       : access constant git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/notes.h:105
      with Import   => True,
      Convention    => C,
      External_Name => "git_note_read";

  --*
  --  * Read the note for an object from a note commit
  --  *
  --  * The note must be freed manually by the user.
  --  *
  --  * @param out pointer to the read note; NULL in case of error
  --  * @param repo repository where to look up the note
  --  * @param notes_commit a pointer to the notes commit object
  --  * @param oid OID of the git object to read the note from
  --  *
  --  * @return 0 or an error code
  --

   function git_note_commit_read
     (c_out        : System.Address;
      repo         : access git.Low_Level.git2_types_h.git_repository;
      notes_commit : access git.Low_Level.git2_types_h.git_commit;
      oid          : access constant git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/notes.h:124
      with Import   => True,
      Convention    => C,
      External_Name => "git_note_commit_read";

  --*
  -- * Get the note author
  -- *
  -- * @param note the note
  -- * @return the author
  --

   function git_note_author (note : access constant git.Low_Level.git2_types_h.git_note) return access constant git.Low_Level.git2_types_h.git_signature  -- /usr/include/git2/notes.h:136
     with Import    => True,
      Convention    => C,
      External_Name => "git_note_author";

  --*
  -- * Get the note committer
  -- *
  -- * @param note the note
  -- * @return the committer
  --

   function git_note_committer (note : access constant git.Low_Level.git2_types_h.git_note) return access constant git.Low_Level.git2_types_h.git_signature  -- /usr/include/git2/notes.h:144
     with Import    => True,
      Convention    => C,
      External_Name => "git_note_committer";

  --*
  -- * Get the note message
  -- *
  -- * @param note the note
  -- * @return the note message
  --

   function git_note_message (note : access constant git.Low_Level.git2_types_h.git_note) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/notes.h:153
     with Import    => True,
      Convention    => C,
      External_Name => "git_note_message";

  --*
  -- * Get the note object's id
  -- *
  -- * @param note the note
  --  * @return the note object's id
  --

   function git_note_id (note : access constant git.Low_Level.git2_types_h.git_note) return access constant git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/notes.h:162
     with Import    => True,
      Convention    => C,
      External_Name => "git_note_id";

  --*
  -- * Add a note for an object
  -- *
  --  * @param out pointer to store the OID (optional); NULL in case of error
  --  * @param repo repository where to store the note
  --  * @param notes_ref canonical name of the reference to use (optional);
  --  *                                  defaults to "refs/notes/commits"
  --  * @param author signature of the notes commit author
  --  * @param committer signature of the notes commit committer
  --  * @param oid OID of the git object to decorate
  --  * @param note Content of the note to add for object oid
  --  * @param force Overwrite existing note
  --  *
  --  * @return 0 or an error code
  --

   function git_note_create
     (c_out     : access git.Low_Level.git2_oid_h.git_oid;
      repo      : access git.Low_Level.git2_types_h.git_repository;
      notes_ref : Interfaces.C.Strings.chars_ptr;
      author    : access constant git.Low_Level.git2_types_h.git_signature;
      committer : access constant git.Low_Level.git2_types_h.git_signature;
      oid       : access constant git.Low_Level.git2_oid_h.git_oid;
      note      : Interfaces.C.Strings.chars_ptr;
      force     : int) return int  -- /usr/include/git2/notes.h:179
      with Import   => True,
      Convention    => C,
      External_Name => "git_note_create";

  --*
  --  * Add a note for an object from a commit
  --  *
  --  * This function will create a notes commit for a given object,
  --  * the commit is a dangling commit, no reference is created.
  --  *
  --  * @param notes_commit_out pointer to store the commit (optional);
  --  *                                  NULL in case of error
  --  * @param notes_blob_out a point to the id of a note blob (optional)
  --  * @param repo repository where the note will live
  --  * @param parent Pointer to parent note
  --  *                                  or NULL if this shall start a new notes tree
  --  * @param author signature of the notes commit author
  --  * @param committer signature of the notes commit committer
  --  * @param oid OID of the git object to decorate
  --  * @param note Content of the note to add for object oid
  --  * @param allow_note_overwrite Overwrite existing note
  --  *
  --  * @return 0 or an error code
  --

   function git_note_commit_create
     (notes_commit_out     : access git.Low_Level.git2_oid_h.git_oid;
      notes_blob_out       : access git.Low_Level.git2_oid_h.git_oid;
      repo                 : access git.Low_Level.git2_types_h.git_repository;
      parent               : access git.Low_Level.git2_types_h.git_commit;
      author               : access constant git.Low_Level.git2_types_h.git_signature;
      committer            : access constant git.Low_Level.git2_types_h.git_signature;
      oid                  : access constant git.Low_Level.git2_oid_h.git_oid;
      note                 : Interfaces.C.Strings.chars_ptr;
      allow_note_overwrite : int) return int  -- /usr/include/git2/notes.h:209
      with Import   => True,
      Convention    => C,
      External_Name => "git_note_commit_create";

  --*
  --  * Remove the note for an object
  --  *
  --  * @param repo repository where the note lives
  --  * @param notes_ref canonical name of the reference to use (optional);
  --  *                                  defaults to "refs/notes/commits"
  --  * @param author signature of the notes commit author
  --  * @param committer signature of the notes commit committer
  --  * @param oid OID of the git object to remove the note from
  --  *
  --  * @return 0 or an error code
  --

   function git_note_remove
     (repo      : access git.Low_Level.git2_types_h.git_repository;
      notes_ref : Interfaces.C.Strings.chars_ptr;
      author    : access constant git.Low_Level.git2_types_h.git_signature;
      committer : access constant git.Low_Level.git2_types_h.git_signature;
      oid       : access constant git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/notes.h:232
      with Import   => True,
      Convention    => C,
      External_Name => "git_note_remove";

  --*
  --  * Remove the note for an object
  --  *
  --  * @param notes_commit_out pointer to store the new notes commit (optional);
  --  *                                  NULL in case of error.
  --  *                                  When removing a note a new tree containing all notes
  --  *                                  sans the note to be removed is created and a new commit
  --  *                                  pointing to that tree is also created.
  --  *                                  In the case where the resulting tree is an empty tree
  --  *                                  a new commit pointing to this empty tree will be returned.
  --  * @param repo repository where the note lives
  --  * @param notes_commit a pointer to the notes commit object
  --  * @param author signature of the notes commit author
  --  * @param committer signature of the notes commit committer
  --  * @param oid OID of the git object to remove the note from
  --  *
  --  * @return 0 or an error code
  --

   function git_note_commit_remove
     (notes_commit_out : access git.Low_Level.git2_oid_h.git_oid;
      repo             : access git.Low_Level.git2_types_h.git_repository;
      notes_commit     : access git.Low_Level.git2_types_h.git_commit;
      author           : access constant git.Low_Level.git2_types_h.git_signature;
      committer        : access constant git.Low_Level.git2_types_h.git_signature;
      oid              : access constant git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/notes.h:257
      with Import   => True,
      Convention    => C,
      External_Name => "git_note_commit_remove";

  --*
  -- * Free a git_note object
  -- *
  --  * @param note git_note object
  --

   procedure git_note_free (note : access git.Low_Level.git2_types_h.git_note)  -- /usr/include/git2/notes.h:270
        with Import => True,
      Convention    => C,
      External_Name => "git_note_free";

  --*
  --  * Get the default notes reference for a repository
  --  *
  --  * @param out buffer in which to store the name of the default notes reference
  --  * @param repo The Git repository
  --  *
  --  * @return 0 or an error code
  --

   function git_note_default_ref (c_out : access git.Low_Level.git2_buffer_h.git_buf; repo : access git.Low_Level.git2_types_h.git_repository) return int  -- /usr/include/git2/notes.h:280
      with Import   => True,
      Convention    => C,
      External_Name => "git_note_default_ref";

  --*
  --  * Loop over all the notes within a specified namespace
  --  * and issue a callback for each one.
  --  *
  --  * @param repo Repository where to find the notes.
  --  *
  --  * @param notes_ref Reference to read from (optional); defaults to
  --  *        "refs/notes/commits".
  --  *
  --  * @param note_cb Callback to invoke per found annotation.  Return non-zero
  --  *        to stop looping.
  --  *
  --  * @param payload Extra parameter to callback function.
  --  *
  --  * @return 0 on success, non-zero callback return value, or error code
  --

   function git_note_foreach
     (repo      : access git.Low_Level.git2_types_h.git_repository;
      notes_ref : Interfaces.C.Strings.chars_ptr;
      note_cb   : git_note_foreach_cb;
      payload   : System.Address) return int  -- /usr/include/git2/notes.h:298
      with Import   => True,
      Convention    => C,
      External_Name => "git_note_foreach";

  --* @}
end git.Low_Level.git2_notes_h;

pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with git.Low_Level.git2_merge_h;
with git.Low_Level.git2_checkout_h;
with git.Low_Level.git2_commit_h;
with System;
with git.Low_Level.git2_oid_h;
limited with git.Low_Level.git2_types_h;


package git.Low_Level.git2_rebase_h is

   GIT_REBASE_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/rebase.h:134
   --  unsupported macro: GIT_REBASE_OPTIONS_INIT { GIT_REBASE_OPTIONS_VERSION, 0, 0, NULL, GIT_MERGE_OPTIONS_INIT, GIT_CHECKOUT_OPTIONS_INIT, NULL, NULL }
   --  unsupported macro: GIT_REBASE_NO_OPERATION SIZE_MAX

   --  * Copyright (C) the libgit2 contributors. All rights reserved.
   --  *
   --  * This file is part of libgit2, distributed under the GNU GPL v2 with
   --  * a Linking Exception. For full terms see the included COPYING file.
  --

   --*
  -- * @file git2/rebase.h
  --  * @brief Git rebase routines
  --  * @defgroup git_rebase Git merge routines
  --  * @ingroup Git
  --  * @{
  --

   --*
  -- * Rebase options
  -- *
  --  * Use to tell the rebase machinery how to operate.
  --

   --  skipped anonymous struct anon_anon_108

   type git_rebase_options is record
      version           : aliased unsigned;  -- /usr/include/git2/rebase.h:33
      quiet             : aliased int;  -- /usr/include/git2/rebase.h:42
      inmemory          : aliased int;  -- /usr/include/git2/rebase.h:51
      rewrite_notes_ref : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/rebase.h:61
      merge_options     : aliased git.Low_Level.git2_merge_h.git_merge_options;  -- /usr/include/git2/rebase.h:66
      checkout_options  : aliased git.Low_Level.git2_checkout_h.git_checkout_options;  -- /usr/include/git2/rebase.h:75
      signing_cb        : git.Low_Level.git2_commit_h.git_commit_signing_cb;  -- /usr/include/git2/rebase.h:84
      payload           : System.Address;  -- /usr/include/git2/rebase.h:90
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/rebase.h:91

  --*
  --     * Used by `git_rebase_init`, this will instruct other clients working
  --     * on this rebase that you want a quiet rebase experience, which they
  --     * may choose to provide in an application-specific manner.  This has no
  --     * effect upon libgit2 directly, but is provided for interoperability
  --     * between Git tools.
  --

  --*
  --     * Used by `git_rebase_init`, this will begin an in-memory rebase,
  --     * which will allow callers to step through the rebase operations and
  --     * commit the rebased changes, but will not rewind HEAD or update the
  --     * repository to be in a rebasing state.  This will not interfere with
  --     * the working directory (if there is one).
  --

  --*
  --     * Used by `git_rebase_finish`, this is the name of the notes reference
  --     * used to rewrite notes for rebased commits when finishing the rebase;
  --     * if NULL, the contents of the configuration option `notes.rewriteRef`
  --     * is examined, unless the configuration option `notes.rewrite.rebase`
  --     * is set to false.  If `notes.rewriteRef` is also NULL, notes will
  --     * not be rewritten.
  --

  --*
  --     * Options to control how trees are merged during `git_rebase_next`.
  --

  --*
  --     * Options to control how files are written during `git_rebase_init`,
  --     * `git_rebase_next` and `git_rebase_abort`.  Note that a minimum
  --     * strategy of `GIT_CHECKOUT_SAFE` is defaulted in `init` and `next`,
  --     * and a minimum strategy of `GIT_CHECKOUT_FORCE` is defaulted in
  --     * `abort` to match git semantics.
  --

  --*
  --     * If provided, this will be called with the commit content, allowing
  --     * a signature to be added to the rebase commit. Can be skipped with
  --     * GIT_PASSTHROUGH. If GIT_PASSTHROUGH is returned, a commit will be made
  --     * without a signature.
  --     * This field is only used when performing git_rebase_commit.
  --

  --*
  --     * This will be passed to each of the callbacks in this struct
  --     * as the last parameter.
  --

  --*
  --  * Type of rebase operation in-progress after calling `git_rebase_next`.
  --

  --*
  --     * The given commit is to be cherry-picked.  The client should commit
  --     * the changes and continue if there are no conflicts.
  --

  --*
  --     * The given commit is to be cherry-picked, but the client should prompt
  --     * the user to provide an updated commit message.
  --

  --*
  --     * The given commit is to be cherry-picked, but the client should stop
  --     * to allow the user to edit the changes before committing them.
  --

  --*
  --     * The given commit is to be squashed into the previous commit.  The
  --     * commit message will be merged with the previous message.
  --

  --*
  --     * The given commit is to be squashed into the previous commit.  The
  --     * commit message from this commit will be discarded.
  --

  --*
  --     * No commit will be cherry-picked.  The client should run the given
  --     * command and (if successful) continue.
  --

   type git_rebase_operation_t is
     (GIT_REBASE_OPERATION_PICK,
      GIT_REBASE_OPERATION_REWORD,
      GIT_REBASE_OPERATION_EDIT,
      GIT_REBASE_OPERATION_SQUASH,
      GIT_REBASE_OPERATION_FIXUP,
      GIT_REBASE_OPERATION_EXEC)
      with Convention => C;  -- /usr/include/git2/rebase.h:132

  --* Indicates that a rebase operation is not (yet) in progress.
  --*
  -- * A rebase operation
  -- *
  --  * Describes a single instruction/operation to be performed during the
  --  * rebase.
  --

  --* The type of rebase operation.
   --  skipped anonymous struct anon_anon_110

   type git_rebase_operation is record
      c_type : aliased git_rebase_operation_t;  -- /usr/include/git2/rebase.h:150
      id     : aliased git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/rebase.h:156
      exec   : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/rebase.h:162
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/rebase.h:163

  --*
  --     * The commit ID being cherry-picked.  This will be populated for
  --     * all operations except those of type `GIT_REBASE_OPERATION_EXEC`.
  --

  --*
  --     * The executable the user has requested be run.  This will only
  --     * be populated for operations of type `GIT_REBASE_OPERATION_EXEC`.
  --

  --*
  --  * Initialize git_rebase_options structure
  --  *
  --  * Initializes a `git_rebase_options` with default values. Equivalent to
  --  * creating an instance with `GIT_REBASE_OPTIONS_INIT`.
  --  *
  --  * @param opts The `git_rebase_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_REBASE_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_rebase_options_init (opts : access git_rebase_options; version : unsigned) return int  -- /usr/include/git2/rebase.h:175
      with Import   => True,
      Convention    => C,
      External_Name => "git_rebase_options_init";

  --*
  --  * Initializes a rebase operation to rebase the changes in `branch`
  --  * relative to `upstream` onto another branch.  To begin the rebase
  --  * process, call `git_rebase_next`.  When you have finished with this
  --  * object, call `git_rebase_free`.
  --  *
  --  * @param out Pointer to store the rebase object
  --  * @param repo The repository to perform the rebase
  --  * @param branch The terminal commit to rebase, or NULL to rebase the
  --  *               current branch
  --  * @param upstream The commit to begin rebasing from, or NULL to rebase all
  --  *                 reachable commits
  --  * @param onto The branch to rebase onto, or NULL to rebase onto the given
  --  *             upstream
  --  * @param opts Options to specify how rebase is performed, or NULL
  --  * @return Zero on success; -1 on failure.
  --

   function git_rebase_init
     (c_out    : System.Address;
      repo     : access git.Low_Level.git2_types_h.git_repository;
      branch   : access constant git.Low_Level.git2_types_h.git_annotated_commit;
      upstream : access constant git.Low_Level.git2_types_h.git_annotated_commit;
      onto     : access constant git.Low_Level.git2_types_h.git_annotated_commit;
      opts     : access constant git_rebase_options) return int  -- /usr/include/git2/rebase.h:196
      with Import   => True,
      Convention    => C,
      External_Name => "git_rebase_init";

  --*
  --  * Opens an existing rebase that was previously started by either an
  --  * invocation of `git_rebase_init` or by another client.
  --  *
  --  * @param out Pointer to store the rebase object
  --  * @param repo The repository that has a rebase in-progress
  --  * @param opts Options to specify how rebase is performed
  --  * @return Zero on success; -1 on failure.
  --

   function git_rebase_open
     (c_out : System.Address;
      repo  : access git.Low_Level.git2_types_h.git_repository;
      opts  : access constant git_rebase_options) return int  -- /usr/include/git2/rebase.h:213
      with Import   => True,
      Convention    => C,
      External_Name => "git_rebase_open";

  --*
  --  * Gets the original `HEAD` ref name for merge rebases.
  --  *
  --  * @return The original `HEAD` ref name
  --

   function git_rebase_orig_head_name (rebase : access git.Low_Level.git2_types_h.git_rebase) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/rebase.h:223
     with Import    => True,
      Convention    => C,
      External_Name => "git_rebase_orig_head_name";

  --*
  --  * Gets the original `HEAD` id for merge rebases.
  --  *
  --  * @return The original `HEAD` id
  --

   function git_rebase_orig_head_id (rebase : access git.Low_Level.git2_types_h.git_rebase) return access constant git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/rebase.h:230
     with Import    => True,
      Convention    => C,
      External_Name => "git_rebase_orig_head_id";

  --*
  --  * Gets the `onto` ref name for merge rebases.
  --  *
  --  * @return The `onto` ref name
  --

   function git_rebase_onto_name (rebase : access git.Low_Level.git2_types_h.git_rebase) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/rebase.h:237
     with Import    => True,
      Convention    => C,
      External_Name => "git_rebase_onto_name";

  --*
  --  * Gets the `onto` id for merge rebases.
  --  *
  --  * @return The `onto` id
  --

   function git_rebase_onto_id (rebase : access git.Low_Level.git2_types_h.git_rebase) return access constant git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/rebase.h:244
     with Import    => True,
      Convention    => C,
      External_Name => "git_rebase_onto_id";

  --*
  --  * Gets the count of rebase operations that are to be applied.
  --  *
  --  * @param rebase The in-progress rebase
  --  * @return The number of rebase operations in total
  --

   function git_rebase_operation_entrycount (rebase : access git.Low_Level.git2_types_h.git_rebase) return unsigned_long  -- /usr/include/git2/rebase.h:252
      with Import   => True,
      Convention    => C,
      External_Name => "git_rebase_operation_entrycount";

  --*
  --  * Gets the index of the rebase operation that is currently being applied.
  --  * If the first operation has not yet been applied (because you have
  --  * called `init` but not yet `next`) then this returns
  --  * `GIT_REBASE_NO_OPERATION`.
  --  *
  --  * @param rebase The in-progress rebase
  --  * @return The index of the rebase operation currently being applied.
  --

   function git_rebase_operation_current (rebase : access git.Low_Level.git2_types_h.git_rebase) return unsigned_long  -- /usr/include/git2/rebase.h:263
      with Import   => True,
      Convention    => C,
      External_Name => "git_rebase_operation_current";

  --*
  --  * Gets the rebase operation specified by the given index.
  --  *
  --  * @param rebase The in-progress rebase
  --  * @param idx The index of the rebase operation to retrieve
  --  * @return The rebase operation or NULL if `idx` was out of bounds
  --

   function git_rebase_operation_byindex (rebase : access git.Low_Level.git2_types_h.git_rebase; idx : unsigned_long) return access git_rebase_operation  -- /usr/include/git2/rebase.h:272
      with Import   => True,
      Convention    => C,
      External_Name => "git_rebase_operation_byindex";

  --*
  --  * Performs the next rebase operation and returns the information about it.
  --  * If the operation is one that applies a patch (which is any operation except
  --  * GIT_REBASE_OPERATION_EXEC) then the patch will be applied and the index and
  --  * working directory will be updated with the changes.  If there are conflicts,
  --  * you will need to address those before committing the changes.
  --  *
  --  * @param operation Pointer to store the rebase operation that is to be performed next
  --  * @param rebase The rebase in progress
  --  * @return Zero on success; -1 on failure.
  --

   function git_rebase_next (operation : System.Address; rebase : access git.Low_Level.git2_types_h.git_rebase) return int  -- /usr/include/git2/rebase.h:287
      with Import   => True,
      Convention    => C,
      External_Name => "git_rebase_next";

  --*
  --  * Gets the index produced by the last operation, which is the result
  --  * of `git_rebase_next` and which will be committed by the next
  --  * invocation of `git_rebase_commit`.  This is useful for resolving
  --  * conflicts in an in-memory rebase before committing them.  You must
  --  * call `git_index_free` when you are finished with this.
  --  *
  --  * This is only applicable for in-memory rebases; for rebases within
  --  * a working directory, the changes were applied to the repository's
  --  * index.
  --

   function git_rebase_inmemory_index (index : System.Address; rebase : access git.Low_Level.git2_types_h.git_rebase) return int  -- /usr/include/git2/rebase.h:302
      with Import   => True,
      Convention    => C,
      External_Name => "git_rebase_inmemory_index";

  --*
  --  * Commits the current patch.  You must have resolved any conflicts that
  --  * were introduced during the patch application from the `git_rebase_next`
  --  * invocation.
  --  *
  --  * @param id Pointer in which to store the OID of the newly created commit
  --  * @param rebase The rebase that is in-progress
  --  * @param author The author of the updated commit, or NULL to keep the
  --  *        author from the original commit
  --  * @param committer The committer of the rebase
  --  * @param message_encoding The encoding for the message in the commit,
  --  *        represented with a standard encoding name.  If message is NULL,
  --  *        this should also be NULL, and the encoding from the original
  --  *        commit will be maintained.  If message is specified, this may be
  --  *        NULL to indicate that "UTF-8" is to be used.
  --  * @param message The message for this commit, or NULL to use the message
  --  *        from the original commit.
  --  * @return Zero on success, GIT_EUNMERGED if there are unmerged changes in
  --  *        the index, GIT_EAPPLIED if the current commit has already
  --  *        been applied to the upstream and there is nothing to commit,
  --  *        -1 on failure.
  --

   function git_rebase_commit
     (id               : access git.Low_Level.git2_oid_h.git_oid;
      rebase           : access git.Low_Level.git2_types_h.git_rebase;
      author           : access constant git.Low_Level.git2_types_h.git_signature;
      committer        : access constant git.Low_Level.git2_types_h.git_signature;
      message_encoding : Interfaces.C.Strings.chars_ptr;
      message          : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/rebase.h:328
      with Import   => True,
      Convention    => C,
      External_Name => "git_rebase_commit";

  --*
  --  * Aborts a rebase that is currently in progress, resetting the repository
  --  * and working directory to their state before rebase began.
  --  *
  --  * @param rebase The rebase that is in-progress
  --  * @return Zero on success; GIT_ENOTFOUND if a rebase is not in progress,
  --  *         -1 on other errors.
  --

   function git_rebase_abort (rebase : access git.Low_Level.git2_types_h.git_rebase) return int  -- /usr/include/git2/rebase.h:344
      with Import   => True,
      Convention    => C,
      External_Name => "git_rebase_abort";

  --*
  --  * Finishes a rebase that is currently in progress once all patches have
  --  * been applied.
  --  *
  --  * @param rebase The rebase that is in-progress
  --  * @param signature The identity that is finishing the rebase (optional)
  --  * @return Zero on success; -1 on error
  --

   function git_rebase_finish (rebase : access git.Low_Level.git2_types_h.git_rebase; signature : access constant git.Low_Level.git2_types_h.git_signature) return int  -- /usr/include/git2/rebase.h:354
      with Import   => True,
      Convention    => C,
      External_Name => "git_rebase_finish";

  --*
  --  * Frees the `git_rebase` object.
  --  *
  --  * @param rebase The rebase object
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

   procedure git_rebase_free (rebase : access git.Low_Level.git2_types_h.git_rebase)  -- /usr/include/git2/rebase.h:363
        with Import => True,
      Convention    => C,
      External_Name => "git_rebase_free";

end git.Low_Level.git2_rebase_h;

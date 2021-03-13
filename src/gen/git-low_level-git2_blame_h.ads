pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;

with git.Low_Level.git2_oid_h;

limited with git.Low_Level.git2_types_h;
with Interfaces.C.Strings;
with System;

package git.Low_Level.git2_blame_h is

   GIT_BLAME_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/blame.h:90
   --  unsupported macro: GIT_BLAME_OPTIONS_INIT {GIT_BLAME_OPTIONS_VERSION}

   --  * Copyright (C) the libgit2 contributors. All rights reserved.
   --  *
   --  * This file is part of libgit2, distributed under the GNU GPL v2 with
   --  * a Linking Exception. For full terms see the included COPYING file.
  --

   --*
  -- * @file git2/blame.h
  --  * @brief Git blame routines
  --  * @defgroup git_blame Git blame routines
  --  * @ingroup Git
  --  * @{
  --

   --*
  --  * Flags for indicating option behavior for git_blame APIs.
  --

   --* Normal blame, the default
  --* Track lines that have moved within a file (like `git blame -M`).
  --     * NOT IMPLEMENTED.

   --* Track lines that have moved across files in the same commit (like `git blame -C`).
  --     * NOT IMPLEMENTED.

   --* Track lines that have been copied from another file that exists in the
  --     * same commit (like `git blame -CC`). Implies SAME_FILE.
  --     * NOT IMPLEMENTED.

   --* Track lines that have been copied from another file that exists in *any*
  --     * commit (like `git blame -CCC`). Implies SAME_COMMIT_COPIES.
  --     * NOT IMPLEMENTED.

   --* Restrict the search of commits to those reachable following only the
  --     * first parents.

   --* Use mailmap file to map author and committer names and email addresses
  --     * to canonical real names and email addresses. The mailmap will be read
  --     * from the working directory, or HEAD in a bare repository.

   subtype git_blame_flag_t is unsigned;
   GIT_BLAME_NORMAL                          : constant unsigned := 0;
   GIT_BLAME_TRACK_COPIES_SAME_FILE          : constant unsigned := 1;
   GIT_BLAME_TRACK_COPIES_SAME_COMMIT_MOVES  : constant unsigned := 2;
   GIT_BLAME_TRACK_COPIES_SAME_COMMIT_COPIES : constant unsigned := 4;
   GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES  : constant unsigned := 8;
   GIT_BLAME_FIRST_PARENT                    : constant unsigned := 16;
   GIT_BLAME_USE_MAILMAP                     : constant unsigned := 32;  -- /usr/include/git2/blame.h:50

  --*
  -- * Blame options structure
  -- *
  --  * Initialize with `GIT_BLAME_OPTIONS_INIT`. Alternatively, you can
  --  * use `git_blame_options_init`.
  --  *
  --

   type git_blame_options is record
      version              : aliased unsigned;  -- /usr/include/git2/blame.h:60
      flags                : aliased unsigned;  -- /usr/include/git2/blame.h:63
      min_match_characters : aliased unsigned_short;  -- /usr/include/git2/blame.h:70
      newest_commit        : aliased git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/blame.h:72
      oldest_commit        : aliased git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/blame.h:77
      min_line             : aliased unsigned_long;  -- /usr/include/git2/blame.h:82
      max_line             : aliased unsigned_long;  -- /usr/include/git2/blame.h:87
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/blame.h:59

  --* A combination of `git_blame_flag_t`
  --* The lower bound on the number of alphanumeric
  --     *   characters that must be detected as moving/copying within a file for it to
  --     *   associate those lines with the parent commit. The default value is 20.
  --     *   This value only takes effect if any of the `GIT_BLAME_TRACK_COPIES_*`
  --     *   flags are specified.
  --

  --* The id of the newest commit to consider. The default is HEAD.
  --*
  --     * The id of the oldest commit to consider.
  --     * The default is the first commit encountered with a NULL parent.
  --

  --*
  --     * The first line in the file to blame.
  --     * The default is 1 (line numbers start with 1).
  --

  --*
  --     * The last line in the file to blame.
  --     * The default is the last line of the file.
  --

  --*
  --  * Initialize git_blame_options structure
  --  *
  --  * Initializes a `git_blame_options` with default values. Equivalent to creating
  --  * an instance with GIT_BLAME_OPTIONS_INIT.
  --  *
  --  * @param opts The `git_blame_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_BLAME_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_blame_options_init (opts : access git_blame_options; version : unsigned) return int  -- /usr/include/git2/blame.h:103
      with Import   => True,
      Convention    => C,
      External_Name => "git_blame_options_init";

  --*
  --  * Structure that represents a blame hunk.
  --  *
  --  * - `lines_in_hunk` is the number of lines in this hunk
  --  * - `final_commit_id` is the OID of the commit where this line was last
  --  *   changed.
  --  * - `final_start_line_number` is the 1-based line number where this hunk
  --  *   begins, in the final version of the file
  --  * - `final_signature` is the author of `final_commit_id`. If
  --  *   `GIT_BLAME_USE_MAILMAP` has been specified, it will contain the canonical
  --  *    real name and email address.
  --  * - `orig_commit_id` is the OID of the commit where this hunk was found.  This
  --  *   will usually be the same as `final_commit_id`, except when
  --  *   `GIT_BLAME_TRACK_COPIES_ANY_COMMIT_COPIES` has been specified.
  --  * - `orig_path` is the path to the file where this hunk originated, as of the
  --  *   commit specified by `orig_commit_id`.
  --  * - `orig_start_line_number` is the 1-based line number where this hunk begins
  --  *   in the file named by `orig_path` in the commit specified by
  --  *   `orig_commit_id`.
  --  * - `orig_signature` is the author of `orig_commit_id`. If
  --  *   `GIT_BLAME_USE_MAILMAP` has been specified, it will contain the canonical
  --  *    real name and email address.
  --  * - `boundary` is 1 iff the hunk has been tracked to a boundary commit (the
  --  *   root, or the commit specified in git_blame_options.oldest_commit)
  --

   type git_blame_hunk is record
      lines_in_hunk           : aliased unsigned_long;  -- /usr/include/git2/blame.h:133
      final_commit_id         : aliased git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/blame.h:135
      final_start_line_number : aliased unsigned_long;  -- /usr/include/git2/blame.h:136
      final_signature         : access git.Low_Level.git2_types_h.git_signature;  -- /usr/include/git2/blame.h:137
      orig_commit_id          : aliased git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/blame.h:139
      orig_path               : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/blame.h:140
      orig_start_line_number  : aliased unsigned_long;  -- /usr/include/git2/blame.h:141
      orig_signature          : access git.Low_Level.git2_types_h.git_signature;  -- /usr/include/git2/blame.h:142
      boundary                : aliased char;  -- /usr/include/git2/blame.h:144
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/blame.h:132

  --* Opaque structure to hold blame results
   type git_blame is null record;   -- incomplete struct

  --*
  --  * Gets the number of hunks that exist in the blame structure.
  --

   function git_blame_get_hunk_count (blame : access git_blame) return unsigned  -- /usr/include/git2/blame.h:154
      with Import   => True,
      Convention    => C,
      External_Name => "git_blame_get_hunk_count";

  --*
  --  * Gets the blame hunk at the given index.
  --  *
  --  * @param blame the blame structure to query
  --  * @param index index of the hunk to retrieve
  --  * @return the hunk at the given index, or NULL on error
  --

   function git_blame_get_hunk_byindex (blame : access git_blame; index : unsigned) return access constant git_blame_hunk  -- /usr/include/git2/blame.h:163
      with Import   => True,
      Convention    => C,
      External_Name => "git_blame_get_hunk_byindex";

  --*
  --  * Gets the hunk that relates to the given line number in the newest commit.
  --  *
  --  * @param blame the blame structure to query
  --  * @param lineno the (1-based) line number to find a hunk for
  --  * @return the hunk that contains the given line, or NULL on error
  --

   function git_blame_get_hunk_byline (blame : access git_blame; lineno : unsigned_long) return access constant git_blame_hunk  -- /usr/include/git2/blame.h:174
      with Import   => True,
      Convention    => C,
      External_Name => "git_blame_get_hunk_byline";

  --*
  --  * Get the blame for a single file.
  --  *
  --  * @param out pointer that will receive the blame object
  --  * @param repo repository whose history is to be walked
  --  * @param path path to file to consider
  --  * @param options options for the blame operation.  If NULL, this is treated as
  --  *                though GIT_BLAME_OPTIONS_INIT were passed.
  --  * @return 0 on success, or an error code. (use git_error_last for information
  --  *         about the error.)
  --

   function git_blame_file
     (c_out   : System.Address;
      repo    : access git.Low_Level.git2_types_h.git_repository;
      path    : Interfaces.C.Strings.chars_ptr;
      options : access git_blame_options) return int  -- /usr/include/git2/blame.h:189
      with Import   => True,
      Convention    => C,
      External_Name => "git_blame_file";

  --*
  --  * Get blame data for a file that has been modified in memory. The `reference`
  --  * parameter is a pre-calculated blame for the in-odb history of the file. This
  --  * means that once a file blame is completed (which can be expensive), updating
  --  * the buffer blame is very fast.
  --  *
  --  * Lines that differ between the buffer and the committed version are marked as
  --  * having a zero OID for their final_commit_id.
  --  *
  --  * @param out pointer that will receive the resulting blame data
  --  * @param reference cached blame from the history of the file (usually the output
  --  *                  from git_blame_file)
  --  * @param buffer the (possibly) modified contents of the file
  --  * @param buffer_len number of valid bytes in the buffer
  --  * @return 0 on success, or an error code. (use git_error_last for information
  --  *         about the error)
  --

   function git_blame_buffer
     (c_out      : System.Address;
      reference  : access git_blame;
      buffer     : Interfaces.C.Strings.chars_ptr;
      buffer_len : unsigned_long) return int  -- /usr/include/git2/blame.h:213
      with Import   => True,
      Convention    => C,
      External_Name => "git_blame_buffer";

  --*
  --  * Free memory allocated by git_blame_file or git_blame_buffer.
  --  *
  --  * @param blame the blame structure to free
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

   procedure git_blame_free (blame : access git_blame)  -- /usr/include/git2/blame.h:224
     with Import    => True,
      Convention    => C,
      External_Name => "git_blame_free";

end git.Low_Level.git2_blame_h;

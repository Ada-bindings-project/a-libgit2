pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with git.Low_Level.git2_oid_h;
with Interfaces.C.Strings;
with git.Low_Level.git2_types_h;

with System;
with git.Low_Level.git2_strarray_h;

limited with git.Low_Level.git2_buffer_h;

package git.Low_Level.git2_diff_h is

   GIT_DIFF_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/diff.h:436
   --  unsupported macro: GIT_DIFF_OPTIONS_INIT {GIT_DIFF_OPTIONS_VERSION, 0, GIT_SUBMODULE_IGNORE_UNSPECIFIED, {NULL,0}, NULL, NULL, NULL, 3}

   GIT_DIFF_HUNK_HEADER_SIZE : constant := 128;  --  /usr/include/git2/diff.h:470

   GIT_DIFF_FIND_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/diff.h:774
   --  unsupported macro: GIT_DIFF_FIND_OPTIONS_INIT {GIT_DIFF_FIND_OPTIONS_VERSION}

   GIT_DIFF_FORMAT_EMAIL_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/diff.h:1404
   --  unsupported macro: GIT_DIFF_FORMAT_EMAIL_OPTIONS_INIT {GIT_DIFF_FORMAT_EMAIL_OPTIONS_VERSION, 0, 1, 1, NULL, NULL, NULL, NULL}

   GIT_DIFF_PATCHID_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/diff.h:1468
   --  unsupported macro: GIT_DIFF_PATCHID_OPTIONS_INIT { GIT_DIFF_PATCHID_OPTIONS_VERSION }

   --  * Copyright (C) the libgit2 contributors. All rights reserved.
   --  *
   --  * This file is part of libgit2, distributed under the GNU GPL v2 with
   --  * a Linking Exception. For full terms see the included COPYING file.
  --

   --*
  -- * @file git2/diff.h
  --  * @brief Git tree and file differencing routines.
  --  * @ingroup Git
  --  * @{
  --

   --*
  --  * Flags for diff options.  A combination of these flags can be passed
  --  * in via the `flags` value in the `git_diff_options`.
  --

   --* Normal diff, the default
  --     * Options controlling which files will be in the diff
  --

   --* Reverse the sides of the diff
  --* Include ignored files in the diff
  --* Even with GIT_DIFF_INCLUDE_IGNORED, an entire ignored directory
  --     *  will be marked with only a single entry in the diff; this flag
  --     *  adds all files under the directory as IGNORED entries, too.
  --

   --* Include untracked files in the diff
  --* Even with GIT_DIFF_INCLUDE_UNTRACKED, an entire untracked
  --     *  directory will be marked with only a single entry in the diff
  --     *  (a la what core Git does in `git status`); this flag adds *all*
  --     *  files under untracked directories as UNTRACKED entries, too.
  --

   --* Include unmodified files in the diff
  --* Normally, a type change between files will be converted into a
  --     *  DELETED record for the old and an ADDED record for the new; this
  --     *  options enabled the generation of TYPECHANGE delta records.
  --

   --* Even with GIT_DIFF_INCLUDE_TYPECHANGE, blob->tree changes still
  --     *  generally show as a DELETED blob.  This flag tries to correctly
  --     *  label blob->tree transitions as TYPECHANGE records with new_file's
  --     *  mode set to tree.  Note: the tree SHA will not be available.
  --

   --* Ignore file mode changes
  --* Treat all submodules as unmodified
  --* Use case insensitive filename comparisons
  --* May be combined with `GIT_DIFF_IGNORE_CASE` to specify that a file
  --     *  that has changed case will be returned as an add/delete pair.
  --

   --* If the pathspec is set in the diff options, this flags indicates
  --     *  that the paths will be treated as literal paths instead of
  --     *  fnmatch patterns.  Each path in the list must either be a full
  --     *  path to a file or a directory.  (A trailing slash indicates that
  --     *  the path will _only_ match a directory).  If a directory is
  --     *  specified, all children will be included.
  --

   --* Disable updating of the `binary` flag in delta records.  This is
  --     *  useful when iterating over a diff if you don't need hunk and data
  --     *  callbacks and want to avoid having to load file completely.
  --

   --* When diff finds an untracked directory, to match the behavior of
  --     *  core Git, it scans the contents for IGNORED and UNTRACKED files.
  --     *  If *all* contents are IGNORED, then the directory is IGNORED; if
  --     *  any contents are not IGNORED, then the directory is UNTRACKED.
  --     *  This is extra work that may not matter in many cases.  This flag
  --     *  turns off that scan and immediately labels an untracked directory
  --     *  as UNTRACKED (changing the behavior to not match core Git).
  --

   --* When diff finds a file in the working directory with stat
  --     * information different from the index, but the OID ends up being the
  --     * same, write the correct stat information into the index.  Note:
  --     * without this flag, diff will always leave the index untouched.
  --

   --* Include unreadable files in the diff
  --* Include unreadable files in the diff
  --     * Options controlling how output will be generated
  --

   --* Use a heuristic that takes indentation and whitespace into account
  --     * which generally can produce better diffs when dealing with ambiguous
  --     * diff hunks.
  --

   --* Treat all files as text, disabling binary attributes & detection
  --* Treat all files as binary, disabling text diffs
  --* Ignore all whitespace
  --* Ignore changes in amount of whitespace
  --* Ignore whitespace at end of line
  --* When generating patch text, include the content of untracked
  --     *  files.  This automatically turns on GIT_DIFF_INCLUDE_UNTRACKED but
  --     *  it does not turn on GIT_DIFF_RECURSE_UNTRACKED_DIRS.  Add that
  --     *  flag if you want the content of every single UNTRACKED file.
  --

   --* When generating output, include the names of unmodified files if
  --     *  they are included in the git_diff.  Normally these are skipped in
  --     *  the formats that list files (e.g. name-only, name-status, raw).
  --     *  Even with this, these will not be included in patch format.
  --

   --* Use the "patience diff" algorithm
  --* Take extra time to find minimal diff
  --* Include the necessary deflate / delta information so that `git-apply`
  --     *  can apply given diff information to binary files.
  --

   subtype git_diff_option_t is unsigned;
   GIT_DIFF_NORMAL                          : constant unsigned := 0;
   GIT_DIFF_REVERSE                         : constant unsigned := 1;
   GIT_DIFF_INCLUDE_IGNORED                 : constant unsigned := 2;
   GIT_DIFF_RECURSE_IGNORED_DIRS            : constant unsigned := 4;
   GIT_DIFF_INCLUDE_UNTRACKED               : constant unsigned := 8;
   GIT_DIFF_RECURSE_UNTRACKED_DIRS          : constant unsigned := 16;
   GIT_DIFF_INCLUDE_UNMODIFIED              : constant unsigned := 32;
   GIT_DIFF_INCLUDE_TYPECHANGE              : constant unsigned := 64;
   GIT_DIFF_INCLUDE_TYPECHANGE_TREES        : constant unsigned := 128;
   GIT_DIFF_IGNORE_FILEMODE                 : constant unsigned := 256;
   GIT_DIFF_IGNORE_SUBMODULES               : constant unsigned := 512;
   GIT_DIFF_IGNORE_CASE                     : constant unsigned := 1_024;
   GIT_DIFF_INCLUDE_CASECHANGE              : constant unsigned := 2_048;
   GIT_DIFF_DISABLE_PATHSPEC_MATCH          : constant unsigned := 4_096;
   GIT_DIFF_SKIP_BINARY_CHECK               : constant unsigned := 8_192;
   GIT_DIFF_ENABLE_FAST_UNTRACKED_DIRS      : constant unsigned := 16_384;
   GIT_DIFF_UPDATE_INDEX                    : constant unsigned := 32_768;
   GIT_DIFF_INCLUDE_UNREADABLE              : constant unsigned := 65_536;
   GIT_DIFF_INCLUDE_UNREADABLE_AS_UNTRACKED : constant unsigned := 131_072;
   GIT_DIFF_INDENT_HEURISTIC                : constant unsigned := 262_144;
   GIT_DIFF_FORCE_TEXT                      : constant unsigned := 1_048_576;
   GIT_DIFF_FORCE_BINARY                    : constant unsigned := 2_097_152;
   GIT_DIFF_IGNORE_WHITESPACE               : constant unsigned := 4_194_304;
   GIT_DIFF_IGNORE_WHITESPACE_CHANGE        : constant unsigned := 8_388_608;
   GIT_DIFF_IGNORE_WHITESPACE_EOL           : constant unsigned := 16_777_216;
   GIT_DIFF_SHOW_UNTRACKED_CONTENT          : constant unsigned := 33_554_432;
   GIT_DIFF_SHOW_UNMODIFIED                 : constant unsigned := 67_108_864;
   GIT_DIFF_PATIENCE                        : constant unsigned := 268_435_456;
   GIT_DIFF_MINIMAL                         : constant unsigned := 536_870_912;
   GIT_DIFF_SHOW_BINARY                     : constant unsigned := 1_073_741_824;  -- /usr/include/git2/diff.h:171

  --*
  --  * The diff object that contains all individual file deltas.
  --  *
  --  * A `diff` represents the cumulative list of differences between two
  --  * snapshots of a repository (possibly filtered by a set of file name
  --  * patterns).
  --  *
  --  * Calculating diffs is generally done in two phases: building a list of
  --  * diffs then traversing it. This makes is easier to share logic across
  --  * the various types of diffs (tree vs tree, workdir vs index, etc.), and
  --  * also allows you to insert optional diff post-processing phases,
  --  * such as rename detection, in between the steps. When you are done with
  --  * a diff object, it must be freed.
  --  *
  --  * This is an opaque structure which will be allocated by one of the diff
  --  * generator functions below (such as `git_diff_tree_to_tree`). You are
  --  * responsible for releasing the object memory when done, using the
  --  * `git_diff_free()` function.
  --  *
  --

   type git_diff is null record;   -- incomplete struct

  --*
  --  * Flags for the delta object and the file objects on each side.
  --  *
  --  * These flags are used for both the `flags` value of the `git_diff_delta`
  --  * and the flags for the `git_diff_file` objects representing the old and
  --  * new sides of the delta.  Values outside of this public range should be
  --  * considered reserved for internal or future use.
  --

  --*< file(s) treated as binary data
  --*< file(s) treated as text data
  --*< `id` value is known correct
  --*< file exists at this side of the delta
   subtype git_diff_flag_t is unsigned;
   GIT_DIFF_FLAG_BINARY     : constant unsigned := 1;
   GIT_DIFF_FLAG_NOT_BINARY : constant unsigned := 2;
   GIT_DIFF_FLAG_VALID_ID   : constant unsigned := 4;
   GIT_DIFF_FLAG_EXISTS     : constant unsigned := 8;  -- /usr/include/git2/diff.h:208

  --*
  --  * What type of change is described by a git_diff_delta?
  --  *
  --  * `GIT_DELTA_RENAMED` and `GIT_DELTA_COPIED` will only show up if you run
  --  * `git_diff_find_similar()` on the diff object.
  --  *
  --  * `GIT_DELTA_TYPECHANGE` only shows up given `GIT_DIFF_INCLUDE_TYPECHANGE`
  --  * in the option flags (otherwise type changes will be split into ADDED /
  --  * DELETED pairs).
  --

  --*< no changes
  --*< entry does not exist in old version
  --*< entry does not exist in new version
  --*< entry content changed between old and new
  --*< entry was renamed between old and new
  --*< entry was copied from another old entry
  --*< entry is ignored item in workdir
  --*< entry is untracked item in workdir
  --*< type of entry changed between old and new
  --*< entry is unreadable
  --*< entry in the index is conflicted
   type git_delta_t is
     (GIT_DELTA_UNMODIFIED,
      GIT_DELTA_ADDED,
      GIT_DELTA_DELETED,
      GIT_DELTA_MODIFIED,
      GIT_DELTA_RENAMED,
      GIT_DELTA_COPIED,
      GIT_DELTA_IGNORED,
      GIT_DELTA_UNTRACKED,
      GIT_DELTA_TYPECHANGE,
      GIT_DELTA_UNREADABLE,
      GIT_DELTA_CONFLICTED)
      with Convention => C;  -- /usr/include/git2/diff.h:232

  --*
  --  * Description of one side of a delta.
  --  *
  --  * Although this is called a "file", it could represent a file, a symbolic
  --  * link, a submodule commit id, or even a tree (although that only if you
  --  * are tracking type changes or ignored/untracked directories).
  --  *
  --  * The `id` is the `git_oid` of the item.  If the entry represents an
  --  * absent side of a diff (e.g. the `old_file` of a `GIT_DELTA_ADDED` delta),
  --  * then the oid will be zeroes.
  --  *
  --  * `path` is the NUL-terminated path to the entry relative to the working
  --  * directory of the repository.
  --  *
  --  * `size` is the size of the entry in bytes.
  --  *
  --  * `flags` is a combination of the `git_diff_flag_t` types
  --  *
  --  * `mode` is, roughly, the stat() `st_mode` value for the item.  This will
  --  * be restricted to one of the `git_filemode_t` values.
  --  *
  --  * The `id_abbrev` represents the known length of the `id` field, when
  --  * converted to a hex string.  It is generally `GIT_OID_HEXSZ`, unless this
  --  * delta was created from reading a patch file, in which case it may be
  --  * abbreviated to something reasonable, like 7 characters.
  --

   --  skipped anonymous struct anon_anon_43

   type git_diff_file is record
      id        : aliased git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/diff.h:261
      path      : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/diff.h:262
      size      : aliased git.Low_Level.git2_types_h.git_object_size_t;  -- /usr/include/git2/diff.h:263
      flags     : aliased unsigned;  -- /usr/include/git2/diff.h:264
      mode      : aliased unsigned_short;  -- /usr/include/git2/diff.h:265
      id_abbrev : aliased unsigned_short;  -- /usr/include/git2/diff.h:266
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/diff.h:267

  --*
  --  * Description of changes to one entry.
  --  *
  --  * A `delta` is a file pair with an old and new revision.  The old version
  --  * may be absent if the file was just created and the new version may be
  --  * absent if the file was deleted.  A diff is mostly just a list of deltas.
  --  *
  --  * When iterating over a diff, this will be passed to most callbacks and
  --  * you can use the contents to understand exactly what has changed.
  --  *
  --  * The `old_file` represents the "from" side of the diff and the `new_file`
  --  * represents to "to" side of the diff.  What those means depend on the
  --  * function that was used to generate the diff and will be documented below.
  --  * You can also use the `GIT_DIFF_REVERSE` flag to flip it around.
  --  *
  --  * Although the two sides of the delta are named "old_file" and "new_file",
  --  * they actually may correspond to entries that represent a file, a symbolic
  --  * link, a submodule commit id, or even a tree (if you are tracking type
  --  * changes or ignored/untracked directories).
  --  *
  --  * Under some circumstances, in the name of efficiency, not all fields will
  --  * be filled in, but we generally try to fill in as much as possible.  One
  --  * example is that the "flags" field may not have either the `BINARY` or the
  --  * `NOT_BINARY` flag set to avoid examining file contents if you do not pass
  --  * in hunk and/or line callbacks to the diff foreach iteration function.  It
  --  * will just use the git attributes for those files.
  --  *
  --  * The similarity score is zero unless you call `git_diff_find_similar()`
  --  * which does a similarity analysis of files in the diff.  Use that
  --  * function to do rename and copy detection, and to split heavily modified
  --  * files in add/delete pairs.  After that call, deltas with a status of
  --  * GIT_DELTA_RENAMED or GIT_DELTA_COPIED will have a similarity score
  --  * between 0 and 100 indicating how similar the old and new sides are.
  --  *
  --  * If you ask `git_diff_find_similar` to find heavily modified files to
  --  * break, but to not *actually* break the records, then GIT_DELTA_MODIFIED
  --  * records may have a non-zero similarity score if the self-similarity is
  --  * below the split threshold.  To display this value like core Git, invert
  --  * the score (a la `printf("M%03d", 100 - delta->similarity)`).
  --

   --  skipped anonymous struct anon_anon_44

   type git_diff_delta is record
      status     : aliased git_delta_t;  -- /usr/include/git2/diff.h:310
      flags      : aliased unsigned;  -- /usr/include/git2/diff.h:311
      similarity : aliased unsigned_short;  -- /usr/include/git2/diff.h:312
      nfiles     : aliased unsigned_short;  -- /usr/include/git2/diff.h:313
      old_file   : aliased git_diff_file;  -- /usr/include/git2/diff.h:314
      new_file   : aliased git_diff_file;  -- /usr/include/git2/diff.h:315
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/diff.h:316

  --*< git_diff_flag_t values
  --*< for RENAMED and COPIED, value 0-100
  --*< number of files in this delta
  --*
  --  * Diff notification callback function.
  --  *
  --  * The callback will be called for each file, just before the `git_diff_delta`
  --  * gets inserted into the diff.
  --  *
  --  * When the callback:
  --  * - returns < 0, the diff process will be aborted.
  --  * - returns > 0, the delta will not be inserted into the diff, but the
  --  *          diff process continues.
  --  * - returns 0, the delta is inserted into the diff, and the diff process
  --  *          continues.
  --

   type git_diff_notify_cb is access function
     (arg1 : access constant git_diff;
      arg2 : access constant git_diff_delta;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/diff.h:331

  --*
  -- * Diff progress callback.
  -- *
  --  * Called before each file comparison.
  --  *
  --  * @param diff_so_far The diff being generated.
  --  * @param old_path The path to the old file or NULL.
  --  * @param new_path The path to the new file or NULL.
  --  * @return Non-zero to abort the diff.
  --

   type git_diff_progress_cb is access function
     (arg1 : access constant git_diff;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/diff.h:347

  --*
  --  * Structure describing options about how the diff should be executed.
  --  *
  --  * Setting all values of the structure to zero will yield the default
  --  * values.  Similarly, passing NULL for the options structure will
  --  * give the defaults.  The default values are marked below.
  --  *
  --

  --*< version for the struct
   --  skipped anonymous struct anon_anon_45

   type git_diff_options is record
      version           : aliased unsigned;  -- /usr/include/git2/diff.h:362
      flags             : aliased unsigned;  -- /usr/include/git2/diff.h:368
      ignore_submodules : aliased git.Low_Level.git2_types_h.git_submodule_ignore_t;  -- /usr/include/git2/diff.h:373
      pathspec          : aliased git.Low_Level.git2_strarray_h.git_strarray;  -- /usr/include/git2/diff.h:379
      notify_cb         : git_diff_notify_cb;  -- /usr/include/git2/diff.h:385
      progress_cb       : git_diff_progress_cb;  -- /usr/include/git2/diff.h:391
      payload           : System.Address;  -- /usr/include/git2/diff.h:394
      context_lines     : aliased unsigned;  -- /usr/include/git2/diff.h:402
      interhunk_lines   : aliased unsigned;  -- /usr/include/git2/diff.h:407
      id_abbrev         : aliased unsigned_short;  -- /usr/include/git2/diff.h:413
      max_size          : aliased git.Low_Level.git2_types_h.git_off_t;  -- /usr/include/git2/diff.h:420
      old_prefix        : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/diff.h:426
      new_prefix        : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/diff.h:432
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/diff.h:433

  --*
  --     * A combination of `git_diff_option_t` values above.
  --     * Defaults to GIT_DIFF_NORMAL
  --

  --  options controlling which files are in the diff
  --* Overrides the submodule ignore setting for all submodules in the diff.
  --*
  --     * An array of paths / fnmatch patterns to constrain diff.
  --     * All paths are included by default.
  --

  --*
  --     * An optional callback function, notifying the consumer of changes to
  --     * the diff as new deltas are added.
  --

  --*
  --     * An optional callback function, notifying the consumer of which files
  --     * are being examined as the diff is generated.
  --

  --* The payload to pass to the callback functions.
  --  options controlling how to diff text is generated
  --*
  --     * The number of unchanged lines that define the boundary of a hunk
  --     * (and to display before and after). Defaults to 3.
  --

  --*
  --     * The maximum number of unchanged lines between hunk boundaries before
  --     * the hunks will be merged into one. Defaults to 0.
  --

  --*
  --     * The abbreviation length to use when formatting object ids.
  --     * Defaults to the value of 'core.abbrev' from the config, or 7 if unset.
  --

  --*
  --     * A size (in bytes) above which a blob will be marked as binary
  --     * automatically; pass a negative value to disable.
  --     * Defaults to 512MB.
  --

  --*
  --     * The virtual "directory" prefix for old file names in hunk headers.
  --     * Default is "a".
  --

  --*
  --     * The virtual "directory" prefix for new file names in hunk headers.
  --     * Defaults to "b".
  --

  --  The current version of the diff options structure
  --  Stack initializer for diff options.  Alternatively use
  --  * `git_diff_options_init` programmatic initialization.
  --

  --*
  --  * Initialize git_diff_options structure
  --  *
  --  * Initializes a `git_diff_options` with default values. Equivalent to creating
  --  * an instance with GIT_DIFF_OPTIONS_INIT.
  --  *
  --  * @param opts The `git_diff_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_DIFF_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_diff_options_init (opts : access git_diff_options; version : unsigned) return int  -- /usr/include/git2/diff.h:454
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_options_init";

  --*
  --  * When iterating over a diff, callback that will be made per file.
  --  *
  --  * @param delta A pointer to the delta data for the file
  --  * @param progress Goes from 0 to 1 over the diff
  --  * @param payload User-specified pointer from foreach function
  --

   type git_diff_file_cb is access function
     (arg1 : access constant git_diff_delta;
      arg2 : Float;
      arg3 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/diff.h:465

  --*
  --  * When producing a binary diff, the binary data returned will be
  --  * either the deflated full ("literal") contents of the file, or
  --  * the deflated binary delta between the two sides (whichever is
  --  * smaller).
  --

  --* There is no binary delta.
  --* The binary data is the literal contents of the file.
  --* The binary data is the delta from one side to the other.
   type git_diff_binary_t is
     (GIT_DIFF_BINARY_NONE,
      GIT_DIFF_BINARY_LITERAL,
      GIT_DIFF_BINARY_DELTA)
      with Convention => C;  -- /usr/include/git2/diff.h:487

  --* The contents of one of the files in a binary diff.
  --* The type of binary data for this file.
   --  skipped anonymous struct anon_anon_47

   type git_diff_binary_file is record
      c_type      : aliased git_diff_binary_t;  -- /usr/include/git2/diff.h:492
      data        : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/diff.h:495
      datalen     : aliased unsigned_long;  -- /usr/include/git2/diff.h:498
      inflatedlen : aliased unsigned_long;  -- /usr/include/git2/diff.h:501
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/diff.h:502

  --* The binary data, deflated.
  --* The length of the binary data.
  --* The length of the binary data after inflation.
  --*
  --  * Structure describing the binary contents of a diff.
  --  *
  --  * A `binary` file / delta is a file (or pair) for which no text diffs
  --  * should be generated. A diff can contain delta entries that are
  --  * binary, but no diff content will be output for those files. There is
  --  * a base heuristic for binary detection and you can further tune the
  --  * behavior with git attributes or diff flags and option settings.
  --

  --*
  --     * Whether there is data in this binary structure or not.
  --     *
  --     * If this is `1`, then this was produced and included binary content.
  --     * If this is `0` then this was generated knowing only that a binary
  --     * file changed but without providing the data, probably from a patch
  --     * that said `Binary files a/file.txt and b/file.txt differ`.
  --

   --  skipped anonymous struct anon_anon_48

   type git_diff_binary is record
      contains_data : aliased unsigned;  -- /usr/include/git2/diff.h:522
      old_file      : aliased git_diff_binary_file;  -- /usr/include/git2/diff.h:523
      new_file      : aliased git_diff_binary_file;  -- /usr/include/git2/diff.h:524
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/diff.h:525

  --*< The contents of the old file.
  --*< The contents of the new file.
  --*
  --  * When iterating over a diff, callback that will be made for
  --  * binary content within the diff.
  --

   type git_diff_binary_cb is access function
     (arg1 : access constant git_diff_delta;
      arg2 : access constant git_diff_binary;
      arg3 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/diff.h:531

  --*
  --  * Structure describing a hunk of a diff.
  --  *
  --  * A `hunk` is a span of modified lines in a delta along with some stable
  --  * surrounding context. You can configure the amount of context and other
  --  * properties of how hunks are generated. Each hunk also comes with a
  --  * header that described where it starts and ends in both the old and new
  --  * versions in the delta.
  --

  --*< Starting line number in old_file
   --  skipped anonymous struct anon_anon_49

   subtype git_diff_hunk_array2278 is Interfaces.C.char_array (0 .. 127);
   type git_diff_hunk is record
      old_start  : aliased int;  -- /usr/include/git2/diff.h:546
      old_lines  : aliased int;  -- /usr/include/git2/diff.h:547
      new_start  : aliased int;  -- /usr/include/git2/diff.h:548
      new_lines  : aliased int;  -- /usr/include/git2/diff.h:549
      header_len : aliased unsigned_long;  -- /usr/include/git2/diff.h:550
      header     : aliased git_diff_hunk_array2278;  -- /usr/include/git2/diff.h:551
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/diff.h:552

  --*< Number of lines in old_file
  --*< Starting line number in new_file
  --*< Number of lines in new_file
  --*< Number of bytes in header text
  --*< Header text, NUL-byte terminated
  --*
  --  * When iterating over a diff, callback that will be made per hunk.
  --

   type git_diff_hunk_cb is access function
     (arg1 : access constant git_diff_delta;
      arg2 : access constant git_diff_hunk;
      arg3 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/diff.h:557

  --*
  -- * Line origin constants.
  -- *
  --  * These values describe where a line came from and will be passed to
  --  * the git_diff_line_cb when iterating over a diff.  There are some
  --  * special origin constants at the end that are used for the text
  --  * output callbacks to demarcate lines that are actually part of
  --  * the file or hunk headers.
  --

  --  These values will be sent to `git_diff_line_cb` along with the line
  --*< Both files have no LF at end
  --*< Old has no LF at end, new does
  --*< Old has LF at end, new does not
  --  The following values will only be sent to a `git_diff_line_cb` when
  --     * the content of a diff is being formatted through `git_diff_print`.
  --

  --*< For "Binary files x and y differ"
   subtype git_diff_line_t is unsigned;
   GIT_DIFF_LINE_CONTEXT       : constant unsigned := 32;
   GIT_DIFF_LINE_ADDITION      : constant unsigned := 43;
   GIT_DIFF_LINE_DELETION      : constant unsigned := 45;
   GIT_DIFF_LINE_CONTEXT_EOFNL : constant unsigned := 61;
   GIT_DIFF_LINE_ADD_EOFNL     : constant unsigned := 62;
   GIT_DIFF_LINE_DEL_EOFNL     : constant unsigned := 60;
   GIT_DIFF_LINE_FILE_HDR      : constant unsigned := 70;
   GIT_DIFF_LINE_HUNK_HDR      : constant unsigned := 72;
   GIT_DIFF_LINE_BINARY        : constant unsigned := 66;  -- /usr/include/git2/diff.h:587

  --*
  --  * Structure describing a line (or data span) of a diff.
  --  *
  --  * A `line` is a range of characters inside a hunk.  It could be a context
  --  * line (i.e. in both old and new versions), an added line (i.e. only in
  --  * the new version), or a removed line (i.e. only in the old version).
  --  * Unfortunately, we don't know anything about the encoding of data in the
  --  * file being diffed, so we cannot tell you much about the line content.
  --  * Line data will not be NUL-byte terminated, however, because it will be
  --  * just a span of bytes inside the larger file.
  --

  --*< A git_diff_line_t value
   --  skipped anonymous struct anon_anon_51

   type git_diff_line is record
      origin         : aliased char;  -- /usr/include/git2/diff.h:601
      old_lineno     : aliased int;  -- /usr/include/git2/diff.h:602
      new_lineno     : aliased int;  -- /usr/include/git2/diff.h:603
      num_lines      : aliased int;  -- /usr/include/git2/diff.h:604
      content_len    : aliased unsigned_long;  -- /usr/include/git2/diff.h:605
      content_offset : aliased git.Low_Level.git2_types_h.git_off_t;  -- /usr/include/git2/diff.h:606
      content        : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/diff.h:607
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/diff.h:608

  --*< Line number in old file or -1 for added line
  --*< Line number in new file or -1 for deleted line
  --*< Number of newline characters in content
  --*< Number of bytes of data
  --*< Offset in the original file to the content
  --*< Pointer to diff text, not NUL-byte terminated
  --*
  --  * When iterating over a diff, callback that will be made per text diff
  --  * line. In this context, the provided range will be NULL.
  --  *
  --  * When printing a diff, callback that will be made to output each line
  --  * of text.  This uses some extra GIT_DIFF_LINE_... constants for output
  --  * of lines of file and hunk headers.
  --

   type git_diff_line_cb is access function
     (arg1 : access constant git_diff_delta;
      arg2 : access constant git_diff_hunk;
      arg3 : access constant git_diff_line;
      arg4 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/diff.h:618

  --*< delta that contains this data
  --*< hunk containing this data
  --*< line data
  --*< user reference data
  --*
  --  * Flags to control the behavior of diff rename/copy detection.
  --

  --* Obey `diff.renames`. Overridden by any other GIT_DIFF_FIND_... flag.
  --* Look for renames? (`--find-renames`)
  --* Consider old side of MODIFIED for renames? (`--break-rewrites=N`)
  --* Look for copies? (a la `--find-copies`).
  --* Consider UNMODIFIED as copy sources? (`--find-copies-harder`).
  --     *
  --     * For this to work correctly, use GIT_DIFF_INCLUDE_UNMODIFIED when
  --     * the initial `git_diff` is being generated.
  --

  --* Mark significant rewrites for split (`--break-rewrites=/M`)
  --* Actually split large rewrites into delete/add pairs
  --* Mark rewrites for split and break into delete/add pairs
  --* Find renames/copies for UNTRACKED items in working directory.
  --     *
  --     * For this to work correctly, use GIT_DIFF_INCLUDE_UNTRACKED when the
  --     * initial `git_diff` is being generated (and obviously the diff must
  --     * be against the working directory for this to make sense).
  --

  --* Turn on all finding features.
  --* Measure similarity ignoring leading whitespace (default)
  --* Measure similarity ignoring all whitespace
  --* Measure similarity including all data
  --* Measure similarity only by comparing SHAs (fast and cheap)
  --* Do not break rewrites unless they contribute to a rename.
  --     *
  --     * Normally, GIT_DIFF_FIND_AND_BREAK_REWRITES will measure the self-
  --     * similarity of modified files and split the ones that have changed a
  --     * lot into a DELETE / ADD pair.  Then the sides of that pair will be
  --     * considered candidates for rename and copy detection.
  --     *
  --     * If you add this flag in and the split pair is *not* used for an
  --     * actual rename or copy, then the modified record will be restored to
  --     * a regular MODIFIED record instead of being split.
  --

  --* Remove any UNMODIFIED deltas after find_similar is done.
  --     *
  --     * Using GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED to emulate the
  --     * --find-copies-harder behavior requires building a diff with the
  --     * GIT_DIFF_INCLUDE_UNMODIFIED flag.  If you do not want UNMODIFIED
  --     * records in the final result, pass this flag to have them removed.
  --

   subtype git_diff_find_t is unsigned;
   GIT_DIFF_FIND_BY_CONFIG                  : constant unsigned := 0;
   GIT_DIFF_FIND_RENAMES                    : constant unsigned := 1;
   GIT_DIFF_FIND_RENAMES_FROM_REWRITES      : constant unsigned := 2;
   GIT_DIFF_FIND_COPIES                     : constant unsigned := 4;
   GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED     : constant unsigned := 8;
   GIT_DIFF_FIND_REWRITES                   : constant unsigned := 16;
   GIT_DIFF_BREAK_REWRITES                  : constant unsigned := 32;
   GIT_DIFF_FIND_AND_BREAK_REWRITES         : constant unsigned := 48;
   GIT_DIFF_FIND_FOR_UNTRACKED              : constant unsigned := 64;
   GIT_DIFF_FIND_ALL                        : constant unsigned := 255;
   GIT_DIFF_FIND_IGNORE_LEADING_WHITESPACE  : constant unsigned := 0;
   GIT_DIFF_FIND_IGNORE_WHITESPACE          : constant unsigned := 4_096;
   GIT_DIFF_FIND_DONT_IGNORE_WHITESPACE     : constant unsigned := 8_192;
   GIT_DIFF_FIND_EXACT_MATCH_ONLY           : constant unsigned := 16_384;
   GIT_DIFF_BREAK_REWRITES_FOR_RENAMES_ONLY : constant unsigned := 32_768;
   GIT_DIFF_FIND_REMOVE_UNMODIFIED          : constant unsigned := 65_536;  -- /usr/include/git2/diff.h:696

  --*
  --  * Pluggable similarity metric
  --

   --  skipped anonymous struct anon_anon_53

   type git_diff_similarity_metric is record
      file_signature : access function
        (arg1 : System.Address;
         arg2 : access constant git_diff_file;
         arg3 : Interfaces.C.Strings.chars_ptr;
         arg4 : System.Address) return int;  -- /usr/include/git2/diff.h:702
      buffer_signature : access function
        (arg1 : System.Address;
         arg2 : access constant git_diff_file;
         arg3 : Interfaces.C.Strings.chars_ptr;
         arg4 : unsigned_long;
         arg5 : System.Address) return int;  -- /usr/include/git2/diff.h:705
      free_signature : access procedure (arg1 : System.Address; arg2 : System.Address);  -- /usr/include/git2/diff.h:708
      similarity     : access function
        (arg1 : access int;
         arg2 : System.Address;
         arg3 : System.Address;
         arg4 : System.Address) return int;  -- /usr/include/git2/diff.h:709
      payload : System.Address;  -- /usr/include/git2/diff.h:710
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/diff.h:711

  --*
  --  * Control behavior of rename and copy detection
  --  *
  --  * These options mostly mimic parameters that can be passed to git-diff.
  --

   --  skipped anonymous struct anon_anon_54

   type git_diff_find_options is record
      version                       : aliased unsigned;  -- /usr/include/git2/diff.h:719
      flags                         : aliased unsigned;  -- /usr/include/git2/diff.h:726
      rename_threshold              : aliased unsigned_short;  -- /usr/include/git2/diff.h:732
      rename_from_rewrite_threshold : aliased unsigned_short;  -- /usr/include/git2/diff.h:738
      copy_threshold                : aliased unsigned_short;  -- /usr/include/git2/diff.h:744
      break_rewrite_threshold       : aliased unsigned_short;  -- /usr/include/git2/diff.h:750
      rename_limit                  : aliased unsigned_long;  -- /usr/include/git2/diff.h:759
      metric                        : access git_diff_similarity_metric;  -- /usr/include/git2/diff.h:771
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/diff.h:772

  --*
  --     * Combination of git_diff_find_t values (default GIT_DIFF_FIND_BY_CONFIG).
  --     * NOTE: if you don't explicitly set this, `diff.renames` could be set
  --     * to false, resulting in `git_diff_find_similar` doing nothing.
  --

  --*
  --     * Threshold above which similar files will be considered renames.
  --     * This is equivalent to the -M option. Defaults to 50.
  --

  --*
  --     * Threshold below which similar files will be eligible to be a rename source.
  --     * This is equivalent to the first part of the -B option. Defaults to 50.
  --

  --*
  --     * Threshold above which similar files will be considered copies.
  --     * This is equivalent to the -C option. Defaults to 50.
  --

  --*
  --     * Treshold below which similar files will be split into a delete/add pair.
  --     * This is equivalent to the last part of the -B option. Defaults to 60.
  --

  --*
  --     * Maximum number of matches to consider for a particular file.
  --     *
  --     * This is a little different from the `-l` option from Git because we
  --     * will still process up to this many matches before abandoning the search.
  --     * Defaults to 200.
  --

  --*
  --     * The `metric` option allows you to plug in a custom similarity metric.
  --     *
  --     * Set it to NULL to use the default internal metric.
  --     *
  --     * The default metric is based on sampling hashes of ranges of data in
  --     * the file, which is a pretty good similarity approximation that should
  --     * work fairly well for both text and binary data while still being
  --     * pretty fast with a fixed memory overhead.
  --

  --*
  --  * Initialize git_diff_find_options structure
  --  *
  --  * Initializes a `git_diff_find_options` with default values. Equivalent to creating
  --  * an instance with GIT_DIFF_FIND_OPTIONS_INIT.
  --  *
  --  * @param opts The `git_diff_find_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_DIFF_FIND_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_diff_find_options_init (opts : access git_diff_find_options; version : unsigned) return int  -- /usr/include/git2/diff.h:787
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_find_options_init";

  --* @name Diff Generator Functions
  -- *
  --  * These are the functions you would use to create (or destroy) a
  --  * git_diff from various objects in a repository.
  --

  --*@{
  --*
  -- * Deallocate a diff.
  -- *
  --  * @param diff The previously created diff; cannot be used after free.
  --

   procedure git_diff_free (diff : access git_diff)  -- /usr/include/git2/diff.h:803
     with Import    => True,
      Convention    => C,
      External_Name => "git_diff_free";

  --*
  --  * Create a diff with the difference between two tree objects.
  --  *
  --  * This is equivalent to `git diff <old-tree> <new-tree>`
  --  *
  --  * The first tree will be used for the "old_file" side of the delta and the
  --  * second tree will be used for the "new_file" side of the delta.  You can
  --  * pass NULL to indicate an empty tree, although it is an error to pass
  --  * NULL for both the `old_tree` and `new_tree`.
  --  *
  --  * @param diff Output pointer to a git_diff pointer to be allocated.
  --  * @param repo The repository containing the trees.
  --  * @param old_tree A git_tree object to diff from, or NULL for empty tree.
  --  * @param new_tree A git_tree object to diff to, or NULL for empty tree.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

   function git_diff_tree_to_tree
     (diff     : System.Address;
      repo     : access git.Low_Level.git2_types_h.git_repository;
      old_tree : access git.Low_Level.git2_types_h.git_tree;
      new_tree : access git.Low_Level.git2_types_h.git_tree;
      opts     : access constant git_diff_options) return int  -- /usr/include/git2/diff.h:821
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_tree_to_tree";

  --*
  --  * Create a diff between a tree and repository index.
  --  *
  --  * This is equivalent to `git diff --cached <treeish>` or if you pass
  --  * the HEAD tree, then like `git diff --cached`.
  --  *
  --  * The tree you pass will be used for the "old_file" side of the delta, and
  --  * the index will be used for the "new_file" side of the delta.
  --  *
  --  * If you pass NULL for the index, then the existing index of the `repo`
  --  * will be used.  In this case, the index will be refreshed from disk
  --  * (if it has changed) before the diff is generated.
  --  *
  --  * @param diff Output pointer to a git_diff pointer to be allocated.
  --  * @param repo The repository containing the tree and index.
  --  * @param old_tree A git_tree object to diff from, or NULL for empty tree.
  --  * @param index The index to diff with; repo index used if NULL.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

   function git_diff_tree_to_index
     (diff     : System.Address;
      repo     : access git.Low_Level.git2_types_h.git_repository;
      old_tree : access git.Low_Level.git2_types_h.git_tree;
      index    : access git.Low_Level.git2_types_h.git_index;
      opts     : access constant git_diff_options) return int  -- /usr/include/git2/diff.h:847
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_tree_to_index";

  --*
  --  * Create a diff between the repository index and the workdir directory.
  --  *
  --  * This matches the `git diff` command.  See the note below on
  --  * `git_diff_tree_to_workdir` for a discussion of the difference between
  --  * `git diff` and `git diff HEAD` and how to emulate a `git diff <treeish>`
  --  * using libgit2.
  --  *
  --  * The index will be used for the "old_file" side of the delta, and the
  --  * working directory will be used for the "new_file" side of the delta.
  --  *
  --  * If you pass NULL for the index, then the existing index of the `repo`
  --  * will be used.  In this case, the index will be refreshed from disk
  --  * (if it has changed) before the diff is generated.
  --  *
  --  * @param diff Output pointer to a git_diff pointer to be allocated.
  --  * @param repo The repository.
  --  * @param index The index to diff from; repo index used if NULL.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

   function git_diff_index_to_workdir
     (diff  : System.Address;
      repo  : access git.Low_Level.git2_types_h.git_repository;
      index : access git.Low_Level.git2_types_h.git_index;
      opts  : access constant git_diff_options) return int  -- /usr/include/git2/diff.h:874
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_index_to_workdir";

  --*
  --  * Create a diff between a tree and the working directory.
  --  *
  --  * The tree you provide will be used for the "old_file" side of the delta,
  --  * and the working directory will be used for the "new_file" side.
  --  *
  --  * This is not the same as `git diff <treeish>` or `git diff-index
  --  * <treeish>`.  Those commands use information from the index, whereas this
  --  * function strictly returns the differences between the tree and the files
  --  * in the working directory, regardless of the state of the index.  Use
  --  * `git_diff_tree_to_workdir_with_index` to emulate those commands.
  --  *
  --  * To see difference between this and `git_diff_tree_to_workdir_with_index`,
  --  * consider the example of a staged file deletion where the file has then
  --  * been put back into the working dir and further modified.  The
  --  * tree-to-workdir diff for that file is 'modified', but `git diff` would
  --  * show status 'deleted' since there is a staged delete.
  --  *
  --  * @param diff A pointer to a git_diff pointer that will be allocated.
  --  * @param repo The repository containing the tree.
  --  * @param old_tree A git_tree object to diff from, or NULL for empty tree.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

   function git_diff_tree_to_workdir
     (diff     : System.Address;
      repo     : access git.Low_Level.git2_types_h.git_repository;
      old_tree : access git.Low_Level.git2_types_h.git_tree;
      opts     : access constant git_diff_options) return int  -- /usr/include/git2/diff.h:903
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_tree_to_workdir";

  --*
  --  * Create a diff between a tree and the working directory using index data
  --  * to account for staged deletes, tracked files, etc.
  --  *
  --  * This emulates `git diff <tree>` by diffing the tree to the index and
  --  * the index to the working directory and blending the results into a
  --  * single diff that includes staged deleted, etc.
  --  *
  --  * @param diff A pointer to a git_diff pointer that will be allocated.
  --  * @param repo The repository containing the tree.
  --  * @param old_tree A git_tree object to diff from, or NULL for empty tree.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

   function git_diff_tree_to_workdir_with_index
     (diff     : System.Address;
      repo     : access git.Low_Level.git2_types_h.git_repository;
      old_tree : access git.Low_Level.git2_types_h.git_tree;
      opts     : access constant git_diff_options) return int  -- /usr/include/git2/diff.h:922
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_tree_to_workdir_with_index";

  --*
  --  * Create a diff with the difference between two index objects.
  --  *
  --  * The first index will be used for the "old_file" side of the delta and the
  --  * second index will be used for the "new_file" side of the delta.
  --  *
  --  * @param diff Output pointer to a git_diff pointer to be allocated.
  --  * @param repo The repository containing the indexes.
  --  * @param old_index A git_index object to diff from.
  --  * @param new_index A git_index object to diff to.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

   function git_diff_index_to_index
     (diff      : System.Address;
      repo      : access git.Low_Level.git2_types_h.git_repository;
      old_index : access git.Low_Level.git2_types_h.git_index;
      new_index : access git.Low_Level.git2_types_h.git_index;
      opts      : access constant git_diff_options) return int  -- /usr/include/git2/diff.h:940
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_index_to_index";

  --*
  --  * Merge one diff into another.
  --  *
  --  * This merges items from the "from" list into the "onto" list.  The
  --  * resulting diff will have all items that appear in either list.
  --  * If an item appears in both lists, then it will be "merged" to appear
  --  * as if the old version was from the "onto" list and the new version
  --  * is from the "from" list (with the exception that if the item has a
  --  * pending DELETE in the middle, then it will show as deleted).
  --  *
  --  * @param onto Diff to merge into.
  --  * @param from Diff to merge.
  --

   function git_diff_merge (onto : access git_diff; from : access constant git_diff) return int  -- /usr/include/git2/diff.h:960
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_merge";

  --*
  --  * Transform a diff marking file renames, copies, etc.
  --  *
  --  * This modifies a diff in place, replacing old entries that look
  --  * like renames or copies with new entries reflecting those changes.
  --  * This also will, if requested, break modified files into add/remove
  --  * pairs if the amount of change is above a threshold.
  --  *
  --  * @param diff diff to run detection algorithms on
  --  * @param options Control how detection should be run, NULL for defaults
  --  * @return 0 on success, -1 on failure
  --

   function git_diff_find_similar (diff : access git_diff; options : access constant git_diff_find_options) return int  -- /usr/include/git2/diff.h:976
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_find_similar";

  --*@}
  --* @name Diff Processor Functions
  -- *
  --  * These are the functions you apply to a diff to process it
  --  * or read it in some way.
  --

  --*@{
  --*
  --  * Query how many diff records are there in a diff.
  --  *
  --  * @param diff A git_diff generated by one of the above functions
  --  * @return Count of number of deltas in the list
  --

   function git_diff_num_deltas (diff : access constant git_diff) return unsigned_long  -- /usr/include/git2/diff.h:996
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_num_deltas";

  --*
  --  * Query how many diff deltas are there in a diff filtered by type.
  --  *
  --  * This works just like `git_diff_entrycount()` with an extra parameter
  --  * that is a `git_delta_t` and returns just the count of how many deltas
  --  * match that particular type.
  --  *
  --  * @param diff A git_diff generated by one of the above functions
  --  * @param type A git_delta_t value to filter the count
  --  * @return Count of number of deltas matching delta_t type
  --

   function git_diff_num_deltas_of_type (diff : access constant git_diff; c_type : git_delta_t) return unsigned_long  -- /usr/include/git2/diff.h:1009
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_num_deltas_of_type";

  --*
  --  * Return the diff delta for an entry in the diff list.
  --  *
  --  * The `git_diff_delta` pointer points to internal data and you do not
  --  * have to release it when you are done with it.  It will go away when
  --  * the * `git_diff` (or any associated `git_patch`) goes away.
  --  *
  --  * Note that the flags on the delta related to whether it has binary
  --  * content or not may not be set if there are no attributes set for the
  --  * file and there has been no reason to load the file data at this point.
  --  * For now, if you need those flags to be up to date, your only option is
  --  * to either use `git_diff_foreach` or create a `git_patch`.
  --  *
  --  * @param diff Diff list object
  --  * @param idx Index into diff list
  --  * @return Pointer to git_diff_delta (or NULL if `idx` out of range)
  --

   function git_diff_get_delta (diff : access constant git_diff; idx : unsigned_long) return access constant git_diff_delta  -- /usr/include/git2/diff.h:1029
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_get_delta";

  --*
  --  * Check if deltas are sorted case sensitively or insensitively.
  --  *
  --  * @param diff diff to check
  --  * @return 0 if case sensitive, 1 if case is ignored
  --

   function git_diff_is_sorted_icase (diff : access constant git_diff) return int  -- /usr/include/git2/diff.h:1038
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_is_sorted_icase";

  --*
  --  * Loop over all deltas in a diff issuing callbacks.
  --  *
  --  * This will iterate through all of the files described in a diff.  You
  --  * should provide a file callback to learn about each file.
  --  *
  --  * The "hunk" and "line" callbacks are optional, and the text diff of the
  --  * files will only be calculated if they are not NULL.  Of course, these
  --  * callbacks will not be invoked for binary files on the diff or for
  --  * files whose only changed is a file mode change.
  --  *
  --  * Returning a non-zero value from any of the callbacks will terminate
  --  * the iteration and return the value to the user.
  --  *
  --  * @param diff A git_diff generated by one of the above functions.
  --  * @param file_cb Callback function to make per file in the diff.
  --  * @param binary_cb Optional callback to make for binary files.
  --  * @param hunk_cb Optional callback to make per hunk of text diff.  This
  --  *                callback is called to describe a range of lines in the
  --  *                diff.  It will not be issued for binary files.
  --  * @param line_cb Optional callback to make per line of diff text.  This
  --  *                same callback will be made for context lines, added, and
  --  *                removed lines, and even for a deleted trailing newline.
  --  * @param payload Reference pointer that will be passed to your callbacks.
  --  * @return 0 on success, non-zero callback return value, or error code
  --

   function git_diff_foreach
     (diff      : access git_diff;
      file_cb   : git_diff_file_cb;
      binary_cb : git_diff_binary_cb;
      hunk_cb   : git_diff_hunk_cb;
      line_cb   : git_diff_line_cb;
      payload   : System.Address) return int  -- /usr/include/git2/diff.h:1066
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_foreach";

  --*
  --  * Look up the single character abbreviation for a delta status code.
  --  *
  --  * When you run `git diff --name-status` it uses single letter codes in
  --  * the output such as 'A' for added, 'D' for deleted, 'M' for modified,
  --  * etc.  This function converts a git_delta_t value into these letters for
  --  * your own purposes.  GIT_DELTA_UNTRACKED will return a space (i.e. ' ').
  --  *
  --  * @param status The git_delta_t value to look up
  --  * @return The single character label for that code
  --

   function git_diff_status_char (status : git_delta_t) return char  -- /usr/include/git2/diff.h:1085
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_status_char";

  --*
  --  * Possible output formats for diff data
  --

  --*< full git diff
  --*< just the file headers of patch
  --*< like git diff --raw
  --*< like git diff --name-only
  --*< like git diff --name-status
  --*< git diff as used by git patch-id
   subtype git_diff_format_t is unsigned;
   GIT_DIFF_FORMAT_PATCH        : constant unsigned := 1;
   GIT_DIFF_FORMAT_PATCH_HEADER : constant unsigned := 2;
   GIT_DIFF_FORMAT_RAW          : constant unsigned := 3;
   GIT_DIFF_FORMAT_NAME_ONLY    : constant unsigned := 4;
   GIT_DIFF_FORMAT_NAME_STATUS  : constant unsigned := 5;
   GIT_DIFF_FORMAT_PATCH_ID     : constant unsigned := 6;  -- /usr/include/git2/diff.h:1097

  --*
  --  * Iterate over a diff generating formatted text output.
  --  *
  --  * Returning a non-zero value from the callbacks will terminate the
  --  * iteration and return the non-zero value to the caller.
  --  *
  --  * @param diff A git_diff generated by one of the above functions.
  --  * @param format A git_diff_format_t value to pick the text format.
  --  * @param print_cb Callback to make per line of diff text.
  --  * @param payload Reference pointer that will be passed to your callback.
  --  * @return 0 on success, non-zero callback return value, or error code
  --

   function git_diff_print
     (diff     : access git_diff;
      format   : git_diff_format_t;
      print_cb : git_diff_line_cb;
      payload  : System.Address) return int  -- /usr/include/git2/diff.h:1111
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_print";

  --*
  --  * Produce the complete formatted text output from a diff into a
  --  * buffer.
  --  *
  --  * @param out A pointer to a user-allocated git_buf that will
  --  *            contain the diff text
  --  * @param diff A git_diff generated by one of the above functions.
  --  * @param format A git_diff_format_t value to pick the text format.
  --  * @return 0 on success or error code
  --

   function git_diff_to_buf
     (c_out  : access git.Low_Level.git2_buffer_h.git_buf;
      diff   : access git_diff;
      format : git_diff_format_t) return int  -- /usr/include/git2/diff.h:1127
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_to_buf";

  --*@}
  -- * Misc
  --

  --*
  --  * Directly run a diff on two blobs.
  --  *
  --  * Compared to a file, a blob lacks some contextual information. As such,
  --  * the `git_diff_file` given to the callback will have some fake data; i.e.
  --  * `mode` will be 0 and `path` will be NULL.
  --  *
  --  * NULL is allowed for either `old_blob` or `new_blob` and will be treated
  --  * as an empty blob, with the `oid` set to NULL in the `git_diff_file` data.
  --  * Passing NULL for both blobs is a noop; no callbacks will be made at all.
  --  *
  --  * We do run a binary content check on the blob content and if either blob
  --  * looks like binary data, the `git_diff_delta` binary attribute will be set
  --  * to 1 and no call to the hunk_cb nor line_cb will be made (unless you pass
  --  * `GIT_DIFF_FORCE_TEXT` of course).
  --  *
  --  * @param old_blob Blob for old side of diff, or NULL for empty blob
  --  * @param old_as_path Treat old blob as if it had this filename; can be NULL
  --  * @param new_blob Blob for new side of diff, or NULL for empty blob
  --  * @param new_as_path Treat new blob as if it had this filename; can be NULL
  --  * @param options Options for diff, or NULL for default options
  --  * @param file_cb Callback for "file"; made once if there is a diff; can be NULL
  --  * @param binary_cb Callback for binary files; can be NULL
  --  * @param hunk_cb Callback for each hunk in diff; can be NULL
  --  * @param line_cb Callback for each line in diff; can be NULL
  --  * @param payload Payload passed to each callback function
  --  * @return 0 on success, non-zero callback return value, or error code
  --

   function git_diff_blobs
     (old_blob    : access constant git.Low_Level.git2_types_h.git_blob;
      old_as_path : Interfaces.C.Strings.chars_ptr;
      new_blob    : access constant git.Low_Level.git2_types_h.git_blob;
      new_as_path : Interfaces.C.Strings.chars_ptr;
      options     : access constant git_diff_options;
      file_cb     : git_diff_file_cb;
      binary_cb   : git_diff_binary_cb;
      hunk_cb     : git_diff_hunk_cb;
      line_cb     : git_diff_line_cb;
      payload     : System.Address) return int  -- /usr/include/git2/diff.h:1167
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_blobs";

  --*
  --  * Directly run a diff between a blob and a buffer.
  --  *
  --  * As with `git_diff_blobs`, comparing a blob and buffer lacks some context,
  --  * so the `git_diff_file` parameters to the callbacks will be faked a la the
  --  * rules for `git_diff_blobs()`.
  --  *
  --  * Passing NULL for `old_blob` will be treated as an empty blob (i.e. the
  --  * `file_cb` will be invoked with GIT_DELTA_ADDED and the diff will be the
  --  * entire content of the buffer added).  Passing NULL to the buffer will do
  --  * the reverse, with GIT_DELTA_REMOVED and blob content removed.
  --  *
  --  * @param old_blob Blob for old side of diff, or NULL for empty blob
  --  * @param old_as_path Treat old blob as if it had this filename; can be NULL
  --  * @param buffer Raw data for new side of diff, or NULL for empty
  --  * @param buffer_len Length of raw data for new side of diff
  --  * @param buffer_as_path Treat buffer as if it had this filename; can be NULL
  --  * @param options Options for diff, or NULL for default options
  --  * @param file_cb Callback for "file"; made once if there is a diff; can be NULL
  --  * @param binary_cb Callback for binary files; can be NULL
  --  * @param hunk_cb Callback for each hunk in diff; can be NULL
  --  * @param line_cb Callback for each line in diff; can be NULL
  --  * @param payload Payload passed to each callback function
  --  * @return 0 on success, non-zero callback return value, or error code
  --

   function git_diff_blob_to_buffer
     (old_blob       : access constant git.Low_Level.git2_types_h.git_blob;
      old_as_path    : Interfaces.C.Strings.chars_ptr;
      buffer         : Interfaces.C.Strings.chars_ptr;
      buffer_len     : unsigned_long;
      buffer_as_path : Interfaces.C.Strings.chars_ptr;
      options        : access constant git_diff_options;
      file_cb        : git_diff_file_cb;
      binary_cb      : git_diff_binary_cb;
      hunk_cb        : git_diff_hunk_cb;
      line_cb        : git_diff_line_cb;
      payload        : System.Address) return int  -- /usr/include/git2/diff.h:1204
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_blob_to_buffer";

  --*
  --  * Directly run a diff between two buffers.
  --  *
  --  * Even more than with `git_diff_blobs`, comparing two buffer lacks
  --  * context, so the `git_diff_file` parameters to the callbacks will be
  --  * faked a la the rules for `git_diff_blobs()`.
  --  *
  --  * @param old_buffer Raw data for old side of diff, or NULL for empty
  --  * @param old_len Length of the raw data for old side of the diff
  --  * @param old_as_path Treat old buffer as if it had this filename; can be NULL
  --  * @param new_buffer Raw data for new side of diff, or NULL for empty
  --  * @param new_len Length of raw data for new side of diff
  --  * @param new_as_path Treat buffer as if it had this filename; can be NULL
  --  * @param options Options for diff, or NULL for default options
  --  * @param file_cb Callback for "file"; made once if there is a diff; can be NULL
  --  * @param binary_cb Callback for binary files; can be NULL
  --  * @param hunk_cb Callback for each hunk in diff; can be NULL
  --  * @param line_cb Callback for each line in diff; can be NULL
  --  * @param payload Payload passed to each callback function
  --  * @return 0 on success, non-zero callback return value, or error code
  --

   function git_diff_buffers
     (old_buffer  : System.Address;
      old_len     : unsigned_long;
      old_as_path : Interfaces.C.Strings.chars_ptr;
      new_buffer  : System.Address;
      new_len     : unsigned_long;
      new_as_path : Interfaces.C.Strings.chars_ptr;
      options     : access constant git_diff_options;
      file_cb     : git_diff_file_cb;
      binary_cb   : git_diff_binary_cb;
      hunk_cb     : git_diff_hunk_cb;
      line_cb     : git_diff_line_cb;
      payload     : System.Address) return int  -- /usr/include/git2/diff.h:1238
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_buffers";

  --*
  --  * Read the contents of a git patch file into a `git_diff` object.
  --  *
  --  * The diff object produced is similar to the one that would be
  --  * produced if you actually produced it computationally by comparing
  --  * two trees, however there may be subtle differences.  For example,
  --  * a patch file likely contains abbreviated object IDs, so the
  --  * object IDs in a `git_diff_delta` produced by this function will
  --  * also be abbreviated.
  --  *
  --  * This function will only read patch files created by a git
  --  * implementation, it will not read unified diffs produced by
  --  * the `diff` program, nor any other types of patch files.
  --  *
  --  * @param out A pointer to a git_diff pointer that will be allocated.
  --  * @param content The contents of a patch file
  --  * @param content_len The length of the patch file contents
  --  * @return 0 or an error code
  --

   function git_diff_from_buffer
     (c_out       : System.Address;
      content     : Interfaces.C.Strings.chars_ptr;
      content_len : unsigned_long) return int  -- /usr/include/git2/diff.h:1271
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_from_buffer";

  --*
  --  * This is an opaque structure which is allocated by `git_diff_get_stats`.
  --  * You are responsible for releasing the object memory when done, using the
  --  * `git_diff_stats_free()` function.
  --

   type git_diff_stats is null record;   -- incomplete struct

  --*
  --  * Formatting options for diff stats
  --

  --* No stats
  --* Full statistics, equivalent of `--stat`
  --* Short statistics, equivalent of `--shortstat`
  --* Number statistics, equivalent of `--numstat`
  --* Extended header information such as creations, renames and mode changes, equivalent of `--summary`
   subtype git_diff_stats_format_t is unsigned;
   GIT_DIFF_STATS_NONE            : constant unsigned := 0;
   GIT_DIFF_STATS_FULL            : constant unsigned := 1;
   GIT_DIFF_STATS_SHORT           : constant unsigned := 2;
   GIT_DIFF_STATS_NUMBER          : constant unsigned := 4;
   GIT_DIFF_STATS_INCLUDE_SUMMARY : constant unsigned := 8;  -- /usr/include/git2/diff.h:1301

  --*
  --  * Accumulate diff statistics for all patches.
  --  *
  --  * @param out Structure containg the diff statistics.
  --  * @param diff A git_diff generated by one of the above functions.
  --  * @return 0 on success; non-zero on error
  --

   function git_diff_get_stats (c_out : System.Address; diff : access git_diff) return int  -- /usr/include/git2/diff.h:1310
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_get_stats";

  --*
  --  * Get the total number of files changed in a diff
  --  *
  --  * @param stats A `git_diff_stats` generated by one of the above functions.
  --  * @return total number of files changed in the diff
  --

   function git_diff_stats_files_changed (stats : access constant git_diff_stats) return unsigned_long  -- /usr/include/git2/diff.h:1320
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_stats_files_changed";

  --*
  --  * Get the total number of insertions in a diff
  --  *
  --  * @param stats A `git_diff_stats` generated by one of the above functions.
  --  * @return total number of insertions in the diff
  --

   function git_diff_stats_insertions (stats : access constant git_diff_stats) return unsigned_long  -- /usr/include/git2/diff.h:1329
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_stats_insertions";

  --*
  --  * Get the total number of deletions in a diff
  --  *
  --  * @param stats A `git_diff_stats` generated by one of the above functions.
  --  * @return total number of deletions in the diff
  --

   function git_diff_stats_deletions (stats : access constant git_diff_stats) return unsigned_long  -- /usr/include/git2/diff.h:1338
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_stats_deletions";

  --*
  --  * Print diff statistics to a `git_buf`.
  --  *
  --  * @param out buffer to store the formatted diff statistics in.
  --  * @param stats A `git_diff_stats` generated by one of the above functions.
  --  * @param format Formatting option.
  --  * @param width Target width for output (only affects GIT_DIFF_STATS_FULL)
  --  * @return 0 on success; non-zero on error
  --

   function git_diff_stats_to_buf
     (c_out  : access git.Low_Level.git2_buffer_h.git_buf;
      stats  : access constant git_diff_stats;
      format : git_diff_stats_format_t;
      width  : unsigned_long) return int  -- /usr/include/git2/diff.h:1350
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_stats_to_buf";

  --*
  --  * Deallocate a `git_diff_stats`.
  --  *
  --  * @param stats The previously created statistics object;
  --  * cannot be used after free.
  --

   procedure git_diff_stats_free (stats : access git_diff_stats)  -- /usr/include/git2/diff.h:1362
     with Import    => True,
      Convention    => C,
      External_Name => "git_diff_stats_free";

  --*
  --  * Formatting options for diff e-mail generation
  --

  --* Normal patch, the default
  --* Don't insert "[PATCH]" in the subject header
   type git_diff_format_email_flags_t is
     (GIT_DIFF_FORMAT_EMAIL_NONE,
      GIT_DIFF_FORMAT_EMAIL_EXCLUDE_SUBJECT_PATCH_MARKER)
      with Convention => C;  -- /usr/include/git2/diff.h:1374

  --*
  --  * Options for controlling the formatting of the generated e-mail.
  --

   --  skipped anonymous struct anon_anon_58

   type git_diff_format_email_options is record
      version       : aliased unsigned;  -- /usr/include/git2/diff.h:1380
      flags         : aliased unsigned;  -- /usr/include/git2/diff.h:1383
      patch_no      : aliased unsigned_long;  -- /usr/include/git2/diff.h:1386
      total_patches : aliased unsigned_long;  -- /usr/include/git2/diff.h:1389
      id            : access constant git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/diff.h:1392
      summary       : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/diff.h:1395
      c_body        : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/diff.h:1398
      author        : access constant git.Low_Level.git2_types_h.git_signature;  -- /usr/include/git2/diff.h:1401
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/diff.h:1402

  --* see `git_diff_format_email_flags_t` above
  --* This patch number
  --* Total number of patches in this series
  --* id to use for the commit
  --* Summary of the change
  --* Commit message's body
  --* Author of the change
  --*
  --  * Create an e-mail ready patch from a diff.
  --  *
  --  * @param out buffer to store the e-mail patch in
  --  * @param diff containing the commit
  --  * @param opts structure with options to influence content and formatting.
  --  * @return 0 or an error code
  --

   function git_diff_format_email
     (c_out : access git.Low_Level.git2_buffer_h.git_buf;
      diff  : access git_diff;
      opts  : access constant git_diff_format_email_options) return int  -- /usr/include/git2/diff.h:1415
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_format_email";

  --*
  --  * Create an e-mail ready patch for a commit.
  --  *
  --  * Does not support creating patches for merge commits (yet).
  --  *
  --  * @param out buffer to store the e-mail patch in
  --  * @param repo containing the commit
  --  * @param commit pointer to up commit
  --  * @param patch_no patch number of the commit
  --  * @param total_patches total number of patches in the patch set
  --  * @param flags determines the formatting of the e-mail
  --  * @param diff_opts structure with options to influence diff or NULL for defaults.
  --  * @return 0 or an error code
  --

   function git_diff_commit_as_email
     (c_out         : access git.Low_Level.git2_buffer_h.git_buf;
      repo          : access git.Low_Level.git2_types_h.git_repository;
      commit        : access git.Low_Level.git2_types_h.git_commit;
      patch_no      : unsigned_long;
      total_patches : unsigned_long;
      flags         : unsigned;
      diff_opts     : access constant git_diff_options) return int  -- /usr/include/git2/diff.h:1434
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_commit_as_email";

  --*
  --  * Initialize git_diff_format_email_options structure
  --  *
  --  * Initializes a `git_diff_format_email_options` with default values. Equivalent
  --  * to creating an instance with GIT_DIFF_FORMAT_EMAIL_OPTIONS_INIT.
  --  *
  --  * @param opts The `git_blame_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_DIFF_FORMAT_EMAIL_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_diff_format_email_options_init (opts : access git_diff_format_email_options; version : unsigned) return int  -- /usr/include/git2/diff.h:1453
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_format_email_options_init";

  --*
  --  * Patch ID options structure
  --  *
  --  * Initialize with `GIT_PATCHID_OPTIONS_INIT`. Alternatively, you can
  --  * use `git_diff_patchid_options_init`.
  --  *
  --

   type git_diff_patchid_options is record
      version : aliased unsigned;  -- /usr/include/git2/diff.h:1465
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/diff.h:1464

  --*
  --  * Initialize git_diff_patchid_options structure
  --  *
  --  * Initializes a `git_diff_patchid_options` with default values. Equivalent to
  --  * creating an instance with `GIT_DIFF_PATCHID_OPTIONS_INIT`.
  --  *
  --  * @param opts The `git_diff_patchid_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_DIFF_PATCHID_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_diff_patchid_options_init (opts : access git_diff_patchid_options; version : unsigned) return int  -- /usr/include/git2/diff.h:1481
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_patchid_options_init";

  --*
  --  * Calculate the patch ID for the given patch.
  --  *
  --  * Calculate a stable patch ID for the given patch by summing the
  --  * hash of the file diffs, ignoring whitespace and line numbers.
  --  * This can be used to derive whether two diffs are the same with
  --  * a high probability.
  --  *
  --  * Currently, this function only calculates stable patch IDs, as
  --  * defined in git-patch-id(1), and should in fact generate the
  --  * same IDs as the upstream git project does.
  --  *
  --  * @param out Pointer where the calculated patch ID should be stored
  --  * @param diff The diff to calculate the ID for
  --  * @param opts Options for how to calculate the patch ID. This is
  --  *  intended for future changes, as currently no options are
  --  *  available.
  --  * @return 0 on success, an error code otherwise.
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/diff.h
  --  * @brief Git tree and file differencing routines.
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Flags for diff options.  A combination of these flags can be passed
  --  * in via the `flags` value in the `git_diff_options`.
  --

  --* Normal diff, the default
  --     * Options controlling which files will be in the diff
  --

  --* Reverse the sides of the diff
  --* Include ignored files in the diff
  --* Even with GIT_DIFF_INCLUDE_IGNORED, an entire ignored directory
  --     *  will be marked with only a single entry in the diff; this flag
  --     *  adds all files under the directory as IGNORED entries, too.
  --

  --* Include untracked files in the diff
  --* Even with GIT_DIFF_INCLUDE_UNTRACKED, an entire untracked
  --     *  directory will be marked with only a single entry in the diff
  --     *  (a la what core Git does in `git status`); this flag adds *all*
  --     *  files under untracked directories as UNTRACKED entries, too.
  --

  --* Include unmodified files in the diff
  --* Normally, a type change between files will be converted into a
  --     *  DELETED record for the old and an ADDED record for the new; this
  --     *  options enabled the generation of TYPECHANGE delta records.
  --

  --* Even with GIT_DIFF_INCLUDE_TYPECHANGE, blob->tree changes still
  --     *  generally show as a DELETED blob.  This flag tries to correctly
  --     *  label blob->tree transitions as TYPECHANGE records with new_file's
  --     *  mode set to tree.  Note: the tree SHA will not be available.
  --

  --* Ignore file mode changes
  --* Treat all submodules as unmodified
  --* Use case insensitive filename comparisons
  --* May be combined with `GIT_DIFF_IGNORE_CASE` to specify that a file
  --     *  that has changed case will be returned as an add/delete pair.
  --

  --* If the pathspec is set in the diff options, this flags indicates
  --     *  that the paths will be treated as literal paths instead of
  --     *  fnmatch patterns.  Each path in the list must either be a full
  --     *  path to a file or a directory.  (A trailing slash indicates that
  --     *  the path will _only_ match a directory).  If a directory is
  --     *  specified, all children will be included.
  --

  --* Disable updating of the `binary` flag in delta records.  This is
  --     *  useful when iterating over a diff if you don't need hunk and data
  --     *  callbacks and want to avoid having to load file completely.
  --

  --* When diff finds an untracked directory, to match the behavior of
  --     *  core Git, it scans the contents for IGNORED and UNTRACKED files.
  --     *  If *all* contents are IGNORED, then the directory is IGNORED; if
  --     *  any contents are not IGNORED, then the directory is UNTRACKED.
  --     *  This is extra work that may not matter in many cases.  This flag
  --     *  turns off that scan and immediately labels an untracked directory
  --     *  as UNTRACKED (changing the behavior to not match core Git).
  --

  --* When diff finds a file in the working directory with stat
  --     * information different from the index, but the OID ends up being the
  --     * same, write the correct stat information into the index.  Note:
  --     * without this flag, diff will always leave the index untouched.
  --

  --* Include unreadable files in the diff
  --* Include unreadable files in the diff
  --     * Options controlling how output will be generated
  --

  --* Use a heuristic that takes indentation and whitespace into account
  --     * which generally can produce better diffs when dealing with ambiguous
  --     * diff hunks.
  --

  --* Treat all files as text, disabling binary attributes & detection
  --* Treat all files as binary, disabling text diffs
  --* Ignore all whitespace
  --* Ignore changes in amount of whitespace
  --* Ignore whitespace at end of line
  --* When generating patch text, include the content of untracked
  --     *  files.  This automatically turns on GIT_DIFF_INCLUDE_UNTRACKED but
  --     *  it does not turn on GIT_DIFF_RECURSE_UNTRACKED_DIRS.  Add that
  --     *  flag if you want the content of every single UNTRACKED file.
  --

  --* When generating output, include the names of unmodified files if
  --     *  they are included in the git_diff.  Normally these are skipped in
  --     *  the formats that list files (e.g. name-only, name-status, raw).
  --     *  Even with this, these will not be included in patch format.
  --

  --* Use the "patience diff" algorithm
  --* Take extra time to find minimal diff
  --* Include the necessary deflate / delta information so that `git-apply`
  --     *  can apply given diff information to binary files.
  --

  --*
  --  * The diff object that contains all individual file deltas.
  --  *
  --  * A `diff` represents the cumulative list of differences between two
  --  * snapshots of a repository (possibly filtered by a set of file name
  --  * patterns).
  --  *
  --  * Calculating diffs is generally done in two phases: building a list of
  --  * diffs then traversing it. This makes is easier to share logic across
  --  * the various types of diffs (tree vs tree, workdir vs index, etc.), and
  --  * also allows you to insert optional diff post-processing phases,
  --  * such as rename detection, in between the steps. When you are done with
  --  * a diff object, it must be freed.
  --  *
  --  * This is an opaque structure which will be allocated by one of the diff
  --  * generator functions below (such as `git_diff_tree_to_tree`). You are
  --  * responsible for releasing the object memory when done, using the
  --  * `git_diff_free()` function.
  --  *
  --

  --*
  --  * Flags for the delta object and the file objects on each side.
  --  *
  --  * These flags are used for both the `flags` value of the `git_diff_delta`
  --  * and the flags for the `git_diff_file` objects representing the old and
  --  * new sides of the delta.  Values outside of this public range should be
  --  * considered reserved for internal or future use.
  --

  --*< file(s) treated as binary data
  --*< file(s) treated as text data
  --*< `id` value is known correct
  --*< file exists at this side of the delta
  --*
  --  * What type of change is described by a git_diff_delta?
  --  *
  --  * `GIT_DELTA_RENAMED` and `GIT_DELTA_COPIED` will only show up if you run
  --  * `git_diff_find_similar()` on the diff object.
  --  *
  --  * `GIT_DELTA_TYPECHANGE` only shows up given `GIT_DIFF_INCLUDE_TYPECHANGE`
  --  * in the option flags (otherwise type changes will be split into ADDED /
  --  * DELETED pairs).
  --

  --*< no changes
  --*< entry does not exist in old version
  --*< entry does not exist in new version
  --*< entry content changed between old and new
  --*< entry was renamed between old and new
  --*< entry was copied from another old entry
  --*< entry is ignored item in workdir
  --*< entry is untracked item in workdir
  --*< type of entry changed between old and new
  --*< entry is unreadable
  --*< entry in the index is conflicted
  --*
  --  * Description of one side of a delta.
  --  *
  --  * Although this is called a "file", it could represent a file, a symbolic
  --  * link, a submodule commit id, or even a tree (although that only if you
  --  * are tracking type changes or ignored/untracked directories).
  --  *
  --  * The `id` is the `git_oid` of the item.  If the entry represents an
  --  * absent side of a diff (e.g. the `old_file` of a `GIT_DELTA_ADDED` delta),
  --  * then the oid will be zeroes.
  --  *
  --  * `path` is the NUL-terminated path to the entry relative to the working
  --  * directory of the repository.
  --  *
  --  * `size` is the size of the entry in bytes.
  --  *
  --  * `flags` is a combination of the `git_diff_flag_t` types
  --  *
  --  * `mode` is, roughly, the stat() `st_mode` value for the item.  This will
  --  * be restricted to one of the `git_filemode_t` values.
  --  *
  --  * The `id_abbrev` represents the known length of the `id` field, when
  --  * converted to a hex string.  It is generally `GIT_OID_HEXSZ`, unless this
  --  * delta was created from reading a patch file, in which case it may be
  --  * abbreviated to something reasonable, like 7 characters.
  --

  --*
  --  * Description of changes to one entry.
  --  *
  --  * A `delta` is a file pair with an old and new revision.  The old version
  --  * may be absent if the file was just created and the new version may be
  --  * absent if the file was deleted.  A diff is mostly just a list of deltas.
  --  *
  --  * When iterating over a diff, this will be passed to most callbacks and
  --  * you can use the contents to understand exactly what has changed.
  --  *
  --  * The `old_file` represents the "from" side of the diff and the `new_file`
  --  * represents to "to" side of the diff.  What those means depend on the
  --  * function that was used to generate the diff and will be documented below.
  --  * You can also use the `GIT_DIFF_REVERSE` flag to flip it around.
  --  *
  --  * Although the two sides of the delta are named "old_file" and "new_file",
  --  * they actually may correspond to entries that represent a file, a symbolic
  --  * link, a submodule commit id, or even a tree (if you are tracking type
  --  * changes or ignored/untracked directories).
  --  *
  --  * Under some circumstances, in the name of efficiency, not all fields will
  --  * be filled in, but we generally try to fill in as much as possible.  One
  --  * example is that the "flags" field may not have either the `BINARY` or the
  --  * `NOT_BINARY` flag set to avoid examining file contents if you do not pass
  --  * in hunk and/or line callbacks to the diff foreach iteration function.  It
  --  * will just use the git attributes for those files.
  --  *
  --  * The similarity score is zero unless you call `git_diff_find_similar()`
  --  * which does a similarity analysis of files in the diff.  Use that
  --  * function to do rename and copy detection, and to split heavily modified
  --  * files in add/delete pairs.  After that call, deltas with a status of
  --  * GIT_DELTA_RENAMED or GIT_DELTA_COPIED will have a similarity score
  --  * between 0 and 100 indicating how similar the old and new sides are.
  --  *
  --  * If you ask `git_diff_find_similar` to find heavily modified files to
  --  * break, but to not *actually* break the records, then GIT_DELTA_MODIFIED
  --  * records may have a non-zero similarity score if the self-similarity is
  --  * below the split threshold.  To display this value like core Git, invert
  --  * the score (a la `printf("M%03d", 100 - delta->similarity)`).
  --

  --*< git_diff_flag_t values
  --*< for RENAMED and COPIED, value 0-100
  --*< number of files in this delta
  --*
  --  * Diff notification callback function.
  --  *
  --  * The callback will be called for each file, just before the `git_diff_delta`
  --  * gets inserted into the diff.
  --  *
  --  * When the callback:
  --  * - returns < 0, the diff process will be aborted.
  --  * - returns > 0, the delta will not be inserted into the diff, but the
  --  *          diff process continues.
  --  * - returns 0, the delta is inserted into the diff, and the diff process
  --  *          continues.
  --

  --*
  -- * Diff progress callback.
  -- *
  --  * Called before each file comparison.
  --  *
  --  * @param diff_so_far The diff being generated.
  --  * @param old_path The path to the old file or NULL.
  --  * @param new_path The path to the new file or NULL.
  --  * @return Non-zero to abort the diff.
  --

  --*
  --  * Structure describing options about how the diff should be executed.
  --  *
  --  * Setting all values of the structure to zero will yield the default
  --  * values.  Similarly, passing NULL for the options structure will
  --  * give the defaults.  The default values are marked below.
  --  *
  --

  --*< version for the struct
  --*
  --     * A combination of `git_diff_option_t` values above.
  --     * Defaults to GIT_DIFF_NORMAL
  --

  --  options controlling which files are in the diff
  --* Overrides the submodule ignore setting for all submodules in the diff.
  --*
  --     * An array of paths / fnmatch patterns to constrain diff.
  --     * All paths are included by default.
  --

  --*
  --     * An optional callback function, notifying the consumer of changes to
  --     * the diff as new deltas are added.
  --

  --*
  --     * An optional callback function, notifying the consumer of which files
  --     * are being examined as the diff is generated.
  --

  --* The payload to pass to the callback functions.
  --  options controlling how to diff text is generated
  --*
  --     * The number of unchanged lines that define the boundary of a hunk
  --     * (and to display before and after). Defaults to 3.
  --

  --*
  --     * The maximum number of unchanged lines between hunk boundaries before
  --     * the hunks will be merged into one. Defaults to 0.
  --

  --*
  --     * The abbreviation length to use when formatting object ids.
  --     * Defaults to the value of 'core.abbrev' from the config, or 7 if unset.
  --

  --*
  --     * A size (in bytes) above which a blob will be marked as binary
  --     * automatically; pass a negative value to disable.
  --     * Defaults to 512MB.
  --

  --*
  --     * The virtual "directory" prefix for old file names in hunk headers.
  --     * Default is "a".
  --

  --*
  --     * The virtual "directory" prefix for new file names in hunk headers.
  --     * Defaults to "b".
  --

  --  The current version of the diff options structure
  --  Stack initializer for diff options.  Alternatively use
  --  * `git_diff_options_init` programmatic initialization.
  --

  --*
  --  * Initialize git_diff_options structure
  --  *
  --  * Initializes a `git_diff_options` with default values. Equivalent to creating
  --  * an instance with GIT_DIFF_OPTIONS_INIT.
  --  *
  --  * @param opts The `git_diff_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_DIFF_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

  --*
  --  * When iterating over a diff, callback that will be made per file.
  --  *
  --  * @param delta A pointer to the delta data for the file
  --  * @param progress Goes from 0 to 1 over the diff
  --  * @param payload User-specified pointer from foreach function
  --

  --*
  --  * When producing a binary diff, the binary data returned will be
  --  * either the deflated full ("literal") contents of the file, or
  --  * the deflated binary delta between the two sides (whichever is
  --  * smaller).
  --

  --* There is no binary delta.
  --* The binary data is the literal contents of the file.
  --* The binary data is the delta from one side to the other.
  --* The contents of one of the files in a binary diff.
  --* The type of binary data for this file.
  --* The binary data, deflated.
  --* The length of the binary data.
  --* The length of the binary data after inflation.
  --*
  --  * Structure describing the binary contents of a diff.
  --  *
  --  * A `binary` file / delta is a file (or pair) for which no text diffs
  --  * should be generated. A diff can contain delta entries that are
  --  * binary, but no diff content will be output for those files. There is
  --  * a base heuristic for binary detection and you can further tune the
  --  * behavior with git attributes or diff flags and option settings.
  --

  --*
  --     * Whether there is data in this binary structure or not.
  --     *
  --     * If this is `1`, then this was produced and included binary content.
  --     * If this is `0` then this was generated knowing only that a binary
  --     * file changed but without providing the data, probably from a patch
  --     * that said `Binary files a/file.txt and b/file.txt differ`.
  --

  --*< The contents of the old file.
  --*< The contents of the new file.
  --*
  --  * When iterating over a diff, callback that will be made for
  --  * binary content within the diff.
  --

  --*
  --  * Structure describing a hunk of a diff.
  --  *
  --  * A `hunk` is a span of modified lines in a delta along with some stable
  --  * surrounding context. You can configure the amount of context and other
  --  * properties of how hunks are generated. Each hunk also comes with a
  --  * header that described where it starts and ends in both the old and new
  --  * versions in the delta.
  --

  --*< Starting line number in old_file
  --*< Number of lines in old_file
  --*< Starting line number in new_file
  --*< Number of lines in new_file
  --*< Number of bytes in header text
  --*< Header text, NUL-byte terminated
  --*
  --  * When iterating over a diff, callback that will be made per hunk.
  --

  --*
  -- * Line origin constants.
  -- *
  --  * These values describe where a line came from and will be passed to
  --  * the git_diff_line_cb when iterating over a diff.  There are some
  --  * special origin constants at the end that are used for the text
  --  * output callbacks to demarcate lines that are actually part of
  --  * the file or hunk headers.
  --

  --  These values will be sent to `git_diff_line_cb` along with the line
  --*< Both files have no LF at end
  --*< Old has no LF at end, new does
  --*< Old has LF at end, new does not
  --  The following values will only be sent to a `git_diff_line_cb` when
  --     * the content of a diff is being formatted through `git_diff_print`.
  --

  --*< For "Binary files x and y differ"
  --*
  --  * Structure describing a line (or data span) of a diff.
  --  *
  --  * A `line` is a range of characters inside a hunk.  It could be a context
  --  * line (i.e. in both old and new versions), an added line (i.e. only in
  --  * the new version), or a removed line (i.e. only in the old version).
  --  * Unfortunately, we don't know anything about the encoding of data in the
  --  * file being diffed, so we cannot tell you much about the line content.
  --  * Line data will not be NUL-byte terminated, however, because it will be
  --  * just a span of bytes inside the larger file.
  --

  --*< A git_diff_line_t value
  --*< Line number in old file or -1 for added line
  --*< Line number in new file or -1 for deleted line
  --*< Number of newline characters in content
  --*< Number of bytes of data
  --*< Offset in the original file to the content
  --*< Pointer to diff text, not NUL-byte terminated
  --*
  --  * When iterating over a diff, callback that will be made per text diff
  --  * line. In this context, the provided range will be NULL.
  --  *
  --  * When printing a diff, callback that will be made to output each line
  --  * of text.  This uses some extra GIT_DIFF_LINE_... constants for output
  --  * of lines of file and hunk headers.
  --

  --*< delta that contains this data
  --*< hunk containing this data
  --*< line data
  --*< user reference data
  --*
  --  * Flags to control the behavior of diff rename/copy detection.
  --

  --* Obey `diff.renames`. Overridden by any other GIT_DIFF_FIND_... flag.
  --* Look for renames? (`--find-renames`)
  --* Consider old side of MODIFIED for renames? (`--break-rewrites=N`)
  --* Look for copies? (a la `--find-copies`).
  --* Consider UNMODIFIED as copy sources? (`--find-copies-harder`).
  --     *
  --     * For this to work correctly, use GIT_DIFF_INCLUDE_UNMODIFIED when
  --     * the initial `git_diff` is being generated.
  --

  --* Mark significant rewrites for split (`--break-rewrites=/M`)
  --* Actually split large rewrites into delete/add pairs
  --* Mark rewrites for split and break into delete/add pairs
  --* Find renames/copies for UNTRACKED items in working directory.
  --     *
  --     * For this to work correctly, use GIT_DIFF_INCLUDE_UNTRACKED when the
  --     * initial `git_diff` is being generated (and obviously the diff must
  --     * be against the working directory for this to make sense).
  --

  --* Turn on all finding features.
  --* Measure similarity ignoring leading whitespace (default)
  --* Measure similarity ignoring all whitespace
  --* Measure similarity including all data
  --* Measure similarity only by comparing SHAs (fast and cheap)
  --* Do not break rewrites unless they contribute to a rename.
  --     *
  --     * Normally, GIT_DIFF_FIND_AND_BREAK_REWRITES will measure the self-
  --     * similarity of modified files and split the ones that have changed a
  --     * lot into a DELETE / ADD pair.  Then the sides of that pair will be
  --     * considered candidates for rename and copy detection.
  --     *
  --     * If you add this flag in and the split pair is *not* used for an
  --     * actual rename or copy, then the modified record will be restored to
  --     * a regular MODIFIED record instead of being split.
  --

  --* Remove any UNMODIFIED deltas after find_similar is done.
  --     *
  --     * Using GIT_DIFF_FIND_COPIES_FROM_UNMODIFIED to emulate the
  --     * --find-copies-harder behavior requires building a diff with the
  --     * GIT_DIFF_INCLUDE_UNMODIFIED flag.  If you do not want UNMODIFIED
  --     * records in the final result, pass this flag to have them removed.
  --

  --*
  --  * Pluggable similarity metric
  --

  --*
  --  * Control behavior of rename and copy detection
  --  *
  --  * These options mostly mimic parameters that can be passed to git-diff.
  --

  --*
  --     * Combination of git_diff_find_t values (default GIT_DIFF_FIND_BY_CONFIG).
  --     * NOTE: if you don't explicitly set this, `diff.renames` could be set
  --     * to false, resulting in `git_diff_find_similar` doing nothing.
  --

  --*
  --     * Threshold above which similar files will be considered renames.
  --     * This is equivalent to the -M option. Defaults to 50.
  --

  --*
  --     * Threshold below which similar files will be eligible to be a rename source.
  --     * This is equivalent to the first part of the -B option. Defaults to 50.
  --

  --*
  --     * Threshold above which similar files will be considered copies.
  --     * This is equivalent to the -C option. Defaults to 50.
  --

  --*
  --     * Treshold below which similar files will be split into a delete/add pair.
  --     * This is equivalent to the last part of the -B option. Defaults to 60.
  --

  --*
  --     * Maximum number of matches to consider for a particular file.
  --     *
  --     * This is a little different from the `-l` option from Git because we
  --     * will still process up to this many matches before abandoning the search.
  --     * Defaults to 200.
  --

  --*
  --     * The `metric` option allows you to plug in a custom similarity metric.
  --     *
  --     * Set it to NULL to use the default internal metric.
  --     *
  --     * The default metric is based on sampling hashes of ranges of data in
  --     * the file, which is a pretty good similarity approximation that should
  --     * work fairly well for both text and binary data while still being
  --     * pretty fast with a fixed memory overhead.
  --

  --*
  --  * Initialize git_diff_find_options structure
  --  *
  --  * Initializes a `git_diff_find_options` with default values. Equivalent to creating
  --  * an instance with GIT_DIFF_FIND_OPTIONS_INIT.
  --  *
  --  * @param opts The `git_diff_find_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_DIFF_FIND_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

  --* @name Diff Generator Functions
  -- *
  --  * These are the functions you would use to create (or destroy) a
  --  * git_diff from various objects in a repository.
  --

  --*@{
  --*
  -- * Deallocate a diff.
  -- *
  --  * @param diff The previously created diff; cannot be used after free.
  --

  --*
  --  * Create a diff with the difference between two tree objects.
  --  *
  --  * This is equivalent to `git diff <old-tree> <new-tree>`
  --  *
  --  * The first tree will be used for the "old_file" side of the delta and the
  --  * second tree will be used for the "new_file" side of the delta.  You can
  --  * pass NULL to indicate an empty tree, although it is an error to pass
  --  * NULL for both the `old_tree` and `new_tree`.
  --  *
  --  * @param diff Output pointer to a git_diff pointer to be allocated.
  --  * @param repo The repository containing the trees.
  --  * @param old_tree A git_tree object to diff from, or NULL for empty tree.
  --  * @param new_tree A git_tree object to diff to, or NULL for empty tree.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

  --*
  --  * Create a diff between a tree and repository index.
  --  *
  --  * This is equivalent to `git diff --cached <treeish>` or if you pass
  --  * the HEAD tree, then like `git diff --cached`.
  --  *
  --  * The tree you pass will be used for the "old_file" side of the delta, and
  --  * the index will be used for the "new_file" side of the delta.
  --  *
  --  * If you pass NULL for the index, then the existing index of the `repo`
  --  * will be used.  In this case, the index will be refreshed from disk
  --  * (if it has changed) before the diff is generated.
  --  *
  --  * @param diff Output pointer to a git_diff pointer to be allocated.
  --  * @param repo The repository containing the tree and index.
  --  * @param old_tree A git_tree object to diff from, or NULL for empty tree.
  --  * @param index The index to diff with; repo index used if NULL.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

  --*
  --  * Create a diff between the repository index and the workdir directory.
  --  *
  --  * This matches the `git diff` command.  See the note below on
  --  * `git_diff_tree_to_workdir` for a discussion of the difference between
  --  * `git diff` and `git diff HEAD` and how to emulate a `git diff <treeish>`
  --  * using libgit2.
  --  *
  --  * The index will be used for the "old_file" side of the delta, and the
  --  * working directory will be used for the "new_file" side of the delta.
  --  *
  --  * If you pass NULL for the index, then the existing index of the `repo`
  --  * will be used.  In this case, the index will be refreshed from disk
  --  * (if it has changed) before the diff is generated.
  --  *
  --  * @param diff Output pointer to a git_diff pointer to be allocated.
  --  * @param repo The repository.
  --  * @param index The index to diff from; repo index used if NULL.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

  --*
  --  * Create a diff between a tree and the working directory.
  --  *
  --  * The tree you provide will be used for the "old_file" side of the delta,
  --  * and the working directory will be used for the "new_file" side.
  --  *
  --  * This is not the same as `git diff <treeish>` or `git diff-index
  --  * <treeish>`.  Those commands use information from the index, whereas this
  --  * function strictly returns the differences between the tree and the files
  --  * in the working directory, regardless of the state of the index.  Use
  --  * `git_diff_tree_to_workdir_with_index` to emulate those commands.
  --  *
  --  * To see difference between this and `git_diff_tree_to_workdir_with_index`,
  --  * consider the example of a staged file deletion where the file has then
  --  * been put back into the working dir and further modified.  The
  --  * tree-to-workdir diff for that file is 'modified', but `git diff` would
  --  * show status 'deleted' since there is a staged delete.
  --  *
  --  * @param diff A pointer to a git_diff pointer that will be allocated.
  --  * @param repo The repository containing the tree.
  --  * @param old_tree A git_tree object to diff from, or NULL for empty tree.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

  --*
  --  * Create a diff between a tree and the working directory using index data
  --  * to account for staged deletes, tracked files, etc.
  --  *
  --  * This emulates `git diff <tree>` by diffing the tree to the index and
  --  * the index to the working directory and blending the results into a
  --  * single diff that includes staged deleted, etc.
  --  *
  --  * @param diff A pointer to a git_diff pointer that will be allocated.
  --  * @param repo The repository containing the tree.
  --  * @param old_tree A git_tree object to diff from, or NULL for empty tree.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

  --*
  --  * Create a diff with the difference between two index objects.
  --  *
  --  * The first index will be used for the "old_file" side of the delta and the
  --  * second index will be used for the "new_file" side of the delta.
  --  *
  --  * @param diff Output pointer to a git_diff pointer to be allocated.
  --  * @param repo The repository containing the indexes.
  --  * @param old_index A git_index object to diff from.
  --  * @param new_index A git_index object to diff to.
  --  * @param opts Structure with options to influence diff or NULL for defaults.
  --

  --*
  --  * Merge one diff into another.
  --  *
  --  * This merges items from the "from" list into the "onto" list.  The
  --  * resulting diff will have all items that appear in either list.
  --  * If an item appears in both lists, then it will be "merged" to appear
  --  * as if the old version was from the "onto" list and the new version
  --  * is from the "from" list (with the exception that if the item has a
  --  * pending DELETE in the middle, then it will show as deleted).
  --  *
  --  * @param onto Diff to merge into.
  --  * @param from Diff to merge.
  --

  --*
  --  * Transform a diff marking file renames, copies, etc.
  --  *
  --  * This modifies a diff in place, replacing old entries that look
  --  * like renames or copies with new entries reflecting those changes.
  --  * This also will, if requested, break modified files into add/remove
  --  * pairs if the amount of change is above a threshold.
  --  *
  --  * @param diff diff to run detection algorithms on
  --  * @param options Control how detection should be run, NULL for defaults
  --  * @return 0 on success, -1 on failure
  --

  --*@}
  --* @name Diff Processor Functions
  -- *
  --  * These are the functions you apply to a diff to process it
  --  * or read it in some way.
  --

  --*@{
  --*
  --  * Query how many diff records are there in a diff.
  --  *
  --  * @param diff A git_diff generated by one of the above functions
  --  * @return Count of number of deltas in the list
  --

  --*
  --  * Query how many diff deltas are there in a diff filtered by type.
  --  *
  --  * This works just like `git_diff_entrycount()` with an extra parameter
  --  * that is a `git_delta_t` and returns just the count of how many deltas
  --  * match that particular type.
  --  *
  --  * @param diff A git_diff generated by one of the above functions
  --  * @param type A git_delta_t value to filter the count
  --  * @return Count of number of deltas matching delta_t type
  --

  --*
  --  * Return the diff delta for an entry in the diff list.
  --  *
  --  * The `git_diff_delta` pointer points to internal data and you do not
  --  * have to release it when you are done with it.  It will go away when
  --  * the * `git_diff` (or any associated `git_patch`) goes away.
  --  *
  --  * Note that the flags on the delta related to whether it has binary
  --  * content or not may not be set if there are no attributes set for the
  --  * file and there has been no reason to load the file data at this point.
  --  * For now, if you need those flags to be up to date, your only option is
  --  * to either use `git_diff_foreach` or create a `git_patch`.
  --  *
  --  * @param diff Diff list object
  --  * @param idx Index into diff list
  --  * @return Pointer to git_diff_delta (or NULL if `idx` out of range)
  --

  --*
  --  * Check if deltas are sorted case sensitively or insensitively.
  --  *
  --  * @param diff diff to check
  --  * @return 0 if case sensitive, 1 if case is ignored
  --

  --*
  --  * Loop over all deltas in a diff issuing callbacks.
  --  *
  --  * This will iterate through all of the files described in a diff.  You
  --  * should provide a file callback to learn about each file.
  --  *
  --  * The "hunk" and "line" callbacks are optional, and the text diff of the
  --  * files will only be calculated if they are not NULL.  Of course, these
  --  * callbacks will not be invoked for binary files on the diff or for
  --  * files whose only changed is a file mode change.
  --  *
  --  * Returning a non-zero value from any of the callbacks will terminate
  --  * the iteration and return the value to the user.
  --  *
  --  * @param diff A git_diff generated by one of the above functions.
  --  * @param file_cb Callback function to make per file in the diff.
  --  * @param binary_cb Optional callback to make for binary files.
  --  * @param hunk_cb Optional callback to make per hunk of text diff.  This
  --  *                callback is called to describe a range of lines in the
  --  *                diff.  It will not be issued for binary files.
  --  * @param line_cb Optional callback to make per line of diff text.  This
  --  *                same callback will be made for context lines, added, and
  --  *                removed lines, and even for a deleted trailing newline.
  --  * @param payload Reference pointer that will be passed to your callbacks.
  --  * @return 0 on success, non-zero callback return value, or error code
  --

  --*
  --  * Look up the single character abbreviation for a delta status code.
  --  *
  --  * When you run `git diff --name-status` it uses single letter codes in
  --  * the output such as 'A' for added, 'D' for deleted, 'M' for modified,
  --  * etc.  This function converts a git_delta_t value into these letters for
  --  * your own purposes.  GIT_DELTA_UNTRACKED will return a space (i.e. ' ').
  --  *
  --  * @param status The git_delta_t value to look up
  --  * @return The single character label for that code
  --

  --*
  --  * Possible output formats for diff data
  --

  --*< full git diff
  --*< just the file headers of patch
  --*< like git diff --raw
  --*< like git diff --name-only
  --*< like git diff --name-status
  --*< git diff as used by git patch-id
  --*
  --  * Iterate over a diff generating formatted text output.
  --  *
  --  * Returning a non-zero value from the callbacks will terminate the
  --  * iteration and return the non-zero value to the caller.
  --  *
  --  * @param diff A git_diff generated by one of the above functions.
  --  * @param format A git_diff_format_t value to pick the text format.
  --  * @param print_cb Callback to make per line of diff text.
  --  * @param payload Reference pointer that will be passed to your callback.
  --  * @return 0 on success, non-zero callback return value, or error code
  --

  --*
  --  * Produce the complete formatted text output from a diff into a
  --  * buffer.
  --  *
  --  * @param out A pointer to a user-allocated git_buf that will
  --  *            contain the diff text
  --  * @param diff A git_diff generated by one of the above functions.
  --  * @param format A git_diff_format_t value to pick the text format.
  --  * @return 0 on success or error code
  --

  --*@}
  -- * Misc
  --

  --*
  --  * Directly run a diff on two blobs.
  --  *
  --  * Compared to a file, a blob lacks some contextual information. As such,
  --  * the `git_diff_file` given to the callback will have some fake data; i.e.
  --  * `mode` will be 0 and `path` will be NULL.
  --  *
  --  * NULL is allowed for either `old_blob` or `new_blob` and will be treated
  --  * as an empty blob, with the `oid` set to NULL in the `git_diff_file` data.
  --  * Passing NULL for both blobs is a noop; no callbacks will be made at all.
  --  *
  --  * We do run a binary content check on the blob content and if either blob
  --  * looks like binary data, the `git_diff_delta` binary attribute will be set
  --  * to 1 and no call to the hunk_cb nor line_cb will be made (unless you pass
  --  * `GIT_DIFF_FORCE_TEXT` of course).
  --  *
  --  * @param old_blob Blob for old side of diff, or NULL for empty blob
  --  * @param old_as_path Treat old blob as if it had this filename; can be NULL
  --  * @param new_blob Blob for new side of diff, or NULL for empty blob
  --  * @param new_as_path Treat new blob as if it had this filename; can be NULL
  --  * @param options Options for diff, or NULL for default options
  --  * @param file_cb Callback for "file"; made once if there is a diff; can be NULL
  --  * @param binary_cb Callback for binary files; can be NULL
  --  * @param hunk_cb Callback for each hunk in diff; can be NULL
  --  * @param line_cb Callback for each line in diff; can be NULL
  --  * @param payload Payload passed to each callback function
  --  * @return 0 on success, non-zero callback return value, or error code
  --

  --*
  --  * Directly run a diff between a blob and a buffer.
  --  *
  --  * As with `git_diff_blobs`, comparing a blob and buffer lacks some context,
  --  * so the `git_diff_file` parameters to the callbacks will be faked a la the
  --  * rules for `git_diff_blobs()`.
  --  *
  --  * Passing NULL for `old_blob` will be treated as an empty blob (i.e. the
  --  * `file_cb` will be invoked with GIT_DELTA_ADDED and the diff will be the
  --  * entire content of the buffer added).  Passing NULL to the buffer will do
  --  * the reverse, with GIT_DELTA_REMOVED and blob content removed.
  --  *
  --  * @param old_blob Blob for old side of diff, or NULL for empty blob
  --  * @param old_as_path Treat old blob as if it had this filename; can be NULL
  --  * @param buffer Raw data for new side of diff, or NULL for empty
  --  * @param buffer_len Length of raw data for new side of diff
  --  * @param buffer_as_path Treat buffer as if it had this filename; can be NULL
  --  * @param options Options for diff, or NULL for default options
  --  * @param file_cb Callback for "file"; made once if there is a diff; can be NULL
  --  * @param binary_cb Callback for binary files; can be NULL
  --  * @param hunk_cb Callback for each hunk in diff; can be NULL
  --  * @param line_cb Callback for each line in diff; can be NULL
  --  * @param payload Payload passed to each callback function
  --  * @return 0 on success, non-zero callback return value, or error code
  --

  --*
  --  * Directly run a diff between two buffers.
  --  *
  --  * Even more than with `git_diff_blobs`, comparing two buffer lacks
  --  * context, so the `git_diff_file` parameters to the callbacks will be
  --  * faked a la the rules for `git_diff_blobs()`.
  --  *
  --  * @param old_buffer Raw data for old side of diff, or NULL for empty
  --  * @param old_len Length of the raw data for old side of the diff
  --  * @param old_as_path Treat old buffer as if it had this filename; can be NULL
  --  * @param new_buffer Raw data for new side of diff, or NULL for empty
  --  * @param new_len Length of raw data for new side of diff
  --  * @param new_as_path Treat buffer as if it had this filename; can be NULL
  --  * @param options Options for diff, or NULL for default options
  --  * @param file_cb Callback for "file"; made once if there is a diff; can be NULL
  --  * @param binary_cb Callback for binary files; can be NULL
  --  * @param hunk_cb Callback for each hunk in diff; can be NULL
  --  * @param line_cb Callback for each line in diff; can be NULL
  --  * @param payload Payload passed to each callback function
  --  * @return 0 on success, non-zero callback return value, or error code
  --

  --*
  --  * Read the contents of a git patch file into a `git_diff` object.
  --  *
  --  * The diff object produced is similar to the one that would be
  --  * produced if you actually produced it computationally by comparing
  --  * two trees, however there may be subtle differences.  For example,
  --  * a patch file likely contains abbreviated object IDs, so the
  --  * object IDs in a `git_diff_delta` produced by this function will
  --  * also be abbreviated.
  --  *
  --  * This function will only read patch files created by a git
  --  * implementation, it will not read unified diffs produced by
  --  * the `diff` program, nor any other types of patch files.
  --  *
  --  * @param out A pointer to a git_diff pointer that will be allocated.
  --  * @param content The contents of a patch file
  --  * @param content_len The length of the patch file contents
  --  * @return 0 or an error code
  --

  --*
  --  * This is an opaque structure which is allocated by `git_diff_get_stats`.
  --  * You are responsible for releasing the object memory when done, using the
  --  * `git_diff_stats_free()` function.
  --

  --*
  --  * Formatting options for diff stats
  --

  --* No stats
  --* Full statistics, equivalent of `--stat`
  --* Short statistics, equivalent of `--shortstat`
  --* Number statistics, equivalent of `--numstat`
  --* Extended header information such as creations, renames and mode changes, equivalent of `--summary`
  --*
  --  * Accumulate diff statistics for all patches.
  --  *
  --  * @param out Structure containg the diff statistics.
  --  * @param diff A git_diff generated by one of the above functions.
  --  * @return 0 on success; non-zero on error
  --

  --*
  --  * Get the total number of files changed in a diff
  --  *
  --  * @param stats A `git_diff_stats` generated by one of the above functions.
  --  * @return total number of files changed in the diff
  --

  --*
  --  * Get the total number of insertions in a diff
  --  *
  --  * @param stats A `git_diff_stats` generated by one of the above functions.
  --  * @return total number of insertions in the diff
  --

  --*
  --  * Get the total number of deletions in a diff
  --  *
  --  * @param stats A `git_diff_stats` generated by one of the above functions.
  --  * @return total number of deletions in the diff
  --

  --*
  --  * Print diff statistics to a `git_buf`.
  --  *
  --  * @param out buffer to store the formatted diff statistics in.
  --  * @param stats A `git_diff_stats` generated by one of the above functions.
  --  * @param format Formatting option.
  --  * @param width Target width for output (only affects GIT_DIFF_STATS_FULL)
  --  * @return 0 on success; non-zero on error
  --

  --*
  --  * Deallocate a `git_diff_stats`.
  --  *
  --  * @param stats The previously created statistics object;
  --  * cannot be used after free.
  --

  --*
  --  * Formatting options for diff e-mail generation
  --

  --* Normal patch, the default
  --* Don't insert "[PATCH]" in the subject header
  --*
  --  * Options for controlling the formatting of the generated e-mail.
  --

  --* see `git_diff_format_email_flags_t` above
  --* This patch number
  --* Total number of patches in this series
  --* id to use for the commit
  --* Summary of the change
  --* Commit message's body
  --* Author of the change
  --*
  --  * Create an e-mail ready patch from a diff.
  --  *
  --  * @param out buffer to store the e-mail patch in
  --  * @param diff containing the commit
  --  * @param opts structure with options to influence content and formatting.
  --  * @return 0 or an error code
  --

  --*
  --  * Create an e-mail ready patch for a commit.
  --  *
  --  * Does not support creating patches for merge commits (yet).
  --  *
  --  * @param out buffer to store the e-mail patch in
  --  * @param repo containing the commit
  --  * @param commit pointer to up commit
  --  * @param patch_no patch number of the commit
  --  * @param total_patches total number of patches in the patch set
  --  * @param flags determines the formatting of the e-mail
  --  * @param diff_opts structure with options to influence diff or NULL for defaults.
  --  * @return 0 or an error code
  --

  --*
  --  * Initialize git_diff_format_email_options structure
  --  *
  --  * Initializes a `git_diff_format_email_options` with default values. Equivalent
  --  * to creating an instance with GIT_DIFF_FORMAT_EMAIL_OPTIONS_INIT.
  --  *
  --  * @param opts The `git_blame_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_DIFF_FORMAT_EMAIL_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

  --*
  --  * Patch ID options structure
  --  *
  --  * Initialize with `GIT_PATCHID_OPTIONS_INIT`. Alternatively, you can
  --  * use `git_diff_patchid_options_init`.
  --  *
  --

  --*
  --  * Initialize git_diff_patchid_options structure
  --  *
  --  * Initializes a `git_diff_patchid_options` with default values. Equivalent to
  --  * creating an instance with `GIT_DIFF_PATCHID_OPTIONS_INIT`.
  --  *
  --  * @param opts The `git_diff_patchid_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_DIFF_PATCHID_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

  --*
  --  * Calculate the patch ID for the given patch.
  --  *
  --  * Calculate a stable patch ID for the given patch by summing the
  --  * hash of the file diffs, ignoring whitespace and line numbers.
  --  * This can be used to derive whether two diffs are the same with
  --  * a high probability.
  --  *
  --  * Currently, this function only calculates stable patch IDs, as
  --  * defined in git-patch-id(1), and should in fact generate the
  --  * same IDs as the upstream git project does.
  --  *
  --  * @param out Pointer where the calculated patch ID should be stored
  --  * @param diff The diff to calculate the ID for
  --  * @param opts Options for how to calculate the patch ID. This is
  --  *  intended for future changes, as currently no options are
  --  *  available.
  --  * @return 0 on success, an error code otherwise.
  --

   function git_diff_patchid
     (c_out : access git.Low_Level.git2_oid_h.git_oid;
      diff  : access git_diff;
      opts  : access git_diff_patchid_options) return int  -- /usr/include/git2/diff.h:1504
      with Import   => True,
      Convention    => C,
      External_Name => "git_diff_patchid";

  --* @}
end git.Low_Level.git2_diff_h;

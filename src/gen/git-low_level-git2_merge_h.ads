pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;


limited with git.Low_Level.git2_diff_h;
limited with git.Low_Level.git2_types_h;
with System;
limited with git.Low_Level.git2_oid_h;
limited with git.Low_Level.git2_oidarray_h;
limited with git.Low_Level.git2_index_h;
limited with git.Low_Level.git2_checkout_h;

package git.Low_Level.git2_merge_h is

   GIT_MERGE_FILE_INPUT_VERSION : constant := 1;  --  /usr/include/git2/merge.h:48
   --  unsupported macro: GIT_MERGE_FILE_INPUT_INIT {GIT_MERGE_FILE_INPUT_VERSION}

   GIT_MERGE_CONFLICT_MARKER_SIZE : constant := 7;  --  /usr/include/git2/merge.h:165

   GIT_MERGE_FILE_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/merge.h:202
   --  unsupported macro: GIT_MERGE_FILE_OPTIONS_INIT {GIT_MERGE_FILE_OPTIONS_VERSION}

   GIT_MERGE_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/merge.h:297
   --  unsupported macro: GIT_MERGE_OPTIONS_INIT { GIT_MERGE_OPTIONS_VERSION, GIT_MERGE_FIND_RENAMES }

   --  * Copyright (C) the libgit2 contributors. All rights reserved.
   --  *
   --  * This file is part of libgit2, distributed under the GNU GPL v2 with
   --  * a Linking Exception. For full terms see the included COPYING file.
  --

   --*
  -- * @file git2/merge.h
  --  * @brief Git merge routines
  --  * @defgroup git_merge Git merge routines
  --  * @ingroup Git
  --  * @{
  --

   --*
  --  * The file inputs to `git_merge_file`.  Callers should populate the
  --  * `git_merge_file_input` structure with descriptions of the files in
  --  * each side of the conflict for use in producing the merge file.
  --

   --  skipped anonymous struct anon_anon_78

   type git_merge_file_input is record
      version : aliased unsigned;  -- /usr/include/git2/merge.h:33
      ptr     : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/merge.h:36
      size    : aliased unsigned_long;  -- /usr/include/git2/merge.h:39
      path    : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/merge.h:42
      mode    : aliased unsigned;  -- /usr/include/git2/merge.h:45
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/merge.h:46

  --* Pointer to the contents of the file.
  --* Size of the contents pointed to in `ptr`.
  --* File name of the conflicted file, or `NULL` to not merge the path.
  --* File mode of the conflicted file, or `0` to not merge the mode.
  --*
  --  * Initializes a `git_merge_file_input` with default values. Equivalent to
  --  * creating an instance with GIT_MERGE_FILE_INPUT_INIT.
  --  *
  --  * @param opts the `git_merge_file_input` instance to initialize.
  --  * @param version the version of the struct; you should pass
  --  *        `GIT_MERGE_FILE_INPUT_VERSION` here.
  --  * @return Zero on success; -1 on failure.
  --

   function git_merge_file_input_init (opts : access git_merge_file_input; version : unsigned) return int  -- /usr/include/git2/merge.h:60
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_file_input_init";

  --*
  --  * Flags for `git_merge` options.  A combination of these flags can be
  --  * passed in via the `flags` value in the `git_merge_options`.
  --

  --*
  --     * Detect renames that occur between the common ancestor and the "ours"
  --     * side or the common ancestor and the "theirs" side.  This will enable
  --     * the ability to merge between a modified and renamed file.
  --

  --*
  --     * If a conflict occurs, exit immediately instead of attempting to
  --     * continue resolving conflicts.  The merge operation will fail with
  --     * GIT_EMERGECONFLICT and no index will be returned.
  --

  --*
  --     * Do not write the REUC extension on the generated index
  --

  --*
  --     * If the commits being merged have multiple merge bases, do not build
  --     * a recursive merge base (by merging the multiple merge bases),
  --     * instead simply use the first base.  This flag provides a similar
  --     * merge base to `git-merge-resolve`.
  --

   subtype git_merge_flag_t is unsigned;
   GIT_MERGE_FIND_RENAMES     : constant unsigned := 1;
   GIT_MERGE_FAIL_ON_CONFLICT : constant unsigned := 2;
   GIT_MERGE_SKIP_REUC        : constant unsigned := 4;
   GIT_MERGE_NO_RECURSIVE     : constant unsigned := 8;  -- /usr/include/git2/merge.h:95

  --*
  --  * Merge file favor options for `git_merge_options` instruct the file-level
  --  * merging functionality how to deal with conflicting regions of the files.
  --

  --*
  --     * When a region of a file is changed in both branches, a conflict
  --     * will be recorded in the index so that `git_checkout` can produce
  --     * a merge file with conflict markers in the working directory.
  --     * This is the default.
  --

  --*
  --     * When a region of a file is changed in both branches, the file
  --     * created in the index will contain the "ours" side of any conflicting
  --     * region.  The index will not record a conflict.
  --

  --*
  --     * When a region of a file is changed in both branches, the file
  --     * created in the index will contain the "theirs" side of any conflicting
  --     * region.  The index will not record a conflict.
  --

  --*
  --     * When a region of a file is changed in both branches, the file
  --     * created in the index will contain each unique line from each side,
  --     * which has the result of combining both files.  The index will not
  --     * record a conflict.
  --

   type git_merge_file_favor_t is
     (GIT_MERGE_FILE_FAVOR_NORMAL,
      GIT_MERGE_FILE_FAVOR_OURS,
      GIT_MERGE_FILE_FAVOR_THEIRS,
      GIT_MERGE_FILE_FAVOR_UNION)
      with Convention => C;  -- /usr/include/git2/merge.h:131

  --*
  -- * File merging flags
  --

  --* Defaults
  --* Create standard conflicted merge files
  --* Create diff3-style files
  --* Condense non-alphanumeric regions for simplified diff file
  --* Ignore all whitespace
  --* Ignore changes in amount of whitespace
  --* Ignore whitespace at end of line
  --* Use the "patience diff" algorithm
  --* Take extra time to find minimal diff
   subtype git_merge_file_flag_t is unsigned;
   GIT_MERGE_FILE_DEFAULT                  : constant unsigned := 0;
   GIT_MERGE_FILE_STYLE_MERGE              : constant unsigned := 1;
   GIT_MERGE_FILE_STYLE_DIFF3              : constant unsigned := 2;
   GIT_MERGE_FILE_SIMPLIFY_ALNUM           : constant unsigned := 4;
   GIT_MERGE_FILE_IGNORE_WHITESPACE        : constant unsigned := 8;
   GIT_MERGE_FILE_IGNORE_WHITESPACE_CHANGE : constant unsigned := 16;
   GIT_MERGE_FILE_IGNORE_WHITESPACE_EOL    : constant unsigned := 32;
   GIT_MERGE_FILE_DIFF_PATIENCE            : constant unsigned := 64;
   GIT_MERGE_FILE_DIFF_MINIMAL             : constant unsigned := 128;  -- /usr/include/git2/merge.h:163

  --*
  --  * Options for merging a file
  --

   --  skipped anonymous struct anon_anon_82

   type git_merge_file_options is record
      version        : aliased unsigned;  -- /usr/include/git2/merge.h:171
      ancestor_label : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/merge.h:177
      our_label      : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/merge.h:183
      their_label    : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/merge.h:189
      favor          : aliased git_merge_file_favor_t;  -- /usr/include/git2/merge.h:192
      flags          : aliased unsigned;  -- /usr/include/git2/merge.h:195
      marker_size    : aliased unsigned_short;  -- /usr/include/git2/merge.h:199
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/merge.h:200

  --*
  --     * Label for the ancestor file side of the conflict which will be prepended
  --     * to labels in diff3-format merge files.
  --

  --*
  --     * Label for our file side of the conflict which will be prepended
  --     * to labels in merge files.
  --

  --*
  --     * Label for their file side of the conflict which will be prepended
  --     * to labels in merge files.
  --

  --* The file to favor in region conflicts.
  --* see `git_merge_file_flag_t` above
  --* The size of conflict markers (eg, "<<<<<<<").  Default is
  --     * GIT_MERGE_CONFLICT_MARKER_SIZE.

  --*
  --  * Initialize git_merge_file_options structure
  --  *
  --  * Initializes a `git_merge_file_options` with default values. Equivalent to
  --  * creating an instance with `GIT_MERGE_FILE_OPTIONS_INIT`.
  --  *
  --  * @param opts The `git_merge_file_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_MERGE_FILE_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_merge_file_options_init (opts : access git_merge_file_options; version : unsigned) return int  -- /usr/include/git2/merge.h:215
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_file_options_init";

  --*
  --  * Information about file-level merging
  --

  --*
  --     * True if the output was automerged, false if the output contains
  --     * conflict markers.
  --

   --  skipped anonymous struct anon_anon_83

   type git_merge_file_result is record
      automergeable : aliased unsigned;  -- /usr/include/git2/merge.h:225
      path          : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/merge.h:231
      mode          : aliased unsigned;  -- /usr/include/git2/merge.h:234
      ptr           : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/merge.h:237
      len           : aliased unsigned_long;  -- /usr/include/git2/merge.h:240
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/merge.h:241

  --*
  --     * The path that the resultant merge file should use, or NULL if a
  --     * filename conflict would occur.
  --

  --* The mode that the resultant merge file should use.
  --* The contents of the merge.
  --* The length of the merge contents.
  --*
  -- * Merging options
  --

   --  skipped anonymous struct anon_anon_84

   type git_merge_options is record
      version          : aliased unsigned;  -- /usr/include/git2/merge.h:247
      flags            : aliased unsigned;  -- /usr/include/git2/merge.h:250
      rename_threshold : aliased unsigned;  -- /usr/include/git2/merge.h:259
      target_limit     : aliased unsigned;  -- /usr/include/git2/merge.h:268
      metric           : access git.Low_Level.git2_diff_h.git_diff_similarity_metric;  -- /usr/include/git2/merge.h:271
      recursion_limit  : aliased unsigned;  -- /usr/include/git2/merge.h:279
      default_driver   : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/merge.h:285
      file_favor       : aliased git_merge_file_favor_t;  -- /usr/include/git2/merge.h:291
      file_flags       : aliased unsigned;  -- /usr/include/git2/merge.h:294
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/merge.h:295

  --* See `git_merge_flag_t` above
  --*
  --     * Similarity to consider a file renamed (default 50).  If
  --     * `GIT_MERGE_FIND_RENAMES` is enabled, added files will be compared
  --     * with deleted files to determine their similarity.  Files that are
  --     * more similar than the rename threshold (percentage-wise) will be
  --     * treated as a rename.
  --

  --*
  --     * Maximum similarity sources to examine for renames (default 200).
  --     * If the number of rename candidates (add / delete pairs) is greater
  --     * than this value, inexact rename detection is aborted.
  --     *
  --     * This setting overrides the `merge.renameLimit` configuration value.
  --

  --* Pluggable similarity metric; pass NULL to use internal metric
  --*
  --     * Maximum number of times to merge common ancestors to build a
  --     * virtual merge base when faced with criss-cross merges.  When this
  --     * limit is reached, the next ancestor will simply be used instead of
  --     * attempting to merge it.  The default is unlimited.
  --

  --*
  --     * Default merge driver to be used when both sides of a merge have
  --     * changed.  The default is the `text` driver.
  --

  --*
  --     * Flags for handling conflicting content, to be used with the standard
  --     * (`text`) merge driver.
  --

  --* see `git_merge_file_flag_t` above
  --*
  --  * Initialize git_merge_options structure
  --  *
  --  * Initializes a `git_merge_options` with default values. Equivalent to
  --  * creating an instance with `GIT_MERGE_OPTIONS_INIT`.
  --  *
  --  * @param opts The `git_merge_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_MERGE_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_merge_options_init (opts : access git_merge_options; version : unsigned) return int  -- /usr/include/git2/merge.h:311
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_options_init";

  --*
  --  * The results of `git_merge_analysis` indicate the merge opportunities.
  --

  --* No merge is possible.  (Unused.)
  --*
  --     * A "normal" merge; both HEAD and the given merge input have diverged
  --     * from their common ancestor.  The divergent commits must be merged.
  --

  --*
  --     * All given merge inputs are reachable from HEAD, meaning the
  --     * repository is up-to-date and no merge needs to be performed.
  --

  --*
  --     * The given merge input is a fast-forward from HEAD and no merge
  --     * needs to be performed.  Instead, the client can check out the
  --     * given merge input.
  --

  --*
  --     * The HEAD of the current repository is "unborn" and does not point to
  --     * a valid commit.  No merge can be performed, but the caller may wish
  --     * to simply set HEAD to the target commit(s).
  --

   subtype git_merge_analysis_t is unsigned;
   GIT_MERGE_ANALYSIS_NONE        : constant unsigned := 0;
   GIT_MERGE_ANALYSIS_NORMAL      : constant unsigned := 1;
   GIT_MERGE_ANALYSIS_UP_TO_DATE  : constant unsigned := 2;
   GIT_MERGE_ANALYSIS_FASTFORWARD : constant unsigned := 4;
   GIT_MERGE_ANALYSIS_UNBORN      : constant unsigned := 8;  -- /usr/include/git2/merge.h:345

  --*
  --  * The user's stated preference for merges.
  --

  --*
  --     * No configuration was found that suggests a preferred behavior for
  --     * merge.
  --

  --*
  --     * There is a `merge.ff=false` configuration setting, suggesting that
  --     * the user does not want to allow a fast-forward merge.
  --

  --*
  --     * There is a `merge.ff=only` configuration setting, suggesting that
  --     * the user only wants fast-forward merges.
  --

   type git_merge_preference_t is
     (GIT_MERGE_PREFERENCE_NONE,
      GIT_MERGE_PREFERENCE_NO_FASTFORWARD,
      GIT_MERGE_PREFERENCE_FASTFORWARD_ONLY)
      with Convention => C;  -- /usr/include/git2/merge.h:368

  --*
  --  * Analyzes the given branch(es) and determines the opportunities for
  --  * merging them into the HEAD of the repository.
  --  *
  --  * @param analysis_out analysis enumeration that the result is written into
  --  * @param repo the repository to merge
  --  * @param their_heads the heads to merge into
  --  * @param their_heads_len the number of heads to merge
  --  * @return 0 on success or error code
  --

   function git_merge_analysis
     (analysis_out    : access git_merge_analysis_t;
      preference_out  : access git_merge_preference_t;
      repo            : access git.Low_Level.git2_types_h.git_repository;
      their_heads     : System.Address;
      their_heads_len : unsigned_long) return int  -- /usr/include/git2/merge.h:380
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_analysis";

  --*
  --  * Analyzes the given branch(es) and determines the opportunities for
  --  * merging them into a reference.
  --  *
  --  * @param analysis_out analysis enumeration that the result is written into
  --  * @param repo the repository to merge
  --  * @param our_ref the reference to perform the analysis from
  --  * @param their_heads the heads to merge into
  --  * @param their_heads_len the number of heads to merge
  --  * @return 0 on success or error code
  --

   function git_merge_analysis_for_ref
     (analysis_out    : access git_merge_analysis_t;
      preference_out  : access git_merge_preference_t;
      repo            : access git.Low_Level.git2_types_h.git_repository;
      our_ref         : access git.Low_Level.git2_types_h.git_reference;
      their_heads     : System.Address;
      their_heads_len : unsigned_long) return int  -- /usr/include/git2/merge.h:398
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_analysis_for_ref";

  --*
  --  * Find a merge base between two commits
  --  *
  --  * @param out the OID of a merge base between 'one' and 'two'
  --  * @param repo the repository where the commits exist
  --  * @param one one of the commits
  --  * @param two the other commit
  --  * @return 0 on success, GIT_ENOTFOUND if not found or error code
  --

   function git_merge_base
     (c_out : access git.Low_Level.git2_oid_h.git_oid;
      repo  : access git.Low_Level.git2_types_h.git_repository;
      one   : access constant git.Low_Level.git2_oid_h.git_oid;
      two   : access constant git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/merge.h:415
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_base";

  --*
  --  * Find merge bases between two commits
  --  *
  --  * @param out array in which to store the resulting ids
  --  * @param repo the repository where the commits exist
  --  * @param one one of the commits
  --  * @param two the other commit
  --  * @return 0 on success, GIT_ENOTFOUND if not found or error code
  --

   function git_merge_bases
     (c_out : access git.Low_Level.git2_oidarray_h.git_oidarray;
      repo  : access git.Low_Level.git2_types_h.git_repository;
      one   : access constant git.Low_Level.git2_oid_h.git_oid;
      two   : access constant git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/merge.h:430
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_bases";

  --*
  --  * Find a merge base given a list of commits
  --  *
  --  * @param out the OID of a merge base considering all the commits
  --  * @param repo the repository where the commits exist
  --  * @param length The number of commits in the provided `input_array`
  --  * @param input_array oids of the commits
  --  * @return Zero on success; GIT_ENOTFOUND or -1 on failure.
  --

   function git_merge_base_many
     (c_out       : access git.Low_Level.git2_oid_h.git_oid;
      repo        : access git.Low_Level.git2_types_h.git_repository;
      length      : unsigned_long;
      input_array : access constant git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/merge.h:445
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_base_many";

  --*
  --  * Find all merge bases given a list of commits
  --  *
  --  * @param out array in which to store the resulting ids
  --  * @param repo the repository where the commits exist
  --  * @param length The number of commits in the provided `input_array`
  --  * @param input_array oids of the commits
  --  * @return Zero on success; GIT_ENOTFOUND or -1 on failure.
  --

   function git_merge_bases_many
     (c_out       : access git.Low_Level.git2_oidarray_h.git_oidarray;
      repo        : access git.Low_Level.git2_types_h.git_repository;
      length      : unsigned_long;
      input_array : access constant git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/merge.h:460
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_bases_many";

  --*
  --  * Find a merge base in preparation for an octopus merge
  --  *
  --  * @param out the OID of a merge base considering all the commits
  --  * @param repo the repository where the commits exist
  --  * @param length The number of commits in the provided `input_array`
  --  * @param input_array oids of the commits
  --  * @return Zero on success; GIT_ENOTFOUND or -1 on failure.
  --

   function git_merge_base_octopus
     (c_out       : access git.Low_Level.git2_oid_h.git_oid;
      repo        : access git.Low_Level.git2_types_h.git_repository;
      length      : unsigned_long;
      input_array : access constant git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/merge.h:475
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_base_octopus";

  --*
  --  * Merge two files as they exist in the in-memory data structures, using
  --  * the given common ancestor as the baseline, producing a
  --  * `git_merge_file_result` that reflects the merge result.  The
  --  * `git_merge_file_result` must be freed with `git_merge_file_result_free`.
  --  *
  --  * Note that this function does not reference a repository and any
  --  * configuration must be passed as `git_merge_file_options`.
  --  *
  --  * @param out The git_merge_file_result to be filled in
  --  * @param ancestor The contents of the ancestor file
  --  * @param ours The contents of the file in "our" side
  --  * @param theirs The contents of the file in "their" side
  --  * @param opts The merge file options or `NULL` for defaults
  --  * @return 0 on success or error code
  --

   function git_merge_file
     (c_out    : access git_merge_file_result;
      ancestor : access constant git_merge_file_input;
      ours     : access constant git_merge_file_input;
      theirs   : access constant git_merge_file_input;
      opts     : access constant git_merge_file_options) return int  -- /usr/include/git2/merge.h:497
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_file";

  --*
  --  * Merge two files as they exist in the index, using the given common
  --  * ancestor as the baseline, producing a `git_merge_file_result` that
  --  * reflects the merge result.  The `git_merge_file_result` must be freed with
  --  * `git_merge_file_result_free`.
  --  *
  --  * @param out The git_merge_file_result to be filled in
  --  * @param repo The repository
  --  * @param ancestor The index entry for the ancestor file (stage level 1)
  --  * @param ours The index entry for our file (stage level 2)
  --  * @param theirs The index entry for their file (stage level 3)
  --  * @param opts The merge file options or NULL
  --  * @return 0 on success or error code
  --

   function git_merge_file_from_index
     (c_out    : access git_merge_file_result;
      repo     : access git.Low_Level.git2_types_h.git_repository;
      ancestor : access constant git.Low_Level.git2_index_h.git_index_entry;
      ours     : access constant git.Low_Level.git2_index_h.git_index_entry;
      theirs   : access constant git.Low_Level.git2_index_h.git_index_entry;
      opts     : access constant git_merge_file_options) return int  -- /usr/include/git2/merge.h:518
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_file_from_index";

  --*
  --  * Frees a `git_merge_file_result`.
  --  *
  --  * @param result The result to free or `NULL`
  --

   procedure git_merge_file_result_free (result : access git_merge_file_result)  -- /usr/include/git2/merge.h:531
     with Import    => True,
      Convention    => C,
      External_Name => "git_merge_file_result_free";

  --*
  --  * Merge two trees, producing a `git_index` that reflects the result of
  --  * the merge.  The index may be written as-is to the working directory
  --  * or checked out.  If the index is to be converted to a tree, the caller
  --  * should resolve any conflicts that arose as part of the merge.
  --  *
  --  * The returned index must be freed explicitly with `git_index_free`.
  --  *
  --  * @param out pointer to store the index result in
  --  * @param repo repository that contains the given trees
  --  * @param ancestor_tree the common ancestor between the trees (or null if none)
  --  * @param our_tree the tree that reflects the destination tree
  --  * @param their_tree the tree to merge in to `our_tree`
  --  * @param opts the merge tree options (or null for defaults)
  --  * @return 0 on success or error code
  --

   function git_merge_trees
     (c_out         : System.Address;
      repo          : access git.Low_Level.git2_types_h.git_repository;
      ancestor_tree : access constant git.Low_Level.git2_types_h.git_tree;
      our_tree      : access constant git.Low_Level.git2_types_h.git_tree;
      their_tree    : access constant git.Low_Level.git2_types_h.git_tree;
      opts          : access constant git_merge_options) return int  -- /usr/include/git2/merge.h:549
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_trees";

  --*
  --  * Merge two commits, producing a `git_index` that reflects the result of
  --  * the merge.  The index may be written as-is to the working directory
  --  * or checked out.  If the index is to be converted to a tree, the caller
  --  * should resolve any conflicts that arose as part of the merge.
  --  *
  --  * The returned index must be freed explicitly with `git_index_free`.
  --  *
  --  * @param out pointer to store the index result in
  --  * @param repo repository that contains the given trees
  --  * @param our_commit the commit that reflects the destination tree
  --  * @param their_commit the commit to merge in to `our_commit`
  --  * @param opts the merge tree options (or null for defaults)
  --  * @return 0 on success or error code
  --

   function git_merge_commits
     (c_out        : System.Address;
      repo         : access git.Low_Level.git2_types_h.git_repository;
      our_commit   : access constant git.Low_Level.git2_types_h.git_commit;
      their_commit : access constant git.Low_Level.git2_types_h.git_commit;
      opts         : access constant git_merge_options) return int  -- /usr/include/git2/merge.h:572
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge_commits";

  --*
  --  * Merges the given commit(s) into HEAD, writing the results into the working
  --  * directory.  Any changes are staged for commit and any conflicts are written
  --  * to the index.  Callers should inspect the repository's index after this
  --  * completes, resolve any conflicts and prepare a commit.
  --  *
  --  * For compatibility with git, the repository is put into a merging
  --  * state. Once the commit is done (or if the uses wishes to abort),
  --  * you should clear this state by calling
  --  * `git_repository_state_cleanup()`.
  --  *
  --  * @param repo the repository to merge
  --  * @param their_heads the heads to merge into
  --  * @param their_heads_len the number of heads to merge
  --  * @param merge_opts merge options
  --  * @param checkout_opts checkout options
  --  * @return 0 on success or error code
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

   function git_merge
     (repo            : access git.Low_Level.git2_types_h.git_repository;
      their_heads     : System.Address;
      their_heads_len : unsigned_long;
      merge_opts      : access constant git_merge_options;
      checkout_opts : access constant git.Low_Level.git2_checkout_h.git_checkout_options) return int  -- /usr/include/git2/merge.h:597
      with Import   => True,
      Convention    => C,
      External_Name => "git_merge";

end git.Low_Level.git2_merge_h;

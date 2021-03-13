pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;


with git.Low_Level.git2_oid_h;
with Interfaces.C.Strings;
with System;
limited with git.Low_Level.git2_types_h;

limited with git.Low_Level.git2_strarray_h;

package git.Low_Level.git2_index_h is

   GIT_INDEX_ENTRY_NAMEMASK   : constant := (16#0fff#);  --  /usr/include/git2/index.h:80
   GIT_INDEX_ENTRY_STAGEMASK  : constant := (16#3000#);  --  /usr/include/git2/index.h:81
   GIT_INDEX_ENTRY_STAGESHIFT : constant := 12;  --  /usr/include/git2/index.h:82
   --  arg-macro: function GIT_INDEX_ENTRY_STAGE (E)
   --    return ((E).flags and GIT_INDEX_ENTRY_STAGEMASK) >> GIT_INDEX_ENTRY_STAGESHIFT;
   --  arg-macro: procedure GIT_INDEX_ENTRY_STAGE_SET (E, S)
   --    do { (E).flags := ((E).flags and ~GIT_INDEX_ENTRY_STAGEMASK) or (((S) and 16#03#) << GIT_INDEX_ENTRY_STAGESHIFT); } while (0)

   --  * Copyright (C) the libgit2 contributors. All rights reserved.
   --  *
   --  * This file is part of libgit2, distributed under the GNU GPL v2 with
   --  * a Linking Exception. For full terms see the included COPYING file.
  --

   --*
  -- * @file git2/index.h
  --  * @brief Git index parsing and manipulation routines
  --  * @defgroup git_index Git index parsing and manipulation routines
  --  * @ingroup Git
  --  * @{
  --

   --* Time structure used in a git index entry
   --  skipped anonymous struct anon_anon_72

   type git_index_time is record
      seconds     : aliased int;  -- /usr/include/git2/index.h:27
      nanoseconds : aliased unsigned;  -- /usr/include/git2/index.h:29
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/index.h:30

  --  nsec should not be stored as time_t compatible
  --*
  --  * In-memory representation of a file entry in the index.
  --  *
  --  * This is a public structure that represents a file entry in the index.
  --  * The meaning of the fields corresponds to core Git's documentation (in
  --  * "Documentation/technical/index-format.txt").
  --  *
  --  * The `flags` field consists of a number of bit fields which can be
  --  * accessed via the first set of `GIT_INDEX_ENTRY_...` bitmasks below.
  --  * These flags are all read from and persisted to disk.
  --  *
  --  * The `flags_extended` field also has a number of bit fields which can be
  --  * accessed via the later `GIT_INDEX_ENTRY_...` bitmasks below.  Some of
  --  * these flags are read from and written to disk, but some are set aside
  --  * for in-memory only reference.
  --  *
  --  * Note that the time and size fields are truncated to 32 bits. This
  --  * is enough to detect changes, which is enough for the index to
  --  * function as a cache, but it should not be taken as an authoritative
  --  * source for that data.
  --

   type git_index_entry is record
      ctime          : aliased git_index_time;  -- /usr/include/git2/index.h:54
      mtime          : aliased git_index_time;  -- /usr/include/git2/index.h:55
      dev            : aliased unsigned;  -- /usr/include/git2/index.h:57
      ino            : aliased unsigned;  -- /usr/include/git2/index.h:58
      mode           : aliased unsigned;  -- /usr/include/git2/index.h:59
      uid            : aliased unsigned;  -- /usr/include/git2/index.h:60
      gid            : aliased unsigned;  -- /usr/include/git2/index.h:61
      file_size      : aliased unsigned;  -- /usr/include/git2/index.h:62
      id             : aliased git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/index.h:64
      flags          : aliased unsigned_short;  -- /usr/include/git2/index.h:66
      flags_extended : aliased unsigned_short;  -- /usr/include/git2/index.h:67
      path           : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/index.h:69
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/index.h:53

  --*
  --  * Bitmasks for on-disk fields of `git_index_entry`'s `flags`
  --  *
  --  * These bitmasks match the four fields in the `git_index_entry` `flags`
  --  * value both in memory and on disk.  You can use them to interpret the
  --  * data in the `flags`.
  --

  --*
  -- * Flags for index entries
  --

   subtype git_index_entry_flag_t is unsigned;
   GIT_INDEX_ENTRY_EXTENDED : constant unsigned := 16_384;
   GIT_INDEX_ENTRY_VALID    : constant unsigned := 32_768;  -- /usr/include/git2/index.h:90

  --*
  --  * Bitmasks for on-disk fields of `git_index_entry`'s `flags_extended`
  --  *
  --  * In memory, the `flags_extended` fields are divided into two parts: the
  --  * fields that are read from and written to disk, and other fields that
  --  * in-memory only and used by libgit2.  Only the flags in
  --  * `GIT_INDEX_ENTRY_EXTENDED_FLAGS` will get saved on-disk.
  --  *
  --  * Thee first three bitmasks match the three fields in the
  --  * `git_index_entry` `flags_extended` value that belong on disk.  You
  --  * can use them to interpret the data in the `flags_extended`.
  --  *
  --  * The rest of the bitmasks match the other fields in the `git_index_entry`
  --  * `flags_extended` value that are only used in-memory by libgit2.
  --  * You can use them to interpret the data in the `flags_extended`.
  --  *
  --

   subtype git_index_entry_extended_flag_t is unsigned;
   GIT_INDEX_ENTRY_INTENT_TO_ADD  : constant unsigned := 8_192;
   GIT_INDEX_ENTRY_SKIP_WORKTREE  : constant unsigned := 16_384;
   GIT_INDEX_ENTRY_EXTENDED_FLAGS : constant unsigned := 24_576;
   GIT_INDEX_ENTRY_UPTODATE       : constant unsigned := 4;  -- /usr/include/git2/index.h:123

  --* Capabilities of system that affect index actions.
   subtype git_index_capability_t is int;
   GIT_INDEX_CAPABILITY_IGNORE_CASE : constant int := 1;
   GIT_INDEX_CAPABILITY_NO_FILEMODE : constant int := 2;
   GIT_INDEX_CAPABILITY_NO_SYMLINKS : constant int := 4;
   GIT_INDEX_CAPABILITY_FROM_OWNER  : constant int := -1;  -- /usr/include/git2/index.h:131

  --* Callback for APIs that add/remove/update files matching pathspec
   type git_index_matched_path_cb is access function
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/index.h:135

  --* Flags for APIs that add files matching pathspec
   subtype git_index_add_option_t is unsigned;
   GIT_INDEX_ADD_DEFAULT                : constant unsigned := 0;
   GIT_INDEX_ADD_FORCE                  : constant unsigned := 1;
   GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH : constant unsigned := 2;
   GIT_INDEX_ADD_CHECK_PATHSPEC         : constant unsigned := 4;  -- /usr/include/git2/index.h:144

  --* Git index stage states
  --*
  --     * Match any index stage.
  --     *
  --     * Some index APIs take a stage to match; pass this value to match
  --     * any entry matching the path regardless of stage.
  --

  --* A normal staged file in the index.
  --* The ancestor side of a conflict.
  --* The "ours" side of a conflict.
  --* The "theirs" side of a conflict.
   subtype git_index_stage_t is int;
   GIT_INDEX_STAGE_ANY      : constant int := -1;
   GIT_INDEX_STAGE_NORMAL   : constant int := 0;
   GIT_INDEX_STAGE_ANCESTOR : constant int := 1;
   GIT_INDEX_STAGE_OURS     : constant int := 2;
   GIT_INDEX_STAGE_THEIRS   : constant int := 3;  -- /usr/include/git2/index.h:167

  --*
  --  * Create a new bare Git index object as a memory representation
  --  * of the Git index file in 'index_path', without a repository
  --  * to back it.
  --  *
  --  * Since there is no ODB or working directory behind this index,
  --  * any Index methods which rely on these (e.g. index_add_bypath)
  --  * will fail with the GIT_ERROR error code.
  --  *
  --  * If you need to access the index of an actual repository,
  --  * use the `git_repository_index` wrapper.
  --  *
  --  * The index must be freed once it's no longer in use.
  --  *
  --  * @param out the pointer for the new index
  --  * @param index_path the path to the index file in disk
  --  * @return 0 or an error code
  --

   function git_index_open (c_out : System.Address; index_path : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/index.h:187
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_open";

  --*
  --  * Create an in-memory index object.
  --  *
  --  * This index object cannot be read/written to the filesystem,
  --  * but may be used to perform in-memory index operations.
  --  *
  --  * The index must be freed once it's no longer in use.
  --  *
  --  * @param out the pointer for the new index
  --  * @return 0 or an error code
  --

   function git_index_new (c_out : System.Address) return int  -- /usr/include/git2/index.h:200
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_new";

  --*
  --  * Free an existing index object.
  --  *
  --  * @param index an existing index object
  --

   procedure git_index_free (index : access git.Low_Level.git2_types_h.git_index)  -- /usr/include/git2/index.h:207
        with Import => True,
      Convention    => C,
      External_Name => "git_index_free";

  --*
  --  * Get the repository this index relates to
  --  *
  --  * @param index The index
  --  * @return A pointer to the repository
  --

   function git_index_owner (index : access constant git.Low_Level.git2_types_h.git_index) return access git.Low_Level.git2_types_h.git_repository  -- /usr/include/git2/index.h:215
     with Import    => True,
      Convention    => C,
      External_Name => "git_index_owner";

  --*
  --  * Read index capabilities flags.
  --  *
  --  * @param index An existing index object
  --  * @return A combination of GIT_INDEX_CAPABILITY values
  --

   function git_index_caps (index : access constant git.Low_Level.git2_types_h.git_index) return int  -- /usr/include/git2/index.h:223
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_caps";

  --*
  --  * Set index capabilities flags.
  --  *
  --  * If you pass `GIT_INDEX_CAPABILITY_FROM_OWNER` for the caps, then
  --  * capabilities will be read from the config of the owner object,
  --  * looking at `core.ignorecase`, `core.filemode`, `core.symlinks`.
  --  *
  --  * @param index An existing index object
  --  * @param caps A combination of GIT_INDEX_CAPABILITY values
  --  * @return 0 on success, -1 on failure
  --

   function git_index_set_caps (index : access git.Low_Level.git2_types_h.git_index; caps : int) return int  -- /usr/include/git2/index.h:236
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_set_caps";

  --*
  --  * Get index on-disk version.
  --  *
  --  * Valid return values are 2, 3, or 4.  If 3 is returned, an index
  --  * with version 2 may be written instead, if the extension data in
  --  * version 3 is not necessary.
  --  *
  --  * @param index An existing index object
  --  * @return the index version
  --

   function git_index_version (index : access git.Low_Level.git2_types_h.git_index) return unsigned  -- /usr/include/git2/index.h:248
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_version";

  --*
  --  * Set index on-disk version.
  --  *
  --  * Valid values are 2, 3, or 4.  If 2 is given, git_index_write may
  --  * write an index with version 3 instead, if necessary to accurately
  --  * represent the index.
  --  *
  --  * @param index An existing index object
  --  * @param version The new version number
  --  * @return 0 on success, -1 on failure
  --

   function git_index_set_version (index : access git.Low_Level.git2_types_h.git_index; version : unsigned) return int  -- /usr/include/git2/index.h:261
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_set_version";

  --*
  --  * Update the contents of an existing index object in memory by reading
  --  * from the hard disk.
  --  *
  --  * If `force` is true, this performs a "hard" read that discards in-memory
  --  * changes and always reloads the on-disk index data.  If there is no
  --  * on-disk version, the index will be cleared.
  --  *
  --  * If `force` is false, this does a "soft" read that reloads the index
  --  * data from disk only if it has changed since the last time it was
  --  * loaded.  Purely in-memory index data will be untouched.  Be aware: if
  --  * there are changes on disk, unwritten in-memory changes are discarded.
  --  *
  --  * @param index an existing index object
  --  * @param force if true, always reload, vs. only read if file has changed
  --  * @return 0 or an error code
  --

   function git_index_read (index : access git.Low_Level.git2_types_h.git_index; force : int) return int  -- /usr/include/git2/index.h:280
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_read";

  --*
  --  * Write an existing index object from memory back to disk
  --  * using an atomic file lock.
  --  *
  --  * @param index an existing index object
  --  * @return 0 or an error code
  --

   function git_index_write (index : access git.Low_Level.git2_types_h.git_index) return int  -- /usr/include/git2/index.h:289
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_write";

  --*
  --  * Get the full path to the index file on disk.
  --  *
  --  * @param index an existing index object
  --  * @return path to index file or NULL for in-memory index
  --

   function git_index_path (index : access constant git.Low_Level.git2_types_h.git_index) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/index.h:297
     with Import    => True,
      Convention    => C,
      External_Name => "git_index_path";

  --*
  --  * Get the checksum of the index
  --  *
  --  * This checksum is the SHA-1 hash over the index file (except the
  --  * last 20 bytes which are the checksum itself). In cases where the
  --  * index does not exist on-disk, it will be zeroed out.
  --  *
  --  * @param index an existing index object
  --  * @return a pointer to the checksum of the index
  --

   function git_index_checksum (index : access git.Low_Level.git2_types_h.git_index) return access constant git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/index.h:309
     with Import    => True,
      Convention    => C,
      External_Name => "git_index_checksum";

  --*
  --  * Read a tree into the index file with stats
  --  *
  --  * The current index contents will be replaced by the specified tree.
  --  *
  --  * @param index an existing index object
  --  * @param tree tree to read
  --  * @return 0 or an error code
  --

   function git_index_read_tree (index : access git.Low_Level.git2_types_h.git_index; tree : access constant git.Low_Level.git2_types_h.git_tree) return int  -- /usr/include/git2/index.h:320
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_read_tree";

  --*
  --  * Write the index as a tree
  --  *
  --  * This method will scan the index and write a representation
  --  * of its current state back to disk; it recursively creates
  --  * tree objects for each of the subtrees stored in the index,
  --  * but only returns the OID of the root tree. This is the OID
  --  * that can be used e.g. to create a commit.
  --  *
  --  * The index instance cannot be bare, and needs to be associated
  --  * to an existing repository.
  --  *
  --  * The index must not contain any file in conflict.
  --  *
  --  * @param out Pointer where to store the OID of the written tree
  --  * @param index Index to write
  --  * @return 0 on success, GIT_EUNMERGED when the index is not clean
  --  * or an error code
  --

   function git_index_write_tree (c_out : access git.Low_Level.git2_oid_h.git_oid; index : access git.Low_Level.git2_types_h.git_index) return int  -- /usr/include/git2/index.h:341
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_write_tree";

  --*
  --  * Write the index as a tree to the given repository
  --  *
  --  * This method will do the same as `git_index_write_tree`, but
  --  * letting the user choose the repository where the tree will
  --  * be written.
  --  *
  --  * The index must not contain any file in conflict.
  --  *
  --  * @param out Pointer where to store OID of the the written tree
  --  * @param index Index to write
  --  * @param repo Repository where to write the tree
  --  * @return 0 on success, GIT_EUNMERGED when the index is not clean
  --  * or an error code
  --

   function git_index_write_tree_to
     (c_out : access git.Low_Level.git2_oid_h.git_oid;
      index : access git.Low_Level.git2_types_h.git_index;
      repo  : access git.Low_Level.git2_types_h.git_repository) return int  -- /usr/include/git2/index.h:358
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_write_tree_to";

  --*@}
  --* @name Raw Index Entry Functions
  -- *
  --  * These functions work on index entries, and allow for raw manipulation
  --  * of the entries.
  --

  --*@{
  -- Index entry manipulation
  --*
  --  * Get the count of entries currently in the index
  --  *
  --  * @param index an existing index object
  --  * @return integer of count of current entries
  --

   function git_index_entrycount (index : access constant git.Low_Level.git2_types_h.git_index) return unsigned_long  -- /usr/include/git2/index.h:377
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_entrycount";

  --*
  --  * Clear the contents (all the entries) of an index object.
  --  *
  --  * This clears the index object in memory; changes must be explicitly
  --  * written to disk for them to take effect persistently.
  --  *
  --  * @param index an existing index object
  --  * @return 0 on success, error code < 0 on failure
  --

   function git_index_clear (index : access git.Low_Level.git2_types_h.git_index) return int  -- /usr/include/git2/index.h:388
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_clear";

  --*
  --  * Get a pointer to one of the entries in the index
  --  *
  --  * The entry is not modifiable and should not be freed.  Because the
  --  * `git_index_entry` struct is a publicly defined struct, you should
  --  * be able to make your own permanent copy of the data if necessary.
  --  *
  --  * @param index an existing index object
  --  * @param n the position of the entry
  --  * @return a pointer to the entry; NULL if out of bounds
  --

   function git_index_get_byindex (index : access git.Low_Level.git2_types_h.git_index; n : unsigned_long) return access constant git_index_entry  -- /usr/include/git2/index.h:401
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_get_byindex";

  --*
  --  * Get a pointer to one of the entries in the index
  --  *
  --  * The entry is not modifiable and should not be freed.  Because the
  --  * `git_index_entry` struct is a publicly defined struct, you should
  --  * be able to make your own permanent copy of the data if necessary.
  --  *
  --  * @param index an existing index object
  --  * @param path path to search
  --  * @param stage stage to search
  --  * @return a pointer to the entry; NULL if it was not found
  --

   function git_index_get_bypath
     (index : access git.Low_Level.git2_types_h.git_index;
      path  : Interfaces.C.Strings.chars_ptr;
      stage : int) return access constant git_index_entry  -- /usr/include/git2/index.h:416
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_get_bypath";

  --*
  --  * Remove an entry from the index
  --  *
  --  * @param index an existing index object
  --  * @param path path to search
  --  * @param stage stage to search
  --  * @return 0 or an error code
  --

   function git_index_remove
     (index : access git.Low_Level.git2_types_h.git_index;
      path  : Interfaces.C.Strings.chars_ptr;
      stage : int) return int  -- /usr/include/git2/index.h:427
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_remove";

  --*
  --  * Remove all entries from the index under a given directory
  --  *
  --  * @param index an existing index object
  --  * @param dir container directory path
  --  * @param stage stage to search
  --  * @return 0 or an error code
  --

   function git_index_remove_directory
     (index : access git.Low_Level.git2_types_h.git_index;
      dir   : Interfaces.C.Strings.chars_ptr;
      stage : int) return int  -- /usr/include/git2/index.h:437
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_remove_directory";

  --*
  --  * Add or update an index entry from an in-memory struct
  --  *
  --  * If a previous index entry exists that has the same path and stage
  --  * as the given 'source_entry', it will be replaced.  Otherwise, the
  --  * 'source_entry' will be added.
  --  *
  --  * A full copy (including the 'path' string) of the given
  --  * 'source_entry' will be inserted on the index.
  --  *
  --  * @param index an existing index object
  --  * @param source_entry new entry object
  --  * @return 0 or an error code
  --

   function git_index_add (index : access git.Low_Level.git2_types_h.git_index; source_entry : access constant git_index_entry) return int  -- /usr/include/git2/index.h:454
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_add";

  --*
  --  * Return the stage number from a git index entry
  --  *
  --  * This entry is calculated from the entry's flag attribute like this:
  --  *
  --  *    (entry->flags & GIT_INDEX_ENTRY_STAGEMASK) >> GIT_INDEX_ENTRY_STAGESHIFT
  --  *
  --  * @param entry The entry
  --  * @return the stage number
  --

   function git_index_entry_stage (c_entry : access constant git_index_entry) return int  -- /usr/include/git2/index.h:466
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_entry_stage";

  --*
  --  * Return whether the given index entry is a conflict (has a high stage
  --  * entry).  This is simply shorthand for `git_index_entry_stage > 0`.
  --  *
  --  * @param entry The entry
  --  * @return 1 if the entry is a conflict entry, 0 otherwise
  --

   function git_index_entry_is_conflict (c_entry : access constant git_index_entry) return int  -- /usr/include/git2/index.h:475
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_entry_is_conflict";

  --*@}
  --* @name Index Entry Iteration Functions
  -- *
  --  * These functions provide an iterator for index entries.
  --

  --*@{
  --*
  --  * Create an iterator that will return every entry contained in the
  --  * index at the time of creation.  Entries are returned in order,
  --  * sorted by path.  This iterator is backed by a snapshot that allows
  --  * callers to modify the index while iterating without affecting the
  --  * iterator.
  --  *
  --  * @param iterator_out The newly created iterator
  --  * @param index The index to iterate
  --

   function git_index_iterator_new (iterator_out : System.Address; index : access git.Low_Level.git2_types_h.git_index) return int  -- /usr/include/git2/index.h:495
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_iterator_new";

  --*
  --  * Return the next index entry in-order from the iterator.
  --  *
  --  * @param out Pointer to store the index entry in
  --  * @param iterator The iterator
  --  * @return 0, GIT_ITEROVER on iteration completion or an error code
  --

   function git_index_iterator_next (c_out : System.Address; iterator : access git.Low_Level.git2_types_h.git_index_iterator) return int  -- /usr/include/git2/index.h:506
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_iterator_next";

  --*
  -- * Free the index iterator
  -- *
  --  * @param iterator The iterator to free
  --

   procedure git_index_iterator_free (iterator : access git.Low_Level.git2_types_h.git_index_iterator)  -- /usr/include/git2/index.h:515
        with Import => True,
      Convention    => C,
      External_Name => "git_index_iterator_free";

  --*@}
  --* @name Workdir Index Entry Functions
  -- *
  --  * These functions work on index entries specifically in the working
  --  * directory (ie, stage 0).
  --

  --*@{
  --*
  --  * Add or update an index entry from a file on disk
  --  *
  --  * The file `path` must be relative to the repository's
  --  * working folder and must be readable.
  --  *
  --  * This method will fail in bare index instances.
  --  *
  --  * This forces the file to be added to the index, not looking
  --  * at gitignore rules.  Those rules can be evaluated through
  --  * the git_status APIs (in status.h) before calling this.
  --  *
  --  * If this file currently is the result of a merge conflict, this
  --  * file will no longer be marked as conflicting.  The data about
  --  * the conflict will be moved to the "resolve undo" (REUC) section.
  --  *
  --  * @param index an existing index object
  --  * @param path filename to add
  --  * @return 0 or an error code
  --

   function git_index_add_bypath (index : access git.Low_Level.git2_types_h.git_index; path : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/index.h:546
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_add_bypath";

  --*
  --  * Add or update an index entry from a buffer in memory
  --  *
  --  * This method will create a blob in the repository that owns the
  --  * index and then add the index entry to the index.  The `path` of the
  --  * entry represents the position of the blob relative to the
  --  * repository's root folder.
  --  *
  --  * If a previous index entry exists that has the same path as the
  --  * given 'entry', it will be replaced.  Otherwise, the 'entry' will be
  --  * added. The `id` and the `file_size` of the 'entry' are updated with the
  --  * real value of the blob.
  --  *
  --  * This forces the file to be added to the index, not looking
  --  * at gitignore rules.  Those rules can be evaluated through
  --  * the git_status APIs (in status.h) before calling this.
  --  *
  --  * If this file currently is the result of a merge conflict, this
  --  * file will no longer be marked as conflicting.  The data about
  --  * the conflict will be moved to the "resolve undo" (REUC) section.
  --  *
  --  * @param index an existing index object
  --  * @param entry filename to add
  --  * @param buffer data to be written into the blob
  --  * @param len length of the data
  --  * @return 0 or an error code
  --

   function git_index_add_from_buffer
     (index   : access git.Low_Level.git2_types_h.git_index;
      c_entry : access constant git_index_entry;
      buffer  : System.Address;
      len     : unsigned_long) return int  -- /usr/include/git2/index.h:575
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_add_from_buffer";

  --*
  --  * Remove an index entry corresponding to a file on disk
  --  *
  --  * The file `path` must be relative to the repository's
  --  * working folder.  It may exist.
  --  *
  --  * If this file currently is the result of a merge conflict, this
  --  * file will no longer be marked as conflicting.  The data about
  --  * the conflict will be moved to the "resolve undo" (REUC) section.
  --  *
  --  * @param index an existing index object
  --  * @param path filename to remove
  --  * @return 0 or an error code
  --

   function git_index_remove_bypath (index : access git.Low_Level.git2_types_h.git_index; path : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/index.h:594
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_remove_bypath";

  --*
  --  * Add or update index entries matching files in the working directory.
  --  *
  --  * This method will fail in bare index instances.
  --  *
  --  * The `pathspec` is a list of file names or shell glob patterns that will
  --  * be matched against files in the repository's working directory.  Each
  --  * file that matches will be added to the index (either updating an
  --  * existing entry or adding a new entry).  You can disable glob expansion
  --  * and force exact matching with the `GIT_INDEX_ADD_DISABLE_PATHSPEC_MATCH`
  --  * flag.
  --  *
  --  * Files that are ignored will be skipped (unlike `git_index_add_bypath`).
  --  * If a file is already tracked in the index, then it *will* be updated
  --  * even if it is ignored.  Pass the `GIT_INDEX_ADD_FORCE` flag to skip
  --  * the checking of ignore rules.
  --  *
  --  * To emulate `git add -A` and generate an error if the pathspec contains
  --  * the exact path of an ignored file (when not using FORCE), add the
  --  * `GIT_INDEX_ADD_CHECK_PATHSPEC` flag.  This checks that each entry
  --  * in the `pathspec` that is an exact match to a filename on disk is
  --  * either not ignored or already in the index.  If this check fails, the
  --  * function will return GIT_EINVALIDSPEC.
  --  *
  --  * To emulate `git add -A` with the "dry-run" option, just use a callback
  --  * function that always returns a positive value.  See below for details.
  --  *
  --  * If any files are currently the result of a merge conflict, those files
  --  * will no longer be marked as conflicting.  The data about the conflicts
  --  * will be moved to the "resolve undo" (REUC) section.
  --  *
  --  * If you provide a callback function, it will be invoked on each matching
  --  * item in the working directory immediately *before* it is added to /
  --  * updated in the index.  Returning zero will add the item to the index,
  --  * greater than zero will skip the item, and less than zero will abort the
  --  * scan and return that value to the caller.
  --  *
  --  * @param index an existing index object
  --  * @param pathspec array of path patterns
  --  * @param flags combination of git_index_add_option_t flags
  --  * @param callback notification callback for each added/updated path (also
  --  *                 gets index of matching pathspec entry); can be NULL;
  --  *                 return 0 to add, >0 to skip, <0 to abort scan.
  --  * @param payload payload passed through to callback function
  --  * @return 0 on success, negative callback return value, or error code
  --

   function git_index_add_all
     (index    : access git.Low_Level.git2_types_h.git_index;
      pathspec : access constant git.Low_Level.git2_strarray_h.git_strarray;
      flags    : unsigned;
      callback : git_index_matched_path_cb;
      payload  : System.Address) return int  -- /usr/include/git2/index.h:642
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_add_all";

  --*
  --  * Remove all matching index entries.
  --  *
  --  * If you provide a callback function, it will be invoked on each matching
  --  * item in the index immediately *before* it is removed.  Return 0 to
  --  * remove the item, > 0 to skip the item, and < 0 to abort the scan.
  --  *
  --  * @param index An existing index object
  --  * @param pathspec array of path patterns
  --  * @param callback notification callback for each removed path (also
  --  *                 gets index of matching pathspec entry); can be NULL;
  --  *                 return 0 to add, >0 to skip, <0 to abort scan.
  --  * @param payload payload passed through to callback function
  --  * @return 0 on success, negative callback return value, or error code
  --

   function git_index_remove_all
     (index    : access git.Low_Level.git2_types_h.git_index;
      pathspec : access constant git.Low_Level.git2_strarray_h.git_strarray;
      callback : git_index_matched_path_cb;
      payload  : System.Address) return int  -- /usr/include/git2/index.h:664
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_remove_all";

  --*
  --  * Update all index entries to match the working directory
  --  *
  --  * This method will fail in bare index instances.
  --  *
  --  * This scans the existing index entries and synchronizes them with the
  --  * working directory, deleting them if the corresponding working directory
  --  * file no longer exists otherwise updating the information (including
  --  * adding the latest version of file to the ODB if needed).
  --  *
  --  * If you provide a callback function, it will be invoked on each matching
  --  * item in the index immediately *before* it is updated (either refreshed
  --  * or removed depending on working directory state).  Return 0 to proceed
  --  * with updating the item, > 0 to skip the item, and < 0 to abort the scan.
  --  *
  --  * @param index An existing index object
  --  * @param pathspec array of path patterns
  --  * @param callback notification callback for each updated path (also
  --  *                 gets index of matching pathspec entry); can be NULL;
  --  *                 return 0 to add, >0 to skip, <0 to abort scan.
  --  * @param payload payload passed through to callback function
  --  * @return 0 on success, negative callback return value, or error code
  --

   function git_index_update_all
     (index    : access git.Low_Level.git2_types_h.git_index;
      pathspec : access constant git.Low_Level.git2_strarray_h.git_strarray;
      callback : git_index_matched_path_cb;
      payload  : System.Address) return int  -- /usr/include/git2/index.h:693
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_update_all";

  --*
  --  * Find the first position of any entries which point to given
  --  * path in the Git index.
  --  *
  --  * @param at_pos the address to which the position of the index entry is written (optional)
  --  * @param index an existing index object
  --  * @param path path to search
  --  * @return a zero-based position in the index if found; GIT_ENOTFOUND otherwise
  --

   function git_index_find
     (at_pos : access unsigned_long;
      index  : access git.Low_Level.git2_types_h.git_index;
      path   : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/index.h:708
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_find";

  --*
  --  * Find the first position of any entries matching a prefix. To find the first position
  --  * of a path inside a given folder, suffix the prefix with a '/'.
  --  *
  --  * @param at_pos the address to which the position of the index entry is written (optional)
  --  * @param index an existing index object
  --  * @param prefix the prefix to search for
  --  * @return 0 with valid value in at_pos; an error code otherwise
  --

   function git_index_find_prefix
     (at_pos : access unsigned_long;
      index  : access git.Low_Level.git2_types_h.git_index;
      prefix : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/index.h:719
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_find_prefix";

  --*@}
  --* @name Conflict Index Entry Functions
  -- *
  --  * These functions work on conflict index entries specifically (ie, stages 1-3)
  --

  --*@{
  --*
  --  * Add or update index entries to represent a conflict.  Any staged
  --  * entries that exist at the given paths will be removed.
  --  *
  --  * The entries are the entries from the tree included in the merge.  Any
  --  * entry may be null to indicate that that file was not present in the
  --  * trees during the merge.  For example, ancestor_entry may be NULL to
  --  * indicate that a file was added in both branches and must be resolved.
  --  *
  --  * @param index an existing index object
  --  * @param ancestor_entry the entry data for the ancestor of the conflict
  --  * @param our_entry the entry data for our side of the merge conflict
  --  * @param their_entry the entry data for their side of the merge conflict
  --  * @return 0 or an error code
  --

   function git_index_conflict_add
     (index          : access git.Low_Level.git2_types_h.git_index;
      ancestor_entry : access constant git_index_entry;
      our_entry      : access constant git_index_entry;
      their_entry    : access constant git_index_entry) return int  -- /usr/include/git2/index.h:744
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_conflict_add";

  --*
  --  * Get the index entries that represent a conflict of a single file.
  --  *
  --  * The entries are not modifiable and should not be freed.  Because the
  --  * `git_index_entry` struct is a publicly defined struct, you should
  --  * be able to make your own permanent copy of the data if necessary.
  --  *
  --  * @param ancestor_out Pointer to store the ancestor entry
  --  * @param our_out Pointer to store the our entry
  --  * @param their_out Pointer to store the their entry
  --  * @param index an existing index object
  --  * @param path path to search
  --  * @return 0 or an error code
  --

   function git_index_conflict_get
     (ancestor_out : System.Address;
      our_out      : System.Address;
      their_out    : System.Address;
      index        : access git.Low_Level.git2_types_h.git_index;
      path         : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/index.h:764
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_conflict_get";

  --*
  --  * Removes the index entries that represent a conflict of a single file.
  --  *
  --  * @param index an existing index object
  --  * @param path path to remove conflicts for
  --  * @return 0 or an error code
  --

   function git_index_conflict_remove (index : access git.Low_Level.git2_types_h.git_index; path : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/index.h:778
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_conflict_remove";

  --*
  --  * Remove all conflicts in the index (entries with a stage greater than 0).
  --  *
  --  * @param index an existing index object
  --  * @return 0 or an error code
  --

   function git_index_conflict_cleanup (index : access git.Low_Level.git2_types_h.git_index) return int  -- /usr/include/git2/index.h:786
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_conflict_cleanup";

  --*
  --  * Determine if the index contains entries representing file conflicts.
  --  *
  --  * @return 1 if at least one conflict is found, 0 otherwise.
  --

   function git_index_has_conflicts (index : access constant git.Low_Level.git2_types_h.git_index) return int  -- /usr/include/git2/index.h:793
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_has_conflicts";

  --*
  --  * Create an iterator for the conflicts in the index.
  --  *
  --  * The index must not be modified while iterating; the results are undefined.
  --  *
  --  * @param iterator_out The newly created conflict iterator
  --  * @param index The index to scan
  --  * @return 0 or an error code
  --

   function git_index_conflict_iterator_new (iterator_out : System.Address; index : access git.Low_Level.git2_types_h.git_index) return int  -- /usr/include/git2/index.h:804
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_conflict_iterator_new";

  --*
  --  * Returns the current conflict (ancestor, ours and theirs entry) and
  --  * advance the iterator internally to the next value.
  --  *
  --  * @param ancestor_out Pointer to store the ancestor side of the conflict
  --  * @param our_out Pointer to store our side of the conflict
  --  * @param their_out Pointer to store their side of the conflict
  --  * @return 0 (no error), GIT_ITEROVER (iteration is done) or an error code
  --  *         (negative value)
  --

   function git_index_conflict_next
     (ancestor_out : System.Address;
      our_out      : System.Address;
      their_out    : System.Address;
      iterator     : access git.Low_Level.git2_types_h.git_index_conflict_iterator) return int  -- /usr/include/git2/index.h:818
      with Import   => True,
      Convention    => C,
      External_Name => "git_index_conflict_next";

  --*
  --  * Frees a `git_index_conflict_iterator`.
  --  *
  --  * @param iterator pointer to the iterator
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

   procedure git_index_conflict_iterator_free (iterator : access git.Low_Level.git2_types_h.git_index_conflict_iterator)  -- /usr/include/git2/index.h:829
        with Import => True,
      Convention    => C,
      External_Name => "git_index_conflict_iterator_free";

end git.Low_Level.git2_index_h;

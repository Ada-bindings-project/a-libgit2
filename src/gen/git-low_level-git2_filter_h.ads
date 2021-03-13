pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
limited with git.Low_Level.git2_types_h;
with Interfaces.C.Strings;

limited with git.Low_Level.git2_buffer_h;

package git.Low_Level.git2_filter_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/filter.h
  -- * @brief Git filter APIs
  -- *
  -- * @ingroup Git
  -- * @{
  --

  --*
  --  * Filters are applied in one of two directions: smudging - which is
  --  * exporting a file from the Git object database to the working directory,
  --  * and cleaning - which is importing a file from the working directory to
  --  * the Git object database.  These values control which direction of
  --  * change is being applied.
  --

   subtype git_filter_mode_t is unsigned;
   GIT_FILTER_TO_WORKTREE : constant unsigned := 0;
   GIT_FILTER_SMUDGE      : constant unsigned := 0;
   GIT_FILTER_TO_ODB      : constant unsigned := 1;
   GIT_FILTER_CLEAN       : constant unsigned := 1;  -- /usr/include/git2/filter.h:36

  --*
  -- * Filter option flags.
  --

  --* Don't error for `safecrlf` violations, allow them to continue.
  --* Don't load `/etc/gitattributes` (or the system equivalent)
  --* Load attributes from `.gitattributes` in the root of HEAD
   subtype git_filter_flag_t is unsigned;
   GIT_FILTER_DEFAULT              : constant unsigned := 0;
   GIT_FILTER_ALLOW_UNSAFE         : constant unsigned := 1;
   GIT_FILTER_NO_SYSTEM_ATTRIBUTES : constant unsigned := 2;
   GIT_FILTER_ATTRIBUTES_FROM_HEAD : constant unsigned := 4;  -- /usr/include/git2/filter.h:52

  --*
  --  * A filter that can transform file data
  --  *
  --  * This represents a filter that can be used to transform or even replace
  --  * file data.  Libgit2 includes one built in filter and it is possible to
  --  * write your own (see git2/sys/filter.h for information on that).
  --  *
  --  * The two builtin filters are:
  --  *
  --  * * "crlf" which uses the complex rules with the "text", "eol", and
  --  *   "crlf" file attributes to decide how to convert between LF and CRLF
  --  *   line endings
  --  * * "ident" which replaces "$Id$" in a blob with "$Id: <blob OID>$" upon
  --  *   checkout and replaced "$Id: <anything>$" with "$Id$" on checkin.
  --

   type git_filter is null record;   -- incomplete struct

  --*
  --  * List of filters to be applied
  --  *
  --  * This represents a list of filters to be applied to a file / blob.  You
  --  * can build the list with one call, apply it with another, and dispose it
  --  * with a third.  In typical usage, there are not many occasions where a
  --  * git_filter_list is needed directly since the library will generally
  --  * handle conversions for you, but it can be convenient to be able to
  --  * build and apply the list sometimes.
  --

   type git_filter_list is null record;   -- incomplete struct

  --*
  --  * Load the filter list for a given path.
  --  *
  --  * This will return 0 (success) but set the output git_filter_list to NULL
  --  * if no filters are requested for the given file.
  --  *
  --  * @param filters Output newly created git_filter_list (or NULL)
  --  * @param repo Repository object that contains `path`
  --  * @param blob The blob to which the filter will be applied (if known)
  --  * @param path Relative path of the file to be filtered
  --  * @param mode Filtering direction (WT->ODB or ODB->WT)
  --  * @param flags Combination of `git_filter_flag_t` flags
  --  * @return 0 on success (which could still return NULL if no filters are
  --  *         needed for the requested file), <0 on error
  --

   function git_filter_list_load
     (filters : System.Address;
      repo    : access git.Low_Level.git2_types_h.git_repository;
      blob    : access git.Low_Level.git2_types_h.git_blob;
      path    : Interfaces.C.Strings.chars_ptr;
      mode    : git_filter_mode_t;
      flags   : unsigned) return int  -- /usr/include/git2/filter.h:98
      with Import   => True,
      Convention    => C,
      External_Name => "git_filter_list_load";

  -- can be NULL
  --*
  --  * Query the filter list to see if a given filter (by name) will run.
  --  * The built-in filters "crlf" and "ident" can be queried, otherwise this
  --  * is the name of the filter specified by the filter attribute.
  --  *
  --  * This will return 0 if the given filter is not in the list, or 1 if
  --  * the filter will be applied.
  --  *
  --  * @param filters A loaded git_filter_list (or NULL)
  --  * @param name The name of the filter to query
  --  * @return 1 if the filter is in the list, 0 otherwise
  --

   function git_filter_list_contains (filters : access git_filter_list; name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/filter.h:118
      with Import   => True,
      Convention    => C,
      External_Name => "git_filter_list_contains";

  --*
  --  * Apply filter list to a data buffer.
  --  *
  --  * See `git2/buffer.h` for background on `git_buf` objects.
  --  *
  --  * If the `in` buffer holds data allocated by libgit2 (i.e. `in->asize` is
  --  * not zero), then it will be overwritten when applying the filters.  If
  --  * not, then it will be left untouched.
  --  *
  --  * If there are no filters to apply (or `filters` is NULL), then the `out`
  --  * buffer will reference the `in` buffer data (with `asize` set to zero)
  --  * instead of allocating data.  This keeps allocations to a minimum, but
  --  * it means you have to be careful about freeing the `in` data since `out`
  --  * may be pointing to it!
  --  *
  --  * @param out Buffer to store the result of the filtering
  --  * @param filters A loaded git_filter_list (or NULL)
  --  * @param in Buffer containing the data to filter
  --  * @return 0 on success, an error code otherwise
  --

   function git_filter_list_apply_to_data
     (c_out   : access git.Low_Level.git2_buffer_h.git_buf;
      filters : access git_filter_list;
      c_in    : access git.Low_Level.git2_buffer_h.git_buf) return int  -- /usr/include/git2/filter.h:142
      with Import   => True,
      Convention    => C,
      External_Name => "git_filter_list_apply_to_data";

  --*
  --  * Apply a filter list to the contents of a file on disk
  --  *
  --  * @param out buffer into which to store the filtered file
  --  * @param filters the list of filters to apply
  --  * @param repo the repository in which to perform the filtering
  --  * @param path the path of the file to filter, a relative path will be
  --  * taken as relative to the workdir
  --

   function git_filter_list_apply_to_file
     (c_out   : access git.Low_Level.git2_buffer_h.git_buf;
      filters : access git_filter_list;
      repo    : access git.Low_Level.git2_types_h.git_repository;
      path    : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/filter.h:156
      with Import   => True,
      Convention    => C,
      External_Name => "git_filter_list_apply_to_file";

  --*
  --  * Apply a filter list to the contents of a blob
  --  *
  --  * @param out buffer into which to store the filtered file
  --  * @param filters the list of filters to apply
  --  * @param blob the blob to filter
  --

   function git_filter_list_apply_to_blob
     (c_out   : access git.Low_Level.git2_buffer_h.git_buf;
      filters : access git_filter_list;
      blob    : access git.Low_Level.git2_types_h.git_blob) return int  -- /usr/include/git2/filter.h:169
      with Import   => True,
      Convention    => C,
      External_Name => "git_filter_list_apply_to_blob";

  --*
  --  * Apply a filter list to an arbitrary buffer as a stream
  --  *
  --  * @param filters the list of filters to apply
  --  * @param data the buffer to filter
  --  * @param target the stream into which the data will be written
  --

   function git_filter_list_stream_data
     (filters : access git_filter_list;
      data    : access git.Low_Level.git2_buffer_h.git_buf;
      target  : access git.Low_Level.git2_types_h.git_writestream) return int  -- /usr/include/git2/filter.h:181
      with Import   => True,
      Convention    => C,
      External_Name => "git_filter_list_stream_data";

  --*
  --  * Apply a filter list to a file as a stream
  --  *
  --  * @param filters the list of filters to apply
  --  * @param repo the repository in which to perform the filtering
  --  * @param path the path of the file to filter, a relative path will be
  --  * taken as relative to the workdir
  --  * @param target the stream into which the data will be written
  --

   function git_filter_list_stream_file
     (filters : access git_filter_list;
      repo    : access git.Low_Level.git2_types_h.git_repository;
      path    : Interfaces.C.Strings.chars_ptr;
      target  : access git.Low_Level.git2_types_h.git_writestream) return int  -- /usr/include/git2/filter.h:195
      with Import   => True,
      Convention    => C,
      External_Name => "git_filter_list_stream_file";

  --*
  --  * Apply a filter list to a blob as a stream
  --  *
  --  * @param filters the list of filters to apply
  --  * @param blob the blob to filter
  --  * @param target the stream into which the data will be written
  --

   function git_filter_list_stream_blob
     (filters : access git_filter_list;
      blob    : access git.Low_Level.git2_types_h.git_blob;
      target  : access git.Low_Level.git2_types_h.git_writestream) return int  -- /usr/include/git2/filter.h:208
      with Import   => True,
      Convention    => C,
      External_Name => "git_filter_list_stream_blob";

  --*
  -- * Free a git_filter_list
  -- *
  --  * @param filters A git_filter_list created by `git_filter_list_load`
  --

   procedure git_filter_list_free (filters : access git_filter_list)  -- /usr/include/git2/filter.h:218
     with Import    => True,
      Convention    => C,
      External_Name => "git_filter_list_free";

  --* @}
end git.Low_Level.git2_filter_h;

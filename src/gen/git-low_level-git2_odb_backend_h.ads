pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
with Interfaces.C.Strings;
with git.Low_Level.git2_types_h;

limited with git.Low_Level.git2_oid_h;
limited with git.Low_Level.git2_indexer_h;

package git.Low_Level.git2_odb_backend_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/backend.h
  --  * @brief Git custom backend functions
  --  * @defgroup git_odb Git object database routines
  --  * @ingroup Git
  --  * @{
  --

  --  * Constructors for in-box ODB backends.
  --

  --*
  --  * Create a backend for the packfiles.
  --  *
  --  * @param out location to store the odb backend pointer
  --  * @param objects_dir the Git repository's objects directory
  --  *
  --  * @return 0 or an error code
  --

   function git_odb_backend_pack (c_out : System.Address; objects_dir : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/odb_backend.h:35
      with Import   => True,
      Convention    => C,
      External_Name => "git_odb_backend_pack";

  --*
  --  * Create a backend for loose objects
  --  *
  --  * @param out location to store the odb backend pointer
  --  * @param objects_dir the Git repository's objects directory
  --  * @param compression_level zlib compression level to use
  --  * @param do_fsync whether to do an fsync() after writing
  --  * @param dir_mode permissions to use creating a directory or 0 for defaults
  --  * @param file_mode permissions to use creating a file or 0 for defaults
  --  *
  --  * @return 0 or an error code
  --

   function git_odb_backend_loose
     (c_out             : System.Address;
      objects_dir       : Interfaces.C.Strings.chars_ptr;
      compression_level : int;
      do_fsync          : int;
      dir_mode          : unsigned;
      file_mode         : unsigned) return int  -- /usr/include/git2/odb_backend.h:49
      with Import   => True,
      Convention    => C,
      External_Name => "git_odb_backend_loose";

  --*
  --  * Create a backend out of a single packfile
  --  *
  --  * This can be useful for inspecting the contents of a single
  --  * packfile.
  --  *
  --  * @param out location to store the odb backend pointer
  --  * @param index_file path to the packfile's .idx file
  --  *
  --  * @return 0 or an error code
  --

   function git_odb_backend_one_pack (c_out : System.Address; index_file : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/odb_backend.h:68
      with Import   => True,
      Convention    => C,
      External_Name => "git_odb_backend_one_pack";

  --* Streaming mode
   subtype git_odb_stream_t is unsigned;
   GIT_STREAM_RDONLY : constant unsigned := 2;
   GIT_STREAM_WRONLY : constant unsigned := 4;
   GIT_STREAM_RW     : constant unsigned := 6;  -- /usr/include/git2/odb_backend.h:75

  --*
  --  * A stream to read/write from a backend.
  --  *
  --  * This represents a stream of data being written to or read from a
  --  * backend. When writing, the frontend functions take care of
  --  * calculating the object's id and all `finalize_write` needs to do is
  --  * store the object with the id it is passed.
  --

   type git_odb_stream;
   type git_odb_stream is record
      backend        : access git.Low_Level.git2_types_h.git_odb_backend;  -- /usr/include/git2/odb_backend.h:86
      mode           : aliased unsigned;  -- /usr/include/git2/odb_backend.h:87
      hash_ctx       : System.Address;  -- /usr/include/git2/odb_backend.h:88
      declared_size  : aliased git.Low_Level.git2_types_h.git_object_size_t;  -- /usr/include/git2/odb_backend.h:90
      received_bytes : aliased git.Low_Level.git2_types_h.git_object_size_t;  -- /usr/include/git2/odb_backend.h:91
      read           : access function
        (arg1 : access git_odb_stream;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : unsigned_long) return int;  -- /usr/include/git2/odb_backend.h:96
      write : access function
        (arg1 : access git_odb_stream;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : unsigned_long) return int;  -- /usr/include/git2/odb_backend.h:101
      finalize_write : access function (arg1 : access git_odb_stream; arg2 : access constant git.Low_Level.git2_oid_h.git_oid) return int;  -- /usr/include/git2/odb_backend.h:113
      free           : access procedure (arg1 : access git_odb_stream);  -- /usr/include/git2/odb_backend.h:121
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/odb_backend.h:85

  --*
  --     * Write at most `len` bytes into `buffer` and advance the stream.
  --

  --*
  --     * Write `len` bytes from `buffer` into the stream.
  --

  --*
  --     * Store the contents of the stream as an object with the id
  --     * specified in `oid`.
  --     *
  --     * This method might not be invoked if:
  --     * - an error occurs earlier with the `write` callback,
  --     * - the object referred to by `oid` already exists in any backend, or
  --     * - the final number of received bytes differs from the size declared
  --     *   with `git_odb_open_wstream()`
  --

  --*
  --     * Free the stream's memory.
  --     *
  --     * This method might be called without a call to `finalize_write` if
  --     * an error occurs or if the object is already present in the ODB.
  --

  --* A stream to write a pack file to the ODB
   type git_odb_writepack;
   type git_odb_writepack is record
      backend : access git.Low_Level.git2_types_h.git_odb_backend;  -- /usr/include/git2/odb_backend.h:126
      append  : access function
        (arg1 : access git_odb_writepack;
         arg2 : System.Address;
         arg3 : unsigned_long;
         arg4 : access git.Low_Level.git2_indexer_h.git_indexer_progress) return int;  -- /usr/include/git2/odb_backend.h:128
      commit : access function (arg1 : access git_odb_writepack; arg2 : access git.Low_Level.git2_indexer_h.git_indexer_progress) return int;  -- /usr/include/git2/odb_backend.h:129
      free   : access procedure (arg1 : access git_odb_writepack);  -- /usr/include/git2/odb_backend.h:130
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/odb_backend.h:125

end git.Low_Level.git2_odb_backend_h;

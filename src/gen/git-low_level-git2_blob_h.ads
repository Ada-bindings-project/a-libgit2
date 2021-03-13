pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
with Git.Low_Level.git2_types_h;
limited with Git.Low_Level.git2_oid_h;


limited with Git.Low_Level.git2_buffer_h;
with Interfaces.C.Strings;

package Git.Low_Level.git2_blob_h is

   GIT_BLOB_FILTER_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/blob.h:129
   --  unsupported macro: GIT_BLOB_FILTER_OPTIONS_INIT {GIT_BLOB_FILTER_OPTIONS_VERSION, GIT_BLOB_FILTER_CHECK_FOR_BINARY}

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/blob.h
  -- * @brief Git blob load and write routines
  -- * @defgroup git_blob Git blob load and write routines
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Lookup a blob object from a repository.
  -- *
  -- * @param blob pointer to the looked up blob
  -- * @param repo the repo to use when locating the blob.
  -- * @param id identity of the blob to locate.
  -- * @return 0 or an error code
  --  

   function git_blob_lookup
     (blob : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      id : access constant Git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/blob.h:33
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_lookup";

  --*
  -- * Lookup a blob object from a repository,
  -- * given a prefix of its identifier (short id).
  -- *
  -- * @see git_object_lookup_prefix
  -- *
  -- * @param blob pointer to the looked up blob
  -- * @param repo the repo to use when locating the blob.
  -- * @param id identity of the blob to locate.
  -- * @param len the length of the short identifier
  -- * @return 0 or an error code
  --  

   function git_blob_lookup_prefix
     (blob : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      id : access constant Git.Low_Level.git2_oid_h.git_oid;
      len : unsigned_long) return int  -- /usr/include/git2/blob.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_lookup_prefix";

  --*
  -- * Close an open blob
  -- *
  -- * This is a wrapper around git_object_free()
  -- *
  -- * IMPORTANT:
  -- * It *is* necessary to call this method when you stop
  -- * using a blob. Failure to do so will cause a memory leak.
  -- *
  -- * @param blob the blob to close
  --  

   procedure git_blob_free (blob : access Git.Low_Level.git2_types_h.git_blob)  -- /usr/include/git2/blob.h:60
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_free";

  --*
  -- * Get the id of a blob.
  -- *
  -- * @param blob a previously loaded blob.
  -- * @return SHA1 hash for this blob.
  --  

   function git_blob_id (blob : access constant Git.Low_Level.git2_types_h.git_blob) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/blob.h:68
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_id";

  --*
  -- * Get the repository that contains the blob.
  -- *
  -- * @param blob A previously loaded blob.
  -- * @return Repository that contains this blob.
  --  

   function git_blob_owner (blob : access constant Git.Low_Level.git2_types_h.git_blob) return access Git.Low_Level.git2_types_h.git_repository  -- /usr/include/git2/blob.h:76
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_owner";

  --*
  -- * Get a read-only buffer with the raw content of a blob.
  -- *
  -- * A pointer to the raw content of a blob is returned;
  -- * this pointer is owned internally by the object and shall
  -- * not be free'd. The pointer may be invalidated at a later
  -- * time.
  -- *
  -- * @param blob pointer to the blob
  -- * @return the pointer
  --  

   function git_blob_rawcontent (blob : access constant Git.Low_Level.git2_types_h.git_blob) return System.Address  -- /usr/include/git2/blob.h:89
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_rawcontent";

  --*
  -- * Get the size in bytes of the contents of a blob
  -- *
  -- * @param blob pointer to the blob
  -- * @return size on bytes
  --  

   function git_blob_rawsize (blob : access constant Git.Low_Level.git2_types_h.git_blob) return Git.Low_Level.git2_types_h.git_object_size_t  -- /usr/include/git2/blob.h:97
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_rawsize";

  --*
  -- * Flags to control the functionality of `git_blob_filter`.
  --  

  --* When set, filters will not be applied to binary files.  
  --*
  --	 * When set, filters will not load configuration from the
  --	 * system-wide `gitattributes` in `/etc` (or system equivalent).
  --	  

  --*
  --	 * When set, filters will be loaded from a `.gitattributes` file
  --	 * in the HEAD commit.
  --	  

   subtype git_blob_filter_flag_t is unsigned;
   GIT_BLOB_FILTER_CHECK_FOR_BINARY : constant unsigned := 1;
   GIT_BLOB_FILTER_NO_SYSTEM_ATTRIBUTES : constant unsigned := 2;
   GIT_BLOB_FILTER_ATTTRIBUTES_FROM_HEAD : constant unsigned := 4;  -- /usr/include/git2/blob.h:117

  --*
  -- * The options used when applying filter options to a file.
  --  

   --  skipped anonymous struct anon_anon_64

   type git_blob_filter_options is record
      version : aliased int;  -- /usr/include/git2/blob.h:123
      flags : aliased unsigned;  -- /usr/include/git2/blob.h:126
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/blob.h:127

  --* Flags to control the filtering process, see `git_blob_filter_flag_t` above  
  --*
  -- * Get a buffer with the filtered content of a blob.
  -- *
  -- * This applies filters as if the blob was being checked out to the
  -- * working directory under the specified filename.  This may apply
  -- * CRLF filtering or other types of changes depending on the file
  -- * attributes set for the blob and the content detected in it.
  -- *
  -- * The output is written into a `git_buf` which the caller must free
  -- * when done (via `git_buf_dispose`).
  -- *
  -- * If no filters need to be applied, then the `out` buffer will just
  -- * be populated with a pointer to the raw content of the blob.  In
  -- * that case, be careful to *not* free the blob until done with the
  -- * buffer or copy it into memory you own.
  -- *
  -- * @param out The git_buf to be filled in
  -- * @param blob Pointer to the blob
  -- * @param as_path Path used for file attribute lookups, etc.
  -- * @param opts Options to use for filtering the blob
  -- * @return 0 on success or an error code
  --  

   function git_blob_filter
     (c_out : access Git.Low_Level.git2_buffer_h.git_buf;
      blob : access Git.Low_Level.git2_types_h.git_blob;
      as_path : Interfaces.C.Strings.chars_ptr;
      opts : access git_blob_filter_options) return int  -- /usr/include/git2/blob.h:154
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_filter";

  --*
  -- * Read a file from the working folder of a repository
  -- * and write it to the Object Database as a loose blob
  -- *
  -- * @param id return the id of the written blob
  -- * @param repo repository where the blob will be written.
  -- *	this repository cannot be bare
  -- * @param relative_path file from which the blob will be created,
  -- *	relative to the repository's working dir
  -- * @return 0 or an error code
  --  

   function git_blob_create_from_workdir
     (id : access Git.Low_Level.git2_oid_h.git_oid;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      relative_path : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/blob.h:171
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_create_from_workdir";

  --*
  -- * Read a file from the filesystem and write its content
  -- * to the Object Database as a loose blob
  -- *
  -- * @param id return the id of the written blob
  -- * @param repo repository where the blob will be written.
  -- *	this repository can be bare or not
  -- * @param path file from which the blob will be created
  -- * @return 0 or an error code
  --  

   function git_blob_create_from_disk
     (id : access Git.Low_Level.git2_oid_h.git_oid;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      path : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/blob.h:183
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_create_from_disk";

  --*
  -- * Create a stream to write a new blob into the object db
  -- *
  -- * This function may need to buffer the data on disk and will in
  -- * general not be the right choice if you know the size of the data
  -- * to write. If you have data in memory, use
  -- * `git_blob_create_from_buffer()`. If you do not, but know the size of
  -- * the contents (and don't want/need to perform filtering), use
  -- * `git_odb_open_wstream()`.
  -- *
  -- * Don't close this stream yourself but pass it to
  -- * `git_blob_create_from_stream_commit()` to commit the write to the
  -- * object db and get the object id.
  -- *
  -- * If the `hintpath` parameter is filled, it will be used to determine
  -- * what git filters should be applied to the object before it is written
  -- * to the object database.
  -- *
  -- * @param out the stream into which to write
  -- * @param repo Repository where the blob will be written.
  -- *        This repository can be bare or not.
  -- * @param hintpath If not NULL, will be used to select data filters
  -- *        to apply onto the content of the blob to be created.
  -- * @return 0 or error code
  --  

   function git_blob_create_from_stream
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      hintpath : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/blob.h:210
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_create_from_stream";

  --*
  -- * Close the stream and write the blob to the object db
  -- *
  -- * The stream will be closed and freed.
  -- *
  -- * @param out the id of the new blob
  -- * @param stream the stream to close
  -- * @return 0 or an error code
  --  

   function git_blob_create_from_stream_commit (c_out : access Git.Low_Level.git2_oid_h.git_oid; stream : access Git.Low_Level.git2_types_h.git_writestream) return int  -- /usr/include/git2/blob.h:224
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_create_from_stream_commit";

  --*
  -- * Write an in-memory buffer to the ODB as a blob
  -- *
  -- * @param id return the id of the written blob
  -- * @param repo repository where to blob will be written
  -- * @param buffer data to be written into the blob
  -- * @param len length of the data
  -- * @return 0 or an error code
  --  

   function git_blob_create_from_buffer
     (id : access Git.Low_Level.git2_oid_h.git_oid;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      buffer : System.Address;
      len : unsigned_long) return int  -- /usr/include/git2/blob.h:237
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_create_from_buffer";

  --*
  -- * Determine if the blob content is most certainly binary or not.
  -- *
  -- * The heuristic used to guess if a file is binary is taken from core git:
  -- * Searching for NUL bytes and looking for a reasonable ratio of printable
  -- * to non-printable characters among the first 8000 bytes.
  -- *
  -- * @param blob The blob which content should be analyzed
  -- * @return 1 if the content of the blob is detected
  -- * as binary; 0 otherwise.
  --  

   function git_blob_is_binary (blob : access constant Git.Low_Level.git2_types_h.git_blob) return int  -- /usr/include/git2/blob.h:251
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_is_binary";

  --*
  -- * Create an in-memory copy of a blob. The copy must be explicitly
  -- * free'd or it will leak.
  -- *
  -- * @param out Pointer to store the copy of the object
  -- * @param source Original object to copy
  --  

   function git_blob_dup (c_out : System.Address; source : access Git.Low_Level.git2_types_h.git_blob) return int  -- /usr/include/git2/blob.h:260
   with Import => True, 
        Convention => C, 
        External_Name => "git_blob_dup";

  --* @}  
end Git.Low_Level.git2_blob_h;

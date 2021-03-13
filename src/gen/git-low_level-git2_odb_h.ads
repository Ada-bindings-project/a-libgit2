pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Git.Low_Level.git2_oid_h;
with System;
with Interfaces.C.Strings;
with Git.Low_Level.git2_types_h;

with Git.Low_Level.git2_indexer_h;
with Git.Low_Level.git2_odb_backend_h;

package Git.Low_Level.git2_odb_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/odb.h
  -- * @brief Git object database routines
  -- * @defgroup git_odb Git object database routines
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Function type for callbacks from git_odb_foreach.
  --  

   type git_odb_foreach_cb is access function (arg1 : access constant Git.Low_Level.git2_oid_h.git_oid; arg2 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/odb.h:28

  --*
  -- * Create a new object database with no backends.
  -- *
  -- * Before the ODB can be used for read/writing, a custom database
  -- * backend must be manually added using `git_odb_add_backend()`
  -- *
  -- * @param out location to store the database pointer, if opened.
  -- *			Set to NULL if the open failed.
  -- * @return 0 or an error code
  --  

   function git_odb_new (c_out : System.Address) return int  -- /usr/include/git2/odb.h:40
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_new";

  --*
  -- * Create a new object database and automatically add
  -- * the two default backends:
  -- *
  -- *	- git_odb_backend_loose: read and write loose object files
  -- *		from disk, assuming `objects_dir` as the Objects folder
  -- *
  -- *	- git_odb_backend_pack: read objects from packfiles,
  -- *		assuming `objects_dir` as the Objects folder which
  -- *		contains a 'pack/' folder with the corresponding data
  -- *
  -- * @param out location to store the database pointer, if opened.
  -- *			Set to NULL if the open failed.
  -- * @param objects_dir path of the backends' "objects" directory.
  -- * @return 0 or an error code
  --  

   function git_odb_open (c_out : System.Address; objects_dir : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/odb.h:58
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_open";

  --*
  -- * Add an on-disk alternate to an existing Object DB.
  -- *
  -- * Note that the added path must point to an `objects`, not
  -- * to a full repository, to use it as an alternate store.
  -- *
  -- * Alternate backends are always checked for objects *after*
  -- * all the main backends have been exhausted.
  -- *
  -- * Writing is disabled on alternate backends.
  -- *
  -- * @param odb database to add the backend to
  -- * @param path path to the objects folder for the alternate
  -- * @return 0 on success; error code otherwise
  --  

   function git_odb_add_disk_alternate (odb : access Git.Low_Level.git2_types_h.git_odb; path : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/odb.h:75
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_add_disk_alternate";

  --*
  -- * Close an open object database.
  -- *
  -- * @param db database pointer to close. If NULL no action is taken.
  --  

   procedure git_odb_free (db : access Git.Low_Level.git2_types_h.git_odb)  -- /usr/include/git2/odb.h:82
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_free";

  --*
  -- * Read an object from the database.
  -- *
  -- * This method queries all available ODB backends
  -- * trying to read the given OID.
  -- *
  -- * The returned object is reference counted and
  -- * internally cached, so it should be closed
  -- * by the user once it's no longer in use.
  -- *
  -- * @param out pointer where to store the read object
  -- * @param db database to search for the object in.
  -- * @param id identity of the object to read.
  -- * @return
  -- * - 0 if the object was read;
  -- * - GIT_ENOTFOUND if the object is not in the database.
  --  

   function git_odb_read
     (c_out : System.Address;
      db : access Git.Low_Level.git2_types_h.git_odb;
      id : access constant Git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/odb.h:101
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_read";

  --*
  -- * Read an object from the database, given a prefix
  -- * of its identifier.
  -- *
  -- * This method queries all available ODB backends
  -- * trying to match the 'len' first hexadecimal
  -- * characters of the 'short_id'.
  -- * The remaining (GIT_OID_HEXSZ-len)*4 bits of
  -- * 'short_id' must be 0s.
  -- * 'len' must be at least GIT_OID_MINPREFIXLEN,
  -- * and the prefix must be long enough to identify
  -- * a unique object in all the backends; the
  -- * method will fail otherwise.
  -- *
  -- * The returned object is reference counted and
  -- * internally cached, so it should be closed
  -- * by the user once it's no longer in use.
  -- *
  -- * @param out pointer where to store the read object
  -- * @param db database to search for the object in.
  -- * @param short_id a prefix of the id of the object to read.
  -- * @param len the length of the prefix
  -- * @return
  -- * - 0 if the object was read;
  -- * - GIT_ENOTFOUND if the object is not in the database.
  -- * - GIT_EAMBIGUOUS if the prefix is ambiguous (several objects match the prefix)
  --  

   function git_odb_read_prefix
     (c_out : System.Address;
      db : access Git.Low_Level.git2_types_h.git_odb;
      short_id : access constant Git.Low_Level.git2_oid_h.git_oid;
      len : unsigned_long) return int  -- /usr/include/git2/odb.h:130
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_read_prefix";

  --*
  -- * Read the header of an object from the database, without
  -- * reading its full contents.
  -- *
  -- * The header includes the length and the type of an object.
  -- *
  -- * Note that most backends do not support reading only the header
  -- * of an object, so the whole object will be read and then the
  -- * header will be returned.
  -- *
  -- * @param len_out pointer where to store the length
  -- * @param type_out pointer where to store the type
  -- * @param db database to search for the object in.
  -- * @param id identity of the object to read.
  -- * @return
  -- * - 0 if the object was read;
  -- * - GIT_ENOTFOUND if the object is not in the database.
  --  

   function git_odb_read_header
     (len_out : access unsigned_long;
      type_out : access Git.Low_Level.git2_types_h.git_object_t;
      db : access Git.Low_Level.git2_types_h.git_odb;
      id : access constant Git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/odb.h:150
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_read_header";

  --*
  -- * Determine if the given object can be found in the object database.
  -- *
  -- * @param db database to be searched for the given object.
  -- * @param id the object to search for.
  -- * @return
  -- * - 1, if the object was found
  -- * - 0, otherwise
  --  

   function git_odb_exists (db : access Git.Low_Level.git2_types_h.git_odb; id : access constant Git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/odb.h:161
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_exists";

  --*
  -- * Determine if an object can be found in the object database by an
  -- * abbreviated object ID.
  -- *
  -- * @param out The full OID of the found object if just one is found.
  -- * @param db The database to be searched for the given object.
  -- * @param short_id A prefix of the id of the object to read.
  -- * @param len The length of the prefix.
  -- * @return 0 if found, GIT_ENOTFOUND if not found, GIT_EAMBIGUOUS if multiple
  -- *         matches were found, other value < 0 if there was a read error.
  --  

   function git_odb_exists_prefix
     (c_out : access Git.Low_Level.git2_oid_h.git_oid;
      db : access Git.Low_Level.git2_types_h.git_odb;
      short_id : access constant Git.Low_Level.git2_oid_h.git_oid;
      len : unsigned_long) return int  -- /usr/include/git2/odb.h:174
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_exists_prefix";

  --*
  -- * The information about object IDs to query in `git_odb_expand_ids`,
  -- * which will be populated upon return.
  --  

  --* The object ID to expand  
   type git_odb_expand_id is record
      id : aliased Git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/odb.h:183
      length : aliased unsigned_short;  -- /usr/include/git2/odb.h:189
      c_type : aliased Git.Low_Level.git2_types_h.git_object_t;  -- /usr/include/git2/odb.h:195
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/odb.h:181

  --*
  --	 * The length of the object ID (in nibbles, or packets of 4 bits; the
  --	 * number of hex characters)
  --	 *  

  --*
  --	 * The (optional) type of the object to search for; leave as `0` or set
  --	 * to `GIT_OBJECT_ANY` to query for any object matching the ID.
  --	  

  --*
  -- * Determine if one or more objects can be found in the object database
  -- * by their abbreviated object ID and type.  The given array will be
  -- * updated in place:  for each abbreviated ID that is unique in the
  -- * database, and of the given type (if specified), the full object ID,
  -- * object ID length (`GIT_OID_HEXSZ`) and type will be written back to
  -- * the array.  For IDs that are not found (or are ambiguous), the
  -- * array entry will be zeroed.
  -- *
  -- * Note that since this function operates on multiple objects, the
  -- * underlying database will not be asked to be reloaded if an object is
  -- * not found (which is unlike other object database operations.)
  -- *
  -- * @param db The database to be searched for the given objects.
  -- * @param ids An array of short object IDs to search for
  -- * @param count The length of the `ids` array
  -- * @return 0 on success or an error code on failure
  --  

   function git_odb_expand_ids
     (db : access Git.Low_Level.git2_types_h.git_odb;
      ids : access git_odb_expand_id;
      count : unsigned_long) return int  -- /usr/include/git2/odb.h:216
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_expand_ids";

  --*
  -- * Refresh the object database to load newly added files.
  -- *
  -- * If the object databases have changed on disk while the library
  -- * is running, this function will force a reload of the underlying
  -- * indexes.
  -- *
  -- * Use this function when you're confident that an external
  -- * application has tampered with the ODB.
  -- *
  -- * NOTE that it is not necessary to call this function at all. The
  -- * library will automatically attempt to refresh the ODB
  -- * when a lookup fails, to see if the looked up object exists
  -- * on disk but hasn't been loaded yet.
  -- *
  -- * @param db database to refresh
  -- * @return 0 on success, error code otherwise
  --  

   function git_odb_refresh (db : access Git.Low_Level.git2_types_h.git_odb) return int  -- /usr/include/git2/odb.h:239
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_refresh";

  --*
  -- * List all objects available in the database
  -- *
  -- * The callback will be called for each object available in the
  -- * database. Note that the objects are likely to be returned in the index
  -- * order, which would make accessing the objects in that order inefficient.
  -- * Return a non-zero value from the callback to stop looping.
  -- *
  -- * @param db database to use
  -- * @param cb the callback to call for each object
  -- * @param payload data to pass to the callback
  -- * @return 0 on success, non-zero callback return value, or error code
  --  

   function git_odb_foreach
     (db : access Git.Low_Level.git2_types_h.git_odb;
      cb : git_odb_foreach_cb;
      payload : System.Address) return int  -- /usr/include/git2/odb.h:254
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_foreach";

  --*
  -- * Write an object directly into the ODB
  -- *
  -- * This method writes a full object straight into the ODB.
  -- * For most cases, it is preferred to write objects through a write
  -- * stream, which is both faster and less memory intensive, specially
  -- * for big objects.
  -- *
  -- * This method is provided for compatibility with custom backends
  -- * which are not able to support streaming writes
  -- *
  -- * @param out pointer to store the OID result of the write
  -- * @param odb object database where to store the object
  -- * @param data buffer with the data to store
  -- * @param len size of the buffer
  -- * @param type type of the data to store
  -- * @return 0 or an error code
  --  

   function git_odb_write
     (c_out : access Git.Low_Level.git2_oid_h.git_oid;
      odb : access Git.Low_Level.git2_types_h.git_odb;
      data : System.Address;
      len : unsigned_long;
      c_type : Git.Low_Level.git2_types_h.git_object_t) return int  -- /usr/include/git2/odb.h:274
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_write";

  --*
  -- * Open a stream to write an object into the ODB
  -- *
  -- * The type and final length of the object must be specified
  -- * when opening the stream.
  -- *
  -- * The returned stream will be of type `GIT_STREAM_WRONLY`, and it
  -- * won't be effective until `git_odb_stream_finalize_write` is called
  -- * and returns without an error
  -- *
  -- * The stream must always be freed when done with `git_odb_stream_free` or
  -- * will leak memory.
  -- *
  -- * @see git_odb_stream
  -- *
  -- * @param out pointer where to store the stream
  -- * @param db object database where the stream will write
  -- * @param size final size of the object that will be written
  -- * @param type type of the object that will be written
  -- * @return 0 if the stream was created; error code otherwise
  --  

   function git_odb_open_wstream
     (c_out : System.Address;
      db : access Git.Low_Level.git2_types_h.git_odb;
      size : Git.Low_Level.git2_types_h.git_object_size_t;
      c_type : Git.Low_Level.git2_types_h.git_object_t) return int  -- /usr/include/git2/odb.h:297
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_open_wstream";

  --*
  -- * Write to an odb stream
  -- *
  -- * This method will fail if the total number of received bytes exceeds the
  -- * size declared with `git_odb_open_wstream()`
  -- *
  -- * @param stream the stream
  -- * @param buffer the data to write
  -- * @param len the buffer's length
  -- * @return 0 if the write succeeded; error code otherwise
  --  

   function git_odb_stream_write
     (stream : access Git.Low_Level.git2_odb_backend_h.git_odb_stream;
      buffer : Interfaces.C.Strings.chars_ptr;
      len : unsigned_long) return int  -- /usr/include/git2/odb.h:310
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_stream_write";

  --*
  -- * Finish writing to an odb stream
  -- *
  -- * The object will take its final name and will be available to the
  -- * odb.
  -- *
  -- * This method will fail if the total number of received bytes
  -- * differs from the size declared with `git_odb_open_wstream()`
  -- *
  -- * @param out pointer to store the resulting object's id
  -- * @param stream the stream
  -- * @return 0 on success; an error code otherwise
  --  

   function git_odb_stream_finalize_write (c_out : access Git.Low_Level.git2_oid_h.git_oid; stream : access Git.Low_Level.git2_odb_backend_h.git_odb_stream) return int  -- /usr/include/git2/odb.h:325
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_stream_finalize_write";

  --*
  -- * Read from an odb stream
  -- *
  -- * Most backends don't implement streaming reads
  --  

   function git_odb_stream_read
     (stream : access Git.Low_Level.git2_odb_backend_h.git_odb_stream;
      buffer : Interfaces.C.Strings.chars_ptr;
      len : unsigned_long) return int  -- /usr/include/git2/odb.h:332
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_stream_read";

  --*
  -- * Free an odb stream
  -- *
  -- * @param stream the stream to free
  --  

   procedure git_odb_stream_free (stream : access Git.Low_Level.git2_odb_backend_h.git_odb_stream)  -- /usr/include/git2/odb.h:339
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_stream_free";

  --*
  -- * Open a stream to read an object from the ODB
  -- *
  -- * Note that most backends do *not* support streaming reads
  -- * because they store their objects as compressed/delta'ed blobs.
  -- *
  -- * It's recommended to use `git_odb_read` instead, which is
  -- * assured to work on all backends.
  -- *
  -- * The returned stream will be of type `GIT_STREAM_RDONLY` and
  -- * will have the following methods:
  -- *
  -- *		- stream->read: read `n` bytes from the stream
  -- *		- stream->free: free the stream
  -- *
  -- * The stream must always be free'd or will leak memory.
  -- *
  -- * @see git_odb_stream
  -- *
  -- * @param out pointer where to store the stream
  -- * @param len pointer where to store the length of the object
  -- * @param type pointer where to store the type of the object
  -- * @param db object database where the stream will read from
  -- * @param oid oid of the object the stream will read from
  -- * @return 0 if the stream was created; error code otherwise
  --  

   function git_odb_open_rstream
     (c_out : System.Address;
      len : access unsigned_long;
      c_type : access Git.Low_Level.git2_types_h.git_object_t;
      db : access Git.Low_Level.git2_types_h.git_odb;
      oid : access constant Git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/odb.h:367
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_open_rstream";

  --*
  -- * Open a stream for writing a pack file to the ODB.
  -- *
  -- * If the ODB layer understands pack files, then the given
  -- * packfile will likely be streamed directly to disk (and a
  -- * corresponding index created).  If the ODB layer does not
  -- * understand pack files, the objects will be stored in whatever
  -- * format the ODB layer uses.
  -- *
  -- * @see git_odb_writepack
  -- *
  -- * @param out pointer to the writepack functions
  -- * @param db object database where the stream will read from
  -- * @param progress_cb function to call with progress information.
  -- * Be aware that this is called inline with network and indexing operations,
  -- * so performance may be affected.
  -- * @param progress_payload payload for the progress callback
  --  

   function git_odb_write_pack
     (c_out : System.Address;
      db : access Git.Low_Level.git2_types_h.git_odb;
      progress_cb : Git.Low_Level.git2_indexer_h.git_indexer_progress_cb;
      progress_payload : System.Address) return int  -- /usr/include/git2/odb.h:392
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_write_pack";

  --*
  -- * Determine the object-ID (sha1 hash) of a data buffer
  -- *
  -- * The resulting SHA-1 OID will be the identifier for the data
  -- * buffer as if the data buffer it were to written to the ODB.
  -- *
  -- * @param out the resulting object-ID.
  -- * @param data data to hash
  -- * @param len size of the data
  -- * @param type of the data to hash
  -- * @return 0 or an error code
  --  

   function git_odb_hash
     (c_out : access Git.Low_Level.git2_oid_h.git_oid;
      data : System.Address;
      len : unsigned_long;
      c_type : Git.Low_Level.git2_types_h.git_object_t) return int  -- /usr/include/git2/odb.h:410
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_hash";

  --*
  -- * Read a file from disk and fill a git_oid with the object id
  -- * that the file would have if it were written to the Object
  -- * Database as an object of the given type (w/o applying filters).
  -- * Similar functionality to git.git's `git hash-object` without
  -- * the `-w` flag, however, with the --no-filters flag.
  -- * If you need filters, see git_repository_hashfile.
  -- *
  -- * @param out oid structure the result is written into.
  -- * @param path file to read and determine object id for
  -- * @param type the type of the object that will be hashed
  -- * @return 0 or an error code
  --  

   function git_odb_hashfile
     (c_out : access Git.Low_Level.git2_oid_h.git_oid;
      path : Interfaces.C.Strings.chars_ptr;
      c_type : Git.Low_Level.git2_types_h.git_object_t) return int  -- /usr/include/git2/odb.h:425
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_hashfile";

  --*
  -- * Create a copy of an odb_object
  -- *
  -- * The returned copy must be manually freed with `git_odb_object_free`.
  -- * Note that because of an implementation detail, the returned copy will be
  -- * the same pointer as `source`: the object is internally refcounted, so the
  -- * copy still needs to be freed twice.
  -- *
  -- * @param dest pointer where to store the copy
  -- * @param source object to copy
  -- * @return 0 or an error code
  --  

   function git_odb_object_dup (dest : System.Address; source : access Git.Low_Level.git2_types_h.git_odb_object) return int  -- /usr/include/git2/odb.h:439
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_object_dup";

  --*
  -- * Close an ODB object
  -- *
  -- * This method must always be called once a `git_odb_object` is no
  -- * longer needed, otherwise memory will leak.
  -- *
  -- * @param object object to close
  --  

   procedure git_odb_object_free (object : access Git.Low_Level.git2_types_h.git_odb_object)  -- /usr/include/git2/odb.h:449
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_object_free";

  --*
  -- * Return the OID of an ODB object
  -- *
  -- * This is the OID from which the object was read from
  -- *
  -- * @param object the object
  -- * @return a pointer to the OID
  --  

   function git_odb_object_id (object : access Git.Low_Level.git2_types_h.git_odb_object) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/odb.h:459
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_object_id";

  --*
  -- * Return the data of an ODB object
  -- *
  -- * This is the uncompressed, raw data as read from the ODB,
  -- * without the leading header.
  -- *
  -- * This pointer is owned by the object and shall not be free'd.
  -- *
  -- * @param object the object
  -- * @return a pointer to the data
  --  

   function git_odb_object_data (object : access Git.Low_Level.git2_types_h.git_odb_object) return System.Address  -- /usr/include/git2/odb.h:472
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_object_data";

  --*
  -- * Return the size of an ODB object
  -- *
  -- * This is the real size of the `data` buffer, not the
  -- * actual size of the object.
  -- *
  -- * @param object the object
  -- * @return the size
  --  

   function git_odb_object_size (object : access Git.Low_Level.git2_types_h.git_odb_object) return unsigned_long  -- /usr/include/git2/odb.h:483
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_object_size";

  --*
  -- * Return the type of an ODB object
  -- *
  -- * @param object the object
  -- * @return the type
  --  

   function git_odb_object_type (object : access Git.Low_Level.git2_types_h.git_odb_object) return Git.Low_Level.git2_types_h.git_object_t  -- /usr/include/git2/odb.h:491
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_object_type";

  --*
  -- * Add a custom backend to an existing Object DB
  -- *
  -- * The backends are checked in relative ordering, based on the
  -- * value of the `priority` parameter.
  -- *
  -- * Read <sys/odb_backend.h> for more information.
  -- *
  -- * @param odb database to add the backend to
  -- * @param backend pointer to a git_odb_backend instance
  -- * @param priority Value for ordering the backends queue
  -- * @return 0 on success; error code otherwise
  --  

   function git_odb_add_backend
     (odb : access Git.Low_Level.git2_types_h.git_odb;
      backend : access Git.Low_Level.git2_types_h.git_odb_backend;
      priority : int) return int  -- /usr/include/git2/odb.h:506
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_add_backend";

  --*
  -- * Add a custom backend to an existing Object DB; this
  -- * backend will work as an alternate.
  -- *
  -- * Alternate backends are always checked for objects *after*
  -- * all the main backends have been exhausted.
  -- *
  -- * The backends are checked in relative ordering, based on the
  -- * value of the `priority` parameter.
  -- *
  -- * Writing is disabled on alternate backends.
  -- *
  -- * Read <sys/odb_backend.h> for more information.
  -- *
  -- * @param odb database to add the backend to
  -- * @param backend pointer to a git_odb_backend instance
  -- * @param priority Value for ordering the backends queue
  -- * @return 0 on success; error code otherwise
  --  

   function git_odb_add_alternate
     (odb : access Git.Low_Level.git2_types_h.git_odb;
      backend : access Git.Low_Level.git2_types_h.git_odb_backend;
      priority : int) return int  -- /usr/include/git2/odb.h:527
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_add_alternate";

  --*
  -- * Get the number of ODB backend objects
  -- *
  -- * @param odb object database
  -- * @return number of backends in the ODB
  --  

   function git_odb_num_backends (odb : access Git.Low_Level.git2_types_h.git_odb) return unsigned_long  -- /usr/include/git2/odb.h:535
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_num_backends";

  --*
  -- * Lookup an ODB backend object by index
  -- *
  -- * @param out output pointer to ODB backend at pos
  -- * @param odb object database
  -- * @param pos index into object database backend list
  -- * @return 0 on success; GIT_ENOTFOUND if pos is invalid; other errors < 0
  --  

   function git_odb_get_backend
     (c_out : System.Address;
      odb : access Git.Low_Level.git2_types_h.git_odb;
      pos : unsigned_long) return int  -- /usr/include/git2/odb.h:545
   with Import => True, 
        Convention => C, 
        External_Name => "git_odb_get_backend";

  --* @}  
end Git.Low_Level.git2_odb_h;

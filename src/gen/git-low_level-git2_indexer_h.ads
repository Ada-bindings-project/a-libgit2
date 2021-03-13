pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;

with System;
with Interfaces.C.Strings;
limited with Git.Low_Level.git2_types_h;
limited with Git.Low_Level.git2_oid_h;

package Git.Low_Level.git2_indexer_h is

   GIT_INDEXER_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/indexer.h:74
   --  unsupported macro: GIT_INDEXER_OPTIONS_INIT { GIT_INDEXER_OPTIONS_VERSION }

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --* A git indexer object  
   type git_indexer is null record;   -- incomplete struct

  --*
  -- * This structure is used to provide callers information about the
  -- * progress of indexing a packfile, either directly or part of a
  -- * fetch or clone that downloads a packfile.
  --  

  --* number of objects in the packfile being indexed  
   type git_indexer_progress is record
      total_objects : aliased unsigned;  -- /usr/include/git2/indexer.h:26
      indexed_objects : aliased unsigned;  -- /usr/include/git2/indexer.h:29
      received_objects : aliased unsigned;  -- /usr/include/git2/indexer.h:32
      local_objects : aliased unsigned;  -- /usr/include/git2/indexer.h:38
      total_deltas : aliased unsigned;  -- /usr/include/git2/indexer.h:41
      indexed_deltas : aliased unsigned;  -- /usr/include/git2/indexer.h:44
      received_bytes : aliased unsigned_long;  -- /usr/include/git2/indexer.h:47
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/indexer.h:24

  --* received objects that have been hashed  
  --* received_objects: objects which have been downloaded  
  --*
  --	 * locally-available objects that have been injected in order
  --	 * to fix a thin pack
  --	  

  --* number of deltas in the packfile being indexed  
  --* received deltas that have been indexed  
  --* size of the packfile received up to now  
  --*
  -- * Type for progress callbacks during indexing.  Return a value less
  -- * than zero to cancel the indexing or download.
  -- *
  -- * @param stats Structure containing information about the state of the tran    sfer
  -- * @param payload Payload provided by caller
  --  

   type git_indexer_progress_cb is access function (arg1 : access constant git_indexer_progress; arg2 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/indexer.h:57

  --*
  -- * Options for indexer configuration
  --  

   type git_indexer_options is record
      version : aliased unsigned;  -- /usr/include/git2/indexer.h:63
      progress_cb : git_indexer_progress_cb;  -- /usr/include/git2/indexer.h:66
      progress_cb_payload : System.Address;  -- /usr/include/git2/indexer.h:68
      verify : aliased unsigned_char;  -- /usr/include/git2/indexer.h:71
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/indexer.h:62

  --* progress_cb function to call with progress information  
  --* progress_cb_payload payload for the progress callback  
  --* Do connectivity checks for the received pack  
  --*
  -- * Initializes a `git_indexer_options` with default values. Equivalent to
  -- * creating an instance with GIT_INDEXER_OPTIONS_INIT.
  -- *
  -- * @param opts the `git_indexer_options` struct to initialize.
  -- * @param version Version of struct; pass `GIT_INDEXER_OPTIONS_VERSION`
  -- * @return Zero on success; -1 on failure.
  --  

   function git_indexer_options_init (opts : access git_indexer_options; version : unsigned) return int  -- /usr/include/git2/indexer.h:85
   with Import => True, 
        Convention => C, 
        External_Name => "git_indexer_options_init";

  --*
  -- * Create a new indexer instance
  -- *
  -- * @param out where to store the indexer instance
  -- * @param path to the directory where the packfile should be stored
  -- * @param mode permissions to use creating packfile or 0 for defaults
  -- * @param odb object database from which to read base objects when
  -- * fixing thin packs. Pass NULL if no thin pack is expected (an error
  -- * will be returned if there are bases missing)
  -- * @param opts Optional structure containing additional options. See
  -- * `git_indexer_options` above.
  --  

   function git_indexer_new
     (c_out : System.Address;
      path : Interfaces.C.Strings.chars_ptr;
      mode : unsigned;
      odb : access Git.Low_Level.git2_types_h.git_odb;
      opts : access git_indexer_options) return int  -- /usr/include/git2/indexer.h:101
   with Import => True, 
        Convention => C, 
        External_Name => "git_indexer_new";

  --*
  -- * Add data to the indexer
  -- *
  -- * @param idx the indexer
  -- * @param data the data to add
  -- * @param size the size of the data in bytes
  -- * @param stats stat storage
  --  

   function git_indexer_append
     (idx : access git_indexer;
      data : System.Address;
      size : unsigned_long;
      stats : access git_indexer_progress) return int  -- /usr/include/git2/indexer.h:116
   with Import => True, 
        Convention => C, 
        External_Name => "git_indexer_append";

  --*
  -- * Finalize the pack and index
  -- *
  -- * Resolve any pending deltas and write out the index file
  -- *
  -- * @param idx the indexer
  --  

   function git_indexer_commit (idx : access git_indexer; stats : access git_indexer_progress) return int  -- /usr/include/git2/indexer.h:125
   with Import => True, 
        Convention => C, 
        External_Name => "git_indexer_commit";

  --*
  -- * Get the packfile's hash
  -- *
  -- * A packfile's name is derived from the sorted hashing of all object
  -- * names. This is only correct after the index has been finalized.
  -- *
  -- * @param idx the indexer instance
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --* A git indexer object  
  --*
  -- * This structure is used to provide callers information about the
  -- * progress of indexing a packfile, either directly or part of a
  -- * fetch or clone that downloads a packfile.
  --  

  --* number of objects in the packfile being indexed  
  --* received objects that have been hashed  
  --* received_objects: objects which have been downloaded  
  --*
  --	 * locally-available objects that have been injected in order
  --	 * to fix a thin pack
  --	  

  --* number of deltas in the packfile being indexed  
  --* received deltas that have been indexed  
  --* size of the packfile received up to now  
  --*
  -- * Type for progress callbacks during indexing.  Return a value less
  -- * than zero to cancel the indexing or download.
  -- *
  -- * @param stats Structure containing information about the state of the tran    sfer
  -- * @param payload Payload provided by caller
  --  

  --*
  -- * Options for indexer configuration
  --  

  --* progress_cb function to call with progress information  
  --* progress_cb_payload payload for the progress callback  
  --* Do connectivity checks for the received pack  
  --*
  -- * Initializes a `git_indexer_options` with default values. Equivalent to
  -- * creating an instance with GIT_INDEXER_OPTIONS_INIT.
  -- *
  -- * @param opts the `git_indexer_options` struct to initialize.
  -- * @param version Version of struct; pass `GIT_INDEXER_OPTIONS_VERSION`
  -- * @return Zero on success; -1 on failure.
  --  

  --*
  -- * Create a new indexer instance
  -- *
  -- * @param out where to store the indexer instance
  -- * @param path to the directory where the packfile should be stored
  -- * @param mode permissions to use creating packfile or 0 for defaults
  -- * @param odb object database from which to read base objects when
  -- * fixing thin packs. Pass NULL if no thin pack is expected (an error
  -- * will be returned if there are bases missing)
  -- * @param opts Optional structure containing additional options. See
  -- * `git_indexer_options` above.
  --  

  --*
  -- * Add data to the indexer
  -- *
  -- * @param idx the indexer
  -- * @param data the data to add
  -- * @param size the size of the data in bytes
  -- * @param stats stat storage
  --  

  --*
  -- * Finalize the pack and index
  -- *
  -- * Resolve any pending deltas and write out the index file
  -- *
  -- * @param idx the indexer
  --  

  --*
  -- * Get the packfile's hash
  -- *
  -- * A packfile's name is derived from the sorted hashing of all object
  -- * names. This is only correct after the index has been finalized.
  -- *
  -- * @param idx the indexer instance
  --  

   function git_indexer_hash (idx : access constant git_indexer) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/indexer.h:135
   with Import => True, 
        Convention => C, 
        External_Name => "git_indexer_hash";

  --*
  -- * Free the indexer and its resources
  -- *
  -- * @param idx the indexer to free
  --  

   procedure git_indexer_free (idx : access git_indexer)  -- /usr/include/git2/indexer.h:142
   with Import => True, 
        Convention => C, 
        External_Name => "git_indexer_free";

end Git.Low_Level.git2_indexer_h;

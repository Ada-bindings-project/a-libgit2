pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
limited with Git.Low_Level.git2_types_h;
limited with Git.Low_Level.git2_oid_h;
with Interfaces.C.Strings;
limited with Git.Low_Level.git2_buffer_h;
with Git.Low_Level.git2_indexer_h;



package Git.Low_Level.git2_pack_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/pack.h
  -- * @brief Git pack management routines
  -- *
  -- * Packing objects
  -- * ---------------
  -- *
  -- * Creation of packfiles requires two steps:
  -- *
  -- * - First, insert all the objects you want to put into the packfile
  -- *   using `git_packbuilder_insert` and `git_packbuilder_insert_tree`.
  -- *   It's important to add the objects in recency order ("in the order
  -- *   that they are 'reachable' from head").
  -- *
  -- *   "ANY order will give you a working pack, ... [but it is] the thing
  -- *   that gives packs good locality. It keeps the objects close to the
  -- *   head (whether they are old or new, but they are _reachable_ from the
  -- *   head) at the head of the pack. So packs actually have absolutely
  -- *   _wonderful_ IO patterns." - Linus Torvalds
  -- *   git.git/Documentation/technical/pack-heuristics.txt
  -- *
  -- * - Second, use `git_packbuilder_write` or `git_packbuilder_foreach` to
  -- *   write the resulting packfile.
  -- *
  -- *   libgit2 will take care of the delta ordering and generation.
  -- *   `git_packbuilder_set_threads` can be used to adjust the number of
  -- *   threads used for the process.
  -- *
  -- * See tests/pack/packbuilder.c for an example.
  -- *
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Stages that are reported by the packbuilder progress callback.
  --  

   type git_packbuilder_stage_t is 
     (GIT_PACKBUILDER_ADDING_OBJECTS,
      GIT_PACKBUILDER_DELTAFICATION)
   with Convention => C;  -- /usr/include/git2/pack.h:55

  --*
  -- * Initialize a new packbuilder
  -- *
  -- * @param out The new packbuilder object
  -- * @param repo The repository
  -- *
  -- * @return 0 or an error code
  --  

   function git_packbuilder_new (c_out : System.Address; repo : access Git.Low_Level.git2_types_h.git_repository) return int  -- /usr/include/git2/pack.h:65
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_new";

  --*
  -- * Set number of threads to spawn
  -- *
  -- * By default, libgit2 won't spawn any threads at all;
  -- * when set to 0, libgit2 will autodetect the number of
  -- * CPUs.
  -- *
  -- * @param pb The packbuilder
  -- * @param n Number of threads to spawn
  -- * @return number of actual threads to be used
  --  

   function git_packbuilder_set_threads (pb : access Git.Low_Level.git2_types_h.git_packbuilder; n : unsigned) return unsigned  -- /usr/include/git2/pack.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_set_threads";

  --*
  -- * Insert a single object
  -- *
  -- * For an optimal pack it's mandatory to insert objects in recency order,
  -- * commits followed by trees and blobs.
  -- *
  -- * @param pb The packbuilder
  -- * @param id The oid of the commit
  -- * @param name The name; might be NULL
  -- *
  -- * @return 0 or an error code
  --  

   function git_packbuilder_insert
     (pb : access Git.Low_Level.git2_types_h.git_packbuilder;
      id : access constant Git.Low_Level.git2_oid_h.git_oid;
      name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/pack.h:92
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_insert";

  --*
  -- * Insert a root tree object
  -- *
  -- * This will add the tree as well as all referenced trees and blobs.
  -- *
  -- * @param pb The packbuilder
  -- * @param id The oid of the root tree
  -- *
  -- * @return 0 or an error code
  --  

   function git_packbuilder_insert_tree (pb : access Git.Low_Level.git2_types_h.git_packbuilder; id : access constant Git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/pack.h:104
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_insert_tree";

  --*
  -- * Insert a commit object
  -- *
  -- * This will add a commit as well as the completed referenced tree.
  -- *
  -- * @param pb The packbuilder
  -- * @param id The oid of the commit
  -- *
  -- * @return 0 or an error code
  --  

   function git_packbuilder_insert_commit (pb : access Git.Low_Level.git2_types_h.git_packbuilder; id : access constant Git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/pack.h:116
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_insert_commit";

  --*
  -- * Insert objects as given by the walk
  -- *
  -- * Those commits and all objects they reference will be inserted into
  -- * the packbuilder.
  -- *
  -- * @param pb the packbuilder
  -- * @param walk the revwalk to use to fill the packbuilder
  -- *
  -- * @return 0 or an error code
  --  

   function git_packbuilder_insert_walk (pb : access Git.Low_Level.git2_types_h.git_packbuilder; walk : access Git.Low_Level.git2_types_h.git_revwalk) return int  -- /usr/include/git2/pack.h:129
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_insert_walk";

  --*
  -- * Recursively insert an object and its referenced objects
  -- *
  -- * Insert the object as well as any object it references.
  -- *
  -- * @param pb the packbuilder
  -- * @param id the id of the root object to insert
  -- * @param name optional name for the object
  -- * @return 0 or an error code
  --  

   function git_packbuilder_insert_recur
     (pb : access Git.Low_Level.git2_types_h.git_packbuilder;
      id : access constant Git.Low_Level.git2_oid_h.git_oid;
      name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/pack.h:141
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_insert_recur";

  --*
  -- * Write the contents of the packfile to an in-memory buffer
  -- *
  -- * The contents of the buffer will become a valid packfile, even though there
  -- * will be no attached index
  -- *
  -- * @param buf Buffer where to write the packfile
  -- * @param pb The packbuilder
  --  

   function git_packbuilder_write_buf (buf : access Git.Low_Level.git2_buffer_h.git_buf; pb : access Git.Low_Level.git2_types_h.git_packbuilder) return int  -- /usr/include/git2/pack.h:152
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_write_buf";

  --*
  -- * Write the new pack and corresponding index file to path.
  -- *
  -- * @param pb The packbuilder
  -- * @param path to the directory where the packfile and index should be stored
  -- * @param mode permissions to use creating a packfile or 0 for defaults
  -- * @param progress_cb function to call with progress information from the indexer (optional)
  -- * @param progress_cb_payload payload for the progress callback (optional)
  -- *
  -- * @return 0 or an error code
  --  

   function git_packbuilder_write
     (pb : access Git.Low_Level.git2_types_h.git_packbuilder;
      path : Interfaces.C.Strings.chars_ptr;
      mode : unsigned;
      progress_cb : Git.Low_Level.git2_indexer_h.git_indexer_progress_cb;
      progress_cb_payload : System.Address) return int  -- /usr/include/git2/pack.h:165
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_write";

  --*
  --* Get the packfile's hash
  --*
  --* A packfile's name is derived from the sorted hashing of all object
  --* names. This is only correct after the packfile has been written.
  --*
  --* @param pb The packbuilder object
  -- 

   function git_packbuilder_hash (pb : access Git.Low_Level.git2_types_h.git_packbuilder) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/pack.h:180
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_hash";

  --*
  -- * Callback used to iterate over packed objects
  -- *
  -- * @see git_packbuilder_foreach
  -- *
  -- * @param buf A pointer to the object's data
  -- * @param size The size of the underlying object
  -- * @param payload Payload passed to git_packbuilder_foreach
  -- * @return non-zero to terminate the iteration
  --  

   type git_packbuilder_foreach_cb is access function
        (arg1 : System.Address;
         arg2 : unsigned_long;
         arg3 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/pack.h:192

  --*
  -- * Create the new pack and pass each object to the callback
  -- *
  -- * @param pb the packbuilder
  -- * @param cb the callback to call with each packed object's buffer
  -- * @param payload the callback's data
  -- * @return 0 or an error code
  --  

   function git_packbuilder_foreach
     (pb : access Git.Low_Level.git2_types_h.git_packbuilder;
      cb : git_packbuilder_foreach_cb;
      payload : System.Address) return int  -- /usr/include/git2/pack.h:202
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_foreach";

  --*
  -- * Get the total number of objects the packbuilder will write out
  -- *
  -- * @param pb the packbuilder
  -- * @return the number of objects in the packfile
  --  

   function git_packbuilder_object_count (pb : access Git.Low_Level.git2_types_h.git_packbuilder) return unsigned_long  -- /usr/include/git2/pack.h:210
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_object_count";

  --*
  -- * Get the number of objects the packbuilder has already written out
  -- *
  -- * @param pb the packbuilder
  -- * @return the number of objects which have already been written
  --  

   function git_packbuilder_written (pb : access Git.Low_Level.git2_types_h.git_packbuilder) return unsigned_long  -- /usr/include/git2/pack.h:218
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_written";

  --* Packbuilder progress notification function  
   type git_packbuilder_progress is access function
        (arg1 : int;
         arg2 : unsigned;
         arg3 : unsigned;
         arg4 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/pack.h:221

  --*
  -- * Set the callbacks for a packbuilder
  -- *
  -- * @param pb The packbuilder object
  -- * @param progress_cb Function to call with progress information during
  -- * pack building. Be aware that this is called inline with pack building
  -- * operations, so performance may be affected.
  -- * @param progress_cb_payload Payload for progress callback.
  -- * @return 0 or an error code
  --  

   function git_packbuilder_set_callbacks
     (pb : access Git.Low_Level.git2_types_h.git_packbuilder;
      progress_cb : git_packbuilder_progress;
      progress_cb_payload : System.Address) return int  -- /usr/include/git2/pack.h:237
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_set_callbacks";

  --*
  -- * Free the packbuilder and all associated data
  -- *
  -- * @param pb The packbuilder
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   procedure git_packbuilder_free (pb : access Git.Low_Level.git2_types_h.git_packbuilder)  -- /usr/include/git2/pack.h:247
   with Import => True, 
        Convention => C, 
        External_Name => "git_packbuilder_free";

end Git.Low_Level.git2_pack_h;

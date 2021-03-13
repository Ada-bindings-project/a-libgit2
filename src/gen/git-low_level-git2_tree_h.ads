pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
with Git.Low_Level.git2_types_h;
with Git.Low_Level.git2_oid_h;

with Interfaces.C.Strings;
limited with Git.Low_Level.git2_buffer_h;

package Git.Low_Level.git2_tree_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/tree.h
  -- * @brief Git tree parsing, loading routines
  -- * @defgroup git_tree Git tree parsing, loading routines
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Lookup a tree object from the repository.
  -- *
  -- * @param out Pointer to the looked up tree
  -- * @param repo The repo to use when locating the tree.
  -- * @param id Identity of the tree to locate.
  -- * @return 0 or an error code
  --  

   function git_tree_lookup
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      id : access constant Git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/tree.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_lookup";

  --*
  -- * Lookup a tree object from the repository,
  -- * given a prefix of its identifier (short id).
  -- *
  -- * @see git_object_lookup_prefix
  -- *
  -- * @param out pointer to the looked up tree
  -- * @param repo the repo to use when locating the tree.
  -- * @param id identity of the tree to locate.
  -- * @param len the length of the short identifier
  -- * @return 0 or an error code
  --  

   function git_tree_lookup_prefix
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      id : access constant Git.Low_Level.git2_oid_h.git_oid;
      len : unsigned_long) return int  -- /usr/include/git2/tree.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_lookup_prefix";

  --*
  -- * Close an open tree
  -- *
  -- * You can no longer use the git_tree pointer after this call.
  -- *
  -- * IMPORTANT: You MUST call this method when you stop using a tree to
  -- * release memory. Failure to do so will cause a memory leak.
  -- *
  -- * @param tree The tree to close
  --  

   procedure git_tree_free (tree : access Git.Low_Level.git2_types_h.git_tree)  -- /usr/include/git2/tree.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_free";

  --*
  -- * Get the id of a tree.
  -- *
  -- * @param tree a previously loaded tree.
  -- * @return object identity for the tree.
  --  

   function git_tree_id (tree : access constant Git.Low_Level.git2_types_h.git_tree) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/tree.h:71
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_id";

  --*
  -- * Get the repository that contains the tree.
  -- *
  -- * @param tree A previously loaded tree.
  -- * @return Repository that contains this tree.
  --  

   function git_tree_owner (tree : access constant Git.Low_Level.git2_types_h.git_tree) return access Git.Low_Level.git2_types_h.git_repository  -- /usr/include/git2/tree.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_owner";

  --*
  -- * Get the number of entries listed in a tree
  -- *
  -- * @param tree a previously loaded tree.
  -- * @return the number of entries in the tree
  --  

   function git_tree_entrycount (tree : access constant Git.Low_Level.git2_types_h.git_tree) return unsigned_long  -- /usr/include/git2/tree.h:87
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entrycount";

  --*
  -- * Lookup a tree entry by its filename
  -- *
  -- * This returns a git_tree_entry that is owned by the git_tree.  You don't
  -- * have to free it, but you must not use it after the git_tree is released.
  -- *
  -- * @param tree a previously loaded tree.
  -- * @param filename the filename of the desired entry
  -- * @return the tree entry; NULL if not found
  --  

   function git_tree_entry_byname (tree : access constant Git.Low_Level.git2_types_h.git_tree; filename : Interfaces.C.Strings.chars_ptr) return access constant Git.Low_Level.git2_types_h.git_tree_entry  -- /usr/include/git2/tree.h:99
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_byname";

  --*
  -- * Lookup a tree entry by its position in the tree
  -- *
  -- * This returns a git_tree_entry that is owned by the git_tree.  You don't
  -- * have to free it, but you must not use it after the git_tree is released.
  -- *
  -- * @param tree a previously loaded tree.
  -- * @param idx the position in the entry list
  -- * @return the tree entry; NULL if not found
  --  

   function git_tree_entry_byindex (tree : access constant Git.Low_Level.git2_types_h.git_tree; idx : unsigned_long) return access constant Git.Low_Level.git2_types_h.git_tree_entry  -- /usr/include/git2/tree.h:112
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_byindex";

  --*
  -- * Lookup a tree entry by SHA value.
  -- *
  -- * This returns a git_tree_entry that is owned by the git_tree.  You don't
  -- * have to free it, but you must not use it after the git_tree is released.
  -- *
  -- * Warning: this must examine every entry in the tree, so it is not fast.
  -- *
  -- * @param tree a previously loaded tree.
  -- * @param id the sha being looked for
  -- * @return the tree entry; NULL if not found
  --  

   function git_tree_entry_byid (tree : access constant Git.Low_Level.git2_types_h.git_tree; id : access constant Git.Low_Level.git2_oid_h.git_oid) return access constant Git.Low_Level.git2_types_h.git_tree_entry  -- /usr/include/git2/tree.h:127
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_byid";

  --*
  -- * Retrieve a tree entry contained in a tree or in any of its subtrees,
  -- * given its relative path.
  -- *
  -- * Unlike the other lookup functions, the returned tree entry is owned by
  -- * the user and must be freed explicitly with `git_tree_entry_free()`.
  -- *
  -- * @param out Pointer where to store the tree entry
  -- * @param root Previously loaded tree which is the root of the relative path
  -- * @param path Path to the contained entry
  -- * @return 0 on success; GIT_ENOTFOUND if the path does not exist
  --  

   function git_tree_entry_bypath
     (c_out : System.Address;
      root : access constant Git.Low_Level.git2_types_h.git_tree;
      path : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/tree.h:142
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_bypath";

  --*
  -- * Duplicate a tree entry
  -- *
  -- * Create a copy of a tree entry. The returned copy is owned by the user,
  -- * and must be freed explicitly with `git_tree_entry_free()`.
  -- *
  -- * @param dest pointer where to store the copy
  -- * @param source tree entry to duplicate
  -- * @return 0 or an error code
  --  

   function git_tree_entry_dup (dest : System.Address; source : access constant Git.Low_Level.git2_types_h.git_tree_entry) return int  -- /usr/include/git2/tree.h:157
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_dup";

  --*
  -- * Free a user-owned tree entry
  -- *
  -- * IMPORTANT: This function is only needed for tree entries owned by the
  -- * user, such as the ones returned by `git_tree_entry_dup()` or
  -- * `git_tree_entry_bypath()`.
  -- *
  -- * @param entry The entry to free
  --  

   procedure git_tree_entry_free (c_entry : access Git.Low_Level.git2_types_h.git_tree_entry)  -- /usr/include/git2/tree.h:168
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_free";

  --*
  -- * Get the filename of a tree entry
  -- *
  -- * @param entry a tree entry
  -- * @return the name of the file
  --  

   function git_tree_entry_name (c_entry : access constant Git.Low_Level.git2_types_h.git_tree_entry) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/tree.h:176
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_name";

  --*
  -- * Get the id of the object pointed by the entry
  -- *
  -- * @param entry a tree entry
  -- * @return the oid of the object
  --  

   function git_tree_entry_id (c_entry : access constant Git.Low_Level.git2_types_h.git_tree_entry) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/tree.h:184
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_id";

  --*
  -- * Get the type of the object pointed by the entry
  -- *
  -- * @param entry a tree entry
  -- * @return the type of the pointed object
  --  

   function git_tree_entry_type (c_entry : access constant Git.Low_Level.git2_types_h.git_tree_entry) return Git.Low_Level.git2_types_h.git_object_t  -- /usr/include/git2/tree.h:192
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_type";

  --*
  -- * Get the UNIX file attributes of a tree entry
  -- *
  -- * @param entry a tree entry
  -- * @return filemode as an integer
  --  

   function git_tree_entry_filemode (c_entry : access constant Git.Low_Level.git2_types_h.git_tree_entry) return Git.Low_Level.git2_types_h.git_filemode_t  -- /usr/include/git2/tree.h:200
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_filemode";

  --*
  -- * Get the raw UNIX file attributes of a tree entry
  -- *
  -- * This function does not perform any normalization and is only useful
  -- * if you need to be able to recreate the original tree object.
  -- *
  -- * @param entry a tree entry
  -- * @return filemode as an integer
  --  

   function git_tree_entry_filemode_raw (c_entry : access constant Git.Low_Level.git2_types_h.git_tree_entry) return Git.Low_Level.git2_types_h.git_filemode_t  -- /usr/include/git2/tree.h:212
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_filemode_raw";

  --*
  -- * Compare two tree entries
  -- *
  -- * @param e1 first tree entry
  -- * @param e2 second tree entry
  -- * @return <0 if e1 is before e2, 0 if e1 == e2, >0 if e1 is after e2
  --  

   function git_tree_entry_cmp (e1 : access constant Git.Low_Level.git2_types_h.git_tree_entry; e2 : access constant Git.Low_Level.git2_types_h.git_tree_entry) return int  -- /usr/include/git2/tree.h:220
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_cmp";

  --*
  -- * Convert a tree entry to the git_object it points to.
  -- *
  -- * You must call `git_object_free()` on the object when you are done with it.
  -- *
  -- * @param object_out pointer to the converted object
  -- * @param repo repository where to lookup the pointed object
  -- * @param entry a tree entry
  -- * @return 0 or an error code
  --  

   function git_tree_entry_to_object
     (object_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      c_entry : access constant Git.Low_Level.git2_types_h.git_tree_entry) return int  -- /usr/include/git2/tree.h:232
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_entry_to_object";

  --*
  -- * Create a new tree builder.
  -- *
  -- * The tree builder can be used to create or modify trees in memory and
  -- * write them as tree objects to the database.
  -- *
  -- * If the `source` parameter is not NULL, the tree builder will be
  -- * initialized with the entries of the given tree.
  -- *
  -- * If the `source` parameter is NULL, the tree builder will start with no
  -- * entries and will have to be filled manually.
  -- *
  -- * @param out Pointer where to store the tree builder
  -- * @param repo Repository in which to store the object
  -- * @param source Source tree to initialize the builder (optional)
  -- * @return 0 on success; error code otherwise
  --  

   function git_treebuilder_new
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      source : access constant Git.Low_Level.git2_types_h.git_tree) return int  -- /usr/include/git2/tree.h:254
   with Import => True, 
        Convention => C, 
        External_Name => "git_treebuilder_new";

  --*
  -- * Clear all the entires in the builder
  -- *
  -- * @param bld Builder to clear
  -- * @return 0 on success; error code otherwise
  --  

   function git_treebuilder_clear (bld : access Git.Low_Level.git2_types_h.git_treebuilder) return int  -- /usr/include/git2/tree.h:263
   with Import => True, 
        Convention => C, 
        External_Name => "git_treebuilder_clear";

  --*
  -- * Get the number of entries listed in a treebuilder
  -- *
  -- * @param bld a previously loaded treebuilder.
  -- * @return the number of entries in the treebuilder
  --  

   function git_treebuilder_entrycount (bld : access Git.Low_Level.git2_types_h.git_treebuilder) return unsigned_long  -- /usr/include/git2/tree.h:271
   with Import => True, 
        Convention => C, 
        External_Name => "git_treebuilder_entrycount";

  --*
  -- * Free a tree builder
  -- *
  -- * This will clear all the entries and free to builder.
  -- * Failing to free the builder after you're done using it
  -- * will result in a memory leak
  -- *
  -- * @param bld Builder to free
  --  

   procedure git_treebuilder_free (bld : access Git.Low_Level.git2_types_h.git_treebuilder)  -- /usr/include/git2/tree.h:282
   with Import => True, 
        Convention => C, 
        External_Name => "git_treebuilder_free";

  --*
  -- * Get an entry from the builder from its filename
  -- *
  -- * The returned entry is owned by the builder and should
  -- * not be freed manually.
  -- *
  -- * @param bld Tree builder
  -- * @param filename Name of the entry
  -- * @return pointer to the entry; NULL if not found
  --  

   function git_treebuilder_get (bld : access Git.Low_Level.git2_types_h.git_treebuilder; filename : Interfaces.C.Strings.chars_ptr) return access constant Git.Low_Level.git2_types_h.git_tree_entry  -- /usr/include/git2/tree.h:294
   with Import => True, 
        Convention => C, 
        External_Name => "git_treebuilder_get";

  --*
  -- * Add or update an entry to the builder
  -- *
  -- * Insert a new entry for `filename` in the builder with the
  -- * given attributes.
  -- *
  -- * If an entry named `filename` already exists, its attributes
  -- * will be updated with the given ones.
  -- *
  -- * The optional pointer `out` can be used to retrieve a pointer to the
  -- * newly created/updated entry.  Pass NULL if you do not need it. The
  -- * pointer may not be valid past the next operation in this
  -- * builder. Duplicate the entry if you want to keep it.
  -- *
  -- * By default the entry that you are inserting will be checked for
  -- * validity; that it exists in the object database and is of the
  -- * correct type.  If you do not want this behavior, set the
  -- * `GIT_OPT_ENABLE_STRICT_OBJECT_CREATION` library option to false.
  -- *
  -- * @param out Pointer to store the entry (optional)
  -- * @param bld Tree builder
  -- * @param filename Filename of the entry
  -- * @param id SHA1 oid of the entry
  -- * @param filemode Folder attributes of the entry. This parameter must
  -- *			be valued with one of the following entries: 0040000, 0100644,
  -- *			0100755, 0120000 or 0160000.
  -- * @return 0 or an error code
  --  

   function git_treebuilder_insert
     (c_out : System.Address;
      bld : access Git.Low_Level.git2_types_h.git_treebuilder;
      filename : Interfaces.C.Strings.chars_ptr;
      id : access constant Git.Low_Level.git2_oid_h.git_oid;
      filemode : Git.Low_Level.git2_types_h.git_filemode_t) return int  -- /usr/include/git2/tree.h:325
   with Import => True, 
        Convention => C, 
        External_Name => "git_treebuilder_insert";

  --*
  -- * Remove an entry from the builder by its filename
  -- *
  -- * @param bld Tree builder
  -- * @param filename Filename of the entry to remove
  --  

   function git_treebuilder_remove (bld : access Git.Low_Level.git2_types_h.git_treebuilder; filename : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/tree.h:338
   with Import => True, 
        Convention => C, 
        External_Name => "git_treebuilder_remove";

  --*
  -- * Callback for git_treebuilder_filter
  -- *
  -- * The return value is treated as a boolean, with zero indicating that the
  -- * entry should be left alone and any non-zero value meaning that the
  -- * entry should be removed from the treebuilder list (i.e. filtered out).
  --  

   type git_treebuilder_filter_cb is access function (arg1 : access constant Git.Low_Level.git2_types_h.git_tree_entry; arg2 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/tree.h:348

  --*
  -- * Selectively remove entries in the tree
  -- *
  -- * The `filter` callback will be called for each entry in the tree with a
  -- * pointer to the entry and the provided `payload`; if the callback returns
  -- * non-zero, the entry will be filtered (removed from the builder).
  -- *
  -- * @param bld Tree builder
  -- * @param filter Callback to filter entries
  -- * @param payload Extra data to pass to filter callback
  -- * @return 0 on success, non-zero callback return value, or error code
  --  

   function git_treebuilder_filter
     (bld : access Git.Low_Level.git2_types_h.git_treebuilder;
      filter : git_treebuilder_filter_cb;
      payload : System.Address) return int  -- /usr/include/git2/tree.h:363
   with Import => True, 
        Convention => C, 
        External_Name => "git_treebuilder_filter";

  --*
  -- * Write the contents of the tree builder as a tree object
  -- *
  -- * The tree builder will be written to the given `repo`, and its
  -- * identifying SHA1 hash will be stored in the `id` pointer.
  -- *
  -- * @param id Pointer to store the OID of the newly written tree
  -- * @param bld Tree builder to write
  -- * @return 0 or an error code
  --  

   function git_treebuilder_write (id : access Git.Low_Level.git2_oid_h.git_oid; bld : access Git.Low_Level.git2_types_h.git_treebuilder) return int  -- /usr/include/git2/tree.h:378
   with Import => True, 
        Convention => C, 
        External_Name => "git_treebuilder_write";

  --*
  -- * Write the contents of the tree builder as a tree object
  -- * using a shared git_buf.
  -- *
  -- * @see git_treebuilder_write
  -- *
  -- * @param oid Pointer to store the OID of the newly written tree
  -- * @param bld Tree builder to write
  -- * @param tree Shared buffer for writing the tree. Will be grown as necessary.
  -- * @return 0 or an error code
  --  

   function git_treebuilder_write_with_buffer
     (oid : access Git.Low_Level.git2_oid_h.git_oid;
      bld : access Git.Low_Level.git2_types_h.git_treebuilder;
      tree : access Git.Low_Level.git2_buffer_h.git_buf) return int  -- /usr/include/git2/tree.h:392
   with Import => True, 
        Convention => C, 
        External_Name => "git_treebuilder_write_with_buffer";

  --* Callback for the tree traversal method  
   type git_treewalk_cb is access function
        (arg1 : Interfaces.C.Strings.chars_ptr;
         arg2 : access constant Git.Low_Level.git2_types_h.git_tree_entry;
         arg3 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/tree.h:396

  --* Tree traversal modes  
  -- Pre-order  
  -- Post-order  
   type git_treewalk_mode is 
     (GIT_TREEWALK_PRE,
      GIT_TREEWALK_POST)
   with Convention => C;  -- /usr/include/git2/tree.h:403

  --*
  -- * Traverse the entries in a tree and its subtrees in post or pre order.
  -- *
  -- * The entries will be traversed in the specified order, children subtrees
  -- * will be automatically loaded as required, and the `callback` will be
  -- * called once per entry with the current (relative) root for the entry and
  -- * the entry data itself.
  -- *
  -- * If the callback returns a positive value, the passed entry will be
  -- * skipped on the traversal (in pre mode). A negative value stops the walk.
  -- *
  -- * @param tree The tree to walk
  -- * @param mode Traversal mode (pre or post-order)
  -- * @param callback Function to call on each tree entry
  -- * @param payload Opaque pointer to be passed on each callback
  -- * @return 0 or an error code
  --  

   function git_tree_walk
     (tree : access constant Git.Low_Level.git2_types_h.git_tree;
      mode : git_treewalk_mode;
      callback : git_treewalk_cb;
      payload : System.Address) return int  -- /usr/include/git2/tree.h:422
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_walk";

  --*
  -- * Create an in-memory copy of a tree. The copy must be explicitly
  -- * free'd or it will leak.
  -- *
  -- * @param out Pointer to store the copy of the tree
  -- * @param source Original tree to copy
  --  

   function git_tree_dup (c_out : System.Address; source : access Git.Low_Level.git2_types_h.git_tree) return int  -- /usr/include/git2/tree.h:435
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_dup";

  --*
  -- * The kind of update to perform
  --  

  --* Update or insert an entry at the specified path  
  --* Remove an entry from the specified path  
   type git_tree_update_t is 
     (GIT_TREE_UPDATE_UPSERT,
      GIT_TREE_UPDATE_REMOVE)
   with Convention => C;  -- /usr/include/git2/tree.h:445

  --*
  -- * An action to perform during the update of a tree
  --  

  --* Update action. If it's an removal, only the path is looked at  
   --  skipped anonymous struct anon_anon_38

   type git_tree_update is record
      action : aliased git_tree_update_t;  -- /usr/include/git2/tree.h:452
      id : aliased Git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/tree.h:454
      filemode : aliased Git.Low_Level.git2_types_h.git_filemode_t;  -- /usr/include/git2/tree.h:456
      path : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/tree.h:458
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/tree.h:459

  --* The entry's id  
  --* The filemode/kind of object  
  --* The full path from the root tree  
  --*
  -- * Create a tree based on another one with the specified modifications
  -- *
  -- * Given the `baseline` perform the changes described in the list of
  -- * `updates` and create a new tree.
  -- *
  -- * This function is optimized for common file/directory addition, removal and
  -- * replacement in trees. It is much more efficient than reading the tree into a
  -- * `git_index` and modifying that, but in exchange it is not as flexible.
  -- *
  -- * Deleting and adding the same entry is undefined behaviour, changing
  -- * a tree to a blob or viceversa is not supported.
  -- *
  -- * @param out id of the new tree
  -- * @param repo the repository in which to create the tree, must be the
  -- * same as for `baseline`
  -- * @param baseline the tree to base these changes on
  -- * @param nupdates the number of elements in the update list
  -- * @param updates the list of updates to perform
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   function git_tree_create_updated
     (c_out : access Git.Low_Level.git2_oid_h.git_oid;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      baseline : access Git.Low_Level.git2_types_h.git_tree;
      nupdates : unsigned_long;
      updates : access constant git_tree_update) return int  -- /usr/include/git2/tree.h:481
   with Import => True, 
        Convention => C, 
        External_Name => "git_tree_create_updated";

end Git.Low_Level.git2_tree_h;

pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;


with Interfaces.C.Strings;


package Git.Low_Level.git2_types_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/types.h
  -- * @brief libgit2 base & compatibility types
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Cross-platform compatibility types for off_t / time_t
  -- *
  -- * NOTE: This needs to be in a public header so that both the library
  -- * implementation and client applications both agree on the same types.
  -- * Otherwise we get undefined behavior.
  -- *
  -- * Use the "best" types that each platform provides. Currently we truncate
  -- * these intermediate representations for compatibility with the git ABI, but
  -- * if and when it changes to support 64 bit types, our code will naturally
  -- * adapt.
  -- * NOTE: These types should match those that are returned by our internal
  -- * stat() functions, for all platforms.
  --  

  -- * Note: Can't use off_t since if a client program includes <sys/types.h>
  -- * before us (directly or indirectly), they'll get 32 bit off_t in their client
  -- * app, even though /we/ define _FILE_OFFSET_BITS=64.
  --  

   subtype git_off_t is long;  -- /usr/include/git2/types.h:61

  --*< time in seconds from epoch  
   subtype git_time_t is long;  -- /usr/include/git2/types.h:62

  --* The maximum size of an object  
   subtype git_object_size_t is unsigned_long;  -- /usr/include/git2/types.h:67

  --* Basic type (loose or packed) of any Git object.  
  --*< Object can be any of the following  
  --*< Object is invalid.  
  --*< A commit object.  
  --*< A tree (directory listing) object.  
  --*< A file revision object.  
  --*< An annotated tag object.  
  --*< A delta, base is given by an offset.  
  --*< A delta, base is given by object id.  
   subtype git_object_t is int;
   GIT_OBJECT_ANY : constant int := -2;
   GIT_OBJECT_INVALID : constant int := -1;
   GIT_OBJECT_COMMIT : constant int := 1;
   GIT_OBJECT_TREE : constant int := 2;
   GIT_OBJECT_BLOB : constant int := 3;
   GIT_OBJECT_TAG : constant int := 4;
   GIT_OBJECT_OFS_DELTA : constant int := 6;
   GIT_OBJECT_REF_DELTA : constant int := 7;  -- /usr/include/git2/types.h:82

  --* An open object database handle.  
   type git_odb is null record;   -- incomplete struct

  --* A custom backend in an ODB  
   type git_odb_backend is null record;   -- incomplete struct

  --* An object read from the ODB  
   type git_odb_object is null record;   -- incomplete struct

  --* A stream to read/write from the ODB  
     --* A stream to write a packfile to the ODB  
     --* An open refs database handle.  
   type git_refdb is null record;   -- incomplete struct

  --* A custom backend for refs  
   type git_refdb_backend is null record;   -- incomplete struct

  --*
  -- * Representation of an existing git repository,
  -- * including all its object contents
  --  

   type git_repository is null record;   -- incomplete struct

  --* Representation of a working tree  
   type git_worktree is null record;   -- incomplete struct

  --* Representation of a generic object in a repository  
   type git_object is null record;   -- incomplete struct

  --* Representation of an in-progress walk through the commits in a repo  
   type git_revwalk is null record;   -- incomplete struct

  --* Parsed representation of a tag object.  
   type git_tag is null record;   -- incomplete struct

  --* In-memory representation of a blob object.  
   type git_blob is null record;   -- incomplete struct

  --* Parsed representation of a commit object.  
   type git_commit is null record;   -- incomplete struct

  --* Representation of each one of the entries in a tree object.  
   type git_tree_entry is null record;   -- incomplete struct

  --* Representation of a tree object.  
   type git_tree is null record;   -- incomplete struct

  --* Constructor for in-memory trees  
   type git_treebuilder is null record;   -- incomplete struct

  --* Memory representation of an index file.  
   type git_index is null record;   -- incomplete struct

  --* An iterator for entries in the index.  
   type git_index_iterator is null record;   -- incomplete struct

  --* An iterator for conflicts in the index.  
   type git_index_conflict_iterator is null record;   -- incomplete struct

  --* Memory representation of a set of config files  
   type git_config is null record;   -- incomplete struct

  --* Interface to access a configuration file  
   type git_config_backend is null record;   -- incomplete struct

  --* Representation of a reference log entry  
   type git_reflog_entry is null record;   -- incomplete struct

  --* Representation of a reference log  
   type git_reflog is null record;   -- incomplete struct

  --* Representation of a git note  
   type git_note is null record;   -- incomplete struct

  --* Representation of a git packbuilder  
   type git_packbuilder is null record;   -- incomplete struct

  --* Time in a signature  
  --*< time in seconds from epoch  
   type git_time is record
      time : aliased git_time_t;  -- /usr/include/git2/types.h:167
      offset : aliased int;  -- /usr/include/git2/types.h:168
      sign : aliased char;  -- /usr/include/git2/types.h:169
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/types.h:166

  --*< timezone offset, in minutes  
  --*< indicator for questionable '-0000' offsets in signature  
  --* An action signature (e.g. for committers, taggers, etc)  
  --*< full name of the author  
   type git_signature is record
      name : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/types.h:174
      email : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/types.h:175
      c_when : aliased git_time;  -- /usr/include/git2/types.h:176
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/types.h:173

  --*< email of the author  
  --*< time when the action happened  
  --* In-memory representation of a reference.  
   type git_reference is null record;   -- incomplete struct

  --* Iterator for references  
   type git_reference_iterator is null record;   -- incomplete struct

  --* Transactional interface to references  
   type git_transaction is null record;   -- incomplete struct

  --* Annotated commits, the input to merge and rebase.  
   type git_annotated_commit is null record;   -- incomplete struct

  --* Representation of a status collection  
   type git_status_list is null record;   -- incomplete struct

  --* Representation of a rebase  
   type git_rebase is null record;   -- incomplete struct

  --* Basic type of any Git reference.  
  --*< Invalid reference  
  --*< A reference that points at an object id  
  --*< A reference that points at another reference  
   type git_reference_t is 
     (GIT_REFERENCE_INVALID,
      GIT_REFERENCE_DIRECT,
      GIT_REFERENCE_SYMBOLIC,
      GIT_REFERENCE_ALL)
   with Convention => C;  -- /usr/include/git2/types.h:203

  --* Basic type of any Git branch.  
   subtype git_branch_t is unsigned;
   GIT_BRANCH_LOCAL : constant unsigned := 1;
   GIT_BRANCH_REMOTE : constant unsigned := 2;
   GIT_BRANCH_ALL : constant unsigned := 3;  -- /usr/include/git2/types.h:210

  --* Valid modes for index and tree entries.  
   subtype git_filemode_t is unsigned;
   GIT_FILEMODE_UNREADABLE : constant unsigned := 0;
   GIT_FILEMODE_TREE : constant unsigned := 16384;
   GIT_FILEMODE_BLOB : constant unsigned := 33188;
   GIT_FILEMODE_BLOB_EXECUTABLE : constant unsigned := 33261;
   GIT_FILEMODE_LINK : constant unsigned := 40960;
   GIT_FILEMODE_COMMIT : constant unsigned := 57344;  -- /usr/include/git2/types.h:220

  --*
  -- * A refspec specifies the mapping between remote and local reference
  -- * names when fetch or pushing.
  --  

   type git_refspec is null record;   -- incomplete struct

  --*
  -- * Git's idea of a remote repository. A remote can be anonymous (in
  -- * which case it does not have backing configuration entires).
  --  

   type git_remote is null record;   -- incomplete struct

  --*
  -- * Interface which represents a transport to communicate with a
  -- * remote.
  --  

   type git_transport is null record;   -- incomplete struct

  --*
  -- * Preparation for a push operation. Can be used to configure what to
  -- * push and the level of parallelism of the packfile builder.
  --  

   type git_push is null record;   -- incomplete struct

  -- documentation in the definition  
        --*
  -- * Parent type for `git_cert_hostkey` and `git_cert_x509`.
  --  

     --*
  -- * Opaque structure representing a submodule.
  --  

   type git_submodule is null record;   -- incomplete struct

  --*
  -- * Submodule update values
  -- *
  -- * These values represent settings for the `submodule.$name.update`
  -- * configuration value which says how to handle `git submodule update` for
  -- * this submodule.  The value is usually set in the ".gitmodules" file and
  -- * copied to ".git/config" when the submodule is initialized.
  -- *
  -- * You can override this setting on a per-submodule basis with
  -- * `git_submodule_set_update()` and write the changed value to disk using
  -- * `git_submodule_save()`.  If you have overwritten the value, you can
  -- * revert it by passing `GIT_SUBMODULE_UPDATE_RESET` to the set function.
  -- *
  -- * The values are:
  -- *
  -- * - GIT_SUBMODULE_UPDATE_CHECKOUT: the default; when a submodule is
  -- *   updated, checkout the new detached HEAD to the submodule directory.
  -- * - GIT_SUBMODULE_UPDATE_REBASE: update by rebasing the current checked
  -- *   out branch onto the commit from the superproject.
  -- * - GIT_SUBMODULE_UPDATE_MERGE: update by merging the commit in the
  -- *   superproject into the current checkout out branch of the submodule.
  -- * - GIT_SUBMODULE_UPDATE_NONE: do not update this submodule even when
  -- *   the commit in the superproject is updated.
  -- * - GIT_SUBMODULE_UPDATE_DEFAULT: not used except as static initializer
  -- *   when we don't want any particular update rule to be specified.
  --  

   subtype git_submodule_update_t is unsigned;
   GIT_SUBMODULE_UPDATE_CHECKOUT : constant unsigned := 1;
   GIT_SUBMODULE_UPDATE_REBASE : constant unsigned := 2;
   GIT_SUBMODULE_UPDATE_MERGE : constant unsigned := 3;
   GIT_SUBMODULE_UPDATE_NONE : constant unsigned := 4;
   GIT_SUBMODULE_UPDATE_DEFAULT : constant unsigned := 0;  -- /usr/include/git2/types.h:293

  --*
  -- * Submodule ignore values
  -- *
  -- * These values represent settings for the `submodule.$name.ignore`
  -- * configuration value which says how deeply to look at the working
  -- * directory when getting submodule status.
  -- *
  -- * You can override this value in memory on a per-submodule basis with
  -- * `git_submodule_set_ignore()` and can write the changed value to disk
  -- * with `git_submodule_save()`.  If you have overwritten the value, you
  -- * can revert to the on disk value by using `GIT_SUBMODULE_IGNORE_RESET`.
  -- *
  -- * The values are:
  -- *
  -- * - GIT_SUBMODULE_IGNORE_UNSPECIFIED: use the submodule's configuration
  -- * - GIT_SUBMODULE_IGNORE_NONE: don't ignore any change - i.e. even an
  -- *   untracked file, will mark the submodule as dirty.  Ignored files are
  -- *   still ignored, of course.
  -- * - GIT_SUBMODULE_IGNORE_UNTRACKED: ignore untracked files; only changes
  -- *   to tracked files, or the index or the HEAD commit will matter.
  -- * - GIT_SUBMODULE_IGNORE_DIRTY: ignore changes in the working directory,
  -- *   only considering changes if the HEAD of submodule has moved from the
  -- *   value in the superproject.
  -- * - GIT_SUBMODULE_IGNORE_ALL: never check if the submodule is dirty
  -- * - GIT_SUBMODULE_IGNORE_DEFAULT: not used except as static initializer
  -- *   when we don't want any particular ignore rule to be specified.
  --  

  --*< use the submodule's configuration  
  --*< any change or untracked == dirty  
  --*< dirty if tracked files change  
  --*< only dirty if HEAD moved  
  --*< never dirty  
   subtype git_submodule_ignore_t is int;
   GIT_SUBMODULE_IGNORE_UNSPECIFIED : constant int := -1;
   GIT_SUBMODULE_IGNORE_NONE : constant int := 1;
   GIT_SUBMODULE_IGNORE_UNTRACKED : constant int := 2;
   GIT_SUBMODULE_IGNORE_DIRTY : constant int := 3;
   GIT_SUBMODULE_IGNORE_ALL : constant int := 4;  -- /usr/include/git2/types.h:329

  --*
  -- * Options for submodule recurse.
  -- *
  -- * Represent the value of `submodule.$name.fetchRecurseSubmodules`
  -- *
  -- * * GIT_SUBMODULE_RECURSE_NO    - do no recurse into submodules
  -- * * GIT_SUBMODULE_RECURSE_YES   - recurse into submodules
  -- * * GIT_SUBMODULE_RECURSE_ONDEMAND - recurse into submodules only when
  -- *                                    commit not already in local clone
  --  

   type git_submodule_recurse_t is 
     (GIT_SUBMODULE_RECURSE_NO,
      GIT_SUBMODULE_RECURSE_YES,
      GIT_SUBMODULE_RECURSE_ONDEMAND)
   with Convention => C;  -- /usr/include/git2/types.h:345

   type git_writestream;
  --* A type to write in a streaming fashion, for example, for filters.  
   type git_writestream is record
      write : access function
           (arg1 : access git_writestream;
            arg2 : Interfaces.C.Strings.chars_ptr;
            arg3 : unsigned_long) return int;  -- /usr/include/git2/types.h:351
      close : access function (arg1 : access git_writestream) return int;  -- /usr/include/git2/types.h:352
      free : access procedure (arg1 : access git_writestream);  -- /usr/include/git2/types.h:353
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/types.h:350

  --* Representation of .mailmap file state.  
  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   type git_mailmap is null record;   -- incomplete struct

end Git.Low_Level.git2_types_h;

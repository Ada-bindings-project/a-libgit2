pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
with Git.Low_Level.git2_types_h;
limited with Git.Low_Level.git2_oid_h;

with Interfaces.C.Strings;
limited with Git.Low_Level.git2_buffer_h;

package Git.Low_Level.git2_commit_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/commit.h
  -- * @brief Git commit parsing, formatting routines
  -- * @defgroup git_commit Git commit parsing, formatting routines
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Lookup a commit object from a repository.
  -- *
  -- * The returned object should be released with `git_commit_free` when no
  -- * longer needed.
  -- *
  -- * @param commit pointer to the looked up commit
  -- * @param repo the repo to use when locating the commit.
  -- * @param id identity of the commit to locate. If the object is
  -- *		an annotated tag it will be peeled back to the commit.
  -- * @return 0 or an error code
  --  

   function git_commit_lookup
     (commit : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      id : access constant Git.Low_Level.git2_oid_h.git_oid) return int  -- /usr/include/git2/commit.h:36
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_lookup";

  --*
  -- * Lookup a commit object from a repository, given a prefix of its
  -- * identifier (short id).
  -- *
  -- * The returned object should be released with `git_commit_free` when no
  -- * longer needed.
  -- *
  -- * @see git_object_lookup_prefix
  -- *
  -- * @param commit pointer to the looked up commit
  -- * @param repo the repo to use when locating the commit.
  -- * @param id identity of the commit to locate. If the object is
  -- *		an annotated tag it will be peeled back to the commit.
  -- * @param len the length of the short identifier
  -- * @return 0 or an error code
  --  

   function git_commit_lookup_prefix
     (commit : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      id : access constant Git.Low_Level.git2_oid_h.git_oid;
      len : unsigned_long) return int  -- /usr/include/git2/commit.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_lookup_prefix";

  --*
  -- * Close an open commit
  -- *
  -- * This is a wrapper around git_object_free()
  -- *
  -- * IMPORTANT:
  -- * It *is* necessary to call this method when you stop
  -- * using a commit. Failure to do so will cause a memory leak.
  -- *
  -- * @param commit the commit to close
  --  

   procedure git_commit_free (commit : access Git.Low_Level.git2_types_h.git_commit)  -- /usr/include/git2/commit.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_free";

  --*
  -- * Get the id of a commit.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return object identity for the commit.
  --  

   function git_commit_id (commit : access constant Git.Low_Level.git2_types_h.git_commit) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/commit.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_id";

  --*
  -- * Get the repository that contains the commit.
  -- *
  -- * @param commit A previously loaded commit.
  -- * @return Repository that contains this commit.
  --  

   function git_commit_owner (commit : access constant Git.Low_Level.git2_types_h.git_commit) return access Git.Low_Level.git2_types_h.git_repository  -- /usr/include/git2/commit.h:86
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_owner";

  --*
  -- * Get the encoding for the message of a commit,
  -- * as a string representing a standard encoding name.
  -- *
  -- * The encoding may be NULL if the `encoding` header
  -- * in the commit is missing; in that case UTF-8 is assumed.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return NULL, or the encoding
  --  

   function git_commit_message_encoding (commit : access constant Git.Low_Level.git2_types_h.git_commit) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/commit.h:98
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_message_encoding";

  --*
  -- * Get the full message of a commit.
  -- *
  -- * The returned message will be slightly prettified by removing any
  -- * potential leading newlines.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return the message of a commit
  --  

   function git_commit_message (commit : access constant Git.Low_Level.git2_types_h.git_commit) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/commit.h:109
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_message";

  --*
  -- * Get the full raw message of a commit.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return the raw message of a commit
  --  

   function git_commit_message_raw (commit : access constant Git.Low_Level.git2_types_h.git_commit) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/commit.h:117
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_message_raw";

  --*
  -- * Get the short "summary" of the git commit message.
  -- *
  -- * The returned message is the summary of the commit, comprising the
  -- * first paragraph of the message with whitespace trimmed and squashed.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return the summary of a commit or NULL on error
  --  

   function git_commit_summary (commit : access Git.Low_Level.git2_types_h.git_commit) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/commit.h:128
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_summary";

  --*
  -- * Get the long "body" of the git commit message.
  -- *
  -- * The returned message is the body of the commit, comprising
  -- * everything but the first paragraph of the message. Leading and
  -- * trailing whitespaces are trimmed.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return the body of a commit or NULL when no the message only
  -- *   consists of a summary
  --  

   function git_commit_body (commit : access Git.Low_Level.git2_types_h.git_commit) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/commit.h:141
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_body";

  --*
  -- * Get the commit time (i.e. committer time) of a commit.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return the time of a commit
  --  

   function git_commit_time (commit : access constant Git.Low_Level.git2_types_h.git_commit) return Git.Low_Level.git2_types_h.git_time_t  -- /usr/include/git2/commit.h:149
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_time";

  --*
  -- * Get the commit timezone offset (i.e. committer's preferred timezone) of a commit.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return positive or negative timezone offset, in minutes from UTC
  --  

   function git_commit_time_offset (commit : access constant Git.Low_Level.git2_types_h.git_commit) return int  -- /usr/include/git2/commit.h:157
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_time_offset";

  --*
  -- * Get the committer of a commit.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return the committer of a commit
  --  

   function git_commit_committer (commit : access constant Git.Low_Level.git2_types_h.git_commit) return access constant Git.Low_Level.git2_types_h.git_signature  -- /usr/include/git2/commit.h:165
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_committer";

  --*
  -- * Get the author of a commit.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return the author of a commit
  --  

   function git_commit_author (commit : access constant Git.Low_Level.git2_types_h.git_commit) return access constant Git.Low_Level.git2_types_h.git_signature  -- /usr/include/git2/commit.h:173
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_author";

  --*
  -- * Get the committer of a commit, using the mailmap to map names and email
  -- * addresses to canonical real names and email addresses.
  -- *
  -- * Call `git_signature_free` to free the signature.
  -- *
  -- * @param out a pointer to store the resolved signature.
  -- * @param commit a previously loaded commit.
  -- * @param mailmap the mailmap to resolve with. (may be NULL)
  -- * @return 0 or an error code
  --  

   function git_commit_committer_with_mailmap
     (c_out : System.Address;
      commit : access constant Git.Low_Level.git2_types_h.git_commit;
      mailmap : access constant Git.Low_Level.git2_types_h.git_mailmap) return int  -- /usr/include/git2/commit.h:186
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_committer_with_mailmap";

  --*
  -- * Get the author of a commit, using the mailmap to map names and email
  -- * addresses to canonical real names and email addresses.
  -- *
  -- * Call `git_signature_free` to free the signature.
  -- *
  -- * @param out a pointer to store the resolved signature.
  -- * @param commit a previously loaded commit.
  -- * @param mailmap the mailmap to resolve with. (may be NULL)
  -- * @return 0 or an error code
  --  

   function git_commit_author_with_mailmap
     (c_out : System.Address;
      commit : access constant Git.Low_Level.git2_types_h.git_commit;
      mailmap : access constant Git.Low_Level.git2_types_h.git_mailmap) return int  -- /usr/include/git2/commit.h:200
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_author_with_mailmap";

  --*
  -- * Get the full raw text of the commit header.
  -- *
  -- * @param commit a previously loaded commit
  -- * @return the header text of the commit
  --  

   function git_commit_raw_header (commit : access constant Git.Low_Level.git2_types_h.git_commit) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/commit.h:209
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_raw_header";

  --*
  -- * Get the tree pointed to by a commit.
  -- *
  -- * @param tree_out pointer where to store the tree object
  -- * @param commit a previously loaded commit.
  -- * @return 0 or an error code
  --  

   function git_commit_tree (tree_out : System.Address; commit : access constant Git.Low_Level.git2_types_h.git_commit) return int  -- /usr/include/git2/commit.h:218
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_tree";

  --*
  -- * Get the id of the tree pointed to by a commit. This differs from
  -- * `git_commit_tree` in that no attempts are made to fetch an object
  -- * from the ODB.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return the id of tree pointed to by commit.
  --  

   function git_commit_tree_id (commit : access constant Git.Low_Level.git2_types_h.git_commit) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/commit.h:228
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_tree_id";

  --*
  -- * Get the number of parents of this commit
  -- *
  -- * @param commit a previously loaded commit.
  -- * @return integer of count of parents
  --  

   function git_commit_parentcount (commit : access constant Git.Low_Level.git2_types_h.git_commit) return unsigned  -- /usr/include/git2/commit.h:236
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_parentcount";

  --*
  -- * Get the specified parent of the commit.
  -- *
  -- * @param out Pointer where to store the parent commit
  -- * @param commit a previously loaded commit.
  -- * @param n the position of the parent (from 0 to `parentcount`)
  -- * @return 0 or an error code
  --  

   function git_commit_parent
     (c_out : System.Address;
      commit : access constant Git.Low_Level.git2_types_h.git_commit;
      n : unsigned) return int  -- /usr/include/git2/commit.h:246
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_parent";

  --*
  -- * Get the oid of a specified parent for a commit. This is different from
  -- * `git_commit_parent`, which will attempt to load the parent commit from
  -- * the ODB.
  -- *
  -- * @param commit a previously loaded commit.
  -- * @param n the position of the parent (from 0 to `parentcount`)
  -- * @return the id of the parent, NULL on error.
  --  

   function git_commit_parent_id (commit : access constant Git.Low_Level.git2_types_h.git_commit; n : unsigned) return access constant Git.Low_Level.git2_oid_h.git_oid  -- /usr/include/git2/commit.h:260
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_parent_id";

  --*
  -- * Get the commit object that is the <n>th generation ancestor
  -- * of the named commit object, following only the first parents.
  -- * The returned commit has to be freed by the caller.
  -- *
  -- * Passing `0` as the generation number returns another instance of the
  -- * base commit itself.
  -- *
  -- * @param ancestor Pointer where to store the ancestor commit
  -- * @param commit a previously loaded commit.
  -- * @param n the requested generation
  -- * @return 0 on success; GIT_ENOTFOUND if no matching ancestor exists
  -- * or an error code
  --  

   function git_commit_nth_gen_ancestor
     (ancestor : System.Address;
      commit : access constant Git.Low_Level.git2_types_h.git_commit;
      n : unsigned) return int  -- /usr/include/git2/commit.h:278
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_nth_gen_ancestor";

  --*
  -- * Get an arbitrary header field
  -- *
  -- * @param out the buffer to fill; existing content will be
  -- * overwritten
  -- * @param commit the commit to look in
  -- * @param field the header field to return
  -- * @return 0 on succeess, GIT_ENOTFOUND if the field does not exist,
  -- * or an error code
  --  

   function git_commit_header_field
     (c_out : access Git.Low_Level.git2_buffer_h.git_buf;
      commit : access constant Git.Low_Level.git2_types_h.git_commit;
      field : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/commit.h:293
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_header_field";

  --*
  -- * Extract the signature from a commit
  -- *
  -- * If the id is not for a commit, the error class will be
  -- * `GIT_ERROR_INVALID`. If the commit does not have a signature, the
  -- * error class will be `GIT_ERROR_OBJECT`.
  -- *
  -- * @param signature the signature block; existing content will be
  -- * overwritten
  -- * @param signed_data signed data; this is the commit contents minus the signature block;
  -- * existing content will be overwritten
  -- * @param repo the repository in which the commit exists
  -- * @param commit_id the commit from which to extract the data
  -- * @param field the name of the header field containing the signature
  -- * block; pass `NULL` to extract the default 'gpgsig'
  -- * @return 0 on success, GIT_ENOTFOUND if the id is not for a commit
  -- * or the commit does not have a signature.
  --  

   function git_commit_extract_signature
     (signature : access Git.Low_Level.git2_buffer_h.git_buf;
      signed_data : access Git.Low_Level.git2_buffer_h.git_buf;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      commit_id : access Git.Low_Level.git2_oid_h.git_oid;
      field : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/commit.h:313
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_extract_signature";

  --*
  -- * Create new commit in the repository from a list of `git_object` pointers
  -- *
  -- * The message will **not** be cleaned up automatically. You can do that
  -- * with the `git_message_prettify()` function.
  -- *
  -- * @param id Pointer in which to store the OID of the newly created commit
  -- *
  -- * @param repo Repository where to store the commit
  -- *
  -- * @param update_ref If not NULL, name of the reference that
  -- *	will be updated to point to this commit. If the reference
  -- *	is not direct, it will be resolved to a direct reference.
  -- *	Use "HEAD" to update the HEAD of the current branch and
  -- *	make it point to this commit. If the reference doesn't
  -- *	exist yet, it will be created. If it does exist, the first
  -- *	parent must be the tip of this branch.
  -- *
  -- * @param author Signature with author and author time of commit
  -- *
  -- * @param committer Signature with committer and * commit time of commit
  -- *
  -- * @param message_encoding The encoding for the message in the
  -- *  commit, represented with a standard encoding name.
  -- *  E.g. "UTF-8". If NULL, no encoding header is written and
  -- *  UTF-8 is assumed.
  -- *
  -- * @param message Full message for this commit
  -- *
  -- * @param tree An instance of a `git_tree` object that will
  -- *  be used as the tree for the commit. This tree object must
  -- *  also be owned by the given `repo`.
  -- *
  -- * @param parent_count Number of parents for this commit
  -- *
  -- * @param parents Array of `parent_count` pointers to `git_commit`
  -- *  objects that will be used as the parents for this commit. This
  -- *  array may be NULL if `parent_count` is 0 (root commit). All the
  -- *  given commits must be owned by the `repo`.
  -- *
  -- * @return 0 or an error code
  -- *	The created commit will be written to the Object Database and
  -- *	the given reference will be updated to point to it
  --  

   function git_commit_create
     (id : access Git.Low_Level.git2_oid_h.git_oid;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      update_ref : Interfaces.C.Strings.chars_ptr;
      author : access constant Git.Low_Level.git2_types_h.git_signature;
      committer : access constant Git.Low_Level.git2_types_h.git_signature;
      message_encoding : Interfaces.C.Strings.chars_ptr;
      message : Interfaces.C.Strings.chars_ptr;
      tree : access constant Git.Low_Level.git2_types_h.git_tree;
      parent_count : unsigned_long;
      parents : System.Address) return int  -- /usr/include/git2/commit.h:359
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_create";

  --*
  -- * Create new commit in the repository using a variable argument list.
  -- *
  -- * The message will **not** be cleaned up automatically. You can do that
  -- * with the `git_message_prettify()` function.
  -- *
  -- * The parents for the commit are specified as a variable list of pointers
  -- * to `const git_commit *`. Note that this is a convenience method which may
  -- * not be safe to export for certain languages or compilers
  -- *
  -- * All other parameters remain the same as `git_commit_create()`.
  -- *
  -- * @see git_commit_create
  --  

   function git_commit_create_v
     (id : access Git.Low_Level.git2_oid_h.git_oid;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      update_ref : Interfaces.C.Strings.chars_ptr;
      author : access constant Git.Low_Level.git2_types_h.git_signature;
      committer : access constant Git.Low_Level.git2_types_h.git_signature;
      message_encoding : Interfaces.C.Strings.chars_ptr;
      message : Interfaces.C.Strings.chars_ptr;
      tree : access constant Git.Low_Level.git2_types_h.git_tree;
      parent_count : unsigned_long  -- , ...
      ) return int  -- /usr/include/git2/commit.h:385
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_create_v";

  --*
  -- * Amend an existing commit by replacing only non-NULL values.
  -- *
  -- * This creates a new commit that is exactly the same as the old commit,
  -- * except that any non-NULL values will be updated.  The new commit has
  -- * the same parents as the old commit.
  -- *
  -- * The `update_ref` value works as in the regular `git_commit_create()`,
  -- * updating the ref to point to the newly rewritten commit.  If you want
  -- * to amend a commit that is not currently the tip of the branch and then
  -- * rewrite the following commits to reach a ref, pass this as NULL and
  -- * update the rest of the commit chain and ref separately.
  -- *
  -- * Unlike `git_commit_create()`, the `author`, `committer`, `message`,
  -- * `message_encoding`, and `tree` parameters can be NULL in which case this
  -- * will use the values from the original `commit_to_amend`.
  -- *
  -- * All parameters have the same meanings as in `git_commit_create()`.
  -- *
  -- * @see git_commit_create
  --  

   function git_commit_amend
     (id : access Git.Low_Level.git2_oid_h.git_oid;
      commit_to_amend : access constant Git.Low_Level.git2_types_h.git_commit;
      update_ref : Interfaces.C.Strings.chars_ptr;
      author : access constant Git.Low_Level.git2_types_h.git_signature;
      committer : access constant Git.Low_Level.git2_types_h.git_signature;
      message_encoding : Interfaces.C.Strings.chars_ptr;
      message : Interfaces.C.Strings.chars_ptr;
      tree : access constant Git.Low_Level.git2_types_h.git_tree) return int  -- /usr/include/git2/commit.h:418
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_amend";

  --*
  -- * Create a commit and write it into a buffer
  -- *
  -- * Create a commit as with `git_commit_create()` but instead of
  -- * writing it to the objectdb, write the contents of the object into a
  -- * buffer.
  -- *
  -- * @param out the buffer into which to write the commit object content
  -- *
  -- * @param repo Repository where the referenced tree and parents live
  -- *
  -- * @param author Signature with author and author time of commit
  -- *
  -- * @param committer Signature with committer and * commit time of commit
  -- *
  -- * @param message_encoding The encoding for the message in the
  -- *  commit, represented with a standard encoding name.
  -- *  E.g. "UTF-8". If NULL, no encoding header is written and
  -- *  UTF-8 is assumed.
  -- *
  -- * @param message Full message for this commit
  -- *
  -- * @param tree An instance of a `git_tree` object that will
  -- *  be used as the tree for the commit. This tree object must
  -- *  also be owned by the given `repo`.
  -- *
  -- * @param parent_count Number of parents for this commit
  -- *
  -- * @param parents Array of `parent_count` pointers to `git_commit`
  -- *  objects that will be used as the parents for this commit. This
  -- *  array may be NULL if `parent_count` is 0 (root commit). All the
  -- *  given commits must be owned by the `repo`.
  -- *
  -- * @return 0 or an error code
  --  

   function git_commit_create_buffer
     (c_out : access Git.Low_Level.git2_buffer_h.git_buf;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      author : access constant Git.Low_Level.git2_types_h.git_signature;
      committer : access constant Git.Low_Level.git2_types_h.git_signature;
      message_encoding : Interfaces.C.Strings.chars_ptr;
      message : Interfaces.C.Strings.chars_ptr;
      tree : access constant Git.Low_Level.git2_types_h.git_tree;
      parent_count : unsigned_long;
      parents : System.Address) return int  -- /usr/include/git2/commit.h:463
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_create_buffer";

  --*
  -- * Create a commit object from the given buffer and signature
  -- *
  -- * Given the unsigned commit object's contents, its signature and the
  -- * header field in which to store the signature, attach the signature
  -- * to the commit and write it into the given repository.
  -- *
  -- * @param out the resulting commit id
  -- * @param commit_content the content of the unsigned commit object
  -- * @param signature the signature to add to the commit. Leave `NULL`
  -- * to create a commit without adding a signature field.
  -- * @param signature_field which header field should contain this
  -- * signature. Leave `NULL` for the default of "gpgsig"
  -- * @return 0 or an error code
  --  

   function git_commit_create_with_signature
     (c_out : access Git.Low_Level.git2_oid_h.git_oid;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      commit_content : Interfaces.C.Strings.chars_ptr;
      signature : Interfaces.C.Strings.chars_ptr;
      signature_field : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/commit.h:489
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_create_with_signature";

  --*
  -- * Create an in-memory copy of a commit. The copy must be explicitly
  -- * free'd or it will leak.
  -- *
  -- * @param out Pointer to store the copy of the commit
  -- * @param source Original commit to copy
  --  

   function git_commit_dup (c_out : System.Address; source : access Git.Low_Level.git2_types_h.git_commit) return int  -- /usr/include/git2/commit.h:503
   with Import => True, 
        Convention => C, 
        External_Name => "git_commit_dup";

  --*
  -- * Commit signing callback.
  -- *
  -- * The callback will be called with the commit content, giving a user an
  -- * opportunity to sign the commit content. The signature_field
  -- * buf may be left empty to specify the default field "gpgsig".
  -- *
  -- * Signatures can take the form of any string, and can be created on an arbitrary
  -- * header field. Signatures are most commonly used for verifying authorship of a
  -- * commit using GPG or a similar cryptographically secure signing algorithm.
  -- * See https://git-scm.com/book/en/v2/Git-Tools-Signing-Your-Work for more
  -- * details.
  -- *
  -- * When the callback:
  -- * - returns GIT_PASSTHROUGH, no signature will be added to the commit.
  -- * - returns < 0, commit creation will be aborted.
  -- * - returns GIT_OK, the signature parameter is expected to be filled.
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   type git_commit_signing_cb is access function
        (arg1 : access Git.Low_Level.git2_buffer_h.git_buf;
         arg2 : access Git.Low_Level.git2_buffer_h.git_buf;
         arg3 : Interfaces.C.Strings.chars_ptr;
         arg4 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/commit.h:523

end Git.Low_Level.git2_commit_h;

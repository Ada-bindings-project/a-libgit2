pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
limited with git.Low_Level.git2_types_h;
with Interfaces.C.Strings;
limited with git.Low_Level.git2_oid_h;

package git.Low_Level.git2_transaction_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/transaction.h
  --  * @brief Git transactional reference routines
  --  * @defgroup git_transaction Git transactional reference routines
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Create a new transaction object
  --  *
  --  * This does not lock anything, but sets up the transaction object to
  --  * know from which repository to lock.
  --  *
  --  * @param out the resulting transaction
  --  * @param repo the repository in which to lock
  --  * @return 0 or an error code
  --

   function git_transaction_new (c_out : System.Address; repo : access git.Low_Level.git2_types_h.git_repository) return int  -- /usr/include/git2/transaction.h:32
      with Import   => True,
      Convention    => C,
      External_Name => "git_transaction_new";

  --*
  -- * Lock a reference
  -- *
  --  * Lock the specified reference. This is the first step to updating a
  --  * reference.
  --  *
  --  * @param tx the transaction
  --  * @param refname the reference to lock
  --  * @return 0 or an error message
  --

   function git_transaction_lock_ref (tx : access git.Low_Level.git2_types_h.git_transaction; refname : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/transaction.h:44
      with Import   => True,
      Convention    => C,
      External_Name => "git_transaction_lock_ref";

  --*
  --  * Set the target of a reference
  --  *
  --  * Set the target of the specified reference. This reference must be
  --  * locked.
  --  *
  --  * @param tx the transaction
  --  * @param refname reference to update
  --  * @param target target to set the reference to
  --  * @param sig signature to use in the reflog; pass NULL to read the identity from the config
  --  * @param msg message to use in the reflog
  --  * @return 0, GIT_ENOTFOUND if the reference is not among the locked ones, or an error code
  --

   function git_transaction_set_target
     (tx      : access git.Low_Level.git2_types_h.git_transaction;
      refname : Interfaces.C.Strings.chars_ptr;
      target  : access constant git.Low_Level.git2_oid_h.git_oid;
      sig     : access constant git.Low_Level.git2_types_h.git_signature;
      msg     : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/transaction.h:59
      with Import   => True,
      Convention    => C,
      External_Name => "git_transaction_set_target";

  --*
  --  * Set the target of a reference
  --  *
  --  * Set the target of the specified reference. This reference must be
  --  * locked.
  --  *
  --  * @param tx the transaction
  --  * @param refname reference to update
  --  * @param target target to set the reference to
  --  * @param sig signature to use in the reflog; pass NULL to read the identity from the config
  --  * @param msg message to use in the reflog
  --  * @return 0, GIT_ENOTFOUND if the reference is not among the locked ones, or an error code
  --

   function git_transaction_set_symbolic_target
     (tx      : access git.Low_Level.git2_types_h.git_transaction;
      refname : Interfaces.C.Strings.chars_ptr;
      target  : Interfaces.C.Strings.chars_ptr;
      sig     : access constant git.Low_Level.git2_types_h.git_signature;
      msg     : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/transaction.h:74
      with Import   => True,
      Convention    => C,
      External_Name => "git_transaction_set_symbolic_target";

  --*
  --  * Set the reflog of a reference
  --  *
  --  * Set the specified reference's reflog. If this is combined with
  --  * setting the target, that update won't be written to the reflog.
  --  *
  --  * @param tx the transaction
  --  * @param refname the reference whose reflog to set
  --  * @param reflog the reflog as it should be written out
  --  * @return 0, GIT_ENOTFOUND if the reference is not among the locked ones, or an error code
  --

   function git_transaction_set_reflog
     (tx      : access git.Low_Level.git2_types_h.git_transaction;
      refname : Interfaces.C.Strings.chars_ptr;
      reflog  : access constant git.Low_Level.git2_types_h.git_reflog) return int  -- /usr/include/git2/transaction.h:87
      with Import   => True,
      Convention    => C,
      External_Name => "git_transaction_set_reflog";

  --*
  -- * Remove a reference
  -- *
  --  * @param tx the transaction
  --  * @param refname the reference to remove
  --  * @return 0, GIT_ENOTFOUND if the reference is not among the locked ones, or an error code
  --

   function git_transaction_remove (tx : access git.Low_Level.git2_types_h.git_transaction; refname : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/transaction.h:96
      with Import   => True,
      Convention    => C,
      External_Name => "git_transaction_remove";

  --*
  --  * Commit the changes from the transaction
  --  *
  --  * Perform the changes that have been queued. The updates will be made
  --  * one by one, and the first failure will stop the processing.
  --  *
  --  * @param tx the transaction
  --  * @return 0 or an error code
  --

   function git_transaction_commit (tx : access git.Low_Level.git2_types_h.git_transaction) return int  -- /usr/include/git2/transaction.h:107
      with Import   => True,
      Convention    => C,
      External_Name => "git_transaction_commit";

  --*
  --  * Free the resources allocated by this transaction
  --  *
  --  * If any references remain locked, they will be unlocked without any
  --  * changes made to them.
  --  *
  --  * @param tx the transaction
  --

   procedure git_transaction_free (tx : access git.Low_Level.git2_types_h.git_transaction)  -- /usr/include/git2/transaction.h:117
        with Import => True,
      Convention    => C,
      External_Name => "git_transaction_free";

  --* @}
end git.Low_Level.git2_transaction_h;

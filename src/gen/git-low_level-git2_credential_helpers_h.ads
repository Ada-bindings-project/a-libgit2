pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with System;

package git.Low_Level.git2_credential_helpers_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  --  * @file git2/credential_helpers.h
  --  * @brief Utility functions for credential management
  --  * @defgroup git_credential_helpers credential management helpers
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Payload for git_credential_userpass_plaintext.
  --

   type git_credential_userpass_payload is record
      username : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/credential_helpers.h:25
      password : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/credential_helpers.h:26
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/credential_helpers.h:24

  --*
  --  * Stock callback usable as a git_credential_acquire_cb.  This calls
  --  * git_cred_userpass_plaintext_new unless the protocol has not specified
  --  * `GIT_CREDENTIAL_USERPASS_PLAINTEXT` as an allowed type.
  --  *
  --  * @param out The newly created credential object.
  --  * @param url The resource for which we are demanding a credential.
  --  * @param user_from_url The username that was embedded in a "user\@host"
  --  *                          remote url, or NULL if not included.
  --  * @param allowed_types A bitmask stating which credential types are OK to return.
  --  * @param payload The payload provided when specifying this callback.  (This is
  --  *        interpreted as a `git_credential_userpass_payload*`.)
  --

   function git_credential_userpass
     (c_out         : System.Address;
      url           : Interfaces.C.Strings.chars_ptr;
      user_from_url : Interfaces.C.Strings.chars_ptr;
      allowed_types : unsigned;
      payload       : System.Address) return int  -- /usr/include/git2/credential_helpers.h:43
      with Import   => True,
      Convention    => C,
      External_Name => "git_credential_userpass";

  --* @}
end git.Low_Level.git2_credential_helpers_h;

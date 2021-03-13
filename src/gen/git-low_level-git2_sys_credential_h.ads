pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with git.Low_Level.git2_credential_h;
with Interfaces.C.Strings;
with System;


package git.Low_Level.git2_sys_credential_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/sys/cred.h
  --  * @brief Git credentials low-level implementation
  --  * @defgroup git_credential Git credentials low-level implementation
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * The base structure for all credential types
  --

  --*< A type of credential
   type git_credential;
   type git_credential is record
      credtype : aliased git.Low_Level.git2_credential_h.git_credential_t;  -- /usr/include/git2/sys/credential.h:26
      free     : access procedure (arg1 : access git_credential);  -- /usr/include/git2/sys/credential.h:29
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/sys/credential.h:25

  --* The deallocator for this type of credentials
  --* A plaintext username and password
  --*< The parent credential
   type git_credential_userpass_plaintext is record
      parent   : aliased git_credential;  -- /usr/include/git2/sys/credential.h:34
      username : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/sys/credential.h:35
      password : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/sys/credential.h:36
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/sys/credential.h:33

  --*< The username to authenticate as
  --*< The password to use
  --* Username-only credential information
  --*< The parent credential
   subtype git_credential_username_array3600 is Interfaces.C.char_array (0 .. 0);
   type git_credential_username is record
      parent   : aliased git_credential;  -- /usr/include/git2/sys/credential.h:41
      username : aliased git_credential_username_array3600;  -- /usr/include/git2/sys/credential.h:42
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/sys/credential.h:40

  --*< The username to authenticate as
  --*
  -- * A ssh key from disk
  --

  --*< The parent credential
   type git_credential_ssh_key is record
      parent     : aliased git_credential;  -- /usr/include/git2/sys/credential.h:49
      username   : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/sys/credential.h:50
      publickey  : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/sys/credential.h:51
      privatekey : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/sys/credential.h:52
      passphrase : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/sys/credential.h:53
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/sys/credential.h:48

  --*< The username to authenticate as
  --*< The path to a public key
  --*< The path to a private key
  --*< Passphrase to decrypt the private key
  --*
  --  * Keyboard-interactive based ssh authentication
  --

  --*< The parent credential
   type git_credential_ssh_interactive is record
      parent          : aliased git_credential;  -- /usr/include/git2/sys/credential.h:60
      username        : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/sys/credential.h:61
      prompt_callback : git.Low_Level.git2_credential_h.git_credential_ssh_interactive_cb;  -- /usr/include/git2/sys/credential.h:66
      payload         : System.Address;  -- /usr/include/git2/sys/credential.h:68
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/sys/credential.h:59

  --*< The username to authenticate as
  --*
  --     * Callback used for authentication.
  --

  --*< Payload passed to prompt_callback
  --*
  --  * A key with a custom signature function
  --

  --*< The parent credential
   type git_credential_ssh_custom is record
      parent        : aliased git_credential;  -- /usr/include/git2/sys/credential.h:75
      username      : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/sys/credential.h:76
      publickey     : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/sys/credential.h:77
      publickey_len : aliased unsigned_long;  -- /usr/include/git2/sys/credential.h:78
      sign_callback : git.Low_Level.git2_credential_h.git_credential_sign_cb;  -- /usr/include/git2/sys/credential.h:83
      payload       : System.Address;  -- /usr/include/git2/sys/credential.h:85
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/sys/credential.h:74

  --*< The username to authenticate as
  --*< The public key data
  --*< Length of the public key
  --*
  --     * Callback used to sign the data.
  --

  --*< Payload passed to prompt_callback
end git.Low_Level.git2_sys_credential_h;

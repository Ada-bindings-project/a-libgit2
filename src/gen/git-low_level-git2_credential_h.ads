pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
limited with git.Low_Level.git2_sys_credential_h;
with System;
with Interfaces.C.Strings;


package git.Low_Level.git2_credential_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/credential.h
  --  * @brief Git authentication & credential management
  --  * @defgroup git_credential Authentication & credential management
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Supported credential types
  --  *
  --  * This represents the various types of authentication methods supported by
  --  * the library.
  --

  --*
  --     * A vanilla user/password request
  --     * @see git_credential_userpass_plaintext_new
  --

  --*
  --     * An SSH key-based authentication request
  --     * @see git_credential_ssh_key_new
  --

  --*
  --     * An SSH key-based authentication request, with a custom signature
  --     * @see git_credential_ssh_custom_new
  --

  --*
  --     * An NTLM/Negotiate-based authentication request.
  --     * @see git_credential_default
  --

  --*
  --     * An SSH interactive authentication request
  --     * @see git_credential_ssh_interactive_new
  --

  --*
  --     * Username-only authentication request
  --     *
  --     * Used as a pre-authentication step if the underlying transport
  --     * (eg. SSH, with no username in its URL) does not know which username
  --     * to use.
  --     *
  --     * @see git_credential_username_new
  --

  --*
  --     * An SSH key-based authentication request
  --     *
  --     * Allows credentials to be read from memory instead of files.
  --     * Note that because of differences in crypto backend support, it might
  --     * not be functional.
  --     *
  --     * @see git_credential_ssh_key_memory_new
  --

   subtype git_credential_t is unsigned;
   GIT_CREDENTIAL_USERPASS_PLAINTEXT : constant unsigned := 1;
   GIT_CREDENTIAL_SSH_KEY            : constant unsigned := 2;
   GIT_CREDENTIAL_SSH_CUSTOM         : constant unsigned := 4;
   GIT_CREDENTIAL_DEFAULT            : constant unsigned := 8;
   GIT_CREDENTIAL_SSH_INTERACTIVE    : constant unsigned := 16;
   GIT_CREDENTIAL_USERNAME           : constant unsigned := 32;
   GIT_CREDENTIAL_SSH_MEMORY         : constant unsigned := 64;  -- /usr/include/git2/credential.h:79

  --*
  --  * The base structure for all credential types
  --

        --* Username-only credential information
     --* A key for NTLM/Kerberos "default" credentials
   --  subtype git_credential_default is Git.Low_Level.git2_sys_credential_h.git_credential;  -- /usr/include/git2/credential.h:92

  --*
  -- * A ssh key from disk
  --

     --*
  --  * Keyboard-interactive based ssh authentication
  --

     --*
  --  * A key with a custom signature function
  --

     --*
  --  * Credential acquisition callback.
  --  *
  --  * This callback is usually involved any time another system might need
  --  * authentication. As such, you are expected to provide a valid
  --  * git_credential object back, depending on allowed_types (a
  --  * git_credential_t bitmask).
  --  *
  --  * Note that most authentication details are your responsibility - this
  --  * callback will be called until the authentication succeeds, or you report
  --  * an error. As such, it's easy to get in a loop if you fail to stop providing
  --  * the same incorrect credentials.
  --  *
  --  * @param out The newly created credential object.
  --  * @param url The resource for which we are demanding a credential.
  --  * @param username_from_url The username that was embedded in a "user\@host"
  --  *                          remote url, or NULL if not included.
  --  * @param allowed_types A bitmask stating which credential types are OK to return.
  --  * @param payload The payload provided when specifying this callback.
  --  * @return 0 for success, < 0 to indicate an error, > 0 to indicate
  --  *       no credential was acquired
  --

   type git_credential_acquire_cb is access function
     (arg1 : System.Address;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : unsigned;
      arg5 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/credential.h:131

  --*
  -- * Free a credential.
  -- *
  --  * This is only necessary if you own the object; that is, if you are a
  --  * transport.
  --  *
  --  * @param cred the object to free
  --

   procedure git_credential_free (cred : access git2_sys_credential_h.git_credential)  -- /usr/include/git2/credential.h:146
        with Import => True,
      Convention    => C,
      External_Name => "git_credential_free";

  --*
  --  * Check whether a credential object contains username information.
  --  *
  --  * @param cred object to check
  --  * @return 1 if the credential object has non-NULL username, 0 otherwise
  --

   function git_credential_has_username (cred : access git2_sys_credential_h.git_credential) return int  -- /usr/include/git2/credential.h:154
      with Import   => True,
      Convention    => C,
      External_Name => "git_credential_has_username";

  --*
  --  * Return the username associated with a credential object.
  --  *
  --  * @param cred object to check
  --  * @return the credential username, or NULL if not applicable
  --

   function git_credential_get_username (cred : access git2_sys_credential_h.git_credential) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/credential.h:162
     with Import    => True,
      Convention    => C,
      External_Name => "git_credential_get_username";

  --*
  --  * Create a new plain-text username and password credential object.
  --  * The supplied credential parameter will be internally duplicated.
  --  *
  --  * @param out The newly created credential object.
  --  * @param username The username of the credential.
  --  * @param password The password of the credential.
  --  * @return 0 for success or an error code for failure
  --

   function git_credential_userpass_plaintext_new
     (c_out    : System.Address;
      username : Interfaces.C.Strings.chars_ptr;
      password : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/credential.h:173
      with Import   => True,
      Convention    => C,
      External_Name => "git_credential_userpass_plaintext_new";

  --*
  --  * Create a "default" credential usable for Negotiate mechanisms like NTLM
  --  * or Kerberos authentication.
  --  *
  --  * @param out The newly created credential object.
  --  * @return 0 for success or an error code for failure
  --

   function git_credential_default_new (c_out : System.Address) return int  -- /usr/include/git2/credential.h:185
      with Import   => True,
      Convention    => C,
      External_Name => "git_credential_default_new";

  --*
  --  * Create a credential to specify a username.
  --  *
  --  * This is used with ssh authentication to query for the username if
  --  * none is specified in the url.
  --  *
  --  * @param out The newly created credential object.
  --  * @param username The username to authenticate with
  --  * @return 0 for success or an error code for failure
  --

   function git_credential_username_new (c_out : System.Address; username : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/credential.h:197
      with Import   => True,
      Convention    => C,
      External_Name => "git_credential_username_new";

  --*
  --  * Create a new passphrase-protected ssh key credential object.
  --  * The supplied credential parameter will be internally duplicated.
  --  *
  --  * @param out The newly created credential object.
  --  * @param username username to use to authenticate
  --  * @param publickey The path to the public key of the credential.
  --  * @param privatekey The path to the private key of the credential.
  --  * @param passphrase The passphrase of the credential.
  --  * @return 0 for success or an error code for failure
  --

   function git_credential_ssh_key_new
     (c_out      : System.Address;
      username   : Interfaces.C.Strings.chars_ptr;
      publickey  : Interfaces.C.Strings.chars_ptr;
      privatekey : Interfaces.C.Strings.chars_ptr;
      passphrase : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/credential.h:210
      with Import   => True,
      Convention    => C,
      External_Name => "git_credential_ssh_key_new";

  --*
  --  * Create a new ssh key credential object reading the keys from memory.
  --  *
  --  * @param out The newly created credential object.
  --  * @param username username to use to authenticate.
  --  * @param publickey The public key of the credential.
  --  * @param privatekey The private key of the credential.
  --  * @param passphrase The passphrase of the credential.
  --  * @return 0 for success or an error code for failure
  --

   function git_credential_ssh_key_memory_new
     (c_out      : System.Address;
      username   : Interfaces.C.Strings.chars_ptr;
      publickey  : Interfaces.C.Strings.chars_ptr;
      privatekey : Interfaces.C.Strings.chars_ptr;
      passphrase : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/credential.h:227
      with Import   => True,
      Convention    => C,
      External_Name => "git_credential_ssh_key_memory_new";

  --  * If the user hasn't included libssh2.h before git2.h, we need to
  --  * define a few types for the callback signatures.
  --

   type u_LIBSSH2_SESSION is null record;   -- incomplete struct

   subtype LIBSSH2_SESSION is u_LIBSSH2_SESSION;  -- /usr/include/git2/credential.h:239

   type u_LIBSSH2_USERAUTH_KBDINT_PROMPT is null record;   -- incomplete struct

   subtype LIBSSH2_USERAUTH_KBDINT_PROMPT is u_LIBSSH2_USERAUTH_KBDINT_PROMPT;  -- /usr/include/git2/credential.h:240

   type u_LIBSSH2_USERAUTH_KBDINT_RESPONSE is null record;   -- incomplete struct

   subtype LIBSSH2_USERAUTH_KBDINT_RESPONSE is u_LIBSSH2_USERAUTH_KBDINT_RESPONSE;  -- /usr/include/git2/credential.h:241

   type git_credential_ssh_interactive_cb is access procedure
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : int;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : int;
      arg5 : int;
      arg6 : access constant LIBSSH2_USERAUTH_KBDINT_PROMPT;
      arg7 : access LIBSSH2_USERAUTH_KBDINT_RESPONSE;
      arg8 : System.Address)
        with Convention => C;  -- /usr/include/git2/credential.h:244

  --*
  --  * Create a new ssh keyboard-interactive based credential object.
  --  * The supplied credential parameter will be internally duplicated.
  --  *
  --  * @param username Username to use to authenticate.
  --  * @param prompt_callback The callback method used for prompts.
  --  * @param payload Additional data to pass to the callback.
  --  * @return 0 for success or an error code for failure.
  --

   function git_credential_ssh_interactive_new
     (c_out           : System.Address;
      username        : Interfaces.C.Strings.chars_ptr;
      prompt_callback : git_credential_ssh_interactive_cb;
      payload         : System.Address) return int  -- /usr/include/git2/credential.h:262
      with Import   => True,
      Convention    => C,
      External_Name => "git_credential_ssh_interactive_new";

  --*
  --  * Create a new ssh key credential object used for querying an ssh-agent.
  --  * The supplied credential parameter will be internally duplicated.
  --  *
  --  * @param out The newly created credential object.
  --  * @param username username to use to authenticate
  --  * @return 0 for success or an error code for failure
  --

   function git_credential_ssh_key_from_agent (c_out : System.Address; username : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/credential.h:276
      with Import   => True,
      Convention    => C,
      External_Name => "git_credential_ssh_key_from_agent";

   type git_credential_sign_cb is access function
     (arg1 : access LIBSSH2_SESSION;
      arg2 : System.Address;
      arg3 : access unsigned_long;
      arg4 : access unsigned_char;
      arg5 : unsigned_long;
      arg6 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/credential.h:280

  --*
  --  * Create an ssh key credential with a custom signing function.
  --  *
  --  * This lets you use your own function to sign the challenge.
  --  *
  --  * This function and its credential type is provided for completeness
  --  * and wraps `libssh2_userauth_publickey()`, which is undocumented.
  --  *
  --  * The supplied credential parameter will be internally duplicated.
  --  *
  --  * @param out The newly created credential object.
  --  * @param username username to use to authenticate
  --  * @param publickey The bytes of the public key.
  --  * @param publickey_len The length of the public key in bytes.
  --  * @param sign_callback The callback method to sign the data during the challenge.
  --  * @param payload Additional data to pass to the callback.
  --  * @return 0 for success or an error code for failure
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

   function git_credential_ssh_custom_new
     (c_out         : System.Address;
      username      : Interfaces.C.Strings.chars_ptr;
      publickey     : Interfaces.C.Strings.chars_ptr;
      publickey_len : unsigned_long;
      sign_callback : git_credential_sign_cb;
      payload       : System.Address) return int  -- /usr/include/git2/credential.h:304
      with Import   => True,
      Convention    => C,
      External_Name => "git_credential_ssh_custom_new";

end git.Low_Level.git2_credential_h;

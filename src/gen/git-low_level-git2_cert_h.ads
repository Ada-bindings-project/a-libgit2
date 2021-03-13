pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Git.Low_Level.git2_types_h;
with Interfaces.C.Strings;
with System;


package Git.Low_Level.git2_cert_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/cert.h
  -- * @brief Git certificate objects
  -- * @defgroup git_cert Certificate objects
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Type of host certificate structure that is passed to the check callback
  --  

   type git_cert_t is 
     (GIT_CERT_NONE,
      GIT_CERT_X509_E,
      GIT_CERT_HOSTKEY_LIBSSH2,
      GIT_CERT_STRARRAY)
   with Convention => C;  -- /usr/include/git2/cert.h:24

  --*
  --	 * No information about the certificate is available. This may
  --	 * happen when using curl.
  --	  

  --*
  --	 * The `data` argument to the callback will be a pointer to
  --	 * the DER-encoded data.
  --	  

  --*
  --	 * The `data` argument to the callback will be a pointer to a
  --	 * `git_cert_hostkey` structure.
  --	  

  --*
  --	 * The `data` argument to the callback will be a pointer to a
  --	 * `git_strarray` with `name:content` strings containing
  --	 * information about the certificate. This is used when using
  --	 * curl.
  --	  

  --*
  -- * Parent type for `git_cert_hostkey` and `git_cert_x509`.
  --  

  --*
  --	 * Type of certificate. A `GIT_CERT_` value.
  --	  

   type git_cert is record
      cert_type : aliased git_cert_t;  -- /usr/include/git2/cert.h:56
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/cert.h:52

  --*
  -- * Callback for the user's custom certificate checks.
  -- *
  -- * @param cert The host certificate
  -- * @param valid Whether the libgit2 checks (OpenSSL or WinHTTP) think
  -- * this certificate is valid
  -- * @param host Hostname of the host libgit2 connected to
  -- * @param payload Payload provided by the caller
  -- * @return 0 to proceed with the connection, < 0 to fail the connection
  -- *         or > 0 to indicate that the callback refused to act and that
  -- *         the existing validity determination should be honored
  --  

   type git_transport_certificate_check_cb is access function
        (arg1 : access git_cert;
         arg2 : int;
         arg3 : Interfaces.C.Strings.chars_ptr;
         arg4 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/cert.h:71

  --*
  -- * Type of SSH host fingerprint
  --  

  --* MD5 is available  
  --* SHA-1 is available  
  --* SHA-256 is available  
   subtype git_cert_ssh_t is unsigned;
   GIT_CERT_SSH_MD5 : constant unsigned := 1;
   GIT_CERT_SSH_SHA1 : constant unsigned := 2;
   GIT_CERT_SSH_SHA256 : constant unsigned := 4;  -- /usr/include/git2/cert.h:83

  --*
  -- * Hostkey information taken from libssh2
  --  

  --*< The parent cert  
   --  skipped anonymous struct anon_anon_67

   type git_cert_hostkey_array2564 is array (0 .. 15) of aliased unsigned_char;
   type git_cert_hostkey_array1716 is array (0 .. 19) of aliased unsigned_char;
   type git_cert_hostkey_array2565 is array (0 .. 31) of aliased unsigned_char;
   type git_cert_hostkey is record
      parent : aliased git_cert;  -- /usr/include/git2/cert.h:89
      c_type : aliased git_cert_ssh_t;  -- /usr/include/git2/cert.h:95
      hash_md5 : aliased git_cert_hostkey_array2564;  -- /usr/include/git2/cert.h:101
      hash_sha1 : aliased git_cert_hostkey_array1716;  -- /usr/include/git2/cert.h:107
      hash_sha256 : aliased git_cert_hostkey_array2565;  -- /usr/include/git2/cert.h:113
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/cert.h:114

  --*
  --	 * A hostkey type from libssh2, either
  --	 * `GIT_CERT_SSH_MD5` or `GIT_CERT_SSH_SHA1`
  --	  

  --*
  --	 * Hostkey hash. If type has `GIT_CERT_SSH_MD5` set, this will
  --	 * have the MD5 hash of the hostkey.
  --	  

  --*
  --	 * Hostkey hash. If type has `GIT_CERT_SSH_SHA1` set, this will
  --	 * have the SHA-1 hash of the hostkey.
  --	  

  --*
  --	 * Hostkey hash. If type has `GIT_CERT_SSH_SHA256` set, this will
  --	 * have the SHA-256 hash of the hostkey.
  --	  

  --*
  -- * X.509 certificate information
  --  

  --*< The parent cert  
   --  skipped anonymous struct anon_anon_68

   type git_cert_x509 is record
      parent : aliased git_cert;  -- /usr/include/git2/cert.h:120
      data : System.Address;  -- /usr/include/git2/cert.h:125
      len : aliased unsigned_long;  -- /usr/include/git2/cert.h:130
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/cert.h:131

  --*
  --	 * Pointer to the X.509 certificate data
  --	  

  --*
  --	 * Length of the memory block pointed to by `data`.
  --	  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

end Git.Low_Level.git2_cert_h;

pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with git.Low_Level.git2_credential_h;
with git.Low_Level.git2_cert_h;
with System;

package git.Low_Level.git2_proxy_h is

   GIT_PROXY_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/proxy.h:81
   --  unsupported macro: GIT_PROXY_OPTIONS_INIT {GIT_PROXY_OPTIONS_VERSION}

   --  * Copyright (C) the libgit2 contributors. All rights reserved.
   --  *
   --  * This file is part of libgit2, distributed under the GNU GPL v2 with
   --  * a Linking Exception. For full terms see the included COPYING file.
  --

   --*
  --  * The type of proxy to use.
  --

   --*
  --     * Do not attempt to connect through a proxy
  --     *
  --     * If built against libcurl, it itself may attempt to connect
  --     * to a proxy if the environment variables specify it.
  --

   --*
  --     * Try to auto-detect the proxy from the git configuration.
  --

   --*
  --     * Connect via the URL given in the options
  --

   type git_proxy_t is
     (GIT_PROXY_NONE,
      GIT_PROXY_AUTO,
      GIT_PROXY_SPECIFIED)
      with Convention => C;  -- /usr/include/git2/proxy.h:36

  --*
  --  * Options for connecting through a proxy
  --  *
  --  * Note that not all types may be supported, depending on the platform
  --  * and compilation options.
  --

   --  skipped anonymous struct anon_anon_92

   type git_proxy_options is record
      version           : aliased unsigned;  -- /usr/include/git2/proxy.h:45
      c_type            : aliased git_proxy_t;  -- /usr/include/git2/proxy.h:50
      url               : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/proxy.h:55
      credentials       : git.Low_Level.git2_credential_h.git_credential_acquire_cb;  -- /usr/include/git2/proxy.h:64
      certificate_check : git.Low_Level.git2_cert_h.git_transport_certificate_check_cb;  -- /usr/include/git2/proxy.h:72
      payload           : System.Address;  -- /usr/include/git2/proxy.h:78
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/proxy.h:79

  --*
  --     * The type of proxy to use, by URL, auto-detect.
  --

  --*
  --     * The URL of the proxy.
  --

  --*
  --     * This will be called if the remote host requires
  --     * authentication in order to connect to it.
  --     *
  --     * Returning GIT_PASSTHROUGH will make libgit2 behave as
  --     * though this field isn't set.
  --

  --*
  --     * If cert verification fails, this will be called to let the
  --     * user make the final decision of whether to allow the
  --     * connection to proceed. Returns 0 to allow the connection
  --     * or a negative value to indicate an error.
  --

  --*
  --     * Payload to be provided to the credentials and certificate
  --     * check callbacks.
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

   function git_proxy_options_init (opts : access git_proxy_options; version : unsigned) return int  -- /usr/include/git2/proxy.h:94
      with Import   => True,
      Convention    => C,
      External_Name => "git_proxy_options_init";

end git.Low_Level.git2_proxy_h;

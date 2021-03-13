pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with System;
limited with git.Low_Level.git2_types_h;

package git.Low_Level.git2_transport_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/transport.h
  --  * @brief Git transport interfaces and functions
  --  * @defgroup git_transport interfaces and functions
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Callback for messages recieved by the transport.
  --  *
  --  * Return a negative value to cancel the network operation.
  --  *
  --  * @param str The message from the transport
  --  * @param len The length of the message
  --  * @param payload Payload provided by the caller
  --

   type git_transport_message_cb is access function
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : int;
      arg3 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/transport.h:34

  --* Signature of a function which creates a transport
  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

   type git_transport_cb is access function
     (arg1 : System.Address;
      arg2 : access git.Low_Level.git2_types_h.git_remote;
      arg3 : System.Address) return int
      with Convention => C;  -- /usr/include/git2/transport.h:37

end git.Low_Level.git2_transport_h;

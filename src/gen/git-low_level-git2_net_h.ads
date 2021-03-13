pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Git.Low_Level.git2_oid_h;
with Interfaces.C.Strings;

package Git.Low_Level.git2_net_h is

   GIT_DEFAULT_PORT : aliased constant String := "9418" & ASCII.NUL;  --  /usr/include/git2/net.h:22

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/net.h
  -- * @brief Git networking declarations
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Direction of the connection.
  -- *
  -- * We need this because we need to know whether we should call
  -- * git-upload-pack or git-receive-pack on the remote end when get_refs
  -- * gets called.
  --  

   type git_direction is 
     (GIT_DIRECTION_FETCH,
      GIT_DIRECTION_PUSH)
   with Convention => C;  -- /usr/include/git2/net.h:34

  --*
  -- * Description of a reference advertised by a remote server, given out
  -- * on `ls` calls.
  --  

  -- available locally  
   type git_remote_head is record
      local : aliased int;  -- /usr/include/git2/net.h:41
      oid : aliased Git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/net.h:42
      loid : aliased Git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/net.h:43
      name : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/net.h:44
      symref_target : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/net.h:49
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/net.h:40

  --*
  --	 * If the server send a symref mapping for this ref, this will
  --	 * point to the target.
  --	  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

end Git.Low_Level.git2_net_h;

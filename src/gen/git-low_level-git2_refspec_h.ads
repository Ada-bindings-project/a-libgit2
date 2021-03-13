pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
with Interfaces.C.Strings;
limited with Git.Low_Level.git2_types_h;
with Git.Low_Level.git2_net_h;
limited with Git.Low_Level.git2_buffer_h;

package Git.Low_Level.git2_refspec_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/refspec.h
  -- * @brief Git refspec attributes
  -- * @defgroup git_refspec Git refspec attributes
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Parse a given refspec string
  -- *
  -- * @param refspec a pointer to hold the refspec handle
  -- * @param input the refspec string
  -- * @param is_fetch is this a refspec for a fetch
  -- * @return 0 if the refspec string could be parsed, -1 otherwise
  --  

   function git_refspec_parse
     (refspec : System.Address;
      input : Interfaces.C.Strings.chars_ptr;
      is_fetch : int) return int  -- /usr/include/git2/refspec.h:32
   with Import => True, 
        Convention => C, 
        External_Name => "git_refspec_parse";

  --*
  -- * Free a refspec object which has been created by git_refspec_parse
  -- *
  -- * @param refspec the refspec object
  --  

   procedure git_refspec_free (refspec : access Git.Low_Level.git2_types_h.git_refspec)  -- /usr/include/git2/refspec.h:39
   with Import => True, 
        Convention => C, 
        External_Name => "git_refspec_free";

  --*
  -- * Get the source specifier
  -- *
  -- * @param refspec the refspec
  -- * @return the refspec's source specifier
  --  

   function git_refspec_src (refspec : access constant Git.Low_Level.git2_types_h.git_refspec) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/refspec.h:47
   with Import => True, 
        Convention => C, 
        External_Name => "git_refspec_src";

  --*
  -- * Get the destination specifier
  -- *
  -- * @param refspec the refspec
  -- * @return the refspec's destination specifier
  --  

   function git_refspec_dst (refspec : access constant Git.Low_Level.git2_types_h.git_refspec) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/refspec.h:55
   with Import => True, 
        Convention => C, 
        External_Name => "git_refspec_dst";

  --*
  -- * Get the refspec's string
  -- *
  -- * @param refspec the refspec
  -- * @returns the refspec's original string
  --  

   function git_refspec_string (refspec : access constant Git.Low_Level.git2_types_h.git_refspec) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/refspec.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "git_refspec_string";

  --*
  -- * Get the force update setting
  -- *
  -- * @param refspec the refspec
  -- * @return 1 if force update has been set, 0 otherwise
  --  

   function git_refspec_force (refspec : access constant Git.Low_Level.git2_types_h.git_refspec) return int  -- /usr/include/git2/refspec.h:71
   with Import => True, 
        Convention => C, 
        External_Name => "git_refspec_force";

  --*
  -- * Get the refspec's direction.
  -- *
  -- * @param spec refspec
  -- * @return GIT_DIRECTION_FETCH or GIT_DIRECTION_PUSH
  --  

   function git_refspec_direction (spec : access constant Git.Low_Level.git2_types_h.git_refspec) return Git.Low_Level.git2_net_h.git_direction  -- /usr/include/git2/refspec.h:79
   with Import => True, 
        Convention => C, 
        External_Name => "git_refspec_direction";

  --*
  -- * Check if a refspec's source descriptor matches a reference 
  -- *
  -- * @param refspec the refspec
  -- * @param refname the name of the reference to check
  -- * @return 1 if the refspec matches, 0 otherwise
  --  

   function git_refspec_src_matches (refspec : access constant Git.Low_Level.git2_types_h.git_refspec; refname : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/refspec.h:88
   with Import => True, 
        Convention => C, 
        External_Name => "git_refspec_src_matches";

  --*
  -- * Check if a refspec's destination descriptor matches a reference
  -- *
  -- * @param refspec the refspec
  -- * @param refname the name of the reference to check
  -- * @return 1 if the refspec matches, 0 otherwise
  --  

   function git_refspec_dst_matches (refspec : access constant Git.Low_Level.git2_types_h.git_refspec; refname : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/refspec.h:97
   with Import => True, 
        Convention => C, 
        External_Name => "git_refspec_dst_matches";

  --*
  -- * Transform a reference to its target following the refspec's rules
  -- *
  -- * @param out where to store the target name
  -- * @param spec the refspec
  -- * @param name the name of the reference to transform
  -- * @return 0, GIT_EBUFS or another error
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   function git_refspec_transform
     (c_out : access Git.Low_Level.git2_buffer_h.git_buf;
      spec : access constant Git.Low_Level.git2_types_h.git_refspec;
      name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/refspec.h:107
   with Import => True, 
        Convention => C, 
        External_Name => "git_refspec_transform";

   function git_refspec_rtransform
     (c_out : access Git.Low_Level.git2_buffer_h.git_buf;
      spec : access constant Git.Low_Level.git2_types_h.git_refspec;
      name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/refspec.h:117
   with Import => True, 
        Convention => C, 
        External_Name => "git_refspec_rtransform";

end Git.Low_Level.git2_refspec_h;

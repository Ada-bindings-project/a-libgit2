pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
limited with git.Low_Level.git2_types_h;
with Interfaces.C.Strings;


package git.Low_Level.git2_mailmap_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/mailmap.h
  --  * @brief Mailmap parsing routines
  --  * @defgroup git_mailmap Git mailmap routines
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Allocate a new mailmap object.
  --  *
  --  * This object is empty, so you'll have to add a mailmap file before you can do
  --  * anything with it. The mailmap must be freed with 'git_mailmap_free'.
  --  *
  --  * @param out pointer to store the new mailmap
  --  * @return 0 on success, or an error code
  --

   function git_mailmap_new (c_out : System.Address) return int  -- /usr/include/git2/mailmap.h:32
      with Import   => True,
      Convention    => C,
      External_Name => "git_mailmap_new";

  --*
  --  * Free the mailmap and its associated memory.
  --  *
  --  * @param mm the mailmap to free
  --

   procedure git_mailmap_free (mm : access git.Low_Level.git2_types_h.git_mailmap)  -- /usr/include/git2/mailmap.h:39
        with Import => True,
      Convention    => C,
      External_Name => "git_mailmap_free";

  --*
  --  * Add a single entry to the given mailmap object. If the entry already exists,
  --  * it will be replaced with the new entry.
  --  *
  --  * @param mm mailmap to add the entry to
  --  * @param real_name the real name to use, or NULL
  --  * @param real_email the real email to use, or NULL
  --  * @param replace_name the name to replace, or NULL
  --  * @param replace_email the email to replace
  --  * @return 0 on success, or an error code
  --

   function git_mailmap_add_entry
     (mm            : access git.Low_Level.git2_types_h.git_mailmap;
      real_name     : Interfaces.C.Strings.chars_ptr;
      real_email    : Interfaces.C.Strings.chars_ptr;
      replace_name  : Interfaces.C.Strings.chars_ptr;
      replace_email : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/mailmap.h:52
      with Import   => True,
      Convention    => C,
      External_Name => "git_mailmap_add_entry";

  --*
  --  * Create a new mailmap instance containing a single mailmap file
  --  *
  --  * @param out pointer to store the new mailmap
  --  * @param buf buffer to parse the mailmap from
  --  * @param len the length of the input buffer
  --  * @return 0 on success, or an error code
  --

   function git_mailmap_from_buffer
     (c_out : System.Address;
      buf   : Interfaces.C.Strings.chars_ptr;
      len   : unsigned_long) return int  -- /usr/include/git2/mailmap.h:64
      with Import   => True,
      Convention    => C,
      External_Name => "git_mailmap_from_buffer";

  --*
  --  * Create a new mailmap instance from a repository, loading mailmap files based
  --  * on the repository's configuration.
  --  *
  --  * Mailmaps are loaded in the following order:
  --  *  1. '.mailmap' in the root of the repository's working directory, if present.
  --  *  2. The blob object identified by the 'mailmap.blob' config entry, if set.
  --  *     [NOTE: 'mailmap.blob' defaults to 'HEAD:.mailmap' in bare repositories]
  --  *  3. The path in the 'mailmap.file' config entry, if set.
  --  *
  --  * @param out pointer to store the new mailmap
  --  * @param repo repository to load mailmap information from
  --  * @return 0 on success, or an error code
  --

   function git_mailmap_from_repository (c_out : System.Address; repo : access git.Low_Level.git2_types_h.git_repository) return int  -- /usr/include/git2/mailmap.h:81
      with Import   => True,
      Convention    => C,
      External_Name => "git_mailmap_from_repository";

  --*
  --  * Resolve a name and email to the corresponding real name and email.
  --  *
  --  * The lifetime of the strings are tied to `mm`, `name`, and `email` parameters.
  --  *
  --  * @param real_name pointer to store the real name
  --  * @param real_email pointer to store the real email
  --  * @param mm the mailmap to perform a lookup with (may be NULL)
  --  * @param name the name to look up
  --  * @param email the email to look up
  --  * @return 0 on success, or an error code
  --

   function git_mailmap_resolve
     (real_name  : System.Address;
      real_email : System.Address;
      mm         : access constant git.Low_Level.git2_types_h.git_mailmap;
      name       : Interfaces.C.Strings.chars_ptr;
      email      : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/mailmap.h:96
      with Import   => True,
      Convention    => C,
      External_Name => "git_mailmap_resolve";

  --*
  --  * Resolve a signature to use real names and emails with a mailmap.
  --  *
  --  * Call `git_signature_free()` to free the data.
  --  *
  --  * @param out new signature
  --  * @param mm mailmap to resolve with
  --  * @param sig signature to resolve
  --  * @return 0 or an error code
  --

   function git_mailmap_resolve_signature
     (c_out : System.Address;
      mm    : access constant git.Low_Level.git2_types_h.git_mailmap;
      sig   : access constant git.Low_Level.git2_types_h.git_signature) return int  -- /usr/include/git2/mailmap.h:110
      with Import   => True,
      Convention    => C,
      External_Name => "git_mailmap_resolve_signature";

  --* @}
end git.Low_Level.git2_mailmap_h;

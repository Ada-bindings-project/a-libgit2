pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
limited with git.Low_Level.git2_buffer_h;
with Interfaces.C.Strings;


package git.Low_Level.git2_message_h is

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/message.h
  --  * @brief Git message management routines
  --  * @ingroup Git
  --  * @{
  --

  --*
  --  * Clean up excess whitespace and make sure there is a trailing newline in the message.
  --  *
  --  * Optionally, it can remove lines which start with the comment character.
  --  *
  --  * @param out The user-allocated git_buf which will be filled with the
  --  *     cleaned up message.
  --  *
  --  * @param message The message to be prettified.
  --  *
  --  * @param strip_comments Non-zero to remove comment lines, 0 to leave them in.
  --  *
  --  * @param comment_char Comment character. Lines starting with this character
  --  * are considered to be comments and removed if `strip_comments` is non-zero.
  --  *
  --  * @return 0 or an error code.
  --

   function git_message_prettify
     (c_out          : access git.Low_Level.git2_buffer_h.git_buf;
      message        : Interfaces.C.Strings.chars_ptr;
      strip_comments : int;
      comment_char   : char) return int  -- /usr/include/git2/message.h:38
      with Import   => True,
      Convention    => C,
      External_Name => "git_message_prettify";

  --*
  --  * Represents a single git message trailer.
  --

   --  skipped anonymous struct anon_anon_125

   type git_message_trailer is record
      key   : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/message.h:44
      value : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/message.h:45
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/message.h:46

  --*
  --  * Represents an array of git message trailers.
  --  *
  --  * Struct members under the private comment are private, subject to change
  --  * and should not be used by callers.
  --

   --  skipped anonymous struct anon_anon_126

   type git_message_trailer_array is record
      trailers        : access git_message_trailer;  -- /usr/include/git2/message.h:55
      count           : aliased unsigned_long;  -- /usr/include/git2/message.h:56
      u_trailer_block : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/message.h:59
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/message.h:60

  -- private
  --*
  --  * Parse trailers out of a message, filling the array pointed to by +arr+.
  --  *
  --  * Trailers are key/value pairs in the last paragraph of a message, not
  --  * including any patches or conflicts that may be present.
  --  *
  --  * @param arr A pre-allocated git_message_trailer_array struct to be filled in
  --  *            with any trailers found during parsing.
  --  * @param message The message to be parsed
  --  * @return 0 on success, or non-zero on error.
  --

   function git_message_trailers (arr : access git_message_trailer_array; message : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/message.h:73
      with Import   => True,
      Convention    => C,
      External_Name => "git_message_trailers";

  --*
  --  * Clean's up any allocated memory in the git_message_trailer_array filled by
  --  * a call to git_message_trailers.
  --

   procedure git_message_trailer_array_free (arr : access git_message_trailer_array)  -- /usr/include/git2/message.h:79
     with Import    => True,
      Convention    => C,
      External_Name => "git_message_trailer_array_free";

  --* @}
end git.Low_Level.git2_message_h;

pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;


package git.Low_Level.git2_oid_h is

   GIT_OID_RAWSZ : constant := 20;  --  /usr/include/git2/oid.h:23
   --  unsupported macro: GIT_OID_HEXSZ (GIT_OID_RAWSZ * 2)

   GIT_OID_MINPREFIXLEN : constant := 4;  --  /usr/include/git2/oid.h:30

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

  --*
  -- * @file git2/oid.h
  --  * @brief Git object id routines
  --  * @defgroup git_oid Git object id routines
  --  * @ingroup Git
  --  * @{
  --

  --* Size (in bytes) of a raw/binary oid
  --* Size (in bytes) of a hex formatted oid
  --* Minimum length (in number of hex characters,
  --  * i.e. packets of 4 bits) of an oid prefix

  --* Unique identity of any object (commit, tree, blob, tag).
  --* raw binary formatted id
   type git_oid_array1716 is array (0 .. 19) of aliased unsigned_char;
   type git_oid is record
      id : aliased git_oid_array1716;  -- /usr/include/git2/oid.h:35
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/oid.h:33

  --*
  --  * Parse a hex formatted object id into a git_oid.
  --  *
  --  * @param out oid structure the result is written into.
  --  * @param str input hex string; must be pointing at the start of
  --  *          the hex sequence and have at least the number of bytes
  --  *          needed for an oid encoded in hex (40 bytes).
  --  * @return 0 or an error code
  --

   function git_oid_fromstr (c_out : access git_oid; str : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/oid.h:47
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_fromstr";

  --*
  --  * Parse a hex formatted null-terminated string into a git_oid.
  --  *
  --  * @param out oid structure the result is written into.
  --  * @param str input hex string; must be null-terminated.
  --  * @return 0 or an error code
  --

   function git_oid_fromstrp (c_out : access git_oid; str : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/oid.h:56
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_fromstrp";

  --*
  --  * Parse N characters of a hex formatted object id into a git_oid.
  --  *
  --  * If N is odd, the last byte's high nibble will be read in and the
  --  * low nibble set to zero.
  --  *
  --  * @param out oid structure the result is written into.
  --  * @param str input hex string of at least size `length`
  --  * @param length length of the input string
  --  * @return 0 or an error code
  --

   function git_oid_fromstrn
     (c_out  : access git_oid;
      str    : Interfaces.C.Strings.chars_ptr;
      length : unsigned_long) return int  -- /usr/include/git2/oid.h:69
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_fromstrn";

  --*
  --  * Copy an already raw oid into a git_oid structure.
  --  *
  --  * @param out oid structure the result is written into.
  --  * @param raw the raw input bytes to be copied.
  --  * @return 0 on success or error code
  --

   function git_oid_fromraw (c_out : access git_oid; raw : access unsigned_char) return int  -- /usr/include/git2/oid.h:78
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_fromraw";

  --*
  --  * Format a git_oid into a hex string.
  --  *
  --  * @param out output hex string; must be pointing at the start of
  --  *          the hex sequence and have at least the number of bytes
  --  *          needed for an oid encoded in hex (40 bytes). Only the
  --  *          oid digits are written; a '\\0' terminator must be added
  --  *          by the caller if it is required.
  --  * @param id oid structure to format.
  --  * @return 0 on success or error code
  --

   function git_oid_fmt (c_out : Interfaces.C.Strings.chars_ptr; id : access constant git_oid) return int  -- /usr/include/git2/oid.h:91
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_fmt";

  --*
  --  * Format a git_oid into a partial hex string.
  --  *
  --  * @param out output hex string; you say how many bytes to write.
  --  *          If the number of bytes is > GIT_OID_HEXSZ, extra bytes
  --  *          will be zeroed; if not, a '\0' terminator is NOT added.
  --  * @param n number of characters to write into out string
  --  * @param id oid structure to format.
  --  * @return 0 on success or error code
  --

   function git_oid_nfmt
     (c_out : Interfaces.C.Strings.chars_ptr;
      n     : unsigned_long;
      id    : access constant git_oid) return int  -- /usr/include/git2/oid.h:103
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_nfmt";

  --*
  --  * Format a git_oid into a loose-object path string.
  --  *
  --  * The resulting string is "aa/...", where "aa" is the first two
  --  * hex digits of the oid and "..." is the remaining 38 digits.
  --  *
  --  * @param out output hex string; must be pointing at the start of
  --  *          the hex sequence and have at least the number of bytes
  --  *          needed for an oid encoded in hex (41 bytes). Only the
  --  *          oid digits are written; a '\\0' terminator must be added
  --  *          by the caller if it is required.
  --  * @param id oid structure to format.
  --  * @return 0 on success, non-zero callback return value, or error code
  --

   function git_oid_pathfmt (c_out : Interfaces.C.Strings.chars_ptr; id : access constant git_oid) return int  -- /usr/include/git2/oid.h:119
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_pathfmt";

  --*
  --  * Format a git_oid into a statically allocated c-string.
  --  *
  --  * The c-string is owned by the library and should not be freed
  --  * by the user. If libgit2 is built with thread support, the string
  --  * will be stored in TLS (i.e. one buffer per thread) to allow for
  --  * concurrent calls of the function.
  --  *
  --  * @param oid The oid structure to format
  --  * @return the c-string
  --

   function git_oid_tostr_s (oid : access constant git_oid) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/oid.h:132
     with Import    => True,
      Convention    => C,
      External_Name => "git_oid_tostr_s";

  --*
  --  * Format a git_oid into a buffer as a hex format c-string.
  --  *
  --  * If the buffer is smaller than GIT_OID_HEXSZ+1, then the resulting
  --  * oid c-string will be truncated to n-1 characters (but will still be
  --  * NUL-byte terminated).
  --  *
  --  * If there are any input parameter errors (out == NULL, n == 0, oid ==
  --  * NULL), then a pointer to an empty string is returned, so that the
  --  * return value can always be printed.
  --  *
  --  * @param out the buffer into which the oid string is output.
  --  * @param n the size of the out buffer.
  --  * @param id the oid structure to format.
  --  * @return the out buffer pointer, assuming no input parameter
  --  *                  errors, otherwise a pointer to an empty string.
  --

   function git_oid_tostr
     (c_out : Interfaces.C.Strings.chars_ptr;
      n     : unsigned_long;
      id    : access constant git_oid) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/oid.h:151
     with Import    => True,
      Convention    => C,
      External_Name => "git_oid_tostr";

  --*
  --  * Copy an oid from one structure to another.
  --  *
  --  * @param out oid structure the result is written into.
  --  * @param src oid structure to copy from.
  --  * @return 0 on success or error code
  --

   function git_oid_cpy (c_out : access git_oid; src : access constant git_oid) return int  -- /usr/include/git2/oid.h:160
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_cpy";

  --*
  --  * Compare two oid structures.
  --  *
  --  * @param a first oid structure.
  --  * @param b second oid structure.
  --  * @return <0, 0, >0 if a < b, a == b, a > b.
  --

   function git_oid_cmp (a : access constant git_oid; b : access constant git_oid) return int  -- /usr/include/git2/oid.h:169
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_cmp";

  --*
  --  * Compare two oid structures for equality
  --  *
  --  * @param a first oid structure.
  --  * @param b second oid structure.
  --  * @return true if equal, false otherwise
  --

   function git_oid_equal (a : access constant git_oid; b : access constant git_oid) return int  -- /usr/include/git2/oid.h:178
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_equal";

  --*
  --  * Compare the first 'len' hexadecimal characters (packets of 4 bits)
  --  * of two oid structures.
  --  *
  --  * @param a first oid structure.
  --  * @param b second oid structure.
  --  * @param len the number of hex chars to compare
  --  * @return 0 in case of a match
  --

   function git_oid_ncmp
     (a   : access constant git_oid;
      b   : access constant git_oid;
      len : unsigned_long) return int  -- /usr/include/git2/oid.h:189
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_ncmp";

  --*
  --  * Check if an oid equals an hex formatted object id.
  --  *
  --  * @param id oid structure.
  --  * @param str input hex string of an object id.
  --  * @return 0 in case of a match, -1 otherwise.
  --

   function git_oid_streq (id : access constant git_oid; str : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/oid.h:198
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_streq";

  --*
  --  * Compare an oid to an hex formatted object id.
  --  *
  --  * @param id oid structure.
  --  * @param str input hex string of an object id.
  --  * @return -1 if str is not valid, <0 if id sorts before str,
  --  *         0 if id matches str, >0 if id sorts after str.
  --

   function git_oid_strcmp (id : access constant git_oid; str : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/oid.h:208
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_strcmp";

  --*
  --  * Check is an oid is all zeros.
  --  *
  --  * @return 1 if all zeros, 0 otherwise.
  --

   function git_oid_is_zero (id : access constant git_oid) return int  -- /usr/include/git2/oid.h:215
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_is_zero";

  --*
  -- * OID Shortener object
  --

   type git_oid_shorten is null record;   -- incomplete struct

  --*
  --  * Create a new OID shortener.
  --  *
  --  * The OID shortener is used to process a list of OIDs
  --  * in text form and return the shortest length that would
  --  * uniquely identify all of them.
  --  *
  --  * E.g. look at the result of `git log --abbrev`.
  --  *
  --  * @param min_length The minimal length for all identifiers,
  --  *          which will be used even if shorter OIDs would still
  --  *          be unique.
  --  *  @return a `git_oid_shorten` instance, NULL if OOM
  --

   function git_oid_shorten_new (min_length : unsigned_long) return access git_oid_shorten  -- /usr/include/git2/oid.h:236
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_shorten_new";

  --*
  --  * Add a new OID to set of shortened OIDs and calculate
  --  * the minimal length to uniquely identify all the OIDs in
  --  * the set.
  --  *
  --  * The OID is expected to be a 40-char hexadecimal string.
  --  * The OID is owned by the user and will not be modified
  --  * or freed.
  --  *
  --  * For performance reasons, there is a hard-limit of how many
  --  * OIDs can be added to a single set (around ~32000, assuming
  --  * a mostly randomized distribution), which should be enough
  --  * for any kind of program, and keeps the algorithm fast and
  --  * memory-efficient.
  --  *
  --  * Attempting to add more than those OIDs will result in a
  --  * GIT_ERROR_INVALID error
  --  *
  --  * @param os a `git_oid_shorten` instance
  --  * @param text_id an OID in text form
  --  * @return the minimal length to uniquely identify all OIDs
  --  *          added so far to the set; or an error code (<0) if an
  --  *          error occurs.
  --

   function git_oid_shorten_add (os : access git_oid_shorten; text_id : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/oid.h:262
      with Import   => True,
      Convention    => C,
      External_Name => "git_oid_shorten_add";

  --*
  --  * Free an OID shortener instance
  --  *
  --  * @param os a `git_oid_shorten` instance
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

   procedure git_oid_shorten_free (os : access git_oid_shorten)  -- /usr/include/git2/oid.h:269
     with Import    => True,
      Convention    => C,
      External_Name => "git_oid_shorten_free";

  --* @}
end git.Low_Level.git2_oid_h;

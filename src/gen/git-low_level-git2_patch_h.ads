pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
with Git.Low_Level.git2_diff_h;

limited with Git.Low_Level.git2_types_h;
with Interfaces.C.Strings;
limited with Git.Low_Level.git2_buffer_h;

package Git.Low_Level.git2_patch_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/patch.h
  -- * @brief Patch handling routines.
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * The diff patch is used to store all the text diffs for a delta.
  -- *
  -- * You can easily loop over the content of patches and get information about
  -- * them.
  --  

   type git_patch is null record;   -- incomplete struct

  --*
  -- * Return a patch for an entry in the diff list.
  -- *
  -- * The `git_patch` is a newly created object contains the text diffs
  -- * for the delta.  You have to call `git_patch_free()` when you are
  -- * done with it.  You can use the patch object to loop over all the hunks
  -- * and lines in the diff of the one delta.
  -- *
  -- * For an unchanged file or a binary file, no `git_patch` will be
  -- * created, the output will be set to NULL, and the `binary` flag will be
  -- * set true in the `git_diff_delta` structure.
  -- *
  -- * It is okay to pass NULL for either of the output parameters; if you pass
  -- * NULL for the `git_patch`, then the text diff will not be calculated.
  -- *
  -- * @param out Output parameter for the delta patch object
  -- * @param diff Diff list object
  -- * @param idx Index into diff list
  -- * @return 0 on success, other value < 0 on error
  --  

   function git_patch_from_diff
     (c_out : System.Address;
      diff : access Git.Low_Level.git2_diff_h.git_diff;
      idx : unsigned_long) return int  -- /usr/include/git2/patch.h:51
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_from_diff";

  --*
  -- * Directly generate a patch from the difference between two blobs.
  -- *
  -- * This is just like `git_diff_blobs()` except it generates a patch object
  -- * for the difference instead of directly making callbacks.  You can use the
  -- * standard `git_patch` accessor functions to read the patch data, and
  -- * you must call `git_patch_free()` on the patch when done.
  -- *
  -- * @param out The generated patch; NULL on error
  -- * @param old_blob Blob for old side of diff, or NULL for empty blob
  -- * @param old_as_path Treat old blob as if it had this filename; can be NULL
  -- * @param new_blob Blob for new side of diff, or NULL for empty blob
  -- * @param new_as_path Treat new blob as if it had this filename; can be NULL
  -- * @param opts Options for diff, or NULL for default options
  -- * @return 0 on success or error code < 0
  --  

   function git_patch_from_blobs
     (c_out : System.Address;
      old_blob : access constant Git.Low_Level.git2_types_h.git_blob;
      old_as_path : Interfaces.C.Strings.chars_ptr;
      new_blob : access constant Git.Low_Level.git2_types_h.git_blob;
      new_as_path : Interfaces.C.Strings.chars_ptr;
      opts : access constant Git.Low_Level.git2_diff_h.git_diff_options) return int  -- /usr/include/git2/patch.h:70
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_from_blobs";

  --*
  -- * Directly generate a patch from the difference between a blob and a buffer.
  -- *
  -- * This is just like `git_diff_blob_to_buffer()` except it generates a patch
  -- * object for the difference instead of directly making callbacks.  You can
  -- * use the standard `git_patch` accessor functions to read the patch
  -- * data, and you must call `git_patch_free()` on the patch when done.
  -- *
  -- * @param out The generated patch; NULL on error
  -- * @param old_blob Blob for old side of diff, or NULL for empty blob
  -- * @param old_as_path Treat old blob as if it had this filename; can be NULL
  -- * @param buffer Raw data for new side of diff, or NULL for empty
  -- * @param buffer_len Length of raw data for new side of diff
  -- * @param buffer_as_path Treat buffer as if it had this filename; can be NULL
  -- * @param opts Options for diff, or NULL for default options
  -- * @return 0 on success or error code < 0
  --  

   function git_patch_from_blob_and_buffer
     (c_out : System.Address;
      old_blob : access constant Git.Low_Level.git2_types_h.git_blob;
      old_as_path : Interfaces.C.Strings.chars_ptr;
      buffer : System.Address;
      buffer_len : unsigned_long;
      buffer_as_path : Interfaces.C.Strings.chars_ptr;
      opts : access constant Git.Low_Level.git2_diff_h.git_diff_options) return int  -- /usr/include/git2/patch.h:95
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_from_blob_and_buffer";

  --*
  -- * Directly generate a patch from the difference between two buffers.
  -- *
  -- * This is just like `git_diff_buffers()` except it generates a patch
  -- * object for the difference instead of directly making callbacks.  You can
  -- * use the standard `git_patch` accessor functions to read the patch
  -- * data, and you must call `git_patch_free()` on the patch when done.
  -- *
  -- * @param out The generated patch; NULL on error
  -- * @param old_buffer Raw data for old side of diff, or NULL for empty
  -- * @param old_len Length of the raw data for old side of the diff
  -- * @param old_as_path Treat old buffer as if it had this filename; can be NULL
  -- * @param new_buffer Raw data for new side of diff, or NULL for empty
  -- * @param new_len Length of raw data for new side of diff
  -- * @param new_as_path Treat buffer as if it had this filename; can be NULL
  -- * @param opts Options for diff, or NULL for default options
  -- * @return 0 on success or error code < 0
  --  

   function git_patch_from_buffers
     (c_out : System.Address;
      old_buffer : System.Address;
      old_len : unsigned_long;
      old_as_path : Interfaces.C.Strings.chars_ptr;
      new_buffer : System.Address;
      new_len : unsigned_long;
      new_as_path : Interfaces.C.Strings.chars_ptr;
      opts : access constant Git.Low_Level.git2_diff_h.git_diff_options) return int  -- /usr/include/git2/patch.h:122
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_from_buffers";

  --*
  -- * Free a git_patch object.
  --  

   procedure git_patch_free (patch : access git_patch)  -- /usr/include/git2/patch.h:135
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_free";

  --*
  -- * Get the delta associated with a patch.  This delta points to internal
  -- * data and you do not have to release it when you are done with it.
  --  

   function git_patch_get_delta (patch : access constant git_patch) return access constant Git.Low_Level.git2_diff_h.git_diff_delta  -- /usr/include/git2/patch.h:141
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_get_delta";

  --*
  -- * Get the number of hunks in a patch
  --  

   function git_patch_num_hunks (patch : access constant git_patch) return unsigned_long  -- /usr/include/git2/patch.h:146
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_num_hunks";

  --*
  -- * Get line counts of each type in a patch.
  -- *
  -- * This helps imitate a diff --numstat type of output.  For that purpose,
  -- * you only need the `total_additions` and `total_deletions` values, but we
  -- * include the `total_context` line count in case you want the total number
  -- * of lines of diff output that will be generated.
  -- *
  -- * All outputs are optional. Pass NULL if you don't need a particular count.
  -- *
  -- * @param total_context Count of context lines in output, can be NULL.
  -- * @param total_additions Count of addition lines in output, can be NULL.
  -- * @param total_deletions Count of deletion lines in output, can be NULL.
  -- * @param patch The git_patch object
  -- * @return 0 on success, <0 on error
  --  

   function git_patch_line_stats
     (total_context : access unsigned_long;
      total_additions : access unsigned_long;
      total_deletions : access unsigned_long;
      patch : access constant git_patch) return int  -- /usr/include/git2/patch.h:164
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_line_stats";

  --*
  -- * Get the information about a hunk in a patch
  -- *
  -- * Given a patch and a hunk index into the patch, this returns detailed
  -- * information about that hunk.  Any of the output pointers can be passed
  -- * as NULL if you don't care about that particular piece of information.
  -- *
  -- * @param out Output pointer to git_diff_hunk of hunk
  -- * @param lines_in_hunk Output count of total lines in this hunk
  -- * @param patch Input pointer to patch object
  -- * @param hunk_idx Input index of hunk to get information about
  -- * @return 0 on success, GIT_ENOTFOUND if hunk_idx out of range, <0 on error
  --  

   function git_patch_get_hunk
     (c_out : System.Address;
      lines_in_hunk : access unsigned_long;
      patch : access git_patch;
      hunk_idx : unsigned_long) return int  -- /usr/include/git2/patch.h:183
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_get_hunk";

  --*
  -- * Get the number of lines in a hunk.
  -- *
  -- * @param patch The git_patch object
  -- * @param hunk_idx Index of the hunk
  -- * @return Number of lines in hunk or GIT_ENOTFOUND if invalid hunk index
  --  

   function git_patch_num_lines_in_hunk (patch : access constant git_patch; hunk_idx : unsigned_long) return int  -- /usr/include/git2/patch.h:196
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_num_lines_in_hunk";

  --*
  -- * Get data about a line in a hunk of a patch.
  -- *
  -- * Given a patch, a hunk index, and a line index in the hunk, this
  -- * will return a lot of details about that line.  If you pass a hunk
  -- * index larger than the number of hunks or a line index larger than
  -- * the number of lines in the hunk, this will return -1.
  -- *
  -- * @param out The git_diff_line data for this line
  -- * @param patch The patch to look in
  -- * @param hunk_idx The index of the hunk
  -- * @param line_of_hunk The index of the line in the hunk
  -- * @return 0 on success, <0 on failure
  --  

   function git_patch_get_line_in_hunk
     (c_out : System.Address;
      patch : access git_patch;
      hunk_idx : unsigned_long;
      line_of_hunk : unsigned_long) return int  -- /usr/include/git2/patch.h:214
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_get_line_in_hunk";

  --*
  -- * Look up size of patch diff data in bytes
  -- *
  -- * This returns the raw size of the patch data.  This only includes the
  -- * actual data from the lines of the diff, not the file or hunk headers.
  -- *
  -- * If you pass `include_context` as true (non-zero), this will be the size
  -- * of all of the diff output; if you pass it as false (zero), this will
  -- * only include the actual changed lines (as if `context_lines` was 0).
  -- *
  -- * @param patch A git_patch representing changes to one file
  -- * @param include_context Include context lines in size if non-zero
  -- * @param include_hunk_headers Include hunk header lines if non-zero
  -- * @param include_file_headers Include file header lines if non-zero
  -- * @return The number of bytes of data
  --  

   function git_patch_size
     (patch : access git_patch;
      include_context : int;
      include_hunk_headers : int;
      include_file_headers : int) return unsigned_long  -- /usr/include/git2/patch.h:236
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_size";

  --*
  -- * Serialize the patch to text via callback.
  -- *
  -- * Returning a non-zero value from the callback will terminate the iteration
  -- * and return that value to the caller.
  -- *
  -- * @param patch A git_patch representing changes to one file
  -- * @param print_cb Callback function to output lines of the patch.  Will be
  -- *                 called for file headers, hunk headers, and diff lines.
  -- * @param payload Reference pointer that will be passed to your callbacks.
  -- * @return 0 on success, non-zero callback return value, or error code
  --  

   function git_patch_print
     (patch : access git_patch;
      print_cb : Git.Low_Level.git2_diff_h.git_diff_line_cb;
      payload : System.Address) return int  -- /usr/include/git2/patch.h:254
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_print";

  --*
  -- * Get the content of a patch as a single diff text.
  -- *
  -- * @param out The git_buf to be filled in
  -- * @param patch A git_patch representing changes to one file
  -- * @return 0 on success, <0 on failure.
  --  

   function git_patch_to_buf (c_out : access Git.Low_Level.git2_buffer_h.git_buf; patch : access git_patch) return int  -- /usr/include/git2/patch.h:266
   with Import => True, 
        Convention => C, 
        External_Name => "git_patch_to_buf";

  --*@} 
end Git.Low_Level.git2_patch_h;

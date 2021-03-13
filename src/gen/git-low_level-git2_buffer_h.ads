pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

with System;

package Git.Low_Level.git2_buffer_h is

   --  arg-macro: procedure GIT_BUF_INIT_CONST (STR, LEN)
   --    { (char *)(STR), 0, (size_t)(LEN) }
  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/buffer.h
  -- * @brief Buffer export structure
  -- *
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * A data buffer for exporting data from libgit2
  -- *
  -- * Sometimes libgit2 wants to return an allocated data buffer to the
  -- * caller and have the caller take responsibility for freeing that memory.
  -- * This can be awkward if the caller does not have easy access to the same
  -- * allocation functions that libgit2 is using.  In those cases, libgit2
  -- * will fill in a `git_buf` and the caller can use `git_buf_dispose()` to
  -- * release it when they are done.
  -- *
  -- * A `git_buf` may also be used for the caller to pass in a reference to
  -- * a block of memory they hold.  In this case, libgit2 will not resize or
  -- * free the memory, but will read from it as needed.
  -- *
  -- * Some APIs may occasionally do something slightly unusual with a buffer,
  -- * such as setting `ptr` to a value that was passed in by the user.  In
  -- * those cases, the behavior will be clearly documented by the API.
  --  

  --*
  --	 * The buffer contents.
  --	 *
  --	 * `ptr` points to the start of the allocated memory.  If it is NULL,
  --	 * then the `git_buf` is considered empty and libgit2 will feel free
  --	 * to overwrite it with new data.
  --	  

   --  skipped anonymous struct anon_anon_22

   type git_buf is record
      ptr : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/buffer.h:47
      asize : aliased unsigned_long;  -- /usr/include/git2/buffer.h:55
      size : aliased unsigned_long;  -- /usr/include/git2/buffer.h:60
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/buffer.h:61

  --*
  --	 * `asize` holds the known total amount of allocated memory if the `ptr`
  --	 *  was allocated by libgit2.  It may be larger than `size`.  If `ptr`
  --	 *  was not allocated by libgit2 and should not be resized and/or freed,
  --	 *  then `asize` will be set to zero.
  --	  

  --*
  --	 * `size` holds the size (in bytes) of the data that is actually used.
  --	  

  --*
  -- * Static initializer for git_buf from static buffer
  --  

  --*
  -- * Free the memory referred to by the git_buf.
  -- *
  -- * Note that this does not free the `git_buf` itself, just the memory
  -- * pointed to by `buffer->ptr`.  This will not free the memory if it looks
  -- * like it was not allocated internally, but it will clear the buffer back
  -- * to the empty state.
  -- *
  -- * @param buffer The buffer to deallocate
  --  

   procedure git_buf_dispose (buffer : access git_buf)  -- /usr/include/git2/buffer.h:78
   with Import => True, 
        Convention => C, 
        External_Name => "git_buf_dispose";

  --*
  -- * Resize the buffer allocation to make more space.
  -- *
  -- * This will attempt to grow the buffer to accommodate the target size.
  -- *
  -- * If the buffer refers to memory that was not allocated by libgit2 (i.e.
  -- * the `asize` field is zero), then `ptr` will be replaced with a newly
  -- * allocated block of data.  Be careful so that memory allocated by the
  -- * caller is not lost.  As a special variant, if you pass `target_size` as
  -- * 0 and the memory is not allocated by libgit2, this will allocate a new
  -- * buffer of size `size` and copy the external data into it.
  -- *
  -- * Currently, this will never shrink a buffer, only expand it.
  -- *
  -- * If the allocation fails, this will return an error and the buffer will be
  -- * marked as invalid for future operations, invaliding the contents.
  -- *
  -- * @param buffer The buffer to be resized; may or may not be allocated yet
  -- * @param target_size The desired available size
  -- * @return 0 on success, -1 on allocation failure
  --  

   function git_buf_grow (buffer : access git_buf; target_size : unsigned_long) return int  -- /usr/include/git2/buffer.h:101
   with Import => True, 
        Convention => C, 
        External_Name => "git_buf_grow";

  --*
  -- * Set buffer to a copy of some raw data.
  -- *
  -- * @param buffer The buffer to set
  -- * @param data The data to copy into the buffer
  -- * @param datalen The length of the data to copy into the buffer
  -- * @return 0 on success, -1 on allocation failure
  --  

   function git_buf_set
     (buffer : access git_buf;
      data : System.Address;
      datalen : unsigned_long) return int  -- /usr/include/git2/buffer.h:111
   with Import => True, 
        Convention => C, 
        External_Name => "git_buf_set";

  --*
  --* Check quickly if buffer looks like it contains binary data
  --*
  --* @param buf Buffer to check
  --* @return 1 if buffer looks like non-text data
  -- 

   function git_buf_is_binary (buf : access constant git_buf) return int  -- /usr/include/git2/buffer.h:120
   with Import => True, 
        Convention => C, 
        External_Name => "git_buf_is_binary";

  --*
  --* Check quickly if buffer contains a NUL byte
  --*
  --* @param buf Buffer to check
  --* @return 1 if buffer contains a NUL byte
  -- 

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   function git_buf_contains_nul (buf : access constant git_buf) return int  -- /usr/include/git2/buffer.h:128
   with Import => True, 
        Convention => C, 
        External_Name => "git_buf_contains_nul";

  --* @}  
end Git.Low_Level.git2_buffer_h;

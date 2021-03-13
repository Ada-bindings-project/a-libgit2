pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package Git.Low_Level.git2_trace_h is

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/trace.h
  -- * @brief Git tracing configuration routines
  -- * @defgroup git_trace Git tracing configuration routines
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Available tracing levels.  When tracing is set to a particular level,
  -- * callers will be provided tracing at the given level and all lower levels.
  --  

  --* No tracing will be performed.  
  --* Severe errors that may impact the program's execution  
  --* Errors that do not impact the program's execution  
  --* Warnings that suggest abnormal data  
  --* Informational messages about program execution  
  --* Detailed data that allows for debugging  
  --* Exceptionally detailed debugging data  
   type git_trace_level_t is 
     (GIT_TRACE_NONE,
      GIT_TRACE_FATAL,
      GIT_TRACE_ERROR,
      GIT_TRACE_WARN,
      GIT_TRACE_INFO,
      GIT_TRACE_DEBUG,
      GIT_TRACE_TRACE)
   with Convention => C;  -- /usr/include/git2/trace.h:47

  --*
  -- * An instance for a tracing function
  --  

   type git_trace_cb is access procedure (arg1 : git_trace_level_t; arg2 : Interfaces.C.Strings.chars_ptr)
   with Convention => C;  -- /usr/include/git2/trace.h:52

  --*
  -- * Sets the system tracing configuration to the specified level with the
  -- * specified callback.  When system events occur at a level equal to, or
  -- * lower than, the given level they will be reported to the given callback.
  -- *
  -- * @param level Level to set tracing to
  -- * @param cb Function to call with trace data
  -- * @return 0 or an error code
  --  

   function git_trace_set (level : git_trace_level_t; cb : git_trace_cb) return int  -- /usr/include/git2/trace.h:63
   with Import => True, 
        Convention => C, 
        External_Name => "git_trace_set";

  --* @}  
end Git.Low_Level.git2_trace_h;

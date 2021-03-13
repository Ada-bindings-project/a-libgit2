pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with System;
limited with git.Low_Level.git2_types_h;
limited with git.Low_Level.git2_buffer_h;

package git.Low_Level.git2_describe_h is

   GIT_DESCRIBE_DEFAULT_MAX_CANDIDATES_TAGS : constant := 10;  --  /usr/include/git2/describe.h:63
   GIT_DESCRIBE_DEFAULT_ABBREVIATED_SIZE    : constant := 7;  --  /usr/include/git2/describe.h:64

   GIT_DESCRIBE_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/describe.h:66
   --  unsupported macro: GIT_DESCRIBE_OPTIONS_INIT { GIT_DESCRIBE_OPTIONS_VERSION, GIT_DESCRIBE_DEFAULT_MAX_CANDIDATES_TAGS, }

   GIT_DESCRIBE_FORMAT_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/describe.h:113
   --  unsupported macro: GIT_DESCRIBE_FORMAT_OPTIONS_INIT { GIT_DESCRIBE_FORMAT_OPTIONS_VERSION, GIT_DESCRIBE_DEFAULT_ABBREVIATED_SIZE, }

   --  * Copyright (C) the libgit2 contributors. All rights reserved.
   --  *
   --  * This file is part of libgit2, distributed under the GNU GPL v2 with
   --  * a Linking Exception. For full terms see the included COPYING file.
  --

   --*
  -- * @file git2/describe.h
  --  * @brief Git describing routines
  --  * @defgroup git_describe Git describing routines
  --  * @ingroup Git
  --  * @{
  --

   --*
  --  * Reference lookup strategy
  --  *
  --  * These behave like the --tags and --all options to git-describe,
  --  * namely they say to look for any reference in either refs/tags/ or
  --  * refs/ respectively.
  --

   type git_describe_strategy_t is
     (GIT_DESCRIBE_DEFAULT,
      GIT_DESCRIBE_TAGS,
      GIT_DESCRIBE_ALL)
      with Convention => C;  -- /usr/include/git2/describe.h:34

  --*
  --  * Describe options structure
  --  *
  --  * Initialize with `GIT_DESCRIBE_OPTIONS_INIT`. Alternatively, you can
  --  * use `git_describe_options_init`.
  --  *
  --

   type git_describe_options is record
      version                     : aliased unsigned;  -- /usr/include/git2/describe.h:44
      max_candidates_tags         : aliased unsigned;  -- /usr/include/git2/describe.h:46
      describe_strategy           : aliased unsigned;  -- /usr/include/git2/describe.h:47
      pattern                     : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/describe.h:48
      only_follow_first_parent    : aliased int;  -- /usr/include/git2/describe.h:53
      show_commit_oid_as_fallback : aliased int;  -- /usr/include/git2/describe.h:60
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/describe.h:43

  --*< default: 10
  --*< default: GIT_DESCRIBE_DEFAULT
  --*
  --     * When calculating the distance from the matching tag or
  --     * reference, only walk down the first-parent ancestry.
  --

  --*
  --     * If no matching tag or reference is found, the describe
  --     * operation would normally fail. If this option is set, it
  --     * will instead fall back to showing the full id of the
  --     * commit.
  --

  --*
  --  * Initialize git_describe_options structure
  --  *
  --  * Initializes a `git_describe_options` with default values. Equivalent to creating
  --  * an instance with GIT_DESCRIBE_OPTIONS_INIT.
  --  *
  --  * @param opts The `git_describe_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_DESCRIBE_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_describe_options_init (opts : access git_describe_options; version : unsigned) return int  -- /usr/include/git2/describe.h:82
      with Import   => True,
      Convention    => C,
      External_Name => "git_describe_options_init";

  --*
  --  * Describe format options structure
  --  *
  --  * Initialize with `GIT_DESCRIBE_FORMAT_OPTIONS_INIT`. Alternatively, you can
  --  * use `git_describe_format_options_init`.
  --  *
  --

   --  skipped anonymous struct anon_anon_104

   type git_describe_format_options is record
      version                : aliased unsigned;  -- /usr/include/git2/describe.h:92
      abbreviated_size       : aliased unsigned;  -- /usr/include/git2/describe.h:99
      always_use_long_format : aliased int;  -- /usr/include/git2/describe.h:104
      dirty_suffix           : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/describe.h:110
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/describe.h:111

  --*
  --     * Size of the abbreviated commit id to use. This value is the
  --     * lower bound for the length of the abbreviated string. The
  --     * default is 7.
  --

  --*
  --     * Set to use the long format even when a shorter name could be used.
  --

  --*
  --     * If the workdir is dirty and this is set, this string will
  --     * be appended to the description string.
  --

  --*
  --  * Initialize git_describe_format_options structure
  --  *
  --  * Initializes a `git_describe_format_options` with default values. Equivalent to creating
  --  * an instance with GIT_DESCRIBE_FORMAT_OPTIONS_INIT.
  --  *
  --  * @param opts The `git_describe_format_options` struct to initialize.
  --  * @param version The struct version; pass `GIT_DESCRIBE_FORMAT_OPTIONS_VERSION`.
  --  * @return Zero on success; -1 on failure.
  --

   function git_describe_format_options_init (opts : access git_describe_format_options; version : unsigned) return int  -- /usr/include/git2/describe.h:129
      with Import   => True,
      Convention    => C,
      External_Name => "git_describe_format_options_init";

  --*
  --  * A struct that stores the result of a describe operation.
  --

   type git_describe_result is null record;   -- incomplete struct

  --*
  -- * Describe a commit
  -- *
  --  * Perform the describe operation on the given committish object.
  --  *
  --  * @param result pointer to store the result. You must free this once
  --  * you're done with it.
  --  * @param committish a committish to describe
  --  * @param opts the lookup options (or NULL for defaults)
  --

   function git_describe_commit
     (result     : System.Address;
      committish : access git.Low_Level.git2_types_h.git_object;
      opts       : access git_describe_options) return int  -- /usr/include/git2/describe.h:146
      with Import   => True,
      Convention    => C,
      External_Name => "git_describe_commit";

  --*
  -- * Describe a commit
  -- *
  --  * Perform the describe operation on the current commit and the
  --  * worktree. After peforming describe on HEAD, a status is run and the
  --  * description is considered to be dirty if there are.
  --  *
  --  * @param out pointer to store the result. You must free this once
  --  * you're done with it.
  --  * @param repo the repository in which to perform the describe
  --  * @param opts the lookup options (or NULL for defaults)
  --

   function git_describe_workdir
     (c_out : System.Address;
      repo  : access git.Low_Level.git2_types_h.git_repository;
      opts  : access git_describe_options) return int  -- /usr/include/git2/describe.h:163
      with Import   => True,
      Convention    => C,
      External_Name => "git_describe_workdir";

  --*
  --  * Print the describe result to a buffer
  --  *
  --  * @param out The buffer to store the result
  --  * @param result the result from `git_describe_commit()` or
  --  * `git_describe_workdir()`.
  --  * @param opts the formatting options (or NULL for defaults)
  --

   function git_describe_format
     (c_out  : access git.Low_Level.git2_buffer_h.git_buf;
      result : access constant git_describe_result;
      opts   : access constant git_describe_format_options) return int  -- /usr/include/git2/describe.h:176
      with Import   => True,
      Convention    => C,
      External_Name => "git_describe_format";

  --*
  --  * Free the describe result.
  --

  --  * Copyright (C) the libgit2 contributors. All rights reserved.
  --  *
  --  * This file is part of libgit2, distributed under the GNU GPL v2 with
  --  * a Linking Exception. For full terms see the included COPYING file.
  --

   procedure git_describe_result_free (result : access git_describe_result)  -- /usr/include/git2/describe.h:184
     with Import    => True,
      Convention    => C,
      External_Name => "git_describe_result_free";

end git.Low_Level.git2_describe_h;

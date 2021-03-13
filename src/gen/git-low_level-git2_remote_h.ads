pragma Ada_2012;
pragma Style_Checks (Off);
pragma Warnings ("U");

with Interfaces.C; use Interfaces.C;
with System;
with Git.Low_Level.git2_types_h;
with Interfaces.C.Strings;
with Git.Low_Level.git2_strarray_h;

with Git.Low_Level.git2_net_h;
with Git.Low_Level.git2_proxy_h;
with Git.Low_Level.git2_oid_h;
limited with Git.Low_Level.git2_buffer_h;
with Git.Low_Level.git2_transport_h;
with Git.Low_Level.git2_credential_h;
with Git.Low_Level.git2_cert_h;
with Git.Low_Level.git2_indexer_h;
with Git.Low_Level.git2_pack_h;

package Git.Low_Level.git2_remote_h is

   GIT_REMOTE_CREATE_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/remote.h:84
   --  unsupported macro: GIT_REMOTE_CREATE_OPTIONS_INIT {GIT_REMOTE_CREATE_OPTIONS_VERSION}

   GIT_REMOTE_CALLBACKS_VERSION : constant := 1;  --  /usr/include/git2/remote.h:590
   --  unsupported macro: GIT_REMOTE_CALLBACKS_INIT {GIT_REMOTE_CALLBACKS_VERSION}

   GIT_FETCH_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/remote.h:693
   --  unsupported macro: GIT_FETCH_OPTIONS_INIT { GIT_FETCH_OPTIONS_VERSION, GIT_REMOTE_CALLBACKS_INIT, GIT_FETCH_PRUNE_UNSPECIFIED, 1, GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED, GIT_PROXY_OPTIONS_INIT }

   GIT_PUSH_OPTIONS_VERSION : constant := 1;  --  /usr/include/git2/remote.h:744
   --  unsupported macro: GIT_PUSH_OPTIONS_INIT { GIT_PUSH_OPTIONS_VERSION, 1, GIT_REMOTE_CALLBACKS_INIT, GIT_PROXY_OPTIONS_INIT }

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

  --*
  -- * @file git2/remote.h
  -- * @brief Git remote management functions
  -- * @defgroup git_remote remote management functions
  -- * @ingroup Git
  -- * @{
  --  

  --*
  -- * Add a remote with the default fetch refspec to the repository's configuration.
  -- *
  -- * @param out the resulting remote
  -- * @param repo the repository in which to create the remote
  -- * @param name the remote's name
  -- * @param url the remote's url
  -- * @return 0, GIT_EINVALIDSPEC, GIT_EEXISTS or an error code
  --  

   function git_remote_create
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr;
      url : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:38
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_create";

  --*
  -- * Remote creation options flags
  --  

  --* Ignore the repository apply.insteadOf configuration  
  --* Don't build a fetchspec from the name if none is set  
   subtype git_remote_create_flags is unsigned;
   GIT_REMOTE_CREATE_SKIP_INSTEADOF : constant unsigned := 1;
   GIT_REMOTE_CREATE_SKIP_DEFAULT_FETCHSPEC : constant unsigned := 2;  -- /usr/include/git2/remote.h:53

  --*
  -- * Remote creation options structure
  -- *
  -- * Initialize with `GIT_REMOTE_CREATE_OPTIONS_INIT`. Alternatively, you can
  -- * use `git_remote_create_options_init`.
  -- *
  --  

   type git_remote_create_options is record
      version : aliased unsigned;  -- /usr/include/git2/remote.h:63
      repository : access Git.Low_Level.git2_types_h.git_repository;  -- /usr/include/git2/remote.h:69
      name : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/remote.h:75
      fetchspec : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/remote.h:78
      flags : aliased unsigned;  -- /usr/include/git2/remote.h:81
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/remote.h:62

  --*
  --	 * The repository that should own the remote.
  --	 * Setting this to NULL results in a detached remote.
  --	  

  --*
  --	 * The remote's name.
  --	 * Setting this to NULL results in an in-memory/anonymous remote.
  --	  

  --* The fetchspec the remote should use.  
  --* Additional flags for the remote. See git_remote_create_flags.  
  --*
  -- * Initialize git_remote_create_options structure
  -- *
  -- * Initializes a `git_remote_create_options` with default values. Equivalent to
  -- * creating an instance with `GIT_REMOTE_CREATE_OPTIONS_INIT`.
  -- *
  -- * @param opts The `git_remote_create_options` struct to initialize.
  -- * @param version The struct version; pass `GIT_REMOTE_CREATE_OPTIONS_VERSION`.
  -- * @return Zero on success; -1 on failure.
  --  

   function git_remote_create_options_init (opts : access git_remote_create_options; version : unsigned) return int  -- /usr/include/git2/remote.h:97
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_create_options_init";

  --*
  -- * Create a remote, with options.
  -- *
  -- * This function allows more fine-grained control over the remote creation.
  -- *
  -- * Passing NULL as the opts argument will result in a detached remote.
  -- *
  -- * @param out the resulting remote
  -- * @param url the remote's url
  -- * @param opts the remote creation options
  -- * @return 0, GIT_EINVALIDSPEC, GIT_EEXISTS or an error code
  --  

   function git_remote_create_with_opts
     (c_out : System.Address;
      url : Interfaces.C.Strings.chars_ptr;
      opts : access constant git_remote_create_options) return int  -- /usr/include/git2/remote.h:113
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_create_with_opts";

  --*
  -- * Add a remote with the provided fetch refspec (or default if NULL) to the repository's
  -- * configuration.
  -- *
  -- * @param out the resulting remote
  -- * @param repo the repository in which to create the remote
  -- * @param name the remote's name
  -- * @param url the remote's url
  -- * @param fetch the remote fetch value
  -- * @return 0, GIT_EINVALIDSPEC, GIT_EEXISTS or an error code
  --  

   function git_remote_create_with_fetchspec
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr;
      url : Interfaces.C.Strings.chars_ptr;
      fetch : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:129
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_create_with_fetchspec";

  --*
  -- * Create an anonymous remote
  -- *
  -- * Create a remote with the given url in-memory. You can use this when
  -- * you have a URL instead of a remote's name.
  -- *
  -- * @param out pointer to the new remote objects
  -- * @param repo the associated repository
  -- * @param url the remote repository's URL
  -- * @return 0 or an error code
  --  

   function git_remote_create_anonymous
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      url : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:147
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_create_anonymous";

  --*
  -- * Create a remote without a connected local repo
  -- *
  -- * Create a remote with the given url in-memory. You can use this when
  -- * you have a URL instead of a remote's name.
  -- *
  -- * Contrasted with git_remote_create_anonymous, a detached remote
  -- * will not consider any repo configuration values (such as insteadof url
  -- * substitutions).
  -- *
  -- * @param out pointer to the new remote objects
  -- * @param url the remote repository's URL
  -- * @return 0 or an error code
  --  

   function git_remote_create_detached (c_out : System.Address; url : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:166
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_create_detached";

  --*
  -- * Get the information for a particular remote
  -- *
  -- * The name will be checked for validity.
  -- * See `git_tag_create()` for rules about valid names.
  -- *
  -- * @param out pointer to the new remote object
  -- * @param repo the associated repository
  -- * @param name the remote's name
  -- * @return 0, GIT_ENOTFOUND, GIT_EINVALIDSPEC or an error code
  --  

   function git_remote_lookup
     (c_out : System.Address;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:181
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_lookup";

  --*
  -- * Create a copy of an existing remote.  All internal strings are also
  -- * duplicated. Callbacks are not duplicated.
  -- *
  -- * Call `git_remote_free` to free the data.
  -- *
  -- * @param dest pointer where to store the copy
  -- * @param source object to copy
  -- * @return 0 or an error code
  --  

   function git_remote_dup (dest : System.Address; source : access Git.Low_Level.git2_types_h.git_remote) return int  -- /usr/include/git2/remote.h:193
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_dup";

  --*
  -- * Get the remote's repository
  -- *
  -- * @param remote the remote
  -- * @return a pointer to the repository
  --  

   function git_remote_owner (remote : access constant Git.Low_Level.git2_types_h.git_remote) return access Git.Low_Level.git2_types_h.git_repository  -- /usr/include/git2/remote.h:201
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_owner";

  --*
  -- * Get the remote's name
  -- *
  -- * @param remote the remote
  -- * @return a pointer to the name or NULL for in-memory remotes
  --  

   function git_remote_name (remote : access constant Git.Low_Level.git2_types_h.git_remote) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/remote.h:209
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_name";

  --*
  -- * Get the remote's url
  -- *
  -- * If url.*.insteadOf has been configured for this URL, it will
  -- * return the modified URL.
  -- *
  -- * @param remote the remote
  -- * @return a pointer to the url
  --  

   function git_remote_url (remote : access constant Git.Low_Level.git2_types_h.git_remote) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/remote.h:220
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_url";

  --*
  -- * Get the remote's url for pushing
  -- *
  -- * If url.*.pushInsteadOf has been configured for this URL, it
  -- * will return the modified URL.
  -- *
  -- * @param remote the remote
  -- * @return a pointer to the url or NULL if no special url for pushing is set
  --  

   function git_remote_pushurl (remote : access constant Git.Low_Level.git2_types_h.git_remote) return Interfaces.C.Strings.chars_ptr  -- /usr/include/git2/remote.h:231
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_pushurl";

  --*
  -- * Set the remote's url in the configuration
  -- *
  -- * Remote objects already in memory will not be affected. This assumes
  -- * the common case of a single-url remote and will otherwise return an error.
  -- *
  -- * @param repo the repository in which to perform the change
  -- * @param remote the remote's name
  -- * @param url the url to set
  -- * @return 0 or an error value
  --  

   function git_remote_set_url
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      remote : Interfaces.C.Strings.chars_ptr;
      url : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:244
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_set_url";

  --*
  -- * Set the remote's url for pushing in the configuration.
  -- *
  -- * Remote objects already in memory will not be affected. This assumes
  -- * the common case of a single-url remote and will otherwise return an error.
  -- *
  -- *
  -- * @param repo the repository in which to perform the change
  -- * @param remote the remote's name
  -- * @param url the url to set
  --  

   function git_remote_set_pushurl
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      remote : Interfaces.C.Strings.chars_ptr;
      url : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:257
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_set_pushurl";

  --*
  -- * Add a fetch refspec to the remote's configuration
  -- *
  -- * Add the given refspec to the fetch list in the configuration. No
  -- * loaded remote instances will be affected.
  -- *
  -- * @param repo the repository in which to change the configuration
  -- * @param remote the name of the remote to change
  -- * @param refspec the new fetch refspec
  -- * @return 0, GIT_EINVALIDSPEC if refspec is invalid or an error value
  --  

   function git_remote_add_fetch
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      remote : Interfaces.C.Strings.chars_ptr;
      refspec : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:270
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_add_fetch";

  --*
  -- * Get the remote's list of fetch refspecs
  -- *
  -- * The memory is owned by the user and should be freed with
  -- * `git_strarray_free`.
  -- *
  -- * @param array pointer to the array in which to store the strings
  -- * @param remote the remote to query
  --  

   function git_remote_get_fetch_refspecs (c_array : access Git.Low_Level.git2_strarray_h.git_strarray; remote : access constant Git.Low_Level.git2_types_h.git_remote) return int  -- /usr/include/git2/remote.h:281
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_get_fetch_refspecs";

  --*
  -- * Add a push refspec to the remote's configuration
  -- *
  -- * Add the given refspec to the push list in the configuration. No
  -- * loaded remote instances will be affected.
  -- *
  -- * @param repo the repository in which to change the configuration
  -- * @param remote the name of the remote to change
  -- * @param refspec the new push refspec
  -- * @return 0, GIT_EINVALIDSPEC if refspec is invalid or an error value
  --  

   function git_remote_add_push
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      remote : Interfaces.C.Strings.chars_ptr;
      refspec : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:294
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_add_push";

  --*
  -- * Get the remote's list of push refspecs
  -- *
  -- * The memory is owned by the user and should be freed with
  -- * `git_strarray_free`.
  -- *
  -- * @param array pointer to the array in which to store the strings
  -- * @param remote the remote to query
  --  

   function git_remote_get_push_refspecs (c_array : access Git.Low_Level.git2_strarray_h.git_strarray; remote : access constant Git.Low_Level.git2_types_h.git_remote) return int  -- /usr/include/git2/remote.h:305
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_get_push_refspecs";

  --*
  -- * Get the number of refspecs for a remote
  -- *
  -- * @param remote the remote
  -- * @return the amount of refspecs configured in this remote
  --  

   function git_remote_refspec_count (remote : access constant Git.Low_Level.git2_types_h.git_remote) return unsigned_long  -- /usr/include/git2/remote.h:313
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_refspec_count";

  --*
  -- * Get a refspec from the remote
  -- *
  -- * @param remote the remote to query
  -- * @param n the refspec to get
  -- * @return the nth refspec
  --  

   function git_remote_get_refspec (remote : access constant Git.Low_Level.git2_types_h.git_remote; n : unsigned_long) return access constant Git.Low_Level.git2_types_h.git_refspec  -- /usr/include/git2/remote.h:322
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_get_refspec";

  --*
  -- * Open a connection to a remote
  -- *
  -- * The transport is selected based on the URL. The direction argument
  -- * is due to a limitation of the git protocol (over TCP or SSH) which
  -- * starts up a specific binary which can only do the one or the other.
  -- *
  -- * @param remote the remote to connect to
  -- * @param direction GIT_DIRECTION_FETCH if you want to fetch or
  -- * GIT_DIRECTION_PUSH if you want to push
  -- * @param callbacks the callbacks to use for this connection
  -- * @param proxy_opts proxy settings
  -- * @param custom_headers extra HTTP headers to use in this connection
  -- * @return 0 or an error code
  --  

   type git_remote_callbacks;
   function git_remote_connect
     (remote : access Git.Low_Level.git2_types_h.git_remote;
      direction : Git.Low_Level.git2_net_h.git_direction;
      callbacks : access constant git_remote_callbacks;
      proxy_opts : access constant Git.Low_Level.git2_proxy_h.git_proxy_options;
      custom_headers : access constant Git.Low_Level.git2_strarray_h.git_strarray) return int  -- /usr/include/git2/remote.h:339
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_connect";

  --*
  -- * Get the remote repository's reference advertisement list
  -- *
  -- * Get the list of references with which the server responds to a new
  -- * connection.
  -- *
  -- * The remote (or more exactly its transport) must have connected to
  -- * the remote repository. This list is available as soon as the
  -- * connection to the remote is initiated and it remains available
  -- * after disconnecting.
  -- *
  -- * The memory belongs to the remote. The pointer will be valid as long
  -- * as a new connection is not initiated, but it is recommended that
  -- * you make a copy in order to make use of the data.
  -- *
  -- * @param out pointer to the array
  -- * @param size the number of remote heads
  -- * @param remote the remote
  -- * @return 0 on success, or an error code
  --  

   function git_remote_ls
     (c_out : System.Address;
      size : access unsigned_long;
      remote : access Git.Low_Level.git2_types_h.git_remote) return int  -- /usr/include/git2/remote.h:361
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_ls";

  --*
  -- * Check whether the remote is connected
  -- *
  -- * Check whether the remote's underlying transport is connected to the
  -- * remote host.
  -- *
  -- * @param remote the remote
  -- * @return 1 if it's connected, 0 otherwise.
  --  

   function git_remote_connected (remote : access constant Git.Low_Level.git2_types_h.git_remote) return int  -- /usr/include/git2/remote.h:372
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_connected";

  --*
  -- * Cancel the operation
  -- *
  -- * At certain points in its operation, the network code checks whether
  -- * the operation has been cancelled and if so stops the operation.
  -- *
  -- * @param remote the remote
  -- * @return 0 on success, or an error code
  --  

   function git_remote_stop (remote : access Git.Low_Level.git2_types_h.git_remote) return int  -- /usr/include/git2/remote.h:383
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_stop";

  --*
  -- * Disconnect from the remote
  -- *
  -- * Close the connection to the remote.
  -- *
  -- * @param remote the remote to disconnect from
  -- * @return 0 on success, or an error code
  --  

   function git_remote_disconnect (remote : access Git.Low_Level.git2_types_h.git_remote) return int  -- /usr/include/git2/remote.h:393
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_disconnect";

  --*
  -- * Free the memory associated with a remote
  -- *
  -- * This also disconnects from the remote, if the connection
  -- * has not been closed yet (using git_remote_disconnect).
  -- *
  -- * @param remote the remote to free
  --  

   procedure git_remote_free (remote : access Git.Low_Level.git2_types_h.git_remote)  -- /usr/include/git2/remote.h:403
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_free";

  --*
  -- * Get a list of the configured remotes for a repo
  -- *
  -- * The string array must be freed by the user.
  -- *
  -- * @param out a string array which receives the names of the remotes
  -- * @param repo the repository to query
  -- * @return 0 or an error code
  --  

   function git_remote_list (c_out : access Git.Low_Level.git2_strarray_h.git_strarray; repo : access Git.Low_Level.git2_types_h.git_repository) return int  -- /usr/include/git2/remote.h:414
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_list";

  --*
  -- * Argument to the completion callback which tells it which operation
  -- * finished.
  --  

   type git_remote_completion_t is 
     (GIT_REMOTE_COMPLETION_DOWNLOAD,
      GIT_REMOTE_COMPLETION_INDEXING,
      GIT_REMOTE_COMPLETION_ERROR)
   with Convention => C;  -- /usr/include/git2/remote.h:420

  --* Push network progress notification function  
   type git_push_transfer_progress_cb is access function
        (arg1 : unsigned;
         arg2 : unsigned;
         arg3 : unsigned_long;
         arg4 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/remote.h:427

  --*
  -- * Represents an update which will be performed on the remote during push
  --  

  --*
  --	 * The source name of the reference
  --	  

   --  skipped anonymous struct anon_anon_94

   type git_push_update is record
      src_refname : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/remote.h:440
      dst_refname : Interfaces.C.Strings.chars_ptr;  -- /usr/include/git2/remote.h:444
      src : aliased Git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/remote.h:448
      dst : aliased Git.Low_Level.git2_oid_h.git_oid;  -- /usr/include/git2/remote.h:452
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/remote.h:453

  --*
  --	 * The name of the reference to update on the server
  --	  

  --*
  --	 * The current target of the reference
  --	  

  --*
  --	 * The new target for the reference
  --	  

  --*
  -- * Callback used to inform of upcoming updates.
  -- *
  -- * @param updates an array containing the updates which will be sent
  -- * as commands to the destination.
  -- * @param len number of elements in `updates`
  -- * @param payload Payload provided by the caller
  --  

   type git_push_negotiation is access function
        (arg1 : System.Address;
         arg2 : unsigned_long;
         arg3 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/remote.h:463

  --*
  -- * Callback used to inform of the update status from the remote.
  -- *
  -- * Called for each updated reference on push. If `status` is
  -- * not `NULL`, the update was rejected by the remote server
  -- * and `status` contains the reason given.
  -- *
  -- * @param refname refname specifying to the remote ref
  -- * @param status status message sent from the remote
  -- * @param data data provided by the caller
  -- * @return 0 on success, otherwise an error
  --  

   type git_push_update_reference_cb is access function
        (arg1 : Interfaces.C.Strings.chars_ptr;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/remote.h:477

  --*
  -- * Callback to resolve URLs before connecting to remote
  -- *
  -- * If you return GIT_PASSTHROUGH, you don't need to write anything to
  -- * url_resolved.
  -- *
  -- * @param url_resolved The buffer to write the resolved URL to
  -- * @param url The URL to resolve
  -- * @param direction GIT_DIRECTION_FETCH or GIT_DIRECTION_PUSH
  -- * @param payload Payload provided by the caller
  -- * @return 0 on success, GIT_PASSTHROUGH or an error
  --  

   type git_url_resolve_cb is access function
        (arg1 : access Git.Low_Level.git2_buffer_h.git_buf;
         arg2 : Interfaces.C.Strings.chars_ptr;
         arg3 : int;
         arg4 : System.Address) return int
   with Convention => C;  -- /usr/include/git2/remote.h:491

  --*
  -- * The callback settings structure
  -- *
  -- * Set the callbacks to be called by the remote when informing the user
  -- * about the progress of the network operations.
  --  

  --*< The version  
   type git_remote_callbacks is record
      version : aliased unsigned;  -- /usr/include/git2/remote.h:500
      sideband_progress : Git.Low_Level.git2_transport_h.git_transport_message_cb;  -- /usr/include/git2/remote.h:507
      completion : access function (arg1 : git_remote_completion_t; arg2 : System.Address) return int;  -- /usr/include/git2/remote.h:513
      credentials : Git.Low_Level.git2_credential_h.git_credential_acquire_cb;  -- /usr/include/git2/remote.h:522
      certificate_check : Git.Low_Level.git2_cert_h.git_transport_certificate_check_cb;  -- /usr/include/git2/remote.h:530
      transfer_progress : Git.Low_Level.git2_indexer_h.git_indexer_progress_cb;  -- /usr/include/git2/remote.h:537
      update_tips : access function
           (arg1 : Interfaces.C.Strings.chars_ptr;
            arg2 : access constant Git.Low_Level.git2_oid_h.git_oid;
            arg3 : access constant Git.Low_Level.git2_oid_h.git_oid;
            arg4 : System.Address) return int;  -- /usr/include/git2/remote.h:543
      pack_progress : Git.Low_Level.git2_pack_h.git_packbuilder_progress;  -- /usr/include/git2/remote.h:550
      push_transfer_progress : git_push_transfer_progress_cb;  -- /usr/include/git2/remote.h:558
      push_update_reference : git_push_update_reference_cb;  -- /usr/include/git2/remote.h:563
      push_negotiation : git_push_negotiation;  -- /usr/include/git2/remote.h:569
      transport : Git.Low_Level.git2_transport_h.git_transport_cb;  -- /usr/include/git2/remote.h:575
      payload : System.Address;  -- /usr/include/git2/remote.h:581
      resolve_url : git_url_resolve_cb;  -- /usr/include/git2/remote.h:587
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/remote.h:499

  --*
  --	 * Textual progress from the remote. Text send over the
  --	 * progress side-band will be passed to this function (this is
  --	 * the 'counting objects' output).
  --	  

  --*
  --	 * Completion is called when different parts of the download
  --	 * process are done (currently unused).
  --	  

  --*
  --	 * This will be called if the remote host requires
  --	 * authentication in order to connect to it.
  --	 *
  --	 * Returning GIT_PASSTHROUGH will make libgit2 behave as
  --	 * though this field isn't set.
  --	  

  --*
  --	 * If cert verification fails, this will be called to let the
  --	 * user make the final decision of whether to allow the
  --	 * connection to proceed. Returns 0 to allow the connection
  --	 * or a negative value to indicate an error.
  --	  

  --*
  --	 * During the download of new data, this will be regularly
  --	 * called with the current count of progress done by the
  --	 * indexer.
  --	  

  --*
  --	 * Each time a reference is updated locally, this function
  --	 * will be called with information about it.
  --	  

  --*
  --	 * Function to call with progress information during pack
  --	 * building. Be aware that this is called inline with pack
  --	 * building operations, so performance may be affected.
  --	  

  --*
  --	 * Function to call with progress information during the
  --	 * upload portion of a push. Be aware that this is called
  --	 * inline with pack building operations, so performance may be
  --	 * affected.
  --	  

  --*
  --	 * See documentation of git_push_update_reference_cb
  --	  

  --*
  --	 * Called once between the negotiation step and the upload. It
  --	 * provides information about what updates will be performed.
  --	  

  --*
  --	 * Create the transport to use for this operation. Leave NULL
  --	 * to auto-detect.
  --	  

  --*
  --	 * This will be passed to each of the callbacks in this struct
  --	 * as the last parameter.
  --	  

  --*
  --	 * Resolve URL before connecting to remote.
  --	 * The returned URL will be used to connect to the remote instead.
  --	  

  --*
  -- * Initializes a `git_remote_callbacks` with default values. Equivalent to
  -- * creating an instance with GIT_REMOTE_CALLBACKS_INIT.
  -- *
  -- * @param opts the `git_remote_callbacks` struct to initialize
  -- * @param version Version of struct; pass `GIT_REMOTE_CALLBACKS_VERSION`
  -- * @return Zero on success; -1 on failure.
  --  

   function git_remote_init_callbacks (opts : access git_remote_callbacks; version : unsigned) return int  -- /usr/include/git2/remote.h:601
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_init_callbacks";

  --* Acceptable prune settings when fetching  
  --*
  --	 * Use the setting from the configuration
  --	  

  --*
  --	 * Force pruning on
  --	  

  --*
  --	 * Force pruning off
  --	  

   type git_fetch_prune_t is 
     (GIT_FETCH_PRUNE_UNSPECIFIED,
      GIT_FETCH_PRUNE,
      GIT_FETCH_NO_PRUNE)
   with Convention => C;  -- /usr/include/git2/remote.h:619

  --*
  -- * Automatic tag following option
  -- *
  -- * Lets us select the --tags option to use.
  --  

  --*
  --	 * Use the setting from the configuration.
  --	  

  --*
  --	 * Ask the server for tags pointing to objects we're already
  --	 * downloading.
  --	  

  --*
  --	 * Don't ask for any tags beyond the refspecs.
  --	  

  --*
  --	 * Ask for the all the tags.
  --	  

   type git_remote_autotag_option_t is 
     (GIT_REMOTE_DOWNLOAD_TAGS_UNSPECIFIED,
      GIT_REMOTE_DOWNLOAD_TAGS_AUTO,
      GIT_REMOTE_DOWNLOAD_TAGS_NONE,
      GIT_REMOTE_DOWNLOAD_TAGS_ALL)
   with Convention => C;  -- /usr/include/git2/remote.h:644

  --*
  -- * Fetch options structure.
  -- *
  -- * Zero out for defaults.  Initialize with `GIT_FETCH_OPTIONS_INIT` macro to
  -- * correctly set the `version` field.  E.g.
  -- *
  -- *		git_fetch_options opts = GIT_FETCH_OPTIONS_INIT;
  --  

   --  skipped anonymous struct anon_anon_97

   type git_fetch_options is record
      version : aliased int;  -- /usr/include/git2/remote.h:655
      callbacks : aliased git_remote_callbacks;  -- /usr/include/git2/remote.h:660
      prune : aliased git_fetch_prune_t;  -- /usr/include/git2/remote.h:665
      update_fetchhead : aliased int;  -- /usr/include/git2/remote.h:671
      download_tags : aliased git_remote_autotag_option_t;  -- /usr/include/git2/remote.h:680
      proxy_opts : aliased Git.Low_Level.git2_proxy_h.git_proxy_options;  -- /usr/include/git2/remote.h:685
      custom_headers : aliased Git.Low_Level.git2_strarray_h.git_strarray;  -- /usr/include/git2/remote.h:690
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/remote.h:691

  --*
  --	 * Callbacks to use for this fetch operation
  --	  

  --*
  --	 * Whether to perform a prune after the fetch
  --	  

  --*
  --	 * Whether to write the results to FETCH_HEAD. Defaults to
  --	 * on. Leave this default in order to behave like git.
  --	  

  --*
  --	 * Determines how to behave regarding tags on the remote, such
  --	 * as auto-downloading tags for objects we're downloading or
  --	 * downloading all of them.
  --	 *
  --	 * The default is to auto-follow tags.
  --	  

  --*
  --	 * Proxy options to use, by default no proxy is used.
  --	  

  --*
  --	 * Extra headers for this fetch operation
  --	  

  --*
  -- * Initialize git_fetch_options structure
  -- *
  -- * Initializes a `git_fetch_options` with default values. Equivalent to
  -- * creating an instance with `GIT_FETCH_OPTIONS_INIT`.
  -- *
  -- * @param opts The `git_fetch_options` struct to initialize.
  -- * @param version The struct version; pass `GIT_FETCH_OPTIONS_VERSION`.
  -- * @return Zero on success; -1 on failure.
  --  

   function git_fetch_options_init (opts : access git_fetch_options; version : unsigned) return int  -- /usr/include/git2/remote.h:707
   with Import => True, 
        Convention => C, 
        External_Name => "git_fetch_options_init";

  --*
  -- * Controls the behavior of a git_push object.
  --  

   --  skipped anonymous struct anon_anon_98

   type git_push_options is record
      version : aliased unsigned;  -- /usr/include/git2/remote.h:716
      pb_parallelism : aliased unsigned;  -- /usr/include/git2/remote.h:726
      callbacks : aliased git_remote_callbacks;  -- /usr/include/git2/remote.h:731
      proxy_opts : aliased Git.Low_Level.git2_proxy_h.git_proxy_options;  -- /usr/include/git2/remote.h:736
      custom_headers : aliased Git.Low_Level.git2_strarray_h.git_strarray;  -- /usr/include/git2/remote.h:741
   end record
   with Convention => C_Pass_By_Copy;  -- /usr/include/git2/remote.h:742

  --*
  --	 * If the transport being used to push to the remote requires the creation
  --	 * of a pack file, this controls the number of worker threads used by
  --	 * the packbuilder when creating that pack file to be sent to the remote.
  --	 *
  --	 * If set to 0, the packbuilder will auto-detect the number of threads
  --	 * to create. The default value is 1.
  --	  

  --*
  --	 * Callbacks to use for this push operation
  --	  

  --*
  --	* Proxy options to use, by default no proxy is used.
  --	 

  --*
  --	 * Extra headers for this push operation
  --	  

  --*
  -- * Initialize git_push_options structure
  -- *
  -- * Initializes a `git_push_options` with default values. Equivalent to
  -- * creating an instance with `GIT_PUSH_OPTIONS_INIT`.
  -- *
  -- * @param opts The `git_push_options` struct to initialize.
  -- * @param version The struct version; pass `GIT_PUSH_OPTIONS_VERSION`.
  -- * @return Zero on success; -1 on failure.
  --  

   function git_push_options_init (opts : access git_push_options; version : unsigned) return int  -- /usr/include/git2/remote.h:757
   with Import => True, 
        Convention => C, 
        External_Name => "git_push_options_init";

  --*
  -- * Download and index the packfile
  -- *
  -- * Connect to the remote if it hasn't been done yet, negotiate with
  -- * the remote git which objects are missing, download and index the
  -- * packfile.
  -- *
  -- * The .idx file will be created and both it and the packfile with be
  -- * renamed to their final name.
  -- *
  -- * @param remote the remote
  -- * @param refspecs the refspecs to use for this negotiation and
  -- * download. Use NULL or an empty array to use the base refspecs
  -- * @param opts the options to use for this fetch
  -- * @return 0 or an error code
  --  

   function git_remote_download
     (remote : access Git.Low_Level.git2_types_h.git_remote;
      refspecs : access constant Git.Low_Level.git2_strarray_h.git_strarray;
      opts : access constant git_fetch_options) return int  -- /usr/include/git2/remote.h:777
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_download";

  --*
  -- * Create a packfile and send it to the server
  -- *
  -- * Connect to the remote if it hasn't been done yet, negotiate with
  -- * the remote git which objects are missing, create a packfile with the missing objects and send it.
  -- *
  -- * @param remote the remote
  -- * @param refspecs the refspecs to use for this negotiation and
  -- * upload. Use NULL or an empty array to use the base refspecs
  -- * @param opts the options to use for this push
  -- * @return 0 or an error code
  --  

   function git_remote_upload
     (remote : access Git.Low_Level.git2_types_h.git_remote;
      refspecs : access constant Git.Low_Level.git2_strarray_h.git_strarray;
      opts : access constant git_push_options) return int  -- /usr/include/git2/remote.h:791
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_upload";

  --*
  -- * Update the tips to the new state
  -- *
  -- * @param remote the remote to update
  -- * @param reflog_message The message to insert into the reflogs. If
  -- * NULL and fetching, the default is "fetch <name>", where <name> is
  -- * the name of the remote (or its url, for in-memory remotes). This
  -- * parameter is ignored when pushing.
  -- * @param callbacks  pointer to the callback structure to use
  -- * @param update_fetchhead whether to write to FETCH_HEAD. Pass 1 to behave like git.
  -- * @param download_tags what the behaviour for downloading tags is for this fetch. This is
  -- * ignored for push. This must be the same value passed to `git_remote_download()`.
  -- * @return 0 or an error code
  --  

   function git_remote_update_tips
     (remote : access Git.Low_Level.git2_types_h.git_remote;
      callbacks : access constant git_remote_callbacks;
      update_fetchhead : int;
      download_tags : git_remote_autotag_option_t;
      reflog_message : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:807
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_update_tips";

  --*
  -- * Download new data and update tips
  -- *
  -- * Convenience function to connect to a remote, download the data,
  -- * disconnect and update the remote-tracking branches.
  -- *
  -- * @param remote the remote to fetch from
  -- * @param refspecs the refspecs to use for this fetch. Pass NULL or an
  -- *                 empty array to use the base refspecs.
  -- * @param opts options to use for this fetch
  -- * @param reflog_message The message to insert into the reflogs. If NULL, the
  -- *								 default is "fetch"
  -- * @return 0 or an error code
  --  

   function git_remote_fetch
     (remote : access Git.Low_Level.git2_types_h.git_remote;
      refspecs : access constant Git.Low_Level.git2_strarray_h.git_strarray;
      opts : access constant git_fetch_options;
      reflog_message : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:828
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_fetch";

  --*
  -- * Prune tracking refs that are no longer present on remote
  -- *
  -- * @param remote the remote to prune
  -- * @param callbacks callbacks to use for this prune
  -- * @return 0 or an error code
  --  

   function git_remote_prune (remote : access Git.Low_Level.git2_types_h.git_remote; callbacks : access constant git_remote_callbacks) return int  -- /usr/include/git2/remote.h:841
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_prune";

  --*
  -- * Perform a push
  -- *
  -- * Peform all the steps from a push.
  -- *
  -- * @param remote the remote to push to
  -- * @param refspecs the refspecs to use for pushing. If NULL or an empty
  -- *                 array, the configured refspecs will be used
  -- * @param opts options to use for this push
  --  

   function git_remote_push
     (remote : access Git.Low_Level.git2_types_h.git_remote;
      refspecs : access constant Git.Low_Level.git2_strarray_h.git_strarray;
      opts : access constant git_push_options) return int  -- /usr/include/git2/remote.h:853
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_push";

  --*
  -- * Get the statistics structure that is filled in by the fetch operation.
  --  

   function git_remote_stats (remote : access Git.Low_Level.git2_types_h.git_remote) return access constant Git.Low_Level.git2_indexer_h.git_indexer_progress  -- /usr/include/git2/remote.h:860
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_stats";

  --*
  -- * Retrieve the tag auto-follow setting
  -- *
  -- * @param remote the remote to query
  -- * @return the auto-follow setting
  --  

   function git_remote_autotag (remote : access constant Git.Low_Level.git2_types_h.git_remote) return git_remote_autotag_option_t  -- /usr/include/git2/remote.h:868
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_autotag";

  --*
  -- * Set the remote's tag following setting.
  -- *
  -- * The change will be made in the configuration. No loaded remotes
  -- * will be affected.
  -- *
  -- * @param repo the repository in which to make the change
  -- * @param remote the name of the remote
  -- * @param value the new value to take.
  --  

   function git_remote_set_autotag
     (repo : access Git.Low_Level.git2_types_h.git_repository;
      remote : Interfaces.C.Strings.chars_ptr;
      value : git_remote_autotag_option_t) return int  -- /usr/include/git2/remote.h:880
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_set_autotag";

  --*
  -- * Retrieve the ref-prune setting
  -- *
  -- * @param remote the remote to query
  -- * @return the ref-prune setting
  --  

   function git_remote_prune_refs (remote : access constant Git.Low_Level.git2_types_h.git_remote) return int  -- /usr/include/git2/remote.h:887
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_prune_refs";

  --*
  -- * Give the remote a new name
  -- *
  -- * All remote-tracking branches and configuration settings
  -- * for the remote are updated.
  -- *
  -- * The new name will be checked for validity.
  -- * See `git_tag_create()` for rules about valid names.
  -- *
  -- * No loaded instances of a the remote with the old name will change
  -- * their name or their list of refspecs.
  -- *
  -- * @param problems non-default refspecs cannot be renamed and will be
  -- * stored here for further processing by the caller. Always free this
  -- * strarray on successful return.
  -- * @param repo the repository in which to rename
  -- * @param name the current name of the remote
  -- * @param new_name the new name the remote should bear
  -- * @return 0, GIT_EINVALIDSPEC, GIT_EEXISTS or an error code
  --  

   function git_remote_rename
     (problems : access Git.Low_Level.git2_strarray_h.git_strarray;
      repo : access Git.Low_Level.git2_types_h.git_repository;
      name : Interfaces.C.Strings.chars_ptr;
      new_name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:909
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_rename";

  --*
  -- * Ensure the remote name is well-formed.
  -- *
  -- * @param remote_name name to be checked.
  -- * @return 1 if the reference name is acceptable; 0 if it isn't
  --  

   function git_remote_is_valid_name (remote_name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:921
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_is_valid_name";

  --*
  --* Delete an existing persisted remote.
  --*
  --* All remote-tracking branches and configuration settings
  --* for the remote will be removed.
  --*
  --* @param repo the repository in which to act
  --* @param name the name of the remote to delete
  --* @return 0 on success, or an error code.
  -- 

   function git_remote_delete (repo : access Git.Low_Level.git2_types_h.git_repository; name : Interfaces.C.Strings.chars_ptr) return int  -- /usr/include/git2/remote.h:933
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_delete";

  --*
  -- * Retrieve the name of the remote's default branch
  -- *
  -- * The default branch of a repository is the branch which HEAD points
  -- * to. If the remote does not support reporting this information
  -- * directly, it performs the guess as git does; that is, if there are
  -- * multiple branches which point to the same commit, the first one is
  -- * chosen. If the master branch is a candidate, it wins.
  -- *
  -- * This function must only be called after connecting.
  -- *
  -- * @param out the buffern in which to store the reference name
  -- * @param remote the remote
  -- * @return 0, GIT_ENOTFOUND if the remote does not have any references
  -- * or none of them point to HEAD's commit, or an error message.
  --  

  -- * Copyright (C) the libgit2 contributors. All rights reserved.
  -- *
  -- * This file is part of libgit2, distributed under the GNU GPL v2 with
  -- * a Linking Exception. For full terms see the included COPYING file.
  --  

   function git_remote_default_branch (c_out : access Git.Low_Level.git2_buffer_h.git_buf; remote : access Git.Low_Level.git2_types_h.git_remote) return int  -- /usr/include/git2/remote.h:951
   with Import => True, 
        Convention => C, 
        External_Name => "git_remote_default_branch";

end Git.Low_Level.git2_remote_h;

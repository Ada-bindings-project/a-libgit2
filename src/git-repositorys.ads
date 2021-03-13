with Ada.Finalization;
with Git.Low_Level.Git2_Types_H;
with Interfaces.C;
with git.Worktrees;
with Git.Odbs;
package Git.Repositorys is
   type Git_Repository_Access is access all Git.Low_Level.Git2_Types_H.Git_Repository;

   type Repository is new Ada.Finalization.Limited_Controlled with record
      Impl : aliased Git_Repository_Access;
   end record;

   procedure Finalize   (Object : in out Repository);

   procedure Open (Repo : in out Repository; Path : String);

   procedure Open (Repo : in out Repository; Wt : Git.Worktrees.Worktree);

   procedure Wrap (Repo : in out Repository; Odb : Git.Odbs.Odb);


   procedure Discover (Repo         : in out Repository;
                       start_path   : String;
                       Across_Fs    : Boolean;
                       Ceiling_Dirs : String);

   type Open_Flag_T is new Interfaces.C.Unsigned;
   NO_SEARCH : constant Open_Flag_T := 2#0000_0001#;
   CROSS_FS  : constant Open_Flag_T := 2#0000_0010#;
   BARE      : constant Open_Flag_T := 2#0000_0100#;
   NO_DOTGIT : constant Open_Flag_T := 2#0000_1000#;
   FROM_ENV  : constant Open_Flag_T := 2#0001_0000#;

   function "+" (L, R : Open_Flag_T) return Open_Flag_T;
   function "-" (L, R : Open_Flag_T) return Open_Flag_T is abstract;
   function "*" (L, R : Open_Flag_T) return Open_Flag_T is abstract;
   function "/" (L, R : Open_Flag_T) return Open_Flag_T is abstract;

   procedure Open (Repo         : in out Repository;
                   Path         : String;
                   Flags        : Open_Flag_T;
                   Ceiling_Dirs : String);

   procedure Open_Bare (Repo : in out Repository; Bare_Path : String);

   procedure Init (Repo : in out Repository; Path : String; Is_Bare : Boolean := False);

   type Init_Flag_T is new Interfaces.C.Unsigned;
   INIT_BARE              : constant Init_Flag_T := 2#0000_0001#;
   INIT_NO_REINIT         : constant Init_Flag_T := 2#0000_0010#;
   INIT_NO_DOTGIT_DIR     : constant Init_Flag_T := 2#0000_0100#;
   INIT_MKDIR             : constant Init_Flag_T := 2#0000_1000#;
   INIT_MKPATH            : constant Init_Flag_T := 2#0001_0000#;
   INIT_EXTERNAL_TEMPLATE : constant Init_Flag_T := 2#0010_0000#;
   INIT_RELATIVE_GITLINK  : constant Init_Flag_T := 2#0100_0000#;

   function "+" (L, R : Init_Flag_T) return Init_Flag_T;
   function "-" (L, R : Init_Flag_T) return Init_Flag_T is abstract;
   function "*" (L, R : Init_Flag_T) return Init_Flag_T is abstract;
   function "/" (L, R : Init_Flag_T) return Init_Flag_T is abstract;

   type Init_Mode_T is new Interfaces.C.Unsigned;
   INIT_SHARED_UMASK : constant Init_Mode_T := 0_000; -- 2#0000_0000_0000#
   INIT_SHARED_GROUP : constant Init_Mode_T := 1_533; -- 2#0101_1111_1101#
   INIT_SHARED_ALL   : constant Init_Mode_T := 1_535; -- 2#0101_1111_1111#
   procedure Init (Repo          : in out Repository;
                   Version       : Integer;
                   Flags         : Init_Flag_T;
                   Mode          : Init_Mode_T;
                   Workdir_Path  : String;
                   Description   : String;
                   Template_Path : String;
                   Initial_Head  : String;
                   Origin_Url    : String);

   --   function Head(Repo : in Repository) return
end Git.Repositorys;

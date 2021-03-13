with Ada.Finalization;
with Git.Low_Level.Git2_Types_H;
with Interfaces.C;
package Git.Repositorys is
   type Git_Repository_Access is access all Git.Low_Level.Git2_Types_H.Git_Repository;

   type Repository is new Ada.Finalization.Limited_Controlled with record
      Impl : aliased Git_Repository_Access;
   end record;

   procedure Finalize   (Object : in out Repository);
   procedure Open (Repo : in out Repository; Path : String);
   --  procedure Open (Repo : in out Repository; wt : git_worktree);
   --  procedure Open (Repo : in out Repository; odb : git_odb);
   --  procedure discover (-----Repo : in out Repository; path : git_odb);

   type Open_Flag_T is new Interfaces.C.Unsigned;
   NO_SEARCH : constant Open_Flag_T := 1;
   CROSS_FS  : constant Open_Flag_T := 2;
   BARE      : constant Open_Flag_T := 4;
   NO_DOTGIT : constant Open_Flag_T := 8;
   FROM_ENV  : constant Open_Flag_T := 16;

   function "+" (L, R : Open_Flag_T) return Open_Flag_T;

   procedure Open (Repo         : in out Repository;
                   Path         : String;
                   Flags        : Open_Flag_T;
                   Ceiling_Dirs : String);

   procedure Open_Bare (Repo : in out Repository; Bare_Path : String);
   procedure Init (Repo : in out Repository; Path : String; Is_Bare : Boolean := False);




end Git.Repositorys;

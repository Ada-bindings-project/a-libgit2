pragma Ada_2012;
with Interfaces.C.Strings;
with Git.Low_Level.Git2_Repository_H;
package body Git.Repositorys is
   use Git.Low_Level.Git2_Repository_H;
   use Interfaces.C.Strings;
   ----------
   -- Open --
   ----------

   procedure Open (Repo : in out Repository; Path : String) is
      Ret    : Interfaces.C.Int;
      C_PAth : Interfaces.C.Strings.Chars_Ptr := New_String (Path);
   begin
      Ret := Git.Low_Level.Git2_Repository_H.Git_Repository_Open
        (C_Out => Repo.Impl'Address,
         Path  => C_Path);
      Free (C_Path);
      Retcode_2_Exeption (Ret);
   end Open;

   ----------
   -- Open --
   ----------

   procedure Open (Repo : in out Repository; Wt : Git.Worktrees.Worktree) is
   begin
      Retcode_2_Exeption (Git.Low_Level.Git2_Repository_H.Git_Repository_Open_From_Worktree
                          (C_Out => Repo.Impl'Address,
                           Wt    => Wt.Impl));
   end Open;

   ----------
   -- Open --
   ----------

   procedure Wrap (Repo : in out Repository; Odb : Git.Odbs.Odb) is
   begin
      Retcode_2_Exeption (Git.Low_Level.Git2_Repository_H.Git_Repository_Wrap_Odb
                          (C_Out => Repo.Impl'Address,
                           Odb   => Odb.Impl));
   end Wrap;

   --------------
   -- Discover --
   --------------

   procedure Discover
     (Repo         : in out Repository;
      Start_Path   : String;
      Across_Fs    : Boolean;
      Ceiling_Dirs : String)
   is
      Ret            : Interfaces.C.Int;
      C_Start_Path   : Interfaces.C.Strings.Chars_Ptr := New_String (Start_Path);
      C_Ceiling_Dirs : Interfaces.C.Strings.Chars_Ptr := New_String (Ceiling_Dirs);
   begin
      --  Ret := Git.Low_Level.Git2_Repository_H.Git_Repository_Discover
      --    (C_Out              => Repo.Impl'Address,
      --     Start_Path         => C_Start_Path,
      --     Across_Fs          => Boolean'Pos (Across_Fs),
      --     Ceiling_Dirs       => C_Ceiling_Dirs);
      Free (C_Start_Path);
      Free (C_Ceiling_Dirs);
      Retcode_2_Exeption (Ret);
   end Discover;

   ---------
   -- "+" --
   ---------

   function "+" (L, R : Open_Flag_T) return Open_Flag_T is
   begin
      return L or R;
   end "+";

   ----------
   -- Open --
   ----------

   procedure Open
     (Repo         : in out Repository;
      Path         : String;
      Flags        : Open_Flag_T;
      Ceiling_Dirs : String)
   is
      Ret            : Interfaces.C.Int;
      C_Path         : Interfaces.C.Strings.Chars_Ptr := New_String (Path);
      C_Ceiling_Dirs : Interfaces.C.Strings.Chars_Ptr := New_String (Ceiling_Dirs);
   begin
      Ret := Git.Low_Level.Git2_Repository_H.Git_Repository_Open_Ext
        (C_Out        => Repo.Impl'Address,
         Path         => C_Path,
         Flags        => Interfaces.C.Unsigned (Flags),
         Ceiling_Dirs => C_Ceiling_Dirs);
      Free (C_Path);
      Free (C_Ceiling_Dirs);
      Retcode_2_Exeption (Ret);
   end Open;

   ---------------
   -- Open_Bare --
   ---------------

   procedure Open_Bare (Repo : in out Repository; Bare_Path : String) is
      Ret    : Interfaces.C.Int;
      C_PAth : Interfaces.C.Strings.Chars_Ptr := New_String (Bare_Path);
   begin
      Ret := Git.Low_Level.Git2_Repository_H.Git_Repository_Open_Bare_F
        (C_Out     => Repo.Impl'Address,
         Bare_Path => C_Path);
      Free (C_Path);
      Retcode_2_Exeption (Ret);
   end Open_Bare;

   ----------
   -- Init --
   ----------

   procedure Init
     (Repo : in out Repository;
      Path    : String;
      Is_Bare : Boolean := False)
   is
      Ret    : Interfaces.C.Int;
      C_PAth : Interfaces.C.Strings.Chars_Ptr := New_String (Path);
   begin
      Ret := Git.Low_Level.Git2_Repository_H.Git_Repository_Init
        (C_Out   => Repo.Impl'Address,
         Path    => C_Path,
         Is_Bare => Boolean'Pos (Is_Bare));
      Free (C_Path);
      Retcode_2_Exeption (Ret);
   end Init;
   function "+" (L, R : Init_Flag_T) return Init_Flag_T is
   begin
      return L or R;
   end;

   procedure Init (Repo          : in out Repository;
                   Version       : Integer;
                   Flags         : Init_Flag_T;
                   Mode          : Init_Mode_T;
                   Workdir_Path  : String;
                   Description   : String;
                   Template_Path : String;
                   Initial_Head  : String;
                   Origin_Url    : String) is
   begin
      null;
   end;

   --------------
   -- Finalize --
   --------------

   procedure Finalize (Object : in out Repository) is
   begin
      if Object.Impl /= null then
         Git_Repository_Free (Object.Impl);
      end if;
   end Finalize;

end Git.Repositorys;

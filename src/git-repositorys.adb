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
     (Repo : in out Repository; Path : String; Is_Bare : Boolean := False)
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

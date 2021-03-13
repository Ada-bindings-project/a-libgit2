pragma Ada_2012;
with Ada.Finalization;
with Git.Low_Level.Git2_Global_H;
package body git is
   use type Interfaces.C.Int;

   ------------------------
   -- Retcode_2_Exeption --
   ------------------------
   procedure Retcode_2_Exeption (Code : Interfaces.C.Int) is
   begin
      if Code /= 0 then
         raise Git_Exeption with "Code:" & Code'Image;
      end if;
   end Retcode_2_Exeption;



   package Controlers is
      type  Controler is new Ada.Finalization.Limited_Controlled with null record;
      procedure Initialize (Object : in out Controler);
      procedure Finalize   (Object : in out Controler);
   end Controlers;

   package body Controlers is
      procedure Initialize (Object : in out Controler) is
         Dummy : Interfaces.C.Int;
      begin
         Dummy := Git.Low_Level.Git2_Global_H.git_libgit2_init;
      end;
      procedure Finalize   (Object : in out Controler) is
         Dummy : Interfaces.C.Int;
      begin
         Dummy := Git.Low_Level.Git2_Global_H.git_libgit2_shutdown;
      end;
   end Controlers;
   C : Controlers.Controler with Unreferenced;

end git;

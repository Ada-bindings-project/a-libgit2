with Ada.Finalization;
with Git.Low_Level.Git2_Types_H;
package Git.Odbs is
   type Git_Odb_Access is access all Git.Low_Level.Git2_Types_H.Git_Odb;

   type Odb is new Ada.Finalization.Limited_Controlled with record
      Impl : aliased Git_Odb_Access;
   end record;
end Git.Odbs;

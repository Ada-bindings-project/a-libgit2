with Ada.Finalization;
with Git.Low_Level.Git2_Types_H;
package Git.Worktrees is
   type Git_Worktree_Access is access all Git.Low_Level.Git2_Types_H.Git_Worktree;

   type Worktree is new Ada.Finalization.Limited_Controlled with record
      Impl : aliased Git_Worktree_Access;
   end record;
end Git.Worktrees;

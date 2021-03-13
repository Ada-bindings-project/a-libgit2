private with Interfaces.C;
package git is
   Git_Exeption : exception;
private
   procedure Retcode_2_Exeption (Code : Interfaces.C.Int);
end git;

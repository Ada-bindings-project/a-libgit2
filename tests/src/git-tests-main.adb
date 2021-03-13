with GNAT.Exception_Traces;
with GNAT.Traceback.Symbolic;
with Git.Repositorys;
procedure Git.Tests.Main is
   Repo : Git.Repositorys.Repository;
begin
   GNAT.Exception_Traces.Trace_On (GNAT.Exception_Traces.Every_Raise);
   GNAT.Exception_Traces.Set_Trace_Decorator (GNAT.Traceback.Symbolic.Symbolic_Traceback_No_Hex'Access);
   Repo.Init ("dummy");
end;

--wzajemne wykluczanie na obiekcie chronionym
with Ada.Text_IO;
use Ada.Text_IO;

procedure Mutex is
  subtype Data is Integer range 0 .. 10;

  protected Shared_Data is
    function Get return Data;      -- for some global type, Data
    procedure Put(D :in Data);
    private pragma Priority(10);           -- all callers must have priority -- no greater than 10
    Current : Data;                -- shared data declaration
  end Shared_Data;

protected body Shared_Data is
  function Get return Data is
    begin
    return Current;
  end Get;

  procedure Put(D : in Data) is
    begin
      Current := D;
    end Put;
end Shared_Data;


begin
  Put_Line("Shared objects");
end Mutex;

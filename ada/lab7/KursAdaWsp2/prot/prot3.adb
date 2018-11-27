-- prot3.adb
-- komunikacja asynchroniczna przez bufor
-- kolejka FIFO

with Ada.Text_IO;
use Ada.Text_IO;

procedure Prot3 is
  
-- obiekt chroniony 
protected Buf is
  entry Wstaw(C : Character);
  entry Pobierz(C : out Character);
  private
   Bc : Character;
   Pusty : Boolean := True;
end Buf;

protected body Buf is
  entry Wstaw(C : Character) when Pusty is
  begin
    Bc := C;
    Pusty := False;
  end Wstaw;
  entry Pobierz(C : out Character) when not Pusty is
  begin
    C := Bc;
    Pusty := True;
  end Pobierz;
end Buf;
  
task Producent; 

task body Producent is
  Cl : Character := 's';
begin  
  Put_Line("$ wstawiam: znak = '" & Cl & "'");
  Buf.Wstaw(Cl);
  Put_Line("$ wstawiłem...");
end Producent;

task Konsument; 

task body Konsument is
  Cl : Character := ' ';
begin  
  Put_Line("# pobiorę...");
  Buf.Pobierz(Cl);
  Put_Line("# pobrałem: znak = '" & Cl & "'");
end Konsument;

begin
  Put_Line("@ jestem w procedurze glownej");
end Prot3;
  
-- prot2.adb
-- zasób dzielony 
-- np. dane

with Ada.Text_IO;
use Ada.Text_IO;

procedure Prot2 is

  type TPunkt is record
    X, Y : Float := 0.0;
  end record;
  
-- obiekt chroniony 
protected Punkt is
  procedure Wstaw(Pp : TPunkt);
  procedure Pobierz(Pp : out TPunkt);
  function Pobierz return TPunkt;
  private
   Xl, Yl : Float := 1.0;
end Punkt;

protected body Punkt is
  procedure Wstaw(Pp : TPunkt) is    
  begin
    Xl := Pp.X;
    Yl := Pp.Y;
    Put_Line("$ <= wstawiam: X=" & Xl'Img & ",Y=" & Yl'Img);
  end Wstaw;
  procedure Pobierz(Pp : out TPunkt) is
  begin
    Pp.X := Xl;
    Pp.Y := Yl;
    Put_Line("$ => pobieram: X=" & Xl'Img & ",Y=" & Yl'Img);
  end Pobierz;
  
  function Pobierz return TPunkt is (X => Xl, Y=> Yl);
  
end Punkt;
  
task Zadanie_W; 

task body Zadanie_W is
  Pw : TPunkt := (X => 5.2, Y => 7.1);
begin  
  Put_Line("$ wstawię: X=" & Pw.X'Img & ",Y=" & Pw.Y'Img);
  Punkt.Wstaw(Pw);
  Put_Line("$ wstawiłem...");
end Zadanie_W;

task Zadanie_P; 

task body Zadanie_P is
  Pw : TPunkt := (X => 0.2, Y => 2.0);
begin 
  --delay 0.0; 
  Put_Line("$ pobiorę...");
  Punkt.Pobierz(Pw);
  --Pw := Punkt.Pobierz;
  Put_Line("$ pobrałem: X=" & Pw.X'Img & ",Y=" & Pw.Y'Img);
end Zadanie_P;

begin
  Put_Line("Jestem w procedurze glownej");
end Prot2;  
  
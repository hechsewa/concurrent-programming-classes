-- tab1.adb

-- Wypisuje tablice dla ktorej elementy 1,3,5,7=1.2, 8-10=2.4 a reszta 7.6
with Ada.Text_IO,Ada.Float_Text_IO;
use Ada.Text_IO,Ada.Float_Text_IO;

procedure Tab1 is
  T1 : array(1..10) of Float := (1|3|5|7 => 1.2, 8..10 =>2.4, others =>7.6);
  Sum : Float := 0.0;
begin
  for I in T1'First..T1'Last loop -- lub T1'Range
   Put("Tab(" & I'Img & ")="); -- z pakietu Ada.Text_IO
   Put( T1(I),3,4,0 ); -- z pakietu Ada.Float_Text_IO
   New_Line;
  end loop;
  for E of T1 loop
    Sum := Sum + E; --sumuje wszystkie wartosci w tablicy
  end loop;
  Put_Line("Suma = " & Sum'Img);
end Tab1;

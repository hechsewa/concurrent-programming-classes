with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, tasks;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, tasks;

--fill vector with random floats, print, sort and measure time
procedure vector is
   Vect : VectT(1..20) := (others => 0.0); --jak zrobic agregat?
   T1, T2 : Time; --pomiar czasu
   T : Duration;
begin
   PrintVect(Vect);
   FillRandom(Vect);
   T1 := Clock;
   Sort(Vect);
   T2 := Clock;
   T := T2-T1;
   WriteVect(Vect);
   Put_Line("Ascending order: " & CheckSort(Vect)'Img);
   Put_Line("Sorted in " & T'Img & " seconds");
   
end vector;

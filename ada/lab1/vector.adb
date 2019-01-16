--procedura glowna
with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, tasks;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, tasks;
--1.1 Zdefiniuj typ np. Wektor opisujący niezawężoną tablicę jednowymiarową
--indeksowaną liczbami całkowitymi z elementami typu rzeczywistego.

type Wektor is array(Intger range <>) of Float;
--fill vector with random floats, print, sort and measure time
procedure vector is
  --1.2 Zadeklaruj i zainicjuj zmienną typu wektor dowolnymi wartościami (agregat).
   Vect : VectT(1..20) := (others => 0.0);
   --1.6.b Dopisz do programu głównego instrukcje pozwalające na pomiar czasu wykonania programu.
   T1, T2 : Time; --pomiar czasu
   T : Duration;
begin
   PrintVect(Vect);
   FillRandom(Vect);
   T1 := Clock; --T1 pobiera czas przed wykonaniem sorta (Ada.Calendar)
   Sort(Vect);
   T2 := Clock;
   T := T2-T1;
   WriteVect(Vect);
   Put_Line("Ascending order: " & CheckSort(Vect)'Img);
   Put_Line("Sorted in " & T'Img & " seconds");

end vector;

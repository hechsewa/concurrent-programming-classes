--tasks.adb
--plik z trescia pakietu 
with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;

package body tasks is

   --1.3 Napisz i wykorzystaj procedurę wypisującą zawartość wektora na ekranie.
   procedure PrintVect(Vect : in VectT) is
   begin
      for I in Vect'Range loop
         Put_Line("Vect(" & I'Img & ")=" & Vect(I)'Img);
      end loop;
   end PrintVect;

   --1.4 Napisz i wykorzystaj procedurę wypełniającą wektor losowymi wartościami.
   procedure FillRandom(Vect : in out VectT) is
      Gen : Generator;
   begin
      Reset(Gen);
      for E of Vect loop
        E := Random(Gen);
      end loop;
   end FillRandom;

   --1.5 Napisz i wykorzystaj funkcję z kwantyfikatorem „dla każdego”
   --(for all …) sprawdzającą posortowanie rosnące wektora.
   function CheckSort(Vect : in VectT) return Boolean is
     (for all I in Vect'First..(Vect'Last-1) => Vect(I) <= Vect(I+1));

   --1.6 Napisz i wykorzystaj procedurę sortującą dowolną metodą wektor.
   --bubble sort
   procedure Sort(Vect : in out VectT) is
      Temp : Float;
   begin
      for I in reverse Vect'Range loop
         for J in Vect'First .. I loop
            if Vect(J)>Vect(I) then
               Temp := Vect(J);
               Vect(J) := Vect(I);
               Vect(I) := Temp;
            end if;
         end loop;
      end loop;
   end Sort;

   --selection sort
   procedure SelectionSort(Vect: in out VectT) is
     Temp : Float; --do zamiany miejscami
     Min : Integer; --kinda wskaznik
   begin
     for I in Vect'First..Vect'Last-1 loop
       Min := I;
       --sprawdz czy jest juz na swoim miejscu
       for J in I+1..Vect'Last loop
         if Vect(Min)>Vect(J) then
           --jesli
           Min := J;
         end if;
       end loop;
       if Min /= I then
         Temp := Vect(I);
         Vect(I) := Vect(Min);
         Vect(Min) := Temp;
       end if;
    end loop;
  end SelectionSort;

   --save to file
   procedure WriteVect(Vect: in VectT) is
      File : File_Type;
      Name : String := "wektor.txt";
   begin
      Create(File, Out_File, Name);
      Put_Line("Created file: " & Name);
      Put(File, "Vector = [ ");
      for E of Vect loop
         if E = Vect(Vect'Last) then
            Put(File, E'Img & " ]");
         else
            Put(File, E'Img & ", ");
         end if;
      end loop;
      Put_Line("Saved vector to file: " & Name);
      Close(File);
   end WriteVect;


end tasks;

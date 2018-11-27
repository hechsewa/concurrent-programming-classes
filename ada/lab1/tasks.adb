--tasks.adb

with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;

package body tasks is

   --printout vector
   procedure PrintVect(Vect : in VectT) is
   begin
      for I in Vect'Range loop
         Put_Line("Vect(" & I'Img & ")=" & Vect(I)'Img);
      end loop;
   end PrintVect;
	
   --fill with random floats
   procedure FillRandom(Vect : in out VectT) is
      Gen : Generator;
   begin
      Reset(Gen);
      for E of Vect loop
        E := Random(Gen);
      end loop;
   end FillRandom;
		
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
	

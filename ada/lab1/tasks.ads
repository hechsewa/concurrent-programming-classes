--plik ze specyfikacja pakietu
package tasks is
   --declare a vector type
   type VectT is array (Integer range <>) of Float;

   procedure PrintVect(Vect : in VectT);
   procedure FillRandom(Vect : in out VectT);
   procedure Sort(Vect : in out VectT);
   procedure WriteVect(Vect : in VectT);

end tasks;

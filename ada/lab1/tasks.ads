package tasks is

   --declare a vector type
   type VectT is array (Integer range <>) of Float;
   
   procedure PrintVect(Vect : in VectT);
   procedure FillRandom(Vect : in out VectT);
   procedure Sort(Vect : in out VectT);
   procedure WriteVect(Vect : in VectT);
   --check if sorted
   function CheckSort(Vect : in VectT) return Boolean is (for all I in Vect'First..(Vect'Last-1) => Vect(I) <= Vect(I+1));

end tasks;

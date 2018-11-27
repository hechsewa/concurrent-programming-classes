with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

--implementing a tree
procedure Lab4Tree is

    package Los_Liczby is new Ada.Numerics.Discrete_Random(Integer);
    use Los_Liczby;

type Element is
      record
         Data : Integer := 0;
         Left : access Element := Null;
         Right : access Element := Null;
      end record;

   type Elem_Ptr is access all Element;


 procedure Print(Tree : access Element) is
      T : access Element := Tree; --wierzcholek
   begin
      if T.Right = Null and T.Left = Null then --no child
         Put_Line(T.Data'Img);
      else --if has 1 or 2 children
         if T.Right /= Null and T.Left /= Null then --has 2 children
            Put_Line(T.Data'Img&"->"&T.Left.Data'Img);
            Put_Line(T.Data'Img&"->"&T.Right.Data'Img);
            Print(T.Left);
            Print(T.Right);
         elsif T.Left /= Null and T.Right = Null then --has left child
            Put_Line(T.Data'Img&"->"&T.Left.Data'Img);
            Print(T.Left);
         elsif T.Right /= Null and T.Left = Null then -- has right child
            Put_Line(T.Data'Img&"->"&T.Right.Data'Img);
            Print(T.Right);
         end if;
      end if;

   end Print;

   --wstawia na pierwsze wolne miejsce po prawej
 procedure Insert(Tree : in out Elem_Ptr; D : in Integer) is
      E : Elem_Ptr := new Element;
      R : access Element := Tree;
begin
  E.Data := D;
  E.Left := Null;
  E.Right := Null;

      if R = Null then
         Tree := E;
      elsif D < R.Data then
         if R.Left = Null then
            R.Left := E;
         else
            Insert(R.Left, D);
         end if;
      elsif D >= R.Data then
         if R.Right = Null then
            R.Right := E;
         else
            Insert(R.Right, D);
         end if;
      end if;
   end Insert;

 procedure GenerateAndInsert(Tree : in out Element; N : in Integer; M : in Integer) is
	Gen: Generator;
	Number : Integer;
 begin
 	Reset(Gen);
	for I in 1..N loop
		Number := Random(Gen) mod M;
		Insert(Tree, Number);
	end loop;
 end;

 procedure Search(Tree : access Element; D : in Integer) is
      T : access Element := Tree;
   begin
      if T.Data /= D and T.Left /= Null then
         Search(T.Left, D);
      elsif T.Data /=D and T.Right /= Null then
         Search(T.Right,D);
      elsif T.Data /= D then
         Put_Line("Not Found");
      else
         Put_Line("Found");
         end if;
      end Search;

   --nie dziala
   procedure Delete(Tree : in out Elem_Ptr; D : in Integer) is
      T : access Element := Tree;
   begin
      if T.Data /= D and T.Left /= Null then
         Delete(T.Left, D);
      elsif T.Data /= D and T.Right /= Null then
         Delete(T.Right, D);
      else
         if T.Left = Null and T.Right = Null then --no child
            T := Null;
         elsif T.Left= Null and T.Right /= Null then --right child
            T := T.Right;
         elsif T.Right = Null and T.Left /= Null then -- left child
            T := T.Left;
         else --2 children
            T := T;
         end if;
      end if;
   end Delete;

   --rownowazenie drzewa
   procedure Weight(Tree: in out Elem_Ptr) is
   begin
      null;

      end Weight;
   Tree : Elem_Ptr := Null;
begin
   --Print(Tree);
   Insert(Tree,4);
   Insert(Tree,3);
   Insert(Tree,5);
   --Delete(Tree,5);
   Print(Tree);
   Put_Line("");
   Search(Tree, 5);
   null;
end Lab4Tree;

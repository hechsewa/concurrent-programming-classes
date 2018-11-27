with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

--implements a list
procedure Lab4Lista is

type Element is
  record 
    Data : Integer := 0;
    Next : access Element := Null;
  end record; 

type Elem_Ptr is access all Element;

procedure Print(List : access Element) is
  L : access Element := List;
begin
  if List = Null then
    Put_Line("List EMPTY!");
  else
    Put_Line("List:"); 
  end if; 
  while L /= Null loop
    Put(L.Data, 4); -- z pakietu Ada.Integer_Text_IO
    New_Line;
    L := L.Next;
  end loop; 
end Print;

procedure Insert(List : in out Elem_Ptr; D : in Integer) is
  E : Elem_Ptr := new Element; 
begin
  E.Data := D;
  E.Next := List;
  -- lub E.all := (D, List);
  List := E;
end Insert;

-- wstawianie jako funkcja - wersja krótka
function Insert(List : access Element; D : in Integer) return access Element is 
  ( new Element'(D,List) ); 


procedure Insert_Sort(List : in out Elem_Ptr; D : in Integer) is 
	L : access Element := List; --pierwszy element listy
	E : Elem_Ptr := new Element;
begin

-- napisz procedurę wstawiającą element zachowując posortowanie (rosnące) listy
if List = Null then
	Insert(List, D);
else
	while (L.Next /= Null) and then (L.Next.Data < D) loop
			L := L.Next;
	end loop;	
	E.Data := D;
	E.Next := L.Next;
	L.Next := E;
end if;
null;
end Insert_Sort;

--procedurę generującą N liczb pseudo-losowych z zakresu 0-M i wstawiającą te liczby (procedura powyżej)
procedure GenN(List : in out Elem_Ptr; M : in Integer; N : in Integer) is
	subtype Num_Type is Integer range 0 .. M;
	package Random_Num is new Ada.Numerics.Discrete_Random(Num_Type);
	use Random_Num;
	
	G : Generator;
	Val : Integer := 0;
begin
	Reset(G);
	for I in 1..N loop
		Val := Random(G);
		Insert_Sort(List, Val);
	end loop;
	null;
end GenN;

--podprogram przeszukujący listę (search)
function Search(List : in out Elem_Ptr; D : in Integer) return Boolean is
	L : access Element := List;
begin
	while (L.Next /= Null) loop
		if (L.Data = D) then
			return True;
		end if;
		L := L.Next;
	end loop;
	return False;
end Search;

--procedurę usuwającą zadany element
procedure Delete(List : in out Elem_Ptr; D : in Integer) is 
	L : access Element := List;
begin
	while(L.Next /= Null) loop
		if(L.Data = D) then
			L.Data := L.Next.Data;
		end if;
		L := L.Next;
	end loop;
end Delete; 


Lista : Elem_Ptr := Null;
Val : Boolean;
begin
  Print(Lista);
  Lista := Insert(Lista, 21);
  Print(Lista);
  Insert(Lista, 20); 
  Print(Lista);
  for I in reverse 1..12 loop
  Insert(Lista, I);
  end loop;
	GenN(Lista, 20, 5);
	Val := Search(Lista,4);
	Put_Line(Val'Img);
	Delete(Lista, 5);
  Print(Lista);
end Lab4Lista;

-- strum3.adb
--
-- materiały dydaktyczne
-- 2016
-- (c) Jacek Piwowarczyk
--
-- zapis i odczyt do/z pliku tekstowego jako strumienia
-- dodanie obsługi strumienia (Read/Write) dla nowego typu
-- 
--powiazanie operacji z nowo zdefiniowanym typem, jak dopisac operacje na strumieniu dla nowych typow

with Ada;
use Ada;
with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;
with Ada.Streams;
use Ada.Streams;
with Ada.Text_IO.Text_Streams;
use Ada.Text_IO.Text_Streams;
with Ada.Numerics.Discrete_Random;

procedure Macierze is
  Plik         : File_Type;
  Nazwa        : String := "textm.txt";
  Strumien     : Stream_Access;
  
  G : Generator;
  
--definicja macierzy 
  type Macierz is array(Integer range <>, Integer range<>) of Float;
   
  procedure Read (S : access Root_Stream_Type'Class; Matx : out Macierz);
  procedure Write (S : access Root_Stream_Type'Class; Matx : in Macierz);
  for Macierz'Read use Read;
  for Macierz'Write use Write;
   
  procedure Read (S : access Root_Stream_Type'Class; Matx : out Macierz) is
  begin
    for EE of Matx loop
      Float'Read(S,EE);
    end loop;
  end Read;  
  procedure Write (S : access Root_Stream_Type'Class; Matx : in Macierz) is
  begin
    for EE of Matx loop
      Float'Write(S,EE);
    end loop;    
  end Write; 
  
  function To_String(M: Macierz; Str: String:=""; I: Integer:=1) return String is
    (if I>M'Last and Str'Length>0 then Str else 
      (if Str'Length=0 then To_String(M,Str&" ",M'First) 
       else (for EE of M loop
		   		To_String(M,Str&ASCII.LF&"["&I'Img&"]=>"&E'Img,I+1)
			end loop;));
  
  Mat : Macierz(0..10,0..10):=(others=>(others => Random(G))); -- przed Resetem
  
begin
  Reset(G);
  Mat:=(others=>(others => Random(G)));
  
  Put_Line("* Zapis do pliku -> " & Nazwa);
  Create(Plik, Out_File, Nazwa); 
  Strumien := Stream(Plik);
  Put_Line("* Zapisuje macierz : " & To_String(Mat) );
  Macierz'Output(Strumien, Mat);
  Close(Plik);
  -- zerowanie
  Mat := (others=>(others=>0.0));
 
  Put_Line("* Odczyt z pliku <- " & Nazwa);
  Open(Plik, In_File, Nazwa);
  Strumien := Stream(Plik);
 
  Mat := Macierz'Input(Strumien);
  Put_Line("* Odczytałem tablicę : " & To_String(Mat) );
  Close(Plik);
  Put_Line("* Koniec");
end Macierze;  

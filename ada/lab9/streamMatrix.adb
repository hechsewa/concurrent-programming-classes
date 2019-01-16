--1.Napisz i użyj procedury wysyłające i odbierające
--ze strumienia macierze liczb rzeczywistych.

with Ada.Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;
with Ada.Streams;
use Ada.Streams;
with Ada.Text_IO.Text_Streams;
use Ada.Text_IO.Text_Streams;
with Ada.Numerics.Discrete_Random;

procedure StreamMatrix is

  --definicja nowego typu Macierzy
  type Macierz is array(Integer range <>, Integer range<>) of Float;

  --deklaracja operacji Odczytu i Zapisu dla Macierzy
  procedure Read (S : access Root_Stream_Type'Class; Matx : out Macierz);
  procedure Write (S : access Root_Stream_Type'Class; Matx : in Macierz);
  for Macierz'Read use Read;
  for Macierz'Write use Write;

  --implementacja operacji odczytu i zapisu dla macierzy
  procedure Read (S : access Root_Stream_Type'Class; Matx : out Macierz) is
  begin
    for E of Matx loop
      Float'Read(S,E);
    end loop;
  end Read;

  procedure Write (S : access Root_Stream_Type'Class; Matx : in Macierz) is
  begin
    for EE of Matx loop
      Float'Write(S,EE);
    end loop;
  end Write;

  --funkcja wypisujaca macierz
  function To_String(M: Macierz; Str: String:=""; I: Integer:=1) return String is
  begin
    if (I>M'Last and Str'Length>0) then
      return Str;
    else
      if Str'Length=0 then
        return To_String(M,Str&" ",M'First);
      else
       for EE of M loop
		   		return To_String(M,Str&ASCII.LF&"["&I'Img&"]=>"&EE'Img,I+1);
			 end loop;
     end if;
   end if;
 end To_String;

--zadeklarowanie zmiennej typu macierz 10x10 i wypelnienie zerami
G: Generator;
Pl: File_Type;
Filename: String := "macierz.txt";
Strumien: Stream_Access;
Mat : Macierz(0..10,0..10):=(others=>(others => 0.0));
begin
  Reset(G);
  Mat := (others =>(others => Random(G)));

  --zapis macierzy do pliku przez strumien
  Put_Line("* Zapis do pliku -> " & Filename);
  Create(Pl, Out_File, Filename); --utworz plik i zapisz
  Strumien := Stream(Pl);
  Put_Line("* Zapisuje macierz : " & To_String(Mat) );
  Macierz'Output(Strumien, Mat);
  Close(Pl);

  --zerowanie Macierzy
  Mat := (others=>(others=>0.0));

  --odczyt macierzy z pliku przez strumien
  Put_Line("* Odczyt z pliku <- " & Filename);
  Open(Pl, In_File, Filename);
  Strumien := Stream(Pl);

  Mat := Macierz'Input(Strumien);
  Put_Line("* Odczytałem tablicę : " & To_String(Mat) );
  Close(Pl);
  Put_Line("* Koniec");

  exception
    when End_Error =>
      if Is_Open(Pl) then
        Close(Pl);
      end if;

end StreamMatrix;

--lab 1 uzupelnienie
with Ada.Text_IO;
use Ada.Text_IO;

procedure fillerlab is

  --1.1 Napisz procedurę wypisującą na ekran
  --zawartość pliku tekstowego o zadanej nazwie (wyjątki!)
  procedure WriteFile(Filename : in String) is
    Input : File_Type;
  begin
    Open(Input, In_File, Filename); --otworz plik do odczytu
    Put_Line("Czytam plik: "& Filename);
    while not End_Of_File(Input) loop
      Put_Line(Get_Line(Input));
    end loop;
    Close(Input); -- zamknij plik
    exception
      when End_Error =>
        if Is_Open(Input) then
          Close(Input);
        end if;
  end WriteFile;

begin
  WriteFile("texet.txt");
end fillerlab;

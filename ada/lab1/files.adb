--lab2 uzupelnienie
--open and print file with exceptions

with Ada.Text_IO, Ada.Calendar;
use Ada.Text_IO, Ada.Calendar;

procedure files is
	
procedure PrintFile is
	Pl : File_Type;
	Nazwa : String := "plik.txt";
	--Dlugosc : Integer := 4;
begin
	
	Put_Line("Zwartosc pliku " &Nazwa);
	begin
		Open(Pl, In_File, Nazwa);
		exception
			when Name_Error => Put_Line(Nazwa&"-no such file");
	end;
	
	while not End_Of_File(Pl) loop
		declare Line : String := Get_Line(Pl);
		begin
			Put_Line(Line);
		end;
	end loop;
	Close(Pl);
	exception
		when End_Error => 
		if Is_Open(Pl) then
			Close(Pl);
		end if;
end PrintFile;

begin
	PrintFile;
end files;

	

	
	
	

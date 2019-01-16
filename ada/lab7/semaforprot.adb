--semafor liczbowy na obiekcie chronionym

--4. Zaimplementuj semafor liczbowy
--na obiekcie chronionym

with Ada.Text_IO;
use Ada.Text_IO;

procedure semaforprot is

	Size: Natural := 2;

	--deklaracja semafora na obiekcie chronionym
	protected SemLicz is
		entry Wait;
		procedure Signal;
		private
			Sem: Integer := Size;
	end SemLicz;

	--implementacja obiekt chroniony
	--5. Zrealizuj wzajemne wykluczanie do Ekranu
	--stosujac semafor
	protected body SemLicz is
		entry Wait
			when Sem > 0 is
			begin
				Sem := Sem-1;
		end Wait;

		procedure Signal is
		begin
			Sem := Sem+1;
		end Signal;
	end SemLicz;

	--uzytkownik
	task type User(Nr: Integer := 1) is
		entry UseSem;
	end User;

	task body User is
	begin
		accept UseSem;
		Put_Line(Nr'Img & "Trying into sem...");
		SemLicz.Wait;
		Put_Line(Nr'Img & "Using the sem...");
		delay 5.0;
		Put_Line(Nr'Img & "Out");
		SemLicz.Signal;
	end User;


U1: User(1);
U2: User(2);
U3: User(3);
begin
	U1.UseSem;
	U2.UseSem;
	U3.UseSem;
end semaforprot;

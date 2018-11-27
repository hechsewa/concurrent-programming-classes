--semafor liczbowy na zadaniu
with Ada.Text_IO;
use Ada.Text_IO;

procedure semaforzad is

	Size: Natural := 2;

	--deklaracja semafora na zadaniu
	task type SemLiczZad is
		entry Wait;
		entry Signal;
	end SemLiczZad;
	
	--implementacja zadanie
	task body SemLiczZad is
	Sem: Integer;
	begin
		Sem := Size;
		loop
			select
				when Sem > 0 =>
					accept Wait do
						Put_Line(Sem'Img);
						Sem := Sem-1;
					end Wait;
			or
				accept Signal;
				Sem := Sem+1;
			end select;
		end loop;
	end SemLiczZad;
	
SemLiczZ: SemLiczZad;
	
	--zadanie uzytkownik
	task type User(Nr: Integer := 1) is
		entry UseSem;
	end User;
	
	task body User is
	begin
		accept UseSem;
		Put_Line(Nr'Img & "Trying into sem...");
		SemLiczZ.Wait;
		Put_Line(Nr'Img & "Using the sem...");
		delay 5.0;
		Put_Line(Nr'Img & "Out");
		SemLiczZ.Signal;
	end User;


U1: User(1);
U2: User(2);
U3: User(3);
begin
	U1.UseSem;
	U2.UseSem;
	U3.UseSem;
end semaforzad;
--1. Napisz obsługę bufora wieloelementowego (N)
--na typie chronionym do komunikacji Producent-Konsument.

with Ada.Text_IO;
use Ada.Text_IO;

procedure Bufor is

	--deklaracja tablica
	type Bufor_Tab is array (Integer range <>) of Character;

	--deklaracja bufor wieloelementowy
	protected type Buf(Size : Integer) is
		entry Wstaw(C : in Character);
		entry Pobierz(C : out Character);
		private
			B : Bufor_Tab(1..Size);
			Ip : Integer := 0;
			Iw : Integer := 1;
			Counter : Integer := 0;
	end Buf;

	--implementacja bufor wieloelementowy
	protected body Buf is

		entry Wstaw(C : in Character)
			when Counter<Size is
			begin
				Iw := (Iw + 1) mod Size;
				B(Iw) := C;
				Counter := Counter+1;
			end Wstaw;

		entry Pobierz(C : out Character)
			when Counter>0 is
			begin
				C := B(Ip);
				Ip := (Ip+1) mod Size; --Ip mod Size+1
				Counter := Counter-1;
			end Pobierz;
	end Buf;

	B1 : Buf(0);

	--producent
	task type Producent is
		entry Start;
		entry Stop;
	end Producent;

	task body Producent is
		Ch : Character := 's';
	begin
		accept Start;
		loop
			select
				accept Stop;
				exit;
			else
				Put_Line("P: wstawiam znak: " & Ch);
				B1.Wstaw(Ch);
				Put_Line("P: wstawione");
				delay 1.0;
			end select;
		end loop;
	end Producent;

	--konsument
	task type Konsument is
		entry Start;
		entry Stop;
	end Konsument;

	task body Konsument is
		Ch : Character := ' ';
	begin
		accept Start;
		loop
			select
				accept Stop;
				exit;
			else
				Put_Line("K: pobieram");
				B1.Pobierz(Ch);
				Put_Line("K: pobrany znak: " & Ch);
			end select;
		end loop;
	end Konsument;


--main
Producent1: Producent;
Konsument1: Konsument;
begin
	Producent1.Start;
	delay 3.0;
	Konsument1.Start;
	delay 10.0;
	Producent1.Stop;
	Konsument1.Stop;


end Bufor;

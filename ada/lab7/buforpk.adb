--bufor wieloelementowy na typie chronionym producent-konsument

with Ada.Text_IO, Ada.Numerics.Float_Random, buforW;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure buforpk is
	
	package packageBuf is new buforw(10,Float);
	

	--producent
	task type Producent is
		entry Start;
		entry Stop;
	end Producent;
	
	task body Producent is
		G: Generator;
		Tmp: Float;
	begin
		accept Start;
		loop
			select
				accept Stop;
				Put_Line("Producent out");
				exit;
			else
				Reset(G);
				Tmp := Random(G);
				Put_Line("P: wstawiam: " & Tmp'Img);
				packageBuf.BufW.Wstaw(Tmp);
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
		Tmp: Float;
	begin
		accept Start;
		loop
			select
				accept Stop;
				Put_Line("Konsument out");
				exit;
			else
				packageBuf.BufW.Pobierz(Tmp);
				Put_Line("K: pobrano: " & Tmp'Img);
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
	delay 5.0;
	Producent1.Stop;
	Konsument1.Stop;
	
	
end buforpk;
		
	
with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Elementary_Functions;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Elementary_Functions;

procedure SitoErastotenesa is

type counter is array(Integer range <>) of Boolean;

procedure findAndPrintPrimeNumbers(n : Integer)  is
	c : counter(2..n) := (others => true);
	j : Integer := 0;
begin
	for i in 2..Integer(Sqrt(Float(n))) loop
		if c(i) = true then
			j := 2*i;
			while j <= n loop
				c(j) := false;
				j := j + i;
			end loop;
		end if;
	end loop;

	for i in 2..n loop
		if c(i) = true then
			Put_Line(i'Img);
		end if;
	end loop;
end;

begin
	findAndPrintPrimeNumbers(50);
end;

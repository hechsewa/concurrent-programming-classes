-- dzielona.adb
-- przykład użycia zmiennej dzielonej

with Ada.Text_IO;
use Ada.Text_IO;

procedure Dzielona is
  
	-- zmienna dzielona
  Czy_Koniec: Boolean := False with Atomic; -- aspekt Atomic
  --pragma Atomic(Czy_Koniec); -- lub pragma Atomic
	
task type Zadanie is
end Zadanie	;

task body Zadanie is
begin
  loop	
    delay 0.1;
    exit when Czy_Koniec; -- lub if Czy_Koniec then exit; end if;
  end loop;	
  Put_Line("Koncze zadanie,");  
end Zadanie;

subtype Zakres is Integer range 1..10; 
Zadania: array(Zakres) of Zadanie;

begin
  Put_Line("Procedura glowna - poczatek ");
  Put_Line("Czekam 1 [s] ... ");
  delay 1.0;
  Czy_Koniec := True;
  Put_Line("Procedura glowna - koniec ");
end Dzielona;
	  	
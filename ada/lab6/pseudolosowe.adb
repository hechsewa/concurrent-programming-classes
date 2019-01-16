-- Napisz zadania zwracające przez wejście/a wartości pseudolosowe.
--wejście zwracające wartości z zakresu 0.0..5.0
--wejścia zwracające wartości: z zakresu 0.0..5.0, kolory, dni tygodnia, 6 liczb z zakresu 1..49

with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Numerics.Float_Random;

procedure Pseudolosowe is

--zadanie zwracajace wartosci z zakresu 0.0-5.0
task Values is
  entry Start(N : out Float);
  entry Koniec;
end Values;

task body Values is
  Gen : Generator;
  C : Float;
begin
  loop
    select
      accept Start(N: out Float) do
          Reset(Gen);
          C := Random(Gen)*5.0;
          N := C;
        end Start;
      or
      accept Koniec;
      exit;
    end select;
  end loop;
end Values;
-----------------------------------------

--losowe Kolory
type Colors is (Red, Green, Blue);
package Los_Color is new Ada.Numerics.Discrete_Random(Colors);
use Los_Color;

--losowe dnia tygodnia
type DniTyg is (Mon, Tue, Wed, Thru, Fri, Sat, Sun);
package Los_Dni is new Ada.Numerics.Discrete_Random(DniTyg);
use Los_Dni;

--losowe 6 liczb 1-49
type Tab is array(1..6) of Integer;
subtype Ranger is Integer range 1 .. 49;
package Los_Tab is new Ada.Numerics.Discrete_Random(Ranger);
use Los_Tab;

--zwracajace wartosci, kolory, dni tygodnia, 6 liczb 1-49
task Mixup is
  entry Tablica(T: out Tab);
  entry Color(C: out Colors);
  entry Dni(D: out DniTyg);
  entry Koniec;
end Mixup;

task body Mixup is
  GDay : Los_Dni.Generator;
  GColor : Los_Color.Generator;
  GTab : Los_Tab.Generator;
begin
  loop
    select
      accept Tablica(T: out Tab) do
          Reset(GTab);
          for E of T loop
            E := Random(GTab);
          end loop;
        end Tablica;
      or accept Color(C: out Colors) do
          Reset(GColor);
          C := Random(GColor);
        end Color;
      or accept Dni(D: out DniTyg) do
          Reset(GDay);
          D := Random(GDay);
        end Dni;
      or accept Koniec;
      exit;
    end select;
  end loop;
end Mixup;

--main body
Num : Float := 0.0;
Tr : Tab := (others => 0);
Co : Colors;
Da : DniTyg;
begin
  for I in 1..4 loop
    Values.Start(Num);
    Put_Line("Received "&Num'Img);
  end loop;
  Values.Koniec;

  Mixup.Tablica(Tr);
  for J in Tr'Range loop
    Put_Line("Tab("&J'Img&")= "&Tr(J)'Img);
  end loop;

  Mixup.Dni(Da);
  Put_Line("Dni tygodnia: "&Da'Img);

  Mixup.Color(Co);
  Put_Line("Color :"&Co'Img);

  Mixup.Koniec;

end Pseudolosowe;

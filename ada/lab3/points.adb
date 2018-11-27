--zad1

with Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Numerics.Elementary_Functions;
use Ada.Text_IO, Ada.Numerics.Float_Random, Ada.Numerics.Elementary_Functions;

--record type & measuring a distance to (0.0) and to previous point
procedure points is

    type Punkt is record
        X: Float := 0.0;
        Y: Float := 0.0;
    end record;
    type Rekord_Pusty is null record;

task ZadA is
    entry Start;
end ZadA;

task ZadB is
    entry Start;
    entry Koniec;
    entry We(P: Punkt);
end ZadB;

task body ZadA is
    Gen: Generator;
    P: Punkt;
begin
    accept Start;
    Reset(Gen);
    for N in 1..3 loop
        P.X := Random(Gen)*10.0;
        P.Y := Random(Gen)*10.0;
        ZadB.We(P);
    end loop;
    ZadB.Koniec;
end ZadA;

task body ZadB is
    Xn: Float;
    Yn: Float;
    Xtemp: Float :=0.0;
    Ytemp: Float := 0.0;
    Wynik: Float := 0.0;
    Wynik2: Float := 0.0;
begin
    accept Start;
    loop
    select
    accept We(P: in Punkt) do
            Xn := P.X;
            Yn := P.Y;
        end We;
        Wynik := Ada.Numerics.Elementary_Functions.Sqrt(Xn**2 + Yn**2);
        Put_Line("Distance of " & "(" & Xn'Img & "," & Yn'Img & ") from (0,0): " & Wynik'Img);

         if Xtemp /= 0.0 and then Ytemp /= 0.0 then
            Wynik2 := Ada.Numerics.Elementary_Functions.Sqrt((Xtemp-Xn)**2 + (Ytemp-Yn)**2);
            Put_Line("Distance from a previous point (" & Xtemp'Img & "," & Ytemp'Img & ") :" & Wynik2'Img);
        end if;

        Xtemp := Xn;
        Ytemp := Yn;

        or
        accept Koniec;
        exit;
        end select;
        end loop;
end ZadB;

begin
    ZadA.Start;
    ZadB.Start;
end points;


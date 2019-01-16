-- Napisz dwa zadania komunikujące się przez spotkania
--jedno - generujące i przesyłające N razy punkt (x,y) o wartościach pseudolosowych
--drugie - odbierające dane i wyliczające
--odległość punktu od początku układu współżędnych
--odległość pomiędzy dwoma kolejnymi punktami
with Ada.Text_IO, Ada.Numerics.Float_Random,Ada.Numerics.Elementary_Functions;
use Ada.Text_IO, Ada.Numerics.Float_Random,Ada.Numerics.Elementary_Functions;

procedure Spotkania is

  --rekord przechowywujacy punkt
  type Pt is record
    X : Float := 0.0;
    Y : Float := 0.0;
  end record;

  --zadanie generujace N punktow
  task Generate is
    entry Start;
  end Generate;

  --zadanie odbieracje i wyliczające
  task Counter is
    entry Start;
    entry Koniec;
    entry Count(P: Pt);
  end Counter;

--generujace body
  task body Generate is
    Gen: Generator;
    P: Pt;
  begin
    accept Start;
    Reset(Gen);
    for M in 1..3 loop
      P.X := Random(Gen)*10.0;
      P.Y := Random(Gen)*10.0;
      Counter.Count(P);
    end loop;
    Counter.Koniec;
  end Generate;

--wyliczajace body
  task body Counter is
    Xn: Float;
    Yn: Float;
    Xtemp: Float :=0.0;
    Ytemp: Float := 0.0;
    Dist: Float := 0.0; --odleglosc od 0,0
    DistPt: Float := 0.0; --odleglosc miedzy pkt-ami
  begin
    accept Start;
    loop
      select
      accept Count(P: in Pt) do
            Xn := P.X;
            Yn := P.Y;
          end Count;
          --oblicz odleglosc od (0,0)
          Dist := Sqrt(Xn*Xn+Yn*Yn);
          Put_Line("Distance of " & "(" & Xn'Img & "," & Yn'Img & ") from (0,0): " & Dist'Img);

          --oblicz odleglosc pomiedzy dwoma pkt kolejnymi
          if Xtemp /= 0.0 and then Ytemp /= 0.0 then
            DistPt := Sqrt((Xtemp-Xn)**2+(Ytemp-Yn)**2);
            Put_Line("Distance from a previous point (" & Xtemp'Img & "," & Ytemp'Img & ") :" & DistPt'Img);
          end if;

          --przechowaj dane dla kolejnego pkt
          Xtemp := Xn;
          Ytemp := Yn;
        or
        accept Koniec;
        exit;
      end select;
    end loop;
  end Counter;

---main body
begin
  Generate.Start;
  Counter.Start;
end Spotkania;

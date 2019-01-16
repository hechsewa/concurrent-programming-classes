with System;

with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Real_Time;
use Ada.Real_Time;
with Ada.Synchronous_Task_Control;
use Ada.Synchronous_Task_Control;
with Ada.Numerics.Discrete_Random;
with Ada.Exceptions;
use Ada.Exceptions;


package body PSporadic is

--implementacja obiektu chronionego
protected body Ekran is
  procedure Pisz(S : String) is
  begin
    Put_Line(S);
  end Pisz;
end Ekran;

--semafor binarny
Sem_Bin: Suspension_Object;

--generator wartosci losowych
subtype Do2000 is Integer range 100..2000;
package Losuj is new Ada.Numerics.Discrete_Random(Do2000);

--implementacja zadania sporadycznego na semaforze binarnym
task body Spor is
begin
  loop
    Suspend_Until_True(Sem_Bin);
    Set_False(Sem_Bin);
    Ekran.Pisz("Zadanie sporadyczne 1");
  end loop;
exception
  when E:others => Put_Line("Error: Zadanie sporadyczne 1");
    Put_Line(Exception_Name (E) & ": " & Exception_Message (E));
end Spor;

--na poczatku semafor ustawiony na false
use Losuj;
G: Generator;
Nastepny : Ada.Real_Time.Time;
Przesuniecie :Ada.Real_Time.Time_Span;
Okres : Do2000;
begin
  Reset(G);
  Set_False(Sem_Bin);
  Okres := Random(G);
  Przesuniecie := Ada.Real_Time.Milliseconds(Okres);
  Nastepny := Ada.Real_Time.Clock + Przesuniecie;
  delay until Nastepny;
  Set_True(Sem_Bin);
end PSporadic;

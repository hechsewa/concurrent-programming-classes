--proste przyklady zadania cyklicznego
--oparte o wyklady prof. Szpyrki
with Ada.Text_IO, Ada.Real_Time, Ada.Synchronous_Task_Control;
use Ada.Text_IO, Ada.Real_Time, Ada.Synchronous_Task_Control;
with System;

procedure TaskCyclic is

  --deklaracja zadania cyklicznego
  task type Cyclic(P: System.Priority; CycleTime: Positive) is
    pragma Priority(P);
  end Cyclic;

  --implementacja zadania cyklicznego
  task body Cyclic is
    Next_Period : Ada.Real_Time.Time; --czas nastepnego wywolania zadania
    --okres wywolywania zadania zamieniony na milisekundy, raczej zawsze stały
    Period : constant Ada.Real_Time.Time_Span := Ada.Real_Time.Microseconds(CycleTime);
  begin
    --nastepne wywolanie (teraz)+okres
    Next_Period := Ada.Real_Time.Clock + Period;
    loop
      delay until Next_Period;
      Put_Line("Woo! ");
      Next_Period := Next_Period+Period; --nastepne wywolanie za okres
    end loop;
  end Cyclic;

C1 : Cyclic(20, 2000);
C2 : Cyclic(10, 2000);
--main procedure body
begin
  Put_Line("Cyclic test");
end TaskCyclic;

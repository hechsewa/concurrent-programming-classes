--proste przyklady zadania sporadycznego
--oparte o wyklady prof. Szpyrki
with Ada.Text_IO, Ada.Real_Time, Ada.Synchronous_Task_Control;
use Ada.Text_IO, Ada.Real_Time, Ada.Synchronous_Task_Control;
with System;

procedure TaskSporadic is
  SO: Suspension_Object;

  task type Sporadic(Pri : System.Priority) is
    pragma Priority(Pri);
  end;

  task body Sporadic is
  -- Declarations
  begin
  -- Initialization code
    loop
      Ada.Synchronous_Task_Control.Suspend_Until_True(SO);
      Put_Line("Sporadic! ");
      -- Non-suspending sporadic response code
    end loop;
  end;

  Sp : Sporadic(17);
begin
  Put_Line("Sporadic test");
end;

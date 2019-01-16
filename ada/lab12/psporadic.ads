--deklaracje PSporadic

with System;

with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Real_Time;
use Ada.Real_Time;

package PSporadic is

--deklaracja Obiektu chronionego
  protected Ekran is
    procedure Pisz(S: String);
    pragma Priority (System.Default_Priority+5);
  end Ekran;

  --zadanie sporadyczne
  task Spor is
    pragma Priority(System.Default_Priority+1);
  end Spor;

end PSporadic;

-- semaforb.adb
-- semafr binarny 

with Ada.Text_IO;
use Ada.Text_IO;

procedure SemaforB is
  
-- typ chroniony 
protected type Semafor_Bin(Init_Sem: Boolean := True) is
  entry Czekaj;
  procedure Sygnalizuj;
  private
   S : Boolean := Init_Sem;
end Semafor_Bin ;

protected body Semafor_Bin  is
  entry Czekaj when S is
  begin
    S := False;
  end Czekaj;
  procedure Sygnalizuj  is
  begin
    S := True;
  end Sygnalizuj;
end Semafor_Bin ;
  
Semafor1: Semafor_Bin(False);  
  
task Producent; 

task body Producent is
begin  
  Put_Line("$ produkuję ... " );
  delay 0.7;
  Put_Line("$ wysyłam sygnał...");
  Semafor1.Sygnalizuj;
  Put_Line("$ kończę produkcję..."); 
end Producent;

task Konsument; 

task body Konsument is
begin  
  Put_Line("# czekam na sygnał...");
  Semafor1.Czekaj;
  Put_Line("# dostałem sygnał ...");
end Konsument;

begin
  Put_Line("@ jestem w procedurze glownej");
end SemaforB;
  
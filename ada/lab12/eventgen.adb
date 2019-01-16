-- 3. Napisz generator zdarzeń (w losowych odstępach) i zadanie sporadyczne:
--z semaforem
-- obiektem chronionym + losowe dane

procedure EventGen is
  pragma Priority(System.Priority'First);

begin
  PSporadic.Ekran.Pisz("Procedura glowna ");
  loop
    null;
  end loop;
end EventGen;

generic
	Rozmiar: Natural;
	type Typ_El is digits <>;
package buforw is
	type TBuf is array(Integer range 1..Rozmiar) of Typ_El;
	
protected BufW is
	entry Wstaw(Ch: in Typ_El);
	entry Pobierz(Ch: out Typ_El);
	private
		Bufo: TBuf;
		IxWst: Integer := 1;
		IxPob : Integer := 0;
		
end BufW;
end buforW;
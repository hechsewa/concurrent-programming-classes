with Ada.Text_IO;
use Ada.Text_IO;

package body buforw is

	protected body BufW is
		entry Wstaw(Ch: in Typ_El)
			when (IxWst mod 10) /= (IxPob mod 10) is
			begin
				Bufo(IxWst mod 10) := Ch;
				IxWst := IxWst+1;
		end Wstaw;

		entry Pobierz(Ch: out Typ_El)
			when (IxPob+1 < IxWst) is
			begin
				Ch := Bufo(IxPob+1 mod 10);
				IxPob := IxPob+1;
			end Pobierz;
	end BufW;

end buforW;
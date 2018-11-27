-module(lab1).
-export([pole/1, volume/1, len/1, amin/1, amax/1, tmin_max/1, lmin_max/1, pola/1, desc/1, temp_conv/2, genOnes/1, genList/2, bsort/1, merge/2]).

%pola 2d i 3d
pole({kwadrat,X,Y}) -> X*Y;
pole({kolo,X}) -> 3.14*X*X;
pole({trojkat, X, H}) -> (1/2)*X*H;
pole({trapez, A, B, H}) -> ((A+B)/2)*H;
pole({kula, X}) -> 4*3.14*X*X;
pole({szescian, X}) -> 6*X*X;
pole({stozek, X, H}) -> 3.14*X*(X+H).

%objetosc bryl
volume({kula, X}) -> (4/3)*3.14*X*X;
volume({szescian, X}) -> X*X*X;
volume({stozek, X, H}) -> 3.14*X*X*H.

%dlugosc listy
len([]) -> 0;
len(L) -> len(L, 0).

len([_|L], Count) -> len(L, Count+1);
len([], Count) -> Count.

%najmniejszy element listy
amin([]) -> 0;
amin([H|T]) -> amin(T, H).

amin([H|T], Min) when H<Min -> amin(T, H);
amin([H|T], Min) when H>=Min -> amin(T, Min);
amin([], Min) -> Min.

%najwiekszy element listy
amax([]) -> 0;
amax([H|T]) -> amax(T, H).

amax([H|T], Max) when H>Max -> amax(T, H);
amax([H|T], Max) when H=<Max -> amax(T, Max);
amax([], Max) -> Max.

%krotkę 2-elementową z najmniejszym i największym elementem listy (tmin_max/1)
tmin_max([H|T]) -> {amin([H|T]), amax([H|T])}.

%zwracający listę 2-elementową z najmniejszym i największym elementem listy (lmin_max/1)
lmin_max([H|T]) -> [amin([H|T]), amax([H|T])].

%pola figur/bryl podanych jako lista krotek
pola([]) -> [];
pola([H|T]) -> [pole(H)|pola(T)].

%lista malejaca
desc(0) -> [];
desc(N) -> desc(N, 0, []).

desc(N, M, Out) when M=/=N -> desc(N, M+1, [M+1|Out]);
desc(N, M, Out) -> Out.

%konweter temperatur
temp_conv({Type1, Temp}, Type2) -> 
	case {Type1,Type2} of
		{c,k} -> Temp+273.15;
		{k,c} -> Temp-273.15;
		{f,c} -> (Temp-32)/1.8;
		{c,f} -> Temp*1.8 + 32;
		_ -> 'nah'
	end.
		
%generator listy jedynek
genOnes(0) -> [];
genOnes(N) -> genOnes(N, []).

genOnes(N, Out) when N=/=0 -> genOnes(N-1, [1|Out]);
genOnes(0, Out) -> Out.

%generator listy danego elementu
genList(N, M) -> genList(N, M, []).

genList(N, M, Out) when N=/=0 -> genList(N-1, M, [M|Out]);
genList(0, _, Out) -> Out.

%merge sort
%glueing function
merge([], L2) -> L2;
merge(L1, []) -> L1;
merge([H1|T1], [H2|T2]) ->
	case H1 < H2 of
		true -> [H1|merge(T1, [H2|T2])];
		false -> [H2|merge([H1|T1], T2)]
    end.	

%actual merge sort
%msort([]) -> [];
%msort([H]) -> [H];
%msort(L) -> {Left, Right} = split(L),
%merge(msort(Left), msort(Right)).
				   
%bubble sort
bsort([]) -> [];
bsort(L) -> bsort(L, []).

bsort([], Sorted) -> lists:reverse(Sorted);
bsort([H1,H2|T], Sorted) when H1>H2 -> bsort([H1|T], [H2|Sorted]);
bsort([H|T], Sorted) -> bsort(T, [H|Sorted]).
		
%lab2 binary tree

-module(binary_tree).
-export([init/0, insert/2, genTree/3]).

%tworzy puste drzewo, root, init() -> tree()
init() -> {node, 'nil'}.

%wstawianie do drzewa
insert(Data, {node, 'nil'}) ->
	{node, {Data, init(), init()}};
insert(NewData, {node, {Data, Left, Right}}) when NewData < Data ->
	{node, {Data, insert(NewData, Left), Right}};
insert(NewData, {node, {Data, Left, Right}}) when NewData > Data -> 
	{node, {Data, Left, insert(NewData, Right)}};
insert(Data, {node, {Data, Left, Right}}) ->
	{node, {Data, Left, Right}}.	
	
	
%generacja losowego drzewa, M liczb z zakresu 1-N
genTree(N,M,T) -> 
	[insert(I, T) || I <- [rand:uniform(N) || _ <- lists:seq(1, M)]].
	
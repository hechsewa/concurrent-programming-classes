-module(trycatch).
-compile([export_all]).

something_went_wrong(banan) -> a;
something_went_wrong(ziemniak) -> throw(a);
something_went_wrong(kartofel) -> exit(a);
something_went_wrong(c2h5oh) -> {'EXIT', a};
something_went_wrong(as2o3) -> erlang:error({123,a}).

catch_me_if_you_can() ->
		[catcher(I) || I <- [banan,ziemniak,kartofel,c2h5oh,as2o3]].
catcher(N) ->
		try something_went_wrong(N) of
				Val -> {N, normal, Val}
		catch
				throw:X -> {N, caught, thrown, X};
				exit:X -> {N, caught, exited, X};
				error:X -> {N, caught, error, X}
		end.

catch_me() ->	[{I, (catch something_went_wrong(I))} || I <- [banan,ziemniak,kartofel,c2h5oh,as2o3]].


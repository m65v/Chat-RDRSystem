%% @author Mayra
%% @doc @todo Add description to hello_world.


-module(hello).

-export([start/0, store/2, lookup/1]).

start()->register (hello, spawn (fun()-> loop() end)).

store (Key, Value)->rpc({store, Key, Value}).

lookup (Key)-> rpc ({lookup,Key}).

rpc(Q)->
	hello ! {self(),Q},
	receive 
		{hello,Reply}-> Reply
	end.

loop()->
	receive 
		{From, {store, Key, Value}} ->
			put(Key, {ok,Value}),
			From ! {hello,true},
			loop();
		{From, {lookup, Key}} ->
			From ! {hello, get(Key)},
			loop()
	end.
%% @author Mayra
%% @doc @todo Add description to server.

-module(server).
-export([start/0]).

start() -> spawn(fun() -> loop([]) end).

loop(Clients) ->  
  process_flag(trap_exit, true),
  %receive messages fron other proccesses that 
% in this case will be the clients, then use pattern
%matching with the messages
%from will have the pid of the sender ,connect is an atom 
%
  receive
    {From, connect, Username} ->
      link(From),
      broadcast(join, Clients, {Username}),
      loop([{Username, From} | Clients]);
    {From, send, Msg} ->
      broadcast(new_msg, Clients, {find(From, Clients), Msg}),
      loop(Clients);
    {'EXIT', From, _} ->
      broadcast(disconnect, Clients, {find(From, Clients)}),
      loop(remove(From, Clients));
    _ ->
      loop(Clients)
  end.
%notify all the other clients that a new client has conncest
% boradcast also uses pattern matching 
broadcast(join, Clients, {Username}) ->  
  broadcast({info, Username ++ " joined the chat."}, Clients);
broadcast(new_msg, Clients, {Username, Msg}) ->  
  broadcast({new_msg, Username, Msg}, Clients);
broadcast(disconnect, Clients, {Username}) ->  
  broadcast({info, Username ++ " left the chat."}, Clients).

broadcast(Msg, Clients) ->  
  lists:foreach(fun({_, Pid}) -> Pid ! Msg end, Clients).

find(From, [{Username, Pid} | _]) when From == Pid ->  
  Username;
find(From, [_ | T]) ->  
  find(From, T).

remove(From, Clients) ->  
  lists:filter(fun({_, Pid}) -> Pid =/= From end, Clients).



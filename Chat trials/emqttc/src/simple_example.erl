-module(simple_example).

-export([start/0]).

-include("/Users/Rickard/Documents/workspace/emqttc/include/emqttc_packet.hrl").

start() ->
    {ok, C} = emqttc:start_link([{host, "129.16.155.34"}, {client_id, <<"simpleClient">>}]),
    emqttc:subscribe(C, <<"TopicA">>, 0),
    emqttc:publish(C, <<"TopicA">>, <<"hello test">>),
    receive
        {publish, Topic, Payload} ->
            io:format("Message Received from ~s: ~p~n", [Topic, Payload])
    after
        1000 ->
            io:format("Error: receive timeout!~n")
    end,
    emqttc:disconnect(C).
    

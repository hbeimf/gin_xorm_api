-module(wsc_cc).

-behaviour(websocket_client_handler).

-export([
         start_link/1,
         init/2,
         websocket_handle/3,
         websocket_info/3,
         websocket_terminate/3
        ]).

start_link(Index) ->
    % crypto:start(),
    % ssl:start(),
    % websocket_client:start_link("wss://echo.websocket.org", ?MODULE, []).
  
    websocket_client:start_link("ws://localhost:8000/wschat", ?MODULE, [Index]).

    

init([Index], _ConnState) ->
    % websocket_client:cast(self(), {text, <<"message 1">>}),
    % io:format("client pid: ~p ~n", [self()]),

    {ok, Index}.

% websocket_handle({pong, _}, _ConnState, State) ->
%     {ok, State};
% websocket_handle({text, Msg}, _ConnState, 5) ->
%     io:format("Received msg ~p~n", [Msg]),
%     {close, <<>>, "done"};

websocket_handle({binary, Bin}, _ConnState, State) ->
	io:format("Client received binary here ~p~n", [Bin]),
	{ok, State};
websocket_handle(Msg, _ConnState, State) ->
    io:format("Client ~p received msg:~n~p~n", [State, Msg]),
    % timer:sleep(1000),
    % BinInt = list_to_binary(integer_to_list(State)),
    % {reply, {text, <<"hello, this is message #", BinInt/binary >>}, State + 1}.
    {ok, State}.


websocket_info(close, _ConnState, _State) ->
	{close, <<>>, "done"};
websocket_info({text, Txt}, _ConnState, State) ->
	{reply, {text, Txt}, State};
websocket_info({binary, Bin}, _ConnState, State) ->
    io:format("send All XXXXXXXXXXXX ==========~n" ),
	{reply, {binary, Bin}, State}.

websocket_terminate(Reason, _ConnState, State) ->
    io:format("~nClient closed in state ~p wih reason ~p~n", [State, Reason]),
    ok.
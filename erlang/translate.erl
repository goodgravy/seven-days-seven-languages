-module(translate).
-export([loop/0]).
-export([translate/2]).

loop() ->
  receive
    {Pid, "casa"} ->
      Pid ! "house",
      loop();
    {Pid, "blanca"} ->
      Pid ! "white",
      loop();
    {Pid, _} ->
      Pid ! "I don't understand",
      exit({translator, die, at, erlang:time()})
  end.

translate(To, Word) ->
  To ! {self(), Word},
  receive
    Translation -> Translation
  end.

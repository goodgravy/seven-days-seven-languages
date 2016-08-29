-module(day_3).
-export([mon_translate/0]).

mon_translate() ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("creating a new translation process~n"),
      register(translator, spawn_link(fun translate:loop/0)),
      mon_translate();
    {'EXIT', From, Reason} ->
      io:format("The translator ~p died: ~p~n", [From, Reason]),
      self() ! new,
      mon_translate()
  end.


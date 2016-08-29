-module(day_3).
-export([mon_translate/0]).

mon_translate() ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("creating a new translation process~n"),
      register(translator, spawn_link(fun translate:loop/0)),
      mon_translate();
    start ->
      io:format("creating a new monitor process, linked to ~p~n", [whereis(translator)]),
      link(whereis(translator)),
      mon_translate();
    {'EXIT', From, Reason} ->
      io:format("Something died: ~p, ~p~n", [From, Reason]),
      case whereis(translator) of
        undefined -> % translator died
          self() ! new;
        _ ->
          self() ! start
      end,
      mon_translate()
  end.


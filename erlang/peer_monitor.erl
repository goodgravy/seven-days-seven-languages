-module(peer_monitor).
-export([mon_translate/0]).

mon_translate() ->
  process_flag(trap_exit, true),
  receive
    start ->
      io:format("starting mon_translate~n"),
      self() ! start_translator,
      self() ! start_peer_mon,
      mon_translate();

    start_translator ->
      io:format("starting translator process~n"),
      register(translator, spawn_link(fun translate:loop/0)),
      mon_translate();

    start_peer_mon ->
      io:format("starting peer_mon process~n"),
      register(peer_mon, spawn_link(fun peer_mon/0)),
      mon_translate();

    link_monitor ->
      case whereis(translator) of
        undefined -> % translator died
          io:format("no translator to link to: creating a new one~n"),
          self() ! start_translator,
          mon_translate();
        _ ->
          io:format("found an existing translator to link to(~p)~n", [whereis(translator)]),
          link(whereis(translator)),
          mon_translate()
      end;

    {'EXIT', From, Reason} ->
      io:format("[mon] something died: ~p, ~p~n", [From, Reason]),
      TranslatorDead = whereis(translator) == undefined,
      PeerMonDead = whereis(peer_mon) == undefined,

      if
        TranslatorDead ->
          self() ! start_translator,
          mon_translate();
        PeerMonDead ->
          self() ! start_peer_mon,
          mon_translate();
        true -> ok
      end
  end.

peer_mon() ->
  process_flag(trap_exit, true),
  receive
    {'EXIT', From, Reason} ->
      io:format("[peer] something died: ~p, ~p~n", [From, Reason]),
      MonTranslateDead = whereis(mon_translate) == undefined,

      if
        MonTranslateDead ->
          register(mon_translate, spawn_link(fun mon_translate/0)),
          mon_translate ! link_monitor,
          peer_mon();
        true -> ok
      end
  end.

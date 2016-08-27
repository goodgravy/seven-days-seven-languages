-module(day_2).
-export([description/2]).

description(Langs, Lang) ->
  case lists:keyfind(Lang, 1, Langs) of
    {_, Desc} -> Desc;
    false     -> "Unknown language"
  end.

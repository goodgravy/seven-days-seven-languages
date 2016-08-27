-module(day_1).
-export([count_to_ten/0]).
-export([output_message/1]).

count_from_to(To, To) -> io:format("~w~n", [To]);
count_from_to(From, To) ->
  io:format("~w~n", [From]),
  count_from_to(From + 1, To).


count_to_ten() -> count_from_to(1, 10).

output_message({error, Message}) -> io:format("error: ~s~n", [Message]);
output_message(success) -> io:format("success~n").

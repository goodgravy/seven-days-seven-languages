-module(day_2).
-export([description/2]).
-export([shopping_prices/1]).
-export([analyse_tic/1]).

description(Langs, Lang) ->
  case lists:keyfind(Lang, 1, Langs) of
    {_, Desc} -> Desc;
    false     -> "Unknown language"
  end.

shopping_prices(Prices) -> [{Item, Price * Quantity} || {Item, Quantity, Price} <- Prices].

rows([S1, S2, S3, S4, S5, S6, S7, S8, S9]) ->
      [
       [S1, S2, S3],
       [S4, S5, S6],
       [S7, S8, S9],
       [S1, S4, S7],
       [S2, S5, S8],
       [S3, S6, S9],
       [S1, S5, S9],
       [S3, S5, S7]
      ].

all(Row, Sym) -> lists:all(fun(Square) -> Square == Sym end, Row).
allX(Row) -> all(Row, x).
allO(Row) -> all(Row, o).

analyse_tic(Board) ->
  X_win = lists:any(fun(Row) -> allX(Row) end, rows(Board)),
  O_win = lists:any(fun(Row) -> allO(Row) end, rows(Board)),
  BoardFull = lists:all(fun(Square) -> Square /= "_" end, Board),

  if
    X_win and O_win -> throw("Invalid: x and o cannot both win");
    X_win -> x;
    O_win -> o;
    BoardFull -> cat;
    true -> no_winner
  end.

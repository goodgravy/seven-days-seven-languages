use_module(library(clpfd)).

eight_queens(Board) :-
  length(Board, 2),
  all_different([nth1(1, nth1(1, Board)), nth1(2, nth1(1, Board))]).



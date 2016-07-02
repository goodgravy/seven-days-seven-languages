concatenate([], List, List).
concatenate([Head|[]], List, [Head|List]).
%% concatenate([Head1|[Head2|[]]], List, [Head1|[Head2|List]]).
%% concatenate([Head1|[Head2|[Head3|[]]]], List, [Head1|[Head2|[Head3|List]]]).

concatenate([Head|Tail1], List, [Head|Tail2]) :-
  write('--------------- concatenate'),
  nl(),
  write(Head),
  nl(),
  write(Tail1),
  nl(),
  write(List),
  nl(),
  write(Tail2),
  nl(),
  display(concatenate(Tail1, List, Tail2)),
  nl(),
  concatenate(Tail1, List, Tail2).

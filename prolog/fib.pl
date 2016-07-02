fib(1, 1) :- !.
fib(0, 0) :- !.
fib(Number, Value) :-
  N1 is Number - 1, fib(N1, V1),
  N2 is Number - 2, fib(N2, V2),
  Value is V1 + V2.

factorial(0, 1).
factorial(Number, Value) :-
  nl(),
  display(factorial(Number - 1, Value / Number)),
  Number > 0,
  N1 is Number - 1,
  factorial(N1, V1),
  Value is Number * V1.


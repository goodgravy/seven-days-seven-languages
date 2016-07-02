rev([], []).
rev([Head|[]], [Head]).
rev([Head|Tail], Reversed) :-
  append(Reversed, Head, ReversedWithHead),
  rev(Tail, ReversedWithHead).

smallest([Head|[]], Head).
smallest([Head|Tail], Smallest) :-
  smallest(Tail, SmallestOfTail),
  Head < SmallestOfTail,
  Smallest is Head.
smallest([Head|Tail], Smallest) :-
  smallest(Tail, SmallestOfTail),
  Head >= SmallestOfTail,
  Smallest is SmallestOfTail.

insert_into_sorted_list(Value, [], [Value]).
insert_into_sorted_list(Value, [Head|Tail], Result) :-
  (Value < Head; Value = Head),
  append([Value], [Head|Tail], Result).
insert_into_sorted_list(Value, [Head|Tail], Result) :-
  Value > Head,
  insert_into_sorted_list(Value, Tail, ValueInTail),
  append([Head], ValueInTail, Result).

% not tail recursive
% stackoverflow at < 3000 item decreasing list
sortl([Head|[]], [Head]).
sortl([Head|Tail], Result) :-
  sortl(Tail, SortedTail),
  insert_into_sorted_list(Head, SortedTail, Result).


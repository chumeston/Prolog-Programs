%Rules
membership(Element, [Element |_]).
membership(Element, [_| FoundElement]) :- membership(Element, FoundElement).

firstelement([FirstElement |_]) :- write(FirstElement).

lastelement([LastElement]) :- write(LastElement).
lastelement([_| Tail]) :- lastelement(Tail).

twoadjacent(Element1, Element2, [Element1, Element2 |_]).
twoadjacent(Element1, Element2, [_| Tail]) :- twoadjacent(Element1, Element2, Tail).

threeadjacent(Element1, Element2, Element3, [Element1 ,Element2 ,Element3 |_]).
threeadjacent(Element1, Element2, Element3,
[_| Tail]) :- threeadjacent(Element1, Element2, Element3, Tail).

appendlist([], List, List).
appendlist([Element, Tail], List, [Element, NewList]) :- appendlist(Tail, List, NewList).

removeelement(FirstElement, [FirstElement | Tail], Tail).
removeelement(FirstElement, [Head | Tail],
[Head | NewTail]) :- removeelement(FirstElement, Tail, NewTail).

appendelement(Element1, List, NewList) :- appendlist(List, [Element1], NewList).

insertlist(Element1, List, NewList) :- removeelement(Element1, NewList, List).

lengthoflist([], 0).
lengthoflist([_| Tail], Size) :- lengthoflist(Tail, NewSize),
Size is NewSize + 1.

reverselist([], List, List).
reverselist([Head | Tail], List, NewList) :- reverselist(Tail, List, [Head | NewList]).

palindrome(Element) :- reverselist(Element, Element, []).

display([]) :- nl.
display([Head | Tail]) :- write(Head), tab(1), display(Tail).

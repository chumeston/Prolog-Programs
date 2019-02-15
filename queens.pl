function(INT, Input) :- length(Input, INT), queens(Input, Board, 0, INT, _, _), queens(Board, 0, Input).

queens([], [], Numbers, Numbers, _, _).

queens([_| Numbers], [Column - NewColumns | Board], ZeroColumn,
N, [_| FirstRows], FirstColumns) :- Column is ZeroColumn + 1,
functor(NewColumns, f, N),
constraints(N, NewColumns, FirstRows, FirstColumns),
queens(Numbers, Board, Column, N, FirstRows, [_|FirstColumns]).

constraints(0, _, _, _) :- !.

constraints(INT, NewRow, [Row | RowSearch], [Column | ColumnSearch]) :- arg(INT, NewRow, Row-Column),
Initial is INT - 1,
constraints(Initial, NewRow, RowSearch, ColumnSearch).

queens([], _, []).

queens([Column | ColumnSearch], ZeroRow, [NewColumn | Return]) :- NewRow is ZeroRow + 1,
select(NewColumn - INTS, [Column | ColumnSearch], PlayingFunc),
arg(NewRow, INTS, NewRow - NewRow),
queens(PlayingFunc, NewRow, Return).

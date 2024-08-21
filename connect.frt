\ #IR board.frt

( ----------------------------- Check for winner ----------------------------- )

( Return a true value if there is a winner and false otherwise )
: connect-win ( board -- b ) drop 0 ( TODO ) ; 

( ------------------------------- Placing coins ------------------------------ )

( Return the number of elements in a column )
: board-col-elem ( board n -- n ) swap dup board-size nip 0 swap 0 do
    ( n board ret )
    rot rot 2dup
    ( ret n board n board )
    i swap board-get 0=
    ( ret n board is-empty )
    if 0 else 1 then >r rot r>
    ( n board ret is-not-empty )
    +
loop nip nip ;

( Return true if the column is full )
: connect-column-is-full ( column board -- b ) dup board-size nip rot rot swap board-col-elem = ;

( Return the height index we should put the next element at on a column. Is )
( free to give index out of the bounds if the column is full )
: connect-next-height ( column board -- n ) dup board-size nip rot rot swap board-col-elem 1+ - ;

( Try to place an element on the given column. Return a true value if it )
( can be done and a false otherwise )
: connect-place-elem ( elem column board -- b ) 2dup connect-column-is-full if 2drop drop 0 exit then
    rot >r 2dup connect-next-height swap r> board-set 1 ; 

\ #SI
( ----------------------------------- Tests ---------------------------------- )

: id 48 + emit ;
:macro r>c r> save>r ;

3 3 board-new >r

0 2 r>c 1 board-set
0 1 r>c 2 board-set
0 0 r>c 3 board-set
1 2 r>c 4 board-set

r>c ' id board-display

r>c 0 board-col-elem .
r>c 1 board-col-elem .
r>c 2 board-col-elem .
cr

0 r>c connect-column-is-full .
1 r>c connect-column-is-full .
2 r>c connect-column-is-full .
cr

0 r>c connect-next-height .
1 r>c connect-next-height .
2 r>c connect-next-height .
cr

7 0 r>c connect-place-elem .
8 1 r>c connect-place-elem .
9 2 r>c connect-place-elem .
cr
r>c ' id board-display


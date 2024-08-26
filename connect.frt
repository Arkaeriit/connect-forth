\ #IR board.frt

( ----------------------------- Check for winner ----------------------------- )

( The following codes contain a lot of duplication. But I don't really want to )
( refactor it to keep it somewhat readable. )

( Ensure that the 4 element on the stack are equal and not null )
: check-4-values ( a b c d -- bool ) save>r = rot r>copy = rot r>copy = r> 0 <> and and and ;

( With the board and two coordonates on the data stack, get the value at the )
( given coordonates and put it on the return stack. Keep the board as is. )
: board-get-1-coord-on-return ( x y board -- board ) ( -- c ) save>r board-get r> swap >r swapr ;

( Given 4 x/y coordinates, get the values from the board and run )
( check-4-values on them )
: check-4-coords ( x1 y1 x2 y2 x3 y3 x4 y4 board -- board bool )
    4 0 do board-get-1-coord-on-return loop >r
    4 0 do r>nip loop check-4-values r> swap ;

( Given an x/y coordinate, get it and the 3 following ones in the column )
: get-4-col ( x y -- x y x y+1 x y+2 x y+3 ) 3 0 do 2dup 1+ loop ;

( Given an x/y coordinate, get it and the 3 following ones in the line )
: get-4-line ( x y -- x y x+1 y x+2 y x+3 y ) 3 0 do 2dup swap 1+ swap loop ;

( given an x/y coordinate, get it and the 3 following ones in the descending )
( right diagonal. )
: get-4-diag-1 ( x y -- x y x+1 y+1 x+2 y+2 x+3 y+3 ) 3 0 do 2dup 1+ swap 1+ swap loop ;

( given an x/y coordinate, get it and the 3 following ones in the descending )
( left diagonal. )
: get-4-diag-2 ( x y -- x y x-1 y+1 x-2 y+2 x-3 y+3 ) 3 0 do 2dup 1+ swap 1- swap loop ;

( Given a coordinate, a word to expand, and the board it to a line, return if )
( there is a win from that )
: connect-win-from-coord ( x y 'x board -- board bool ) >r execute r> check-4-coords ;

( Check that there was a win in a column )
: connect-win-column ( x board -- board bool ) dup board-size nip 3 - 0 do
        ( x board )
        2dup i swap ['] get-4-col swap connect-win-from-coord
        ( x board board bool )
        if drop nip 1 unloop exit else drop then
    loop nip 0 ;

( Check that there is a win in any column )
: connect-win-columns ( board -- board bool ) dup board-size drop 0 do
        i swap connect-win-column
        if 1 unloop exit then
    loop 0 ;

( Check that there was a win in a line )
: connect-win-line ( x board -- board bool ) dup board-size drop 3 - 0 do
        ( x board )
        2dup >r i swap r> ['] get-4-line swap connect-win-from-coord
        ( x board board bool )
        if drop nip 1 unloop exit else drop then
    loop nip 0 ;

( Check that there is a win in any column )
: connect-win-lines ( board -- board bool ) dup board-size nip 0 do
        i swap connect-win-line
        if 1 unloop exit then
    loop 0 ;

( Check that there is a win in a descending right diagonal )
: connect-win-diag-1 ( board -- board bool ) save>r board-size 3 - 0 do
    dup 3 - 0 do
        i j ['] get-4-diag-1 r>copy connect-win-from-coord
        if drop r> 1 unloop unloop exit then
        drop
    loop loop drop r> 0 ;

( Check that there is a win in a descending left diagonal )
: connect-win-diag-2 ( board -- board bool ) save>r board-size 3 - 0 do
    dup 3 do
        i j ['] get-4-diag-2 r>copy connect-win-from-coord
        if drop r> 1 unloop unloop exit then
        drop
    loop loop drop r> 0 ;

( Return a true value if there is a winner and false otherwise )
: connect-win ( board -- b ) connect-win-columns swap connect-win-lines swap connect-win-diag-1 swap connect-win-diag-2 nip or or or ;

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

3 3 board-new >r

0 2 r>copy 1 board-set
0 1 r>copy 2 board-set
0 0 r>copy 3 board-set
1 2 r>copy 4 board-set

r>copy ' id board-display

r>copy 0 board-col-elem .
r>copy 1 board-col-elem .
r>copy 2 board-col-elem .
cr

0 r>copy connect-column-is-full .
1 r>copy connect-column-is-full .
2 r>copy connect-column-is-full .
cr

0 r>copy connect-next-height .
1 r>copy connect-next-height .
2 r>copy connect-next-height .
cr

7 0 r>copy connect-place-elem .
8 1 r>copy connect-place-elem .
9 2 r>copy connect-place-elem .
cr
r>copy ' id board-display


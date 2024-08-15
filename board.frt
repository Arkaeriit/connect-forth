( Makes a copy of n in the R stack )
:macro save>r ( n -- n ) dup >r ;

( ------------------------------ Initialization ------------------------------ )

( Return the memory needed for a board of the given dimentions )
: board-memory-size ( width height -- n ) * 2 cells + ;

( Initialise a board of the given dimention in the given ALLOCATED memory )
: board-init ( width height addr -- )
    rot rot 2dup >r >r rot ( copy the width and height on the return stack )
    save>r ! r> cell+      ( write the height )
    save>r ! r> cell+      ( write the width )
    r> r> * 0 do           ( loop over each case )
        dup 0 swap c! 1 +  ( clear the case and increment the pointer )
    loop drop ;

: .? ( n -- n ) dup . cr ;
: .?? ( n n -- n n ) 2dup . . cr ;
: .??? ( n n n -- n n n ) save>r . save>r . save>r . r> r> r> cr ;

( Allocate a board from the heap and init it )
: board-new ( width height -- addr ) 2dup board-memory-size allocate drop dup >r board-init r> ;

( Allocate a board on the Forth memory and init it )
: board-here ( width height -- addr ) 2dup board-memory-size here swap allot dup >r board-init r> ;

( ------------------------------ Getters/Setters ----------------------------- )

( Get the dimentions of a board )
: board-size ( addr -- width height ) dup cell+ @ swap @ ;

( Check if the coordinates given are valid for the board. If they are, return )
( them, if they are not, print an error message an return 0 0 )
: board-check-coord ( width height addr -- width height addr )
    save>r rot save>r rot save>r rot
    board-size rot  > rot rot swap > and
        if r> r> swap r>
        else r> r> 2drop 0 0 r> ." Error, invalid coordinates!" cr
    then ;

( Get the address of the desired case of the board. Sanitize beforehand. )
: board-get-addr ( width height addr -- addr ) board-check-coord
    save>r board-size drop * + r> 2 cells + + ;

( Get the value of the desired case of the board. )
: board-get ( width height addr -- c ) board-get-addr c@ ;

( Set the value of the desired case of the board. )
: board-set ( width height addr c -- ) >r board-get-addr r> swap c! ;

( ---------------------------------- Display --------------------------------- )

( Display the n-th line of the boarad. 'x is a token to a function that takes )
( bytes as input and output a string to render )
: board-display-line ( board n 'x -- board ) rot dup board-size drop ( get width )
    ." | "
    0 do
        ( n 'x b ) 
        rot i 
        ( 'x b n i )
        swap save>r rot save>r board-get
        ( 'x c / n b)
        swap save>r execute ."  | "
        ( / n b 'x )
        r> r> r>
        ( 'x b n )
        rot rot
    loop swap drop swap drop cr ;

( Display a line made to delimit rows. )
: board-display-inter-line ( board -- board ) ." +" dup board-size drop 0 do ." ---+" loop ."  " cr ;

( Display a whole word using the 'x on each byte to display. )
: board-display ( board 'x -- ) swap board-display-inter-line dup board-size nip 0 do
        ( 'x b )
        2dup swap i swap board-display-line
        board-display-inter-line drop
    loop 2drop ;

: id 48 + emit ;
:macro r>c r> save>r ;

10 15 board-new >r

0 0 r>c 1 board-set
0 3 r>c 2 board-set
5 0 r>c 3 board-set
7 7 r>c 4 board-set

r> ' id board-display


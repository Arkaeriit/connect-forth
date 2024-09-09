\ #IR connect.frt

( ---------------------------------- Display --------------------------------- )

( The board should contain 0 for empty cases and 1 or 2 for cases with player )
( coins. They will be shown as colored X or O )

( Reset terminal's color )
: .nc ( -- ) 27 emit ." [m" ;

( Print a string in green )
: .green ( string -- ) 27 emit ." [0;32m" type .nc ;

( Print a string in yellow )
: .yellow ( string -- ) 27 emit ." [0;93m" type .nc ;

( Display a case of the board )
: display-case ( c -- ) dup 0= if drop ."  " exit then 
    dup 1 = if drop s" O" .green  exit then
    dup 2 = if drop s" X" .yellow exit then
    ." Error, invalid case." cr (bye) ;

( Display the board properly formated )
: connect-display ( board -- ) ['] display-case board-display ;

( -------------------------------- Game state -------------------------------- )

( The game state is rather simple, a pointer to the board and either 1 or 2 to )
( tell which player's turn it is, and a boolean telling if the game has been )
( won. )

( Allocate a game given an allocator )
: (game-allot) ( width height 'x -- addr ) save>r (board-allot) 3 cells r> execute dup rot swap ! dup cell+ 1 swap ! dup 2 cells + 0 swap ! ;

( Allocate a game on the heap )
: game-new ( width height -- addr ) ['] heap-allocator (game-allot) ;
( Allocate a game on the Forth memory )
: game-here ( width height -- addr ) ['] forth-allocator (game-allot)  ;

: game-free ( game -- ) dup @ board-free (free) ;

: game-get-board ( game -- board ) @ ;
: game-get-player ( game -- c ) cell+ @ ;
: game-get-win-state-addr ( game -- addr ) 2 cells + ;

: game-swap-player ( game -- ) dup game-get-player
    dup  1 = if drop 2
    else 2 = if      1
    else ." Error, invalid player in game state." cr 1 then then
    swap cell+ ! ;

( Try to put a coin of the current player to the target column. If it is full, )
( print an error message. Otherwise, place the coin and swap players )
: (game-play) ( column game -- ) save>r dup game-get-player rot rot @ connect-place-elem
    if r> game-swap-player
    else ." The target column is full." cr r> drop
    then ;

( Play a round and chek if there is a win. If so, print a win message and )
( update the state. Don't try to play if there if already a winner. )
: game-play ( column game -- )
    ( TODO: also check for tie )
    dup game-get-win-state-addr @ if
        ." Player " game-get-player display-case ."  already won." cr drop exit then
    save>r (game-play)
    r>copy game-get-board connect-win if
        r> dup dup game-swap-player game-get-win-state-addr 1 swap ! ." Player " game-get-player display-case ."  win! Congratulations!" cr
        else r> drop then ;

: game-display ( game -- ) game-get-board connect-display ;

\ #SI
( ----------------------------------- Tests ---------------------------------- )


s" green" .green ." white" s" yellow" .yellow cr

3 3 board-new >r
1 0 r>copy connect-place-elem
2 1 r>copy connect-place-elem
1 2 r>copy connect-place-elem
2 0 r>copy connect-place-elem
r> connect-display

3 3 game-new >r
0 r>copy game-play
1 r>copy game-play
0 r>copy game-play
0 r>copy game-play
0 r>copy game-play
2 r>copy game-play
r> game-display

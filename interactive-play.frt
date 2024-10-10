( Functions in this files are meant to allow to play Connect Forth in an )
( interactive forth environment. )

\ #IR game.frt

7 constant width
6 constant height
variable game-state
0 game-state !

( display-frame variable. Used to surrond the display with a string if needed )
( default to being empty )
variable display-frame 1 cell allot
s" " display-frame 2!
: (display-frame) display-frame 2@ type ;

: (c4-display) ( -- ) (display-frame) game-state @ game-display (display-frame) ;
: (c4-is-won) ( -- bool ) game-state @ game-get-win-state-addr @ ;

: (c4-free) game-state @ 0<> if game-state @ game-free then ;
: (c4-start) ( -- ) (c4-free) width height game-new game-state ! ;
: c4-start ( -- ) (c4-start) ." Starting a new game of Connect Forth!" cr
    ." Play by entering c4-1 to c4-7." cr (c4-display) ;

( Play a coin on the nth column, 1 indexed )
: c4-play ( n -- ) dup width > if
        ." Error, invalid column." cr drop exit then
    1- game-state @ game-play (c4-display) ;

( Compile the word c4-n which call c4-play with the value n )
: compile-c4-x ( n -- ) dup <# s"  c4-play ; " holds s>d #s d>s drop bl hold s>d #s s"  : c4-" holds #> evaluate ;

( Compile all c4-x words needed to play with the current width )
: compile-all-c4-x width 0 do i 1+ compile-c4-x loop ;
compile-all-c4-x


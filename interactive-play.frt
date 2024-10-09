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

: c4-play ( n -- ) 1- game-state @ game-play (c4-display) ;

: c4-1 ( -- ) 1 c4-play ;
: c4-2 ( -- ) 2 c4-play ;
: c4-3 ( -- ) 3 c4-play ;
: c4-4 ( -- ) 4 c4-play ;
: c4-5 ( -- ) 5 c4-play ;
: c4-6 ( -- ) 6 c4-play ;
: c4-7 ( -- ) 7 c4-play ;


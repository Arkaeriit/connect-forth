( Functions in this files are meant to allow to play Connect Forth in an )
( interactive forth environment. )

\ #IR game.frt

7 constant width
6 constant height
variable game-state

( display-frame variable. Used to surrond the display with a string if needed )
( default to being empty )
variable display-frame 1 cell allot
s" " display-frame 2!
: (display-frame) display-frame 2@ type ;

: (c4-display) ( -- ) (display-frame) game-state @ game-display (display-frame) ;
: (c4-is-won) ( -- bool ) game-state @ game-get-win-state-addr @ ;

: (c4-start) ( -- ) width height game-new game-state ! ;
: c4-start ( -- ) (c4-start) ." Starting a new game of Connect Forth!" cr
    ." Play by entering c4-1 to c4-7." cr (c4-display) ;

: c4-1 ( -- ) 0 game-state @ game-play (c4-display) ;
: c4-2 ( -- ) 1 game-state @ game-play (c4-display) ;
: c4-3 ( -- ) 2 game-state @ game-play (c4-display) ;
: c4-4 ( -- ) 3 game-state @ game-play (c4-display) ;
: c4-5 ( -- ) 4 game-state @ game-play (c4-display) ;
: c4-6 ( -- ) 5 game-state @ game-play (c4-display) ;
: c4-7 ( -- ) 6 game-state @ game-play (c4-display) ;

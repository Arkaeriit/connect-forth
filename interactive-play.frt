( Functions in this files are meant to allow to play Connect Forth in an )
( interactive forth environment. )

\ #IR game.frt

7 constant width
6 constant height
variable game-state

: (c4-display) ( -- ) game-state @ game-display ;

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

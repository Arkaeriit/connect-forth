( Standalone executable playing over the interactive version. )

\ #IR c4.frt

: handle-key ( c -- )
    ( Manage ASCII 1 to 7 )
    dup  49 = if drop c4-1 0 then
    dup  50 = if drop c4-2 0 then
    dup  51 = if drop c4-3 0 then
    dup  52 = if drop c4-4 0 then
    dup  53 = if drop c4-5 0 then
    dup  54 = if drop c4-6 0 then
    dup  55 = if drop c4-7 0 then
    ( Ignore whitespace )
    dup  10 = if drop 0 then
    dup  13 = if drop 0 then
    dup  32 = if drop 0 then
    ( Quit on ^D, q, or Q )
    dup   4 = if bye then
    dup  81 = if bye then
    dup 113 = if bye then
    ( If we managed the char, we have a 0, otherwise, it's an error )
    dup 0= if drop
        else ." Error, unexpected char: " emit cr
    then ;

: repl begin key handle-key
    ( TODO: end game when needed. )
    0 until ;

: main (c4-start)
    ." Starting a new game of Connect Forth!" cr
    ." Play by typing 1, 2, 3, 4, 5, 6, or 7 to choose a column." cr
    ." Quit by typing q, Q, or ctrl-d." cr
    (c4-display)
    repl ;

main


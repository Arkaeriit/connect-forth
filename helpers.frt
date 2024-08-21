( Makes a copy of n in the R stack )
: save>r ( n -- n ) ( -- n ) dup r> swap >r >r ;

( Copies the top of the call stack onto the data stack )
: r>copy ( -- n ) ( n -- n ) r> r> save>r swap >r ;

( Swap the two top element of the call stack )
: swapr ( -- ) ( x y -- y x ) r> r> r> swap >r >r >r ;

( Get the value before the top of the return stack )
: r>nip ( -- b ) ( b a -- a ) r> r> r> rot rot >r >r ;


( Debug words )
: .? ( n -- n ) dup . cr ;
: .?? ( n n -- n n ) 2dup . . cr ;
: .??? ( n n n -- n n n ) save>r . save>r . save>r . r> r> r> cr ;
: .d? ." Depth: " depth . cr ;
: .x? save>r 0 do dup . >r swapr loop r> 0 do r> loop cr ;


( Makes a copy of n in the R stack )
: save>r ( n -- n ) ( -- n ) dup r> swap >r >r ;

( Copies the top of the call stack onto the data stack )
: r>copy ( -- n ) ( n -- n ) r> r> save>r swap >r ;

: .? ( n -- n ) dup . cr ;
: .?? ( n n -- n n ) 2dup . . cr ;
: .??? ( n n n -- n n n ) save>r . save>r . save>r . r> r> r> cr ;


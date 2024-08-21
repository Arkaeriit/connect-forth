( Makes a copy of n in the R stack )
:macro save>r ( n -- n ) ( -- n ) dup >r ;

( Copies the top of the call stack onto the data stack )
:macro r>copy ( -- n ) ( n -- n ) r> save>r ;

: .? ( n -- n ) dup . cr ;
: .?? ( n n -- n n ) 2dup . . cr ;
: .??? ( n n n -- n n n ) save>r . save>r . save>r . r> r> r> cr ;


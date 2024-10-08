.PHONY: all
all : connect-forth.frt

connect-forth.frt: cli-play.frt c4.frt
	preforth $< $@

c4.frt : interactive-play.frt game.frt connect.frt board.frt helpers.frt
	preforth $< $@

compact.frt : c4.frt
	cat $< | sed -z 's:\n: :g; s:(\s[^)]*)::g' > $@

devzat-display.frt : compact.frt
	printf ' : (bye) 0 ! ; ' >> $@
	cat $< >> $@
	printf ' s" ```\\n" display-frame 2! ' >> $@

devzat.frt : devzat-display.frt
	cat $< | sed 's:\(.\{3000\}[^ ]*\):\1\n:' | sed 's:^:forth:' > $@

test: connect-forth.frt
	amforth $<

clean:
	rm -f c4.frt
	rm -f devzat.frt
	rm -f compact.frt
	rm -f connect-forth.frt
	rm -f devzat-display.frt


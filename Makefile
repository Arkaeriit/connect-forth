connect-forth.frt: cli-play.frt c4.frt
	preforth $< $@

c4.frt : interactive-play.frt game.frt connect.frt board.frt
	preforth $< $@

test: connect-forth.frt
	amforth $<

clean:
	rm -f c4.frt
	rm -f connect-forth.frt


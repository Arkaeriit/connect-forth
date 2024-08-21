c4.frt: interactive-play.frt game.frt connect.frt board.frt
	preforth $< $@

test: c4.frt
	amforth $<

clean:
	rm -f c4.frt


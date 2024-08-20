c4.frt: connect.frt board.frt
	preforth $< $@

test: c4.frt
	amforth $<

clean:
	rm -f c4.frt


SRC = $(wildcard ./*.d)
BIN = $(basename $(SRC))

DMD = dmd

compile: $(BIN)

%: %.d
	$(DMD) $<

clean:
	rm -f *.o $(BIN)

all:
	@echo compile, clean

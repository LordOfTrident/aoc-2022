SRC = $(wildcard ./*.zig)
BIN = $(basename $(SRC))

ZIG = zig

compile:
	$(ZIG) build

clean:
	rm -f *.o $(BIN)
	rm -r -f ./zig-out/
	rm -r -f ./zig-cache/

all:
	@echo compile, clean

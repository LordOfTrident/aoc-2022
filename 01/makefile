SRC = $(wildcard ./*.pas)
BIN = $(basename $(SRC))

FPC = fpc
FPC_FLAGS = -O4

compile: $(BIN)

%: %.pas
	$(FPC) $(FPC_FLAGS) $< -o$@

clean:
	rm -f *.o $(BIN)

all:
	@echo compile, clean

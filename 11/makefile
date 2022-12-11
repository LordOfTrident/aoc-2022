SRC = $(wildcard ./*.nim)
BIN = $(basename $(SRC))

NIM = nim

compile: $(BIN)

%: %.nim
	$(NIM) c $<

clean:
	rm -f $(BIN)

all:
	@echo compile, clean

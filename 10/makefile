SRC = $(wildcard ./*.cs)
BIN = $(basename $(SRC))

MCS = mcs

compile: $(BIN)

%: %.cs
	$(MCS) $< -out:$@

clean:
	rm -f $(BIN)

all:
	@echo compile, clean

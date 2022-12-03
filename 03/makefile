SRC = $(wildcard ./*.go)
BIN = $(basename $(wildcard ./*.go))

GO = go

compile: $(BIN)

%: %.go
	$(GO) build -o $@ $<

clean:
	rm -f $(BIN)

all:
	@echo compile, clean

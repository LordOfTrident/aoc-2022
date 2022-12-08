SRC = $(wildcard ./*.c)
BIN = $(basename $(SRC))

CC       = gcc
CC_VER   = c99
CC_FLAGS = -Og -std=$(CC_VER) -Wall -Wextra -Werror -pedantic -Wno-deprecated-declarations

compile: $(BIN)

%: %.c
	$(CC) $(CC_FLAGS) $< -o $@

clean:
	rm -f *.o $(BIN)

all:
	@echo compile, clean

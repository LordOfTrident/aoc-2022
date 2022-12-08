SRC = $(wildcard ./*.cc)
BIN = $(basename $(SRC))

CXX       = g++
CXX_VER   = c++17
CXX_FLAGS = -Og -std=$(CXX_VER) -Wall -Wextra -Werror -pedantic -Wno-deprecated-declarations

compile: $(BIN)

%: %.cc
	$(CXX) $(CXX_FLAGS) $< -o $@

clean:
	rm -f *.o $(BIN)

all:
	@echo compile, clean

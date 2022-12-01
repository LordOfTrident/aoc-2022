SRC = main.pas
APP = app

FPC = fpc
FPC_FLAGS = -O4

compile:
	$(FPC) $(FPC_FLAGS) $(SRC) -o$(APP)

clean:
	rm -f *.o $(APP)

all:
	@echo compile, clean

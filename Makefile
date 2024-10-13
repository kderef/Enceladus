CC = g++
SRC = src/main.cc
BIN = bin/station-neptune-7
CSTD = c++11
CFLAGS = -std=$(CSTD) \
	-Iext/raylib/src -Iext/incbin -Iext/raygui/src \
	-Lext/raylib/src -lraylib

LIBRAYLIB = ext/raylib/src/libraylib.a

ifeq ($(OS), Windows_NT)
	# TODO Link
	CFLAGS += -static
else
	UNAME_S := $(shell uname -s)

	ifeq ($(UNAME_S),Linux)
    	# CCFLAGS += -D LINUX
	endif
	ifeq ($(UNAME_S),Darwin)
    	CFLAGS += \
    		-framework CoreVideo -framework IOKit -framework Cocoa -framework GLUT -framework OpenGL 
	endif
endif


build: $(LIBRAYLIB)
	$(CC) $(SRC) -o $(BIN) $(CFLAGS)

mingw:
	$(eval CC = x86_64-w64-mingw32-g++)

debug:
	$(eval CFLAGS += -Og -DDEBUG)

optimize:
	$(eval CFLAGS += -Ofast)

run: $(LIBRAYLIB)
	$(BIN)

$(LIBRAYLIB):
	make -C ext/raylib/src

exec: build run

.PHONY: clean mingw build run exec

.PHONY: all clean
CC = gcc
CFLAGS= -Wall -Werror
EXECUTABLE = geometry.exe
all: bin/$(EXECUTABLE)

bin/$(EXECUTABLE):build/my_prog.o build/perimetr.o build/square.o
	$(CC) $(CFLAGS) build/my_prog.o build/perimetr.o build/square.o -lm -o bin/$(EXECUTABLE)
build/my_prog.o: src/my_prog.c
	$(CC) $(CFLAGS) src/my_prog.c -o build/my_prog.o -c -lm 

build/perimetr.o: src/perimetr.c
	$(CC) $(CFLAGS) src/perimetr.c -o build/perimetr.o -c -lm 

build/square.o: src/square.c
	$(CC) $(CFLAGS) src/square.c -o build/square.o -c -lm
test: bin/geometry_test

bin/geometry_test: build/test/main.o build/test/square.o build/test/perimetr.o build/test/peres.o
	$(CC) $(CFLAGS) build/test/main.o build/test/square.o build/test/perimetr.o build/test/peres.o -o bin/geometry_test -lm
build/test/main.o: test/main.c
	$(CC) $(CFLAGS) -c -I thirdparty -I src test/main.c -o build/test/main.o

build/test/square.o: src/square.o src/foo.h
	$(CC) $(CFLAGS) -c -I thirdparty -I src src/square.c -o build/test/square.o
build/test/perimetr.o: src/perimetr.o src/foo.h
	$(CC) $(CFLAGS) -c -I thirdparty -I src src/perimetr.c -o build/test/perimetr.o
build/test/peres.o: src/peres.o src/foo.h
	$(CC) $(CFLAGS) -c -I thirdparty -I src src/peres.c -o build/test/peres.o

clean:
	rm -rf build/*.o bin/*.exe

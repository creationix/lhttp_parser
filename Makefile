CFLAGS=-Ihttp-parser -I${HOME}/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -Wall -Werror -fPIC
LIBS=-lm -lpthread -lrt

all: lhttp_parser.so

http-parser/http_parser.o:
	CPPFLAGS=-fPIC $(MAKE) -C http-parser http_parser.o

lhttp_parser.o: lhttp_parser.c lhttp_parser.o
	$(CC) -c $< -o $@ ${CFLAGS}

lhttp_parser.so: lhttp_parser.o http-parser/http_parser.o
	$(CC) -o lhttp_parser.so lhttp_parser.o http-parser/http_parser.o ${LIBS} -shared

clean:
	rm -f *.so *.o

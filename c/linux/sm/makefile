CC = gcc -Wall
INCLUDE= -I./ -I/usr/include/pgsql
LIB= -L./ -L/usr/lib/pgsql
LDFLAGS= -lpadrao -lpq

COMPILE = ${CC} ${INCLUDE} ${LIB}

OBJECTS =

all:
	${COMPILE} -o sm main.c ${LDFLAGS} -O ${OBJECTS}

install:
	install -c -m 0700 sm /usr/local/bin
	install -c -m 0700 smd /etc/rc.d/init.d
	ln -sf /etc/rc.d/init.d/smd /etc/rc.d/rc3.d/S99smd

clean:
	rm -f *core* sm *~ *.so *.o

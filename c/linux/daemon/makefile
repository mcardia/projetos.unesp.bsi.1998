CC = gcc -Wall -O2
INCLUDE= -I./ -I/usr/include/pgsql
LIB= -L./ -L/usr/lib/pgsql
LDFLAGS= -lpadrao -lpq

COMPILE = ${CC}

OBJECTS = http.o base.o mail.o proxy.o ftp.o outros.o

all:
	${COMPILE} -c http.c   ${INCLUDE} ${LIB}
	${COMPILE} -c base.c   ${INCLUDE} ${LIB}
	${COMPILE} -c mail.c   ${INCLUDE} ${LIB}
	${COMPILE} -c proxy.c  ${INCLUDE} ${LIB}
	${COMPILE} -c ftp.c    ${INCLUDE} ${LIB}
	${COMPILE} -c outros.c ${INCLUDE} ${LIB}

	${COMPILE} -o netmon main.c ${OBJECTS} ${INCLUDE} ${LIB} ${LDFLAGS}

clean:
	rm -f *core* netmon *~ *.o *.o

install:
	install -c -m 0700 -o root -g root netmon /usr/local/bin
	install -c -m 0700 -o root -g root netmon.conf /etc

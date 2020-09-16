CC = gcc -Wall -static
CCFLAGS = -I./ -I/usr/include/pgsql
LDFLAGS = -L./ -L/usr/lib/pgsql
OPT =

COMPILE = $(CC)

all:
	$(COMPILE) -c util.c $(CCFLAGS) $(LDFLAGS) $(OPT)
	$(COMPILE) -c socket.c $(CCFLAGS) $(LDFLAGS) $(OPT)
	$(COMPILE) -c time.c $(CCFLAGS) $(LDFLAGS) $(OPT)
	$(COMPILE) -c file.c $(CCFLAGS) $(LDFLAGS) $(OPT)
	$(COMPILE) -c net.c $(CCFLAGS) $(LDFLAGS) $(OPT)
	$(COMPILE) -c db.c $(CCFLAGS) $(LDFLAGS) $(OPT)
	$(COMPILE) -c read_conf.c $(CCFLAGS) $(LDFLAGS) $(OPT)
	$(COMPILE) -c named.c $(CCFLAGS) $(LDFLAGS) $(OPT)
	$(COMPILE) -c fping/fping.c -DHAVE_CONFIG_H -I./fping

install:
	ar -rc libpadrao.a *.o
	chmod 600 makefile *.c *.o *.h *.a
	install -c -m 0600 libpadrao.h /usr/local/include/
	install -c -m 0700 libpadrao.a /usr/local/lib/

deinstall:
	rm -f /usr/local/include/libpadrao.h /usr/local/include/libpadrao.a

clean:
	rm -f *.o *.a *~
	rm -f *core teste


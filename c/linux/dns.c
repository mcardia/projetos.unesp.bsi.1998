#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

int main(int argc, char **argv) {
	struct in_addr *host_add;
	struct hostent *host_ent;
	int i;

	if ( argc < 2 )
	{
		printf("Usage: %s hostname\n", argv[0]);
		exit(-1);
	}

	printf("Resolvendo %s...\n", argv[1]);
	host_ent = gethostbyname(argv[1]);

	if (host_ent == NULL) {	
		printf("Nao foi possivel resolver %s\n", argv[1]);
		exit(-1);
	}
	printf("Formatando dados...\n");
	host_add = (struct in_addr *) *(host_ent->h_addr_list) ;
	if (host_add == NULL) {
		printf("Nao foi possivel resolver %s\n", argv[1]);
		exit(-1);
	} else {
		i = 0;
		while (host_add) {
        		printf("%s -> %s\n", argv[1], inet_ntoa(*host_add));
	      		host_add = (struct in_addr *) (host_ent->h_addr_list[++i]) ;
	    	}
	}
	return(0);
}

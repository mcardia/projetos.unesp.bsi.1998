#include<libpadrao.h>

int socket_server( int port )
{
	int sock, sk;	
	struct sockaddr_in sk_addr;
	int ret = sizeof (sk_addr);
	
	if ( (sock = socket(PF_INET, SOCK_STREAM, 0)) == -1 )
	{
		fprintf(stderr, "Erro criando sockect\n");
		return(-1);
	}
	
	memset ( &sk_addr, 0, sizeof(sk_addr) );
	sk_addr.sin_family=PF_INET;
	sk_addr.sin_addr.s_addr=htonl(INADDR_ANY);
	sk_addr.sin_port=htons(port);
	
	if ( bind(sock, (struct sockaddr *)&sk_addr, sizeof(sk_addr)) == -1 )
	{
		fprintf(stderr,"Erro no bind\n");
		return(-1);
	}

	if ( listen(sock, 1) == -1 )
	{
		fprintf(stderr,"Erro no listen\n");
		return(-1);
	}
	
	if ( (sk = accept(sock, (struct sockaddr *)&sk_addr, &ret )) == -1 )
	{
		fprintf(stderr, "Erro no accept\n");
		return(-1);
	}

	return(sk);
}

int socket_client(char *server, int port) 
{
	int sock;
	struct sockaddr_in sk_addr;
	struct hostent *he;
	
	memset( (char *)&sk_addr, '\0', sizeof(sk_addr) );
	
	sk_addr.sin_family=PF_INET;
	sk_addr.sin_addr.s_addr=inet_addr(server);
	sk_addr.sin_port=htons(port);
	
	if ((he = gethostbyname(server)) != NULL)
	{
		bcopy(he->h_addr, (char *)&sk_addr.sin_addr, he->h_length);
	} else 
	{
		if ( (sk_addr.sin_addr.s_addr = inet_addr(server)) < 0 ) 
		{
			return(-1);
		}
	}
	sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
	if ( connect(sock,(struct sockaddr *)&sk_addr,sizeof(sk_addr)) == -1 ) 
	{
		close(sock);
		return(-1);
	}
	return(sock);
}

char *read_socket(int sock) 
{
	char buffer[1024], *result;
		
	sleep(1); 
	memset(buffer,'\0',1024);
	read(sock,buffer,1024);
	result = buffer;
	return( result );
}

char *readln_socket(int sock)
{
	FILE *fp;
	char buffer[255];
	
	memset(buffer, 0, 255);
	
	fp=fdopen(sock,"r");
	while ( !feof(fp) )
	{
		fgets(buffer, 254, fp);
		fprintf(stdout, "%s", buffer);
	}
	(void)fclose(fp);
	return NULL;
}

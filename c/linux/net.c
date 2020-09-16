#include <libpadrao.h>

int send_mail(char *host, char *from, char *to, char *subject, char *message)
{
	typedef char string[1024];
	char domain[255];
	char lixo[255];
	char *from_aux;
	string msg[6];
	char data[255];
	char buff[255];
	
	int  sock;
	int  i;
	int ret = 0;
		
	from_aux = (char*) malloc (strlen(from));	
	memset(domain, 0, 255);
	memset(lixo,   0, 255);
	memset(from_aux,   0, strlen(from));
	
	for ( i = 0; i<=5; i++ )
		memset(msg[i], 0, 1024);
	
	memset(data,   0, 255);
	
	strcpy(from_aux, from);
	strcpy(lixo,   strtok(from_aux, "@"));
	strcpy(domain, strtok(NULL,     "@"));
	free(from_aux);
	
	get_time( data, "%d %b %Y %r");
	 
	memset( msg, 0, 500 );
	
	sprintf( msg[0], "HELO %s\r\n",        domain);
	sprintf( msg[1], "MAIL FROM:<%s>\r\n", from);
	sprintf( msg[2], "RCPT TO:<%s>\r\n",   to);
	sprintf( msg[3], "DATA\r\n");
	sprintf( msg[4], "From: %s\r\nTo: %s\r\nDate: %s\r\nSubject: %s\r\n\r\n%s\r\n.\r\n", 
		 from, to, data, subject, message);
	sprintf( msg[5], "QUIT\r\n");
	
	while ( (sock = socket_client(host, 25)) == -1 )
	{
		sleep(1);
	}
	
	for ( i = 0; i <= 5; i++ )
	{
		if ( send(sock, msg[i], strlen(msg[i]), 0) == -1 )
		{
			ret = -1;
			break;
		}
		usleep(300000);
		memset(buff, 0, 255);
		if ( recv(sock, buff, 255, 0) == -1 )
		{
			ret = -2;
			break;
		}
		if ( i == 1 )
		{
			if ( !strstr(buff, "ok") )
			{
				ret = -3;
				break;
			}
		}
	}
	close(sock);
	return(ret);
}

int send_sms(char *prefixo, char *celular, char *sender, char *mensagem) 
{
	int cont, sock;
	char buffer[7][1024], form[1024];
	int length=0;

	memset(form,    0, 1024);

	for ( cont=0; cont <= 6; cont++ )
	{
		memset(buffer[cont],  0, 1024);
	}
	
	length = strlen(mensagem);
	
	sprintf(form, 
"INAPPLICATION=1&msg_total=%s&totalChars=%d&Check=yes&pre1=%s&min=%s&msg=%s&sender=%s", mensagem, length, prefixo, celular, mensagem, sender);	     	

	sprintf(buffer[0], "POST /submit.asp HTTP/1.1\r\n");
	sprintf(buffer[1], "Accept: *.*\r\n");
	sprintf(buffer[2], "Content-Type: application/x-www-form-urlencoded\r\n");
	sprintf(buffer[3], "Host: www.torpedoinfo.com.br\r\n");
	sprintf(buffer[4], "Content-Length: %d\r\n", strlen(form) );
	sprintf(buffer[5], "Connection: Close\r\n\r\n");
	sprintf(buffer[6], "%s\r\n", form);

	cont = 1;
	sock = socket_client("www.torpedoinfo.com.br", 80);
	while ( cont++ <= 10 || (sock == -1) )
	{
		close(sock);
		sock = socket_client("www.torpedoinfo.com.br", 80);
	}

	if ( cont == 10 && sock == -1 )
	{
		return(0);
	}

	for ( cont = 0; cont <= 6; cont++ )
	{
		write( sock, buffer[cont], strlen(buffer[cont]) );
	}

	close(sock);
	return(1);
}


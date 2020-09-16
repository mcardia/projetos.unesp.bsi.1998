void send_pager(int grupo, char *msg) 
{
	time_t horario_t;
	int sock, i;
	char string1[1024], string2[1024], string3[1024],
	     string4[1024], string5[1024], string6[1024], string7[1024],
	     hora[17],
	     mensagem[1024],
	     celular[1024];
	FILE *pager;
	
	memset(hora, 0, 17);
	memset(mensagem, 0, 1024);
	memset(celular, 0, 1024);
	memset(string1, 0, 1024);
	memset(string2, 0, 1024);
	memset(string3, 0, 1024);
	memset(string4, 0, 1024);
	memset(string5, 0, 1024);
	memset(string6, 0, 1024);
	memset(string7, 0, 1024);

	if ( ( pager = fopen("/etc/pager.conf", "r")) == NULL )
	{
		fprintf(stderr, "Erro ao abrir o arquiv pager.conf\n");
		exit(0);
	}
	
	horario_t = time (NULL);
	strftime(hora, 17, "%H:%M-%d/%m/%y", localtime( &horario_t )); 
	
	while ( !feof(pager) )
	{
		memset(celular, 0, 1024);
		fgets(celular, 1024, pager);
		
		sprintf(mensagem, "INAPPLICATION=1&msg_total=%s&totalChars=%d&Check=yes&pre1=14&min=%s&msg=%s-%s", msg, strlen(msg), celular, msg, hora);	     	

		sprintf(string1, "POST /submit.asp HTTP/1.1\r\n");
		sprintf(string2, "Accept: */*\r\n");
		sprintf(string3, "Content-Type: application/x-www-form-urlencoded\r\n");
		sprintf(string4, "Host: www.torpedoinfo.com.br\r\n");
		sprintf(string5, "Content-Length: %d\r\n", strlen(mensagem));
		sprintf(string6, "Connection: Close\r\n\r\n");
		sprintf(string7, "%s\r\n", mensagem);
	
		fprintf(stdout, "Conectando... ");
		sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
		while ( open_sock(sock, "www.torpedoinfo.com.br", 80) == -1 )
		{
			close(sock);
			sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
			sleep(1);
		}
		fprintf(stdout, "Conectado.\n");
	
		fprintf(stdout, "Enviando pager para (14) - %s ...", celular);
		write( sock, string1, strlen(string1) );
		write( sock, string2, strlen(string2) );
		write( sock, string3, strlen(string3) );
		write( sock, string4, strlen(string4) );
		write( sock, string5, strlen(string5) );
		write( sock, string6, strlen(string6) );
		write( sock, string7, strlen(string7) );
		fprintf(stdout, "Concluido.\n\n");
		recv_dados(sock);
		close(sock);
	}
}


#include <libnetmon.h>

#define TABELA      "mail"
#define TIPO        "mail"

void mail(void)
{
        PGresult *query;
	int linha = 0;
        char str_sql[255];
	char servidor[40], host_smtp[255], host_pop3[255];
	char mensagem[255];

	int port_smtp=25, port_pop3=110, id=0, id_status_smtp, id_status_pop3;
	int sock, cont=1, err_pop3, err_smtp, id_erro;

        memset(str_sql, 0, 255);

        strcpy(str_sql, "SELECT id, servidor, host_smtp, host_pop3, port_smtp, port_pop3, id_status_smtp, id_status_pop3
			 FROM mail
			 ORDER BY servidor");	
        query = db_query(str_sql);

        while ( ! db_eof(query, linha) )
        {
		id = atoi(db_get(query, linha, "id"));
		memset (servidor, 0, 40);
		strncpy (servidor, trim(db_get(query, linha, "servidor")), strlen(db_get(query, linha, "servidor")));

		memset (host_smtp, 0, 255);
		memset (host_pop3, 0, 255);
		strncpy (host_smtp, trim(db_get(query, linha, "host_smtp")), strlen(db_get(query, linha, "host_smtp")));
		strncpy (host_pop3, trim(db_get(query, linha, "host_pop3")), strlen(db_get(query, linha, "host_pop3")));

		port_smtp=atoi(db_get(query, linha, "port_smtp"));
		port_pop3=atoi(db_get(query, linha, "port_pop3"));
                id_status_smtp = atoi(db_get(query, linha, "id_status_smtp"));
                id_status_pop3 = atoi(db_get(query, linha, "id_status_pop3"));
		
		err_smtp = 0;
		err_pop3 = 0;
		cont = 1;
                id_erro = 0;

       		while ( cont++ <= NUM_TEST )
       		{
                    if ( fping(host_smtp) )
                    {
			fprintf(stdout, "SMTP: %s:%d\n", host_smtp, port_smtp);
		      	sock = socket_client(host_smtp, port_smtp);
		       	if ( sock == -1 )
		       	{
                            err_smtp++;
			}
			close(sock);
                    } else
                    {
			err_smtp++;
                    }
                }

                cont=1;

		while ( cont++ <= NUM_TEST )
		{
                    if ( fping(host_pop3) )
                    {
			fprintf(stdout, "POP3: %s:%d\n", host_pop3, port_pop3);
		       	sock = socket_client(host_pop3, port_pop3);
		       	if ( sock == -1 )
		       	{
                            err_pop3++;
			}
			close(sock);
                    } else
                    {
			err_pop3++;
                    }
                }

		memset(mensagem, 0, 255);
		if ( !err_smtp )
                {
                    memset(mensagem, 0, 255);
		    sprintf(mensagem, "Servidor SMTP: %s [%s] esta funcionando.\n", servidor, host_smtp);
                    id_erro=0;
                    update_status_mail(id, 1, TABELA, "smtp");
		} else
		{
                    if ( err_smtp < NUM_TEST )
		    {
		       	memset(mensagem, 0, 255);
		       	sprintf(mensagem, "Aviso SMTP: %s [%s] está instável\n", servidor, host_smtp);
                        id_erro=2;
                        update_status_mail(id, 2, TABELA, "smtp");
                    }
                    if ( err_smtp >= NUM_TEST )
		    {
		       	memset(mensagem, 0, 255);
		       	sprintf(mensagem, "Erro SMTP: %s [%s]\n", servidor, host_smtp);
                        id_erro=1;
                        update_status_mail(id, 2, TABELA, "smtp");
		    }
		}

                if ( (id_erro) || (!id_erro && id_status_smtp != 1) )
                {
		        alert(mensagem);
                }
                estatistica( id, TIPO, id_erro);

		id_erro=0;

                memset(mensagem, 0, 255);
		if ( !err_pop3 )
                {
                    memset(mensagem, 0, 255);
		    sprintf(mensagem, "Servidor SMTP: %s [%s] esta funcionando.\n", servidor, host_pop3);
                    id_erro=0;
                    update_status_mail(id, 1, TABELA, "pop3");
		} else
		{
                    if ( err_pop3 < NUM_TEST )
		    {
		       	memset(mensagem, 0, 255);
		       	sprintf(mensagem, "Aviso POP3: %s [%s] está instável\n", servidor, host_pop3);
                        id_erro=2;
                        update_status_mail(id, 2, TABELA, "pop3");
                    }
                    if ( err_pop3 >= NUM_TEST )
		    {
		       	memset(mensagem, 0, 255);
		       	sprintf(mensagem, "Erro POP3: %s [%s]\n", servidor, host_pop3);
                        id_erro=1;
                        update_status_mail(id, 2, TABELA, "pop3");
		    }
		}

                if ( (id_erro) || (!id_erro && id_status_pop3 != 1) )
                {
		        alert(mensagem);
                }
                estatistica( id, TIPO, id_erro);
                linha++;
	}
        db_free(query);
}


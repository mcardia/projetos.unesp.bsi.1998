#include <libnetmon.h>

#define TABELA      "outros"
#define TIPO        "outros"

void outros(void)
{
        PGresult *query;
        int linha=0;
        char str_sql[255];
	char servidor[40], host[255];
	char mensagem[255];

	int port=0, id=0, id_status, id_tcp=0;
	int sock, cont=1, err_outros=0, id_erro;

        memset(str_sql, 0, 255);

        strcpy(str_sql, "SELECT id, servidor, host, port, id_tcp, id_status
			 FROM outros
			 ORDER BY servidor");	
        query = db_query(str_sql);

        while ( ! db_eof(query, linha) )
        {
		id = atoi(db_get(query, linha, "id"));
		memset (servidor, 0, 40);
		strncpy (servidor, trim(db_get(query, linha, "servidor")), strlen(db_get(query, linha, "servidor")));

		memset (host, 0, 255);
		strncpy (host, trim(db_get(query, linha, "host")), strlen(db_get(query, linha, "host")));

		port=atoi(db_get(query, linha, "port"));
                id_tcp = atoi(db_get(query, linha, "id_tcp"));
                id_status = atoi(db_get(query, linha, "id_status"));
		
		err_outros = 0;
		cont = 1;
                id_erro = 0;

                while ( cont++ <= NUM_TEST )
                {
                    if ( fping(host) )
                    {
                        if ( id_tcp )
                        {
			    fprintf(stdout, "\t- %s:%d\n", host, port);
                            sock = socket_client(host, port);
                            if ( sock == -1 )
                            {
		       		err_outros++;
                            }
                            close(sock);
                        }
                    } else
                    {
                        err_outros++;
                    }
                }

                memset(mensagem, 0, 255);
                if ( !err_outros )
                {
                    memset(mensagem, 0, 255);
                    sprintf(mensagem, "Servidor: %s [%s] esta funcionando.\n", servidor, host);
                    id_erro=0;
                    update_status(id, 1, TABELA);
                } else
                {
                    if ( err_outros < NUM_TEST )
                    {
                        memset(mensagem, 0, 255);
                        sprintf(mensagem, "Aviso: %s [%s] est� inst�vel\n", servidor, host);
                        id_erro=2;
                        update_status(id, 3, TABELA);
                    }
                    if ( err_outros >= NUM_TEST )
                    {
                        memset(mensagem, 0, 255);
                        sprintf(mensagem, "Erro: %s [%s]\n", servidor, host);
                        id_erro=1;
                        update_status(id, 2, TABELA);
                    }
                }

                if ( (id_erro) || (!id_erro && id_status != 1) )
                {
		        alert(mensagem);
                }

                estatistica( id, TIPO, id_erro );
                linha++;
        }
        db_free(query);
}


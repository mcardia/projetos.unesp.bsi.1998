#include <libnetmon.h>

#define TABELA      "bases"
#define TIPO        "bases"

void bases(void)
{
        PGresult *query;
	int linha = 0;
        char str_sql[255];
	char servidor[40], host[255];
	char mensagem[255];
        char tipo[255];

	int port=0, id=0, id_status, id_tipo;
	int sock, cont=1, err_base=0, id_erro;

        memset(str_sql, 0, 255);

        strcpy(str_sql, "SELECT id, servidor, host, id_tipo, id_status, tipo
			 FROM bases LEFT JOIN bases_tipo ON ( bases.id_tipo = bases_tipo.id )
			 ORDER BY servidor");	
        query = db_query(str_sql);

        while ( ! db_eof(query, linha) )
        {
		id = atoi(db_get(query, linha, "id"));
		memset (servidor, 0, 40);
		strncpy (servidor, trim(db_get(query, linha, "servidor")), strlen(db_get(query, linha, "servidor")));

		memset (host, 0, 255);
		strncpy (host, trim(db_get(query, linha, "host")), strlen(db_get(query, linha, "host")));

                id_tipo=atoi(db_get(query, linha, "id_tipo"));

                switch ( id_tipo )
                {
                    case 1 : port = 3306; break;
                    case 2 : port = 1433; break;
                    case 3 : port = 5432; break;
                    default : port = 3306; break;
                }

                id_status = atoi(db_get(query, linha, "id_status"));
		
                memset(tipo, 0, 255);
                strncpy(tipo, trim(db_get(query, linha, "tipo")), strlen(db_get(query, linha, "tipo")));

		err_base = 0;
		cont = 1;
                id_erro = 0;

                while ( cont++ <= NUM_TEST )
                {
                    if ( fping(host) )
                    {
			fprintf(stdout, "\t- %s:%d\n", host, port);
                        sock = socket_client(host, port);
			if ( sock == -1 )
			{
                            err_base++;
			}
			close(sock);
                    } else
                    {
			err_base++;
                    }
                }

		memset(mensagem, 0, 255);
		if ( !err_base )
                {
                    memset(mensagem, 0, 255);
		    sprintf(mensagem, "Servidor %s: %s [%s] esta funcionando.\n", tipo, servidor, host);
                    id_erro=0;
                    update_status(id, 1, TABELA);
		} else
		{
			if ( err_base < NUM_TEST)
			{
				memset(mensagem, 0, 255);
				sprintf(mensagem, "Aviso DATABASE: %s [%s] está instável\n", servidor, host);
                                id_erro=2;
                                update_status(id, 2, TABELA);
                        }
                        if ( err_base >= NUM_TEST)
			{
				memset(mensagem, 0, 255);
				sprintf(mensagem, "Erro DATABASE: %s [%s]\n", servidor, host);
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


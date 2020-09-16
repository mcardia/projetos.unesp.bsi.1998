#include <libnetmon.h>

int main(int argc, char **argv)
{
    int opt;
    int fl_http = 0, fl_mail = 0, fl_proxy = 0, fl_ftp = 0, fl_bases = 0, fl_outros = 0;

    init();

    if ( ! db_connect(DB_HOST, DB_BASE, DB_USER, DB_PASS) )
	{
		fprintf(stderr, "Nao foi possivel conectar com o bando de dados\n");
	}

        if ( argc == 1 ) usage();

        while (1)
        {
            opt = getopt(argc, argv, "AHMPFBOh");

            if ( opt == -1 ) break;

            switch ( opt )
            {
                case 'H' : fl_http=1;  break;
                case 'M' : fl_mail=1;  break;
                case 'P' : fl_proxy=1; break;
                case 'F' : fl_ftp=1;   break;
                case 'B' : fl_bases=1; break;
                case 'O' : fl_outros=1; break;
                case 'A' : fl_http=1; fl_mail=1; fl_proxy=1;
                           fl_ftp=1; fl_bases=1; fl_outros=1; break;
                default  : usage();
            }
        }

        if ( fl_http )
        {
            fprintf(stdout, "Testando http...\n");
            http();
        }
        if ( fl_mail )
        {
            fprintf(stdout, "Testando mail...\n");
            mail();
        }
        if ( fl_proxy )
        {
            fprintf(stdout, "Testando proxy...\n");
            proxy();
        }
        if ( fl_ftp )
        {
            fprintf(stdout, "Testando ftp...\n");
            ftp();
        }
        if ( fl_bases )
        {
            fprintf(stdout, "Testando bases...\n");
            bases();
        }
        if ( fl_outros )
        {
            fprintf(stdout, "Testando outros servidores...\n");
            outros();
        }

        db_close();
	return(0);
}

void estatistica(int id, char *tipo, int erro)
{
    char data[20];
    char str_sql[255];
    int id_tipo = 0;
    int val = 0;

    PGresult *query;
    
    memset(data, 0, 20);
    strcpy(data, db_datetime());

    memset(str_sql, 0, 255);
    sprintf(str_sql, "SELECT id FROM tipo_servidor WHERE tipo = '%s'", trim(tipo));
    query = db_query(str_sql);
    if ( db_count(query) )
    {
        id_tipo = atoi(db_get(query, 0, "id"));
    } else
    {
        fprintf(stderr, "Tipo de servidor inexistente\n");
        exit(-1);
    }
    db_free(query);

    memset(str_sql, 0, 255);
    sprintf(str_sql, "SELECT id, erros, ok FROM estatistica
                      WHERE data = '%s'
                      AND   id_servidor = %d
                      AND   id_tipo = %d", data, id, id_tipo);
    query = db_query(str_sql);

    memset(str_sql, 0, 255);

    if ( db_count(query) )
    {
        if ( erro )
        {
            val = atoi(db_get(query, 0, "erros")); val++;
            sprintf(str_sql, "UPDATE estatistica SET
                              erros = %d WHERE id = %d", val, atoi(db_get(query, 0, "id")));
        } else
        {
            val = atoi(db_get(query, 0, "ok")); val++;
            sprintf(str_sql, "UPDATE estatistica SET
                              ok = %d WHERE id = %d", val, atoi(db_get(query, 0, "id")));
        }

    } else
    {
        if ( erro )
        {
            sprintf(str_sql, "INSERT INTO estatistica ( id_servidor, id_tipo, data, erros, ok )
                              VALUES ( %d, %d, '%s', %d, %d)", id, id_tipo, data, 1, 0);
        } else
        {
            sprintf(str_sql, "INSERT INTO estatistica ( id_servidor, id_tipo, data, erros, ok )
                              VALUES ( %d, %d, '%s', %d, %d)", id, id_tipo, data, 0, 1);
        }
    }
    db_free(query);
    (void)db_query(str_sql);
}

void update_status(int id, int id_status, char *tabela)
{
        char str_sql[255];

        memset( str_sql, 0, 255 );
        sprintf( str_sql, "UPDATE %s SET id_status=%d WHERE id=%d", tabela, id_status, id);
        (void)db_query(str_sql);

        return;
}

void update_status_mail(int id, int id_status, char *tabela, char *tipo)
{
        char str_sql[255];

        memset( str_sql, 0, 255 );
        sprintf( str_sql, "UPDATE %s SET id_status_%s=%d WHERE id=%d", tabela, tipo, id_status, id);
        (void)db_query(str_sql);

        return;
}

void alert(char *mensagem)
{
	PGresult *query;
	char str_sql[255];
	char prefixo[20], celular[20], email[255];
        int id_email, id_celular, linha=0;

	memset(str_sql, 0, 255);

	strcpy(str_sql, "SELECT prefixo, celular, email, id_celular, id_email FROM contatos");

	query = db_query(str_sql);

	while ( ! db_eof(query, linha) )
	{
		memset(prefixo, 0, 20);
		memset(celular, 0, 20);
		memset(email,   0, 255);

		strncpy(prefixo, db_get(query, linha, "prefixo"), strlen(db_get(query, linha, "prefixo")));
		strncpy(celular, db_get(query, linha, "celular"), strlen(db_get(query, linha, "celular")));
		strncpy(email,   db_get(query, linha, "email"),   strlen(db_get(query, linha, "email")));

                id_celular = atoi(db_get(query, linha, "id_celular"));
                id_email = atoi(db_get(query, linha, "id_email"));

                if ( id_celular )
                {
                    printf("\t\t**enviando SMS para: (%s) %s\n", prefixo, celular);
                    (void) send_sms(prefixo, celular, SUBJECT, mensagem);
                }
                if ( id_email )
                {
                    printf("\t\t**enviando email para: %s\n", email);
                    (void) send_mail(MAIL_HOST, MAIL_FROM, email, SUBJECT, mensagem);
                }
		linha++;
	}
	db_free(query);

	return;
}

void init()
{
    struct _tabela *config;

    if ( (config = read_conf("./netmon.conf")) == NULL )
    {
        if ( (config = read_conf("/etc/netmon.conf")) == NULL )
        {
            if ( (config = read_conf("~/.netmon.conf")) == NULL )
            {
                fprintf(stderr, "Não foi possível ler o arquivo de configuração\n");
                exit(-1);
            }
        }
    }

    while ( config )
    {
        if ( strcmp(config->atomo, "DB_HOST")==0 )
            input(config->valor, DB_HOST, 255);
        if ( strcmp(config->atomo, "DB_BASE")==0 )
            input(config->valor, DB_BASE, 255);
        if ( strcmp(config->atomo, "DB_USER")==0 )
            input(config->valor, DB_USER, 255);
        if ( strcmp(config->atomo, "DB_PASS")==0 )
            input(config->valor, DB_PASS, 255);
        if ( strcmp(config->atomo, "MAIL_HOST")==0 )
            input(config->valor, MAIL_HOST, 255);
        if ( strcmp(config->atomo, "MAIL_FROM")==0 )
            input(config->valor, MAIL_FROM, 255);
        if ( strcmp(config->atomo, "SUBJECT")==0 )
            input(config->valor, SUBJECT, 255);
        if ( strcmp(config->atomo, "NUM_TEST")==0 )
            NUM_TEST = atoi(config->valor);
        config = config->next;
    }
}
void usage()
{
    fprintf(stdout, "Eagle Eyes - Net Monitor v1.0\n");
    fprintf(stdout, "Desenvolvido por:\n");
    fprintf(stdout, "\tMário Augusto Mattiazzo Cardia\n");
    fprintf(stdout, "\tmario.cardia@uol.com.br\n\n");
    fprintf(stdout, "Opções de execução:\n");
    fprintf(stdout, "\t./netmon -A ou ./netmon -[HMPFB] ou ./netmon -h\n");
    fprintf(stdout, "onde:\n");
    fprintf(stdout, "\t-A : Executa todos os testes.\n");
    fprintf(stdout, "\t-H : Executa o teste nos servidores www.\n");
    fprintf(stdout, "\t-M : Executa o teste nos servidores de e-mail.\n");
    fprintf(stdout, "\t-P : Executa o teste nos servidores proxy.\n");
    fprintf(stdout, "\t-F : Executa o teste nos servidores de FTP.\n");
    fprintf(stdout, "\t-B : Executa o teste nos servidores SQL.\n");
    fprintf(stdout, "\t-O : Executa o teste em servidores não especificados.\n");
    fprintf(stdout, "\t-h : Mostra esta ajuda.\n");
    fprintf(stdout, "\n");
    exit(0);
}




#include <libpadrao.h>

void executa(char *service, char *acao)
{
	int uid;
	char cmd[255];

	uid = getuid();
	(void)setuid(0);

	memset(cmd, 0, 255);
	sprintf(cmd, "/etc/rc.d/init.d/%s %s", trim(service), trim(acao));
	system(cmd);	
	setuid(uid);
	return;
}

int main(int argc, char **argv)
{
    PGresult *query, *delete;
    int linha=0;
    int pid;
    int id;
    char servico[255], acao[255];
    char sql[255];
    FILE *log;
    
    pid = fork();
    
    if ( pid > 0 )
    {
    	exit(0);
    }
    if ( pid == 0 )
    {
        if ( ! db_connect("localhost", "firewall", "sa", "bdadmin") )
        {
            return(-1);
        }
    
        while(1)
        {
	    query = db_query("SELECT * FROM controle");
	    linha=0;
	    while ( ! db_eof(query, linha) )
	    {
		memset(servico, 0, 255);
		memset(acao, 0, 255);
	
		id = atoi(db_get(query, linha, "id"));
		strcpy(servico, db_get(query, linha, "servico"));
		strcpy(acao, db_get(query, linha, "acao"));
	
		executa(servico, acao);

		if ( (log=fopen("/var/log/smd.log", "a+")) )
		{
			fprintf( log, "%s> Acao: %s : Servico: %s\n", db_datetime(), acao, servico);
			fclose(log);
		}
	
		sprintf(sql, "DELETE FROM controle WHERE id=%d", id);
		delete = db_query(sql);
		db_free(delete);

		linha++;
	    }
	    db_free(query); 
    	    sleep(1);
        }
        db_close();
    }
    return(0);
}

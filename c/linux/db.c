#include<libpadrao.h>

PGconn *conn;

int db_connect(char *host, char *base, char *user, char *pass)
{
	char conn_str[1024];

	memset(conn_str, 0, 1024);
	
	sprintf(conn_str, "host='%s' dbname='%s' user='%s' password='%s'", host, base, user, pass);
	conn=PQconnectdb(conn_str);
	if ( PQstatus(conn) == CONNECTION_BAD )
	{
		return(0);
	}
	return(1);
}

PGresult *db_query(char *str_sql)
{
	return(PQexec(conn, str_sql));
}

int db_eof( PGresult *query, int linha )
{
	if ( PQntuples(query) > linha) return(0);
	return(1);
}

int db_count(PGresult *query)
{
	return( PQntuples(query) );
}

char *db_get( PGresult *query, int linha, char *field )
{
	int idx = PQfnumber(query, field);
	return ( PQgetvalue(query, linha, idx) );
}

void db_close()
{
	PQfinish(conn);
}

void db_free(PGresult *query)
{
	PQclear(query);
}



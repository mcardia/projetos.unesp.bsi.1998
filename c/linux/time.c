#include <libpadrao.h>

void get_time(char *ret, char *ft)
{
	time_t	horario;
	struct tm *tempo;
	
	horario = time(NULL);
	tempo = localtime( &horario );
	strftime( ret, 255, ft, tempo );
}

char *date(char *sep)
{
    static char ret[20];
    char dia[20], mes[20], ano[20];
    char ft[20];

    memset(ret, 0, 20);
    memset(dia, 0, 20);
    memset(mes, 0, 20);
    memset(ano, 0, 20);

    memset(ft,  0, 20);
    strcpy(ft, "%d");
    get_time(dia, ft);

    memset(ft,  0, 20);
    strcpy(ft, "%m");
    get_time(mes, ft);

    memset(ft,  0, 20);
    strcpy(ft, "%Y");
    get_time(ano, ft);

    sprintf(ret, "%s%s%s%s%s", dia, sep, mes, sep, ano);

    return((char *)ret);
}

char *db_date()
{
    static char ret[20];
    char dia[20], mes[20], ano[20];
    char ft[20];

    memset(ret, 0, 20);
    memset(dia, 0, 20);
    memset(mes, 0, 20);
    memset(ano, 0, 20);

    memset(ft,  0, 20);
    strcpy(ft, "%d");
    get_time(dia, ft);

    memset(ft,  0, 20);
    strcpy(ft, "%m");
    get_time(mes, ft);

    memset(ft,  0, 20);
    strcpy(ft, "%Y");
    get_time(ano, ft);

    sprintf(ret, "%s-%s-%s", ano, mes, dia);

    return((char *)ret);
}

char *db_datetime()
{
    static char ret[20];
    char dia[20], mes[20], ano[20], hora[20], minuto[20], segundo[20];
    char ft[20];

    memset(ret, 0, 20);
    memset(dia, 0, 20);
    memset(mes, 0, 20);
    memset(ano, 0, 20);
    memset(hora, 0, 20);
    memset(minuto, 0, 20);
    memset(segundo, 0, 20);

    memset(ft,  0, 20);
    strcpy(ft, "%d");
    get_time(dia, ft);

    memset(ft,  0, 20);
    strcpy(ft, "%m");
    get_time(mes, ft);

    memset(ft,  0, 20);
    strcpy(ft, "%Y");
    get_time(ano, ft);

    memset(ft,  0, 20);
    strcpy(ft, "%H");
    get_time(hora, ft);

    memset(ft,  0, 20);
    strcpy(ft, "%M");
    get_time(minuto, ft);

    memset(ft,  0, 20);
    strcpy(ft, "%S");
    get_time(segundo, ft);

    sprintf(ret, "%s-%s-%s %s:%s:%s", ano, mes, dia, hora, minuto, segundo);

    return((char *)ret);
}

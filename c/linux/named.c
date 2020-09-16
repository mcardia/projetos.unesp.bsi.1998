#include <libpadrao.h>

int add_domain(char *domain, char *administrator, char *ns)
{
    FILE *zone;
    FILE *conf;
    char zone_file[255];
    char conf_file[255];

    memset(zone_file, 0, 255);
    memset(conf_file, 0, 255);

    sprintf(zone_file, "/var/named/%s.zone", domain);
    sprintf(conf_file, "/etc/named.conf");
//    sprintf(zone_file, "./%s.zone", domain);
//    sprintf(conf_file, "./named.conf");

    if ( (zone=fopen(zone_file, "w+")) == NULL )
    {
        fprintf(stderr, "%s não pode ser criado. abortando operaçao.\n", zone_file);
        return(-1);
    }

    if ( (conf=fopen(conf_file, "a")) == NULL )
    {
        fprintf(stderr, "%s não encontrado. abortando operaçao.\n", conf_file);
        return(-1);
    }

    fprintf(zone, "$TTL 86400\n");
    fprintf(zone, "@\tIN\tSOA\t@  %s (\n", administrator);
    fprintf(zone, "\t\t\t200202013 ; serial\n");
    fprintf(zone, "\t\t\t28800 ; refresh\n");
    fprintf(zone, "\t\t\t7200 ; retry\n");
    fprintf(zone, "\t\t\t604800 ; expire\n");
    fprintf(zone, "\t\t\t86400 ; ttl\n");
    fprintf(zone, "\t\t\t)\n");
    fprintf(zone, "@\tIN\tNS\t%s\n\n", ns);

    fprintf(conf, "zone  \"%s\" {\n", domain);
    fprintf(conf, "\ttype master;\n");
    fprintf(conf, "\tfile  \"%s.zone\";\n", domain);
    fprintf(conf, "};\n\n");

    fclose(zone);
    fclose(conf);

    return(0);
}


char *get_next_origin(FILE *file, int *linha)
{
    char ch=0;
    char atomo[255];
    static char *rtstr;
    int idx = 0;

    memset(atomo, 0, 255);

    while ( strncmp(atomo, "$ORIGIN", 7) != 0 )
    {
        ch = fgetc(file);
        while ( !feof(file) && (ch == ' ' || ch == '\n' || ch == '\t' || ch == '\r' || ch == '#') )
        {
            if ( ch == '#' )
            {
                while ( ch != '\n' && !feof(file) )
                {
                    ch = fgetc(file);
                }
            }
            if ( ch == '\n' ) (*linha)++;
            ch = fgetc(file);
        }

        memset(atomo, 0, 255);
        atomo[idx] = ch;

        ch = fgetc(file);

        while ( !feof(file) && ( is_letra(ch) || is_digito(ch) ) )
        {
            atomo[++idx] = ch;
            ch = fgetc(file);
        }
        ungetc(ch, file);

        printf("->%s\n", atomo);

        if ( feof(file) ) return(NULL);
    }

    printf("%s\n", atomo);

    ch = fgetc(file);
    while ( ch == ' ' || ch == '\t' || ch == '\n')
    {
        if ( ch == '\n' ) linha++;
        ch = fgetc(file);
    }

    idx = 0;
    memset(atomo, 0, 255);
    while ( !feof(file) && (is_letra(ch) || is_digito(ch)) )
    {
        atomo[idx++] = ch;
        ch = fgetc(file);
    }
    ungetc(ch, file);

    if ( feof(file) || (strlen(atomo) == 0) )
    {
        return(NULL);
    }

    if ( atomo[strlen(atomo)-1] == '.' ) atomo[strlen(atomo)-1] = 0;

    rtstr = ( char * ) malloc ( strlen(atomo) + 1 );
    memset(rtstr, 0, strlen(atomo) + 1 );
    strncpy(rtstr, atomo, strlen(atomo));
    return((char*)rtstr);
}

int add_subdomain(char *subdomain, char *domain, char *origin, char *destino, char *type)
{
    FILE *zone;
    char zone_file[255];
    char buffer[255];

    char *next_origin;
    int linha = 1, achou = 0;


    memset(zone_file, 0, 255);

//    sprintf(zone_file, "/var/named/%s.zone", domain);
    sprintf(zone_file, "%s.zone", domain);

    if ( (zone=fopen(zone_file, "r")) == NULL )
    {
        fprintf(stderr, "%s não pode ser aberto. abortando operaçao.\n", zone_file);
        return(-1);
    }

    while ( !feof(zone) )
    {
        next_origin = get_next_origin(zone, &linha);
        if ( next_origin == NULL ) continue;
        if ( strcmp(origin, next_origin) == 0 )
        {
            achou = 1;
            break;
        }
    }

    fclose(zone);

    if ( achou )
    {
        printf("%d: %s\n", linha, origin);

        memset(buffer, 0, 255);
        sprintf(buffer, "%s\tIN\t%s\t%s", subdomain, type, destino);
        (void)insert_line(++linha, buffer, zone_file);
        printf( "%d: %s\n", linha, buffer);
    } else
    {
        memset(buffer, 0, 255);
        sprintf(buffer, "\n$ORIGIN %s.", origin);
        (void)insert_line(0, buffer, zone_file);

        memset(buffer, 0, 255);
        sprintf(buffer, "%s\tIN\t%s\t%s", subdomain, type, destino);
//        (void)insert_line(0, buffer, zone_file);
    }

    return(0);
}

void del_domain(char *domain)
{
}

void del_subdomain(char *zone, char *domain)
{
}

#include <libpadrao.h>

char *is_word( char *atomo )
{
	char *at;
	
	at = (char*) malloc (strlen(atomo));
        memset( at, 0, strlen(atomo) );
	strcpy( at, strtolower(atomo) );

	if ( strcmp(at, "var") == 0 ) return(id_var);
	return(NULL);
}

int is_letra(char ch)
{
	if ( isalpha(ch) || ch == '_' )
		return(1);
	else
		return(0);
}

int is_digito(char dg)
{
	if ( isdigit(dg) )
		return(1);
	else
		return(0);
}

int is_symbol(char ch)
{
	switch (ch)
	{
	    case '$' : return(1);
            case '/' : return(1);
            case '.' : return(1);
            default  : return(0);
	}
}

struct analex *do_analex(FILE *file)
{
    static struct analex ret;
    char ch;
    char atomo[255];
    char id[255];
    char *aux;
	
    int idx = 0;
	
    memset(atomo, 0, 255);
    memset(id, 0, 255);
	
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
	ch = fgetc(file);
    }

    if ( feof(file) ) return(NULL);

    if ( ch == '$' ) /* Macro */
    {
        atomo[idx] = ch;
        ch = fgetc(file);
        if ( is_letra(ch) )
        {
            while ( !feof(file) && ( is_letra(ch) || is_digito(ch)) )
            {
                atomo[++idx] = ch;
                ch = fgetc(file);
            }
            ungetc(ch, file);
            strcpy(id, id_macro);
        } else
        {
            fprintf(stderr, "Sintaxe invalida\n");
            exit(-1);
        }
    } else
    {
        atomo[idx] = ch;
        ch = fgetc(file);
        while ( ch != '$' && (is_symbol(ch) || is_letra(ch) || is_digito(ch)) && !feof(file) )
        {
            atomo[++idx] = ch;
      	    ch = fgetc(file);
        }
        ungetc(ch, file);
        if ( (aux = is_word(atomo)) ==  NULL )
        {
            strcpy(id, id_string);
        } else
        {
            strcpy(id, aux);
        }
    }
	
    memset(ret.atomo, 0, 255 );
    memset(ret.id,    0, 255 );
    strncpy( ret.atomo, atomo, strlen(atomo) );
    strncpy( ret.id, id, strlen(id) );
	
    return(&ret);
}

void do_var(FILE *file)
{
    char variavel[255];
    char valor[255];
    char aux[255];
    char temp[4096];
    struct _tabela *macro;
    int i;

    if ( (simbolo = do_analex(file)) == NULL ) return;

    if ( strcmp(simbolo->id, id_string) != 0 )
    {
        fprintf(stderr, "Sintaxe inválida\n");
        exit(-1);
    }

    input( simbolo->atomo, variavel, 255 );

    if ( (simbolo = do_analex(file)) == NULL ) return;

    memset(temp, 0, 4096);
    while ( strcmp(simbolo->id, id_var) != 0 )
    {
        if ( strcmp(simbolo->id, id_macro) == 0 )
        {
            memset(aux, 0, 255);
            for ( i = 1; i <= (strlen(simbolo->atomo)-1); i++ )
            {
                aux[i-1] = simbolo->atomo[i];
            }
            if ( (macro = search(aux, tabela)) != NULL )
            {
                (void) strcat (temp, macro->valor);
            }
        }
        if ( strcmp(simbolo->id, id_string) == 0 )
        {
            (void) strcat (temp, simbolo->atomo);
        }
        if ( (simbolo = do_analex(file)) == NULL )
        {
            break;
        }
    }
    input(temp, valor, 255);
    insert(variavel, valor);
}

struct _tabela *read_conf(char *file_name)
{
    FILE *file;

    tabela = NULL;
    pointer = NULL;

    if ( (file=fopen(file_name, "r")) == NULL )
    {
        return(NULL);
    }

    simbolo = do_analex(file);
    while ( !feof(file) )
    {
        if ( strcmp(simbolo->id, id_var) != 0 )
        {
            fprintf(stderr, "Sintaxe inválida no arquivo\n");
            exit(-1);
        }
        do_var(file);
    }
    fclose(file);

    return(tabela);
}

void display( struct _tabela *lista )
{
    while (lista)
    {
        printf("%s = %s\n", lista->atomo, lista->valor);
        lista = lista->next;
    }
}

struct _tabela *search (char *what, struct _tabela *lista)
{
    while (lista)
    {
        if ( strcmp(what, lista->atomo) == 0 ) return lista;
        lista = lista->next;
    }
    return(NULL);
}

void insert(char *atomo, char *valor)
{
    struct _tabela *info;

    info = (struct _tabela *) malloc ( sizeof(lista) );

    input ( atomo, info->atomo, 255);
    input ( valor, info->valor, 255);
    info->next = NULL;

    if ( tabela == NULL ) /* Primeiro elemento da lista */
    {
        tabela  = info;
        pointer = info;
        return;
    }
    /* Insere no final da lista */
    pointer->next = info;
    pointer = pointer->next;
}

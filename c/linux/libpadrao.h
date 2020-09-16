#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <netdb.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <pwd.h>
#include <pgsql/libpq-fe.h>

#define id_var    "id_var"
#define id_macro  "id_macro"
#define id_string "id_string"


/* Estrura de dados read_conf */
struct analex
{
    char atomo[255];
    char id[255];
} st_analex;

struct analex *simbolo;

struct _tabela
{
    char atomo[255];
    char valor[255];
    struct _tabela *next;
};

struct _tabela *tabela;
struct _tabela *pointer;
struct _tabela lista;

/* Funcoes util */
char *trim (register const char *string);
void str_clear (char *string, char *ret);
char *ap_trim (char *string);
char *strtolower( char *str );

/* Funcoes socket */
int socket_server(int port);
int socket_client(char *server, int port);
char *read_socket(int sock) ;
char *readln_socket(int sock);

/*Funcoes time */
void get_time(char *ret, char *ft);
char *date(char *sep);
char *db_date();
char *db_datetime();

/* Funcoes file */
int count_line(char *file_name);
int insert_line(int linha, char *buffer, char *file_name);
int is_dir(char *dir);
int is_reg(char *path);

/* Funcoes net */
int send_mail(char *host, char *from, char *to, char *subject, char *message);
int send_sms(char *prefixo, char *celular, char *sender, char *mensagem);
int fping(char *host);

/* Funcoes read_conf */
void input(char *valor, char *variavel, int size);
struct _tabela *search (char *what, struct _tabela *lista);
void insert(char *atomo, char *valor);
void display(struct _tabela *lista);

char *is_word( char *atomo );
int is_letra(char ch);
int is_digito(char dg);
int is_symbol(char ch);
struct analex *do_analex(FILE *file);
void do_var(FILE *file);
struct _tabela *read_conf(char *file_name);

/* Funcoes db */
int db_connect(char *host, char *base, char *user, char *pass);
PGresult *db_query(char *str_sql);
int db_eof(PGresult *query, int linha);
char *db_get(PGresult *query, int linha, char *field);
void db_close();
void db_free(PGresult *query);
int db_count(PGresult *query);

/* Funcoes named */

int add_domain(char *domain, char *administrator, char *ns);
int add_subdomain(char *subdomain, char *domain, char *origin, char *destino, char *type);
void del_domain(char *domain);
void del_subdomain(char *zone, char *domain);
char *get_next_origin(FILE *file, int *linha);


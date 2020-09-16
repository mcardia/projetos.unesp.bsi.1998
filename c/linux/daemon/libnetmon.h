#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libpadrao.h>
#include <unistd.h>

void http(void);
void bases(void);
void mail(void);
void proxy(void);
void ftp(void);
void outros(void);

void estatistica( int id, char *tipo, int erro);
void alert(char *mensagem);
void update_status(int id, int id_status, char *tabela);
void update_status_mail(int id, int id_status, char *tabela, char *tipo);
void init();
void usage();

char DB_HOST[255];
char DB_BASE[255];
char DB_USER[255];
char DB_PASS[255];
char MAIL_HOST[255];
char MAIL_FROM[255];
char SUBJECT[255];
int NUM_TEST;

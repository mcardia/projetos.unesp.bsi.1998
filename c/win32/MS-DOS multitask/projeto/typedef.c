FILE *arq;

typedef struct tMensagem {
        int flag;
        char emissor[30];
        char msg[30];
        struct tMensagem *proxima;
} MSG;

typedef MSG *ptrMensagem;

typedef struct desc_p {
    char nome[35];
    enum {ativo, terminado, bloqueadoEnv, bloqueadoRecv, bloqueado } estado;
    PTR_DESC contexto;
    ptrMensagem mensagem;
    int numMensagem;
    int maxMensagem;
    struct desc_p *prox_bloq; /* Para a fila do semaforo */
    struct desc_p *prox_desc; /* Para a fila dos processos */
} descritor_proc;

typedef descritor_proc *PTR_DESC_PROC;

typedef struct Tsemaforo {
        int s;
        PTR_DESC_PROC q;
} semaforo;


typedef struct registros {
        unsigned bx1, es1;
} regs;

typedef union k {
        regs x;
        char far *y;
} rcDos;

PTR_DESC_PROC first, last, exec, busca;
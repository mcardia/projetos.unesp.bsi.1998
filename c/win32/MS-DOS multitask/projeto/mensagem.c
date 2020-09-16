
PTR_DESC_PROC pMsg, auxMsg;

int existe(nome)
    char *nome[30];
{
    pMsg = exec;
    auxMsg = pMsg;

    pMsg = pMsg->prox_desc;

    while ( strcmp(pMsg->nome, nome) )
    {
        if ( pMsg==auxMsg)
        {
           return 0;
        }
        pMsg = pMsg->prox_desc;
    }

    return 1;
}

int cheia()
{
    if ( pMsg->numMensagem == pMsg->maxMensagem )
    {
       return 1;
    }
    return 0;
}

int envia(msg, nome)
    char *msg[30]; char *nome[30];
{
    ptrMensagem aux;
    PTR_DESC_PROC origem;

    if ( !existe(nome) )
       return 0;
    if ( cheia() )
       return 0;

    disable();
    aux = pMsg->mensagem;
    while ( aux->flag )
    {
       aux = aux->proxima;
    }
    aux->flag=1;
    strcpy(aux->emissor, exec->nome);
    strcpy(aux->msg, msg);
    pMsg->numMensagem++;

    if ( pMsg->estado == bloqueadoEnv )
       pMsg->estado=ativo;

    exec->estado=bloqueadoRecv;
    origem  = exec;
    exec = exec->prox_desc;
    while ( exec->estado != ativo )
    {
       exec = exec->prox_desc;
    }
    enable();
    transfer(origem->contexto, exec->contexto);

    return 1;
}

void far recebe(msg, nome)
     char *msg[30]; char *nome[30];
{
     PTR_DESC_PROC origem;
     ptrMensagem aux;

     if ( exec->numMensagem==0 )
     {
        disable();
        exec->estado=bloqueadoEnv;
        origem=exec;
        exec=exec->prox_desc;
        while ( exec->estado != ativo )
        {
            exec=exec->prox_desc;
        }
        enable();
        transfer(origem->contexto, exec->contexto);
     }
     disable();
     aux=exec->mensagem;
     while ( ! aux->flag )
         aux = aux->proxima;
     strcpy(msg, aux->msg);
     strcpy(nome, aux->emissor);
     aux->flag=0;
     exec->numMensagem--;
     if ( existe(nome) )
     {
        if ( pMsg->estado==bloqueadoRecv )
            pMsg->estado=ativo;
     }
     enable();
}
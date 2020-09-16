#include <system.h>
#include "typedef.c"
#include "mensagem.c"
#include "semaforo.c"

rcDos a;

PTR_DESC      dEscalador;

void far iniciaSistema()
{
  first = NULL;
  last = NULL;
}

void far voltaDos()
{
   disable();
   setvect(8, p_est->int_anterior);
   enable();
   printf("\n\n\n Terminado com sucesso \n\n\n");
   exit(0);
}

ptrMensagem cria_mensagem(maxMensagem)
int maxMensagem;
{
   ptrMensagem mAux, pMsg, uMsg;
   int i;

   mAux = NULL;
   pMsg = mAux;
   uMsg = mAux;

   for (i=1; i==maxMensagem; i++)
   {
       mAux=(MSG*)malloc(sizeof(MSG));
       mAux->proxima=NULL;

       if (i==1)
       {
           pMsg = mAux;
           uMsg = mAux;
       }
       else
       {
          uMsg->proxima = mAux;
          uMsg = mAux;
       }
   }
   return pMsg;
}

void far criaProcesso(nome, addr, maxMensagem)
char nome[35]; void far (*addr)(); int maxMensagem;
{
    PTR_DESC_PROC procAux;
    procAux = (descritor_proc*)malloc(sizeof(descritor_proc));

    strcpy(procAux->nome,nome);
    procAux->estado = ativo;
    procAux->contexto = cria_desc();
    procAux->maxMensagem = maxMensagem;
    procAux->numMensagem = 0;
    procAux->mensagem = cria_mensagem(maxMensagem);
    procAux->prox_bloq = NULL;
    newprocess(addr,procAux->contexto);
    if (first == NULL)
    {
        first = procAux;
        first->prox_desc = procAux;
        last = procAux;
    }
    else
    {
        last->prox_desc = procAux;
        procAux->prox_desc = first;
        last = procAux;
    }
}

void far localizaProximo()
{
    busca=exec;
    exec = exec->prox_desc;
    while (exec->estado != ativo)
    {
        if ( exec==busca )
        {
            voltaDos();
        }
        exec = exec->prox_desc;
    }

    p_est->p_destino = exec->contexto;
}

void far escalador()
{
  p_est->p_origem  = dEscalador;
  p_est->p_destino = exec->contexto;
  p_est->num_vetor = 8;

  _AH=0x34;
  _AL=0x00;
  geninterrupt(0x21);
  a.x.bx1=_BX;
  a.x.es1=_ES;

  while (1)
  {
      iotransfer();
      disable();
      if (! *a.y)
      {
          localizaProximo();
      }
      enable();
  }
}

void far terminarProcesso()
{
    disable();
    exec->estado = terminado;
    enable();
    while(1);
}

void far disparaSistema()
{
    PTR_DESC dAux;
    dAux       = cria_desc();
    dEscalador = cria_desc();
    newprocess(escalador, dEscalador);
    exec = first;
    transfer(dAux, dEscalador);
}

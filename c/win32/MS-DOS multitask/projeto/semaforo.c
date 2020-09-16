
void far cria_semaforo(semaf, n)
     semaforo *semaf; int n;
{
     semaf->s=n;
     semaf->q=NULL;
}

void far p(semaf)
     semaforo *semaf;
{
     PTR_DESC_PROC aux, exec_aux;

     disable();
     if ( semaf->s > 0 )
     {
         semaf->s--;
         enable();
     }
     else
     {
         exec->estado=bloqueado;
         if ( semaf->q == NULL )
         {
            semaf->q=exec;
         }
         else
         {
            aux=semaf->q;
            while (aux->prox_bloq != NULL ) aux=aux->prox_bloq;
            aux->prox_bloq = exec;
         }
         exec->prox_bloq=NULL;
         exec_aux = exec;
         exec=exec->prox_desc;
         while ( exec->estado != ativo ) exec=exec->prox_desc;
         enable();
         transfer(exec_aux->contexto, exec->contexto);
     }
}

void far v(semaf)
     semaforo *semaf;
{
     disable();
     if ( semaf->q == NULL )
     {
         semaf->s++;
     }
     else
     {
         semaf->q->estado=ativo;
         semaf->q=semaf->q->prox_bloq;
     }
     enable();
}
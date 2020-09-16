#define maxBuffer 1000

typedef int Tbuffer [maxBuffer];

Tbuffer buffer;
int i, c, cont=0;
semaforo mutex, cheio, vazio;

void far deposita(msg)
     int msg;
{
     char conteudo[40];
     buffer[i]=msg;
     if (++i >= 1000) i=0;
     sprintf(conteudo, "Produtor ----> Depositado: %d\n", msg);
     fprintf(arq, "%s", conteudo);
     printf("Depositado: %d\n", msg);
}

void far retira(msg)
     int *msg;
{
     char conteudo[40];
     msg=buffer[c];
     if (++c >= 1000 ) c=0;
     sprintf(conteudo, "Consumidor -----> Lido: %d\n", msg);
     printf("Lido: %d\n", msg);
     fprintf(arq, "%s", conteudo);
}

int produz()
{
  cont++;
  if (cont > 1000) cont = 0;
  return cont;
}

void far produtor()
{
    int m;
    int a=0;
    while(++a < 2000)
    {
       m=produz();
       p(&vazio);
       p(&mutex);
       deposita(m);
       v(&mutex);
       v(&cheio);
    }
    terminarProcesso();
}

void far consumidor()
{
    int m;
    int a=0;

    while(++a<2000)
    {
        p(&cheio);
        p(&mutex);
        retira(m);
        v(&mutex);
        v(&vazio);
    }
    terminarProcesso();
}

void far processo1()
{
    int cont=0;
    char m[30];
    int i;

    while (cont++ <= 100)
    {
      sprintf(m, "Mensagem %d", cont);
      i = envia(m, "Processo2");
      if (!i)
      {
        printf("\n\nNÆo foi poss¡vel enviar a mensagem\n\n");
        break;
      }
      else
      {
        printf("Mensagem (%s) enviada para flop   --->", m);
        fprintf(arq, "Processo1 (Envia) ----> %s enviado\n", m);
      }
    }

    terminarProcesso();
}

void far processo2()
{
    int cont=0;
    char m[30], r[30];
    while (cont++ <= 100)
    {
      recebe(m, r);
      printf("Recebida mensagem (%s) do processo %s.\n", m, r);
      fprintf(arq, "Processo2 (recebe) ----> Recebido %s de %s\n",m,r);
    }
    terminarProcesso();
}
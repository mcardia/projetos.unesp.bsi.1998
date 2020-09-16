#include "nucleo.c"
#include "processo.c"

main()
{
    arq=fopen("rel.txt","w");
    clrscr();
    i=c=0;
    iniciaSistema();
    cria_semaforo(&cheio, 0);
    cria_semaforo(&vazio, maxBuffer);
    cria_semaforo(&mutex, 1);
    criaProcesso("Produtor", produtor);
    criaProcesso("Consumidor", consumidor);
    criaProcesso("Processo1", processo1);
    criaProcesso("Processo2", processo2);
    disparaSistema();
    fclose(arq);
}

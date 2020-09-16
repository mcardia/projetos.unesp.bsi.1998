Projeto: Nucleo MultiTarefas com Comunicacao e Sincronizacao
Desenvolvido por:
        Mario Augusto Mattiazzo Cardia  
           mcardia@travelnet.com.br
        Simone Doro Laborda        
           simone@travenet.com.br

Informacoes:
============================================================================
        O Nucleo esta no Diretorio PROJETO
        O Diretorio "C" contem o compilador utilizado no desenvolvimento
do projeto.


Arquivos:
============================================================================

SO.C       --> Rotina Principal que cria e dispara os processos
PROCESSO.C --> Contem o codigo fonte dos 4 processos que sao executados e
               rotinas auxiliares aos mesmos.
NUCLEO.C   --> Rotinas para a realizacao da divisao da CPU
               (escalador, criaProcesso, etc..)
MENSAGEM.C --> Rotinas para troca de mensagens
TYPEDEF.C  --> Contem as estruturas e tipos utilizado em todo o projeto
SEMAFORO.C --> Contem as primitivas P e V e rotinas auxiliares
SO.EXE     --> Binario executavel do nucleo 

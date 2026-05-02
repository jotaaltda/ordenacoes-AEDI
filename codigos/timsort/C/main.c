#include <stdio.h>
#include <time.h>
#define TAMANHO_VETOR 1000000

//Analise do vetor na forma aleatória - .dat cru
//vetor ordenado - depois da ordenação
//vetor invertido - inverte o ordenado
//valores semlhantes - arquivo separado

int main(){

    // ... Leitura do arquivo ...

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    // ... Ordenação ...

    clock_gettime(CLOCK_MONOTONIC, &end);


    //Calcula o tempo passado 
    double tempo = (end.tv_sec - start.tv_sec) * 1e9 + (end.tv_nsec - start.tv_nsec);

    tempo /= 1e9;

}
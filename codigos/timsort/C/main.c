#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "timsort.h"
#include "io.h"
#define TAMANHO_VETOR 100

//Analise do vetor na forma aleatória - .dat cru
//vetor ordenado - depois da ordenação
//vetor invertido - inverte o ordenado
//valores semlhantes - arquivo separado

int main(){

    int *vetor = ler_arquivo("../../../Dados/valores.dat", TAMANHO_VETOR);

    if (vetor == NULL) {
        return 1;
    }

    for (int i = 0; i < TAMANHO_VETOR; i++) {
        printf("%d ", vetor[i]);
    }

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    // ... Ordenação ...

    clock_gettime(CLOCK_MONOTONIC, &end);


    //Calcula o tempo passado 
    double tempo = (end.tv_sec - start.tv_sec) * 1e9 + (end.tv_nsec - start.tv_nsec);

    tempo /= 1e9;

    //todo free vetor

}
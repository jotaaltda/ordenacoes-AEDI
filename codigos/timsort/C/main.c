#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include "timsort.h"
#include "io.h"
#define TAMANHO_VETOR 1000000

//Analise do vetor na forma aleatória - .dat cru
//vetor ordenado - depois da ordenação
//vetor invertido - inverte o ordenado
//valores semlhantes - arquivo separado

int main(){

    int *vetor = ler_arquivo("../../../Dados/valores.dat", TAMANHO_VETOR);

    if (vetor == NULL) {
        return 1;
    }

    struct timespec start, end;

    //-----------------------Ordenação vetor aleatório-----------------------
    int *copia = malloc(TAMANHO_VETOR * sizeof(int));
    if (copia == NULL) {
        printf("Erro de memória!\n");
        return 1;
    }
    memcpy(copia, vetor, TAMANHO_VETOR * sizeof(int));
    
    clock_gettime(CLOCK_MONOTONIC, &start);
    timsort(copia, TAMANHO_VETOR);
    clock_gettime(CLOCK_MONOTONIC, &end);

    double tempo = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
    printf("Com vetor aleatorio tamanho %d, demorou %fs\n", TAMANHO_VETOR, tempo);
    
    free(copia);
    free(vetor);
    return 0;
}
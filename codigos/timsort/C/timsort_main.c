#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include "timsort.h"
#include "io.h"
#define TAMANHO_VETOR_MAX 1000000

int main(){
    struct timespec start, end;
    double tempo;
    double total;
    double media;
    int tamanho = 100; //1000, 10000, 100000, 1000000

    int *vetor = ler_arquivo("../../../Dados/valores.dat", TAMANHO_VETOR_MAX);
    if (vetor == NULL) {
        printf("Erro na leitura do arquivo!\n");
        return 1;
    }

    int *copia = malloc(TAMANHO_VETOR_MAX * sizeof(int));
    if (copia == NULL) {
        printf("Erro de memória!\n");
        return 1;
    }

    int *invertido = malloc(TAMANHO_VETOR_MAX * sizeof(int));
    if (invertido == NULL) {
        printf("Erro de memória!\n");
        return 1;
    }

    int *vetor_semelhante = ler_arquivo("../../../Dados/valores-semelhantes.dat", TAMANHO_VETOR_MAX);
    if (vetor_semelhante == NULL) {
        printf("Erro na leitura do arquivo!\n");
        return 1;
    }

    int *ordenado = malloc(TAMANHO_VETOR_MAX * sizeof(int));
    if (ordenado == NULL) {
        printf("Erro de memória!\n");
        return 1;
    }
    
    //i até 5 porque o tamanho vai de 10^2 a 10^6
    for(int i = 0; i < 5; i++){
    //-----------------------Ordenação vetor aleatório-----------------------
        tempo = 0;
        total = 0;
        media = 0;
        printf("-------Tamanho %i-------\n", tamanho);
        printf("..........Aleatorio.........\n");
        for(int j = 0; j < 10; j++){

            memcpy(copia, vetor, tamanho * sizeof(int));
            
            clock_gettime(CLOCK_MONOTONIC, &start);
            timsort(copia, tamanho);
            clock_gettime(CLOCK_MONOTONIC, &end);

            tempo = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
            printf("...  Tempo %i: %.6fs  ...\n", j, tempo);
            total += tempo;
        }
        media = total / 10;
        printf("...   Media: %.6fs   ...\n", media);
        printf("............................\n");

    //-----------------------Ordenação vetor ordenado------------------------
        tempo = 0;
        total = 0;
        media = 0;
        printf("..........Ordenado..........\n");

        memcpy(ordenado, vetor, tamanho * sizeof(int));
        timsort(ordenado, tamanho);

        for(int j = 0; j < 10; j++){

            //Aparentemente se usar o mesmo vetor já ordenado pra todas iterações, removemendo essa copia,
            //o programa fica levemente mais rápido a cada iteração consecutiva, porque fica em cache
            //Essa cópia "desnecessária" é só pra tirar esse aproveitamento de cache
            memcpy(copia, ordenado, tamanho * sizeof(int));

            clock_gettime(CLOCK_MONOTONIC, &start);
            timsort(copia, tamanho);
            clock_gettime(CLOCK_MONOTONIC, &end);

            tempo = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
            printf("...  Tempo %i: %.6fs  ...\n", j, tempo);
            total += tempo;
        }
        media = total / 10;
        printf("...   Media: %.6fs   ...\n", media);
        printf("............................\n");

    //-----------------------Ordenação vetor invertido-----------------------
        tempo = 0;
        total = 0;
        media = 0;
        for (int k = 0; k < tamanho; k++) {
            invertido[k] = ordenado[tamanho - 1 - k];
        }
        printf("..........Invertido.........\n");
        for(int j = 0; j < 10; j++){

            memcpy(copia, invertido, tamanho * sizeof(int));
            clock_gettime(CLOCK_MONOTONIC, &start);
            timsort(copia, tamanho);
            clock_gettime(CLOCK_MONOTONIC, &end);

            tempo = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
            printf("...  Tempo %i: %.6fs  ...\n", j, tempo);
            total += tempo;
        }
        media = total / 10;
        printf("...   Media: %.6fs   ...\n", media);
        printf("............................\n");

    //-----------------------Ordenação vetor semelhante----------------------
        tempo = 0;
        total = 0;
        media = 0;
        printf(".....Valores Semelhantes....\n");
        for(int j = 0; j < 10; j++){

            memcpy(copia, vetor_semelhante, tamanho * sizeof(int));
            clock_gettime(CLOCK_MONOTONIC, &start);
            timsort(copia, tamanho);
            clock_gettime(CLOCK_MONOTONIC, &end);

            tempo = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
            printf("...  Tempo %i: %.6fs  ...\n", j, tempo);
            total += tempo;
        }
        media = total / 10;
        printf("...   Media: %.6fs   ...\n", media);
        printf("............................\n");

    //-----------------------------------------------------------------------
        tamanho = tamanho*10;
    }
    free(vetor);
    free(copia);
    free(invertido);
    free(vetor_semelhante);
    free(ordenado);
    return 0;
}
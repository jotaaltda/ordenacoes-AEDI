#include <stdio.h>
#include <stdlib.h>
#include "io.h"

int* ler_arquivo(const char* caminho, int tamanho){
    FILE *fp = fopen(caminho, "r");
    if(fp == NULL){
        printf("Erro ao abrir o arquivo!\n");
        return NULL;
    }

    int *vetor = malloc(tamanho * sizeof(int));

    if (vetor == NULL) {
        printf("Erro de memória!\n");
        fclose(fp);
        return NULL;
    }

    char linha[64];

    for(int i = 0; i < tamanho; i++){
        if (fgets(linha, sizeof(linha), fp) == NULL) {
            printf("Erro ao ler o arquivo na posição %d\n", i);
            fclose(fp);
            free(vetor);
            return NULL;
        }

        if (sscanf(linha, "%d", &vetor[i]) != 1) {
            printf("Erro ao converter linha %d\n", i);
            fclose(fp);
            free(vetor);
            return NULL;
        }
    }
    
    fclose(fp);
    return vetor;
}
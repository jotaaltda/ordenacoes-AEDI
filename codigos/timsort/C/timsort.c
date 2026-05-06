#include <stdlib.h>
#include <stdio.h>
#include "timsort.h"
#define MINRUN 32

void insertionSort(int vetor[], int tamanho){
    for(int i = 1; i < tamanho; i++){
        int x = vetor[i];
        int j = i - 1;
        while(j >= 0 && vetor[j] > x){
            vetor[j + 1] = vetor[j];
            j--;
        }
        vetor[j + 1] = x;
    }
}

void merge(int vetor[], int esq, int meio, int dir, int temp[]){
    for(int i = esq; i <= dir; i++){
        temp[i] = vetor[i];
    }

    int i = esq;
    int j = meio + 1;
    int k = esq;

    while (i <= meio && j <= dir) {
        if (temp[i] <= temp[j]) {
            vetor[k++] = temp[i++];
        } else {
            vetor[k++] = temp[j++];
        }
    }

    while (i <= meio) {
        vetor[k++] = temp[i++];
    }

    while (j <= dir) {
        vetor[k++] = temp[j++];
    }
}

void timsort(int vetor[], int n) {

    int *temp = malloc(n * sizeof(int));
    if (temp == NULL) {
        printf("Erro de memória!");
        return;
    }

    for (int i = 0; i < n; i += MINRUN) {
        int fim = i + MINRUN - 1;
        if (fim >= n)
            fim = n - 1;

        insertionSort(&vetor[i], fim - i + 1);
    }

    for (int tamanho = MINRUN; tamanho < n; tamanho *= 2) {

        for (int left = 0; left < n; left += 2 * tamanho) {

            int mid = left + tamanho - 1;
            int right = left + 2 * tamanho - 1;

            if (mid >= n)
                continue;

            if (right >= n)
                right = n - 1;

            merge(vetor, left, mid, right, temp);
        }
    }
    free(temp);
}
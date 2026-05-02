#include <stdlib.h>
#include "timsort.h"
#define MINRUN 32

void insertionSort(int vetor[], int tamanho){
    int x, j;
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

void mergeSort(int vetor[], int esq, int meio, int dir){
    int n1 = meio - esq + 1;
    int n2 = dir - meio;

    int *L = malloc(n1 * sizeof(int));
    int *R = malloc(n2 * sizeof(int));

    for (int i = 0; i < n1; i++)
        L[i] = vetor[esq + i];

    for (int j = 0; j < n2; j++)
        R[j] = vetor[meio + 1 + j];

    int i = 0, j = 0, k = esq;

    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            vetor[k] = L[i];
            i++;
        } else {
            vetor[k] = R[j];
            j++;
        }
        k++;
    }

    while (i < n1) {
        vetor[k] = L[i];
        i++;
        k++;
    }

    while (j < n2) {
        vetor[k] = R[j];
        j++;
        k++;
    }

    free(L);
    free(R);
}

void timsort(int vetor[], int n) {

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

            mergeSort(vetor, left, mid, right);
        }
    }
}
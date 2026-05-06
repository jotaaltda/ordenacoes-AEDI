#ifndef TIMSORT_H
#define TIMSORT_H

void insertionSort(int vetor[], int tamanho);

void merge(int vetor[], int esq, int meio, int dir, int temp[]);

void timsort(int vetor[], int n);

#endif
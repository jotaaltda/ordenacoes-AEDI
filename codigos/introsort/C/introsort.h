#ifndef INTROSORT_H
#define INTROSORT_H

#include <stddef.h>

typedef struct {
    double tempo;
    size_t memoria;
} Resultado;

int* lerArquivo(const char *nomeArquivo, int quantidade);

void introsort(int *vetor, int n);

void inverterVetor(int *vetor, int n);

void copiarVetor(int *origem, int *destino, int n);

Resultado executarOrdenacao(int *vetor, int n);

void imprimirResultado(
    const char *arquivo,
    int tamanho,
    Resultado r
);

#endif
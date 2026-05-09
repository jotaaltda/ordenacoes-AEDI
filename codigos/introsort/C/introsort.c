#include "introsort.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>

double tempoAtual() {
    return (double)clock() / CLOCKS_PER_SEC;
}

size_t consumoMemoriaBytes(size_t quantidade) {
    return quantidade * sizeof(int);
}

void inverterVetor(int *vetor, int n) {

    int inicio = 0;
    int fim = n - 1;

    while (inicio < fim) {

        int temp = vetor[inicio];
        vetor[inicio] = vetor[fim];
        vetor[fim] = temp;

        inicio++;
        fim--;
    }
}

void copiarVetor(int *origem, int *destino, int n) {
    memcpy(destino, origem, n * sizeof(int));
}

int* lerArquivo(const char *nomeArquivo, int quantidade) {

    FILE *arquivo = fopen(nomeArquivo, "r");

    if (!arquivo) {

        printf("Erro ao abrir arquivo: %s\n", nomeArquivo);
        return NULL;
    }

    int *vetor = malloc(quantidade * sizeof(int));

    if (!vetor) {

        fclose(arquivo);
        return NULL;
    }

    for (int i = 0; i < quantidade; i++) {

        if (fscanf(arquivo, "%d", &vetor[i]) != 1) {

            printf("Erro lendo valor %d do arquivo %s\n",
                   i,
                   nomeArquivo);

            free(vetor);
            fclose(arquivo);

            return NULL;
        }
    }

    fclose(arquivo);

    return vetor;
}

static void insertionSort(int *vetor, int inicio, int fim) {

    for (int i = inicio + 1; i <= fim; i++) {

        int chave = vetor[i];
        int j = i - 1;

        while (j >= inicio && vetor[j] > chave) {

            vetor[j + 1] = vetor[j];
            j--;
        }

        vetor[j + 1] = chave;
    }
}

static void heapify(
    int *vetor,
    int n,
    int i,
    int offset
) {

    int maior = i;

    int esquerda = 2 * i + 1;
    int direita = 2 * i + 2;

    if (
        esquerda < n &&
        vetor[offset + esquerda] >
        vetor[offset + maior]
    ) {
        maior = esquerda;
    }

    if (
        direita < n &&
        vetor[offset + direita] >
        vetor[offset + maior]
    ) {
        maior = direita;
    }

    if (maior != i) {

        int temp = vetor[offset + i];
        vetor[offset + i] = vetor[offset + maior];
        vetor[offset + maior] = temp;

        heapify(vetor, n, maior, offset);
    }
}

static void heapSort(
    int *vetor,
    int inicio,
    int fim
) {

    int n = fim - inicio + 1;

    for (int i = n / 2 - 1; i >= 0; i--) {
        heapify(vetor, n, i, inicio);
    }

    for (int i = n - 1; i > 0; i--) {

        int temp = vetor[inicio];
        vetor[inicio] = vetor[inicio + i];
        vetor[inicio + i] = temp;

        heapify(vetor, i, 0, inicio);
    }
}

static int particionar(
    int *vetor,
    int inicio,
    int fim
) {

    int pivo = vetor[fim];

    int i = inicio - 1;

    for (int j = inicio; j < fim; j++) {

        if (vetor[j] <= pivo) {

            i++;

            int temp = vetor[i];
            vetor[i] = vetor[j];
            vetor[j] = temp;
        }
    }

    int temp = vetor[i + 1];
    vetor[i + 1] = vetor[fim];
    vetor[fim] = temp;

    return i + 1;
}

static void introsortUtil(
    int *vetor,
    int inicio,
    int fim,
    int profundidadeMaxima
) {

    int tamanho = fim - inicio + 1;

    if (tamanho <= 16) {

        insertionSort(vetor, inicio, fim);
        return;
    }

    if (profundidadeMaxima == 0) {

        heapSort(vetor, inicio, fim);
        return;
    }

    int pivo = particionar(vetor, inicio, fim);

    introsortUtil(
        vetor,
        inicio,
        pivo - 1,
        profundidadeMaxima - 1
    );

    introsortUtil(
        vetor,
        pivo + 1,
        fim,
        profundidadeMaxima - 1
    );
}

void introsort(int *vetor, int n) {

    int profundidadeMaxima =
        2 * log(n);

    introsortUtil(
        vetor,
        0,
        n - 1,
        profundidadeMaxima
    );
}

Resultado executarOrdenacao(
    int *vetor,
    int n
) {

    Resultado r;

    double inicio = tempoAtual();

    introsort(vetor, n);

    double fim = tempoAtual();

    r.tempo = fim - inicio;

    r.memoria =
        consumoMemoriaBytes(n);

    return r;
}

void imprimirResultado(
    const char *arquivo,
    int tamanho,
    Resultado r
) {

    printf(
        "%s - vetor de tamanho 10^%d\n",
        arquivo,
        (int)log10(tamanho)
    );

    printf(
        "Tempo de execucao: %.6f segundos\n",
        r.tempo
    );

    printf(
        "Consumo aproximado de memoria: %.2f KB\n\n",
        (double)r.memoria / 1024.0
    );
}
#include "introsort.h"

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define TOTAL_TAMANHOS 5

const int tamanhos[TOTAL_TAMANHOS] = {
    100,
    1000,
    10000,
    100000,
    1000000};

void executarCenario(
    const char *titulo,
    int *dadosOriginais,
    int tamanho,
    const char *nomeArquivo)
{

    printf("=====================================\n");
    printf("%s\n", titulo);
    printf("=====================================\n\n");

    int *vetor =
        malloc(tamanho * sizeof(int));

    copiarVetor(
        dadosOriginais,
        vetor,
        tamanho);

    Resultado r1 =
        executarOrdenacao(vetor, tamanho);

    imprimirResultado(
        nomeArquivo,
        tamanho,
        r1);

    printf("[ORDENADO]\n");

    Resultado r2 =
        executarOrdenacao(vetor, tamanho);

    imprimirResultado(
        nomeArquivo,
        tamanho,
        r2);

    inverterVetor(vetor, tamanho);

    printf("[INVERTIDO]\n");

    Resultado r3 =
        executarOrdenacao(vetor, tamanho);

    imprimirResultado(
        nomeArquivo,
        tamanho,
        r3);

    free(vetor);
}

int main()
{

    const char *arquivo1 =
        "../../../Dados/valores.dat";

    const char *arquivo2 =
        "../../../Dados/valores-semelhantes.dat";

    for (int i = 0;
         i < TOTAL_TAMANHOS;
         i++)
    {

        int tamanho = tamanhos[i];

        int *dados1 =
            lerArquivo(arquivo1, tamanho);

        int *dados2 =
            lerArquivo(arquivo2, tamanho);

        if (!dados1 || !dados2)
        {
            return 1;
        }

        printf("\n\n");
        printf("#########################################\n");
        printf(
            "TESTE COM 10^%d ELEMENTOS\n",
            (int)log10(tamanho));
        printf("#########################################\n\n");

        executarCenario(
            "=== Valores Espalhados ===",
            dados1,
            tamanho,
            "valores.dat");

        executarCenario(
            "=== Valores Semelhantes ===",
            dados2,
            tamanho,
            "valores-semelhantes.dat");

        free(dados1);
        free(dados2);
    }

    return 0;
}
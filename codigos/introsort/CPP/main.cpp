#include "introsort.h"

#include <iostream>
#include <vector>
#include <cmath>

#define TOTAL_TAMANHOS 5

const int tamanhos[TOTAL_TAMANHOS] = {
    100,
    1000,
    10000,
    100000,
    1000000
};

void executarCenario(
    const std::string& titulo,
    std::vector<int> dadosOriginais,
    int tamanho,
    const std::string& nomeArquivo
) {

    std::cout
        << "=====================================\n";

    std::cout
        << titulo
        << "\n";

    std::cout
        << "=====================================\n\n";

    std::vector<int> vetor =
        dadosOriginais;

    Resultado r1 =
        executarOrdenacao(vetor);

    imprimirResultado(
        nomeArquivo,
        tamanho,
        r1
    );

    std::cout
        << "[ORDENADO]\n";

    Resultado r2 =
        executarOrdenacao(vetor);

    imprimirResultado(
        nomeArquivo,
        tamanho,
        r2
    );

    inverterVetor(vetor);

    std::cout
        << "[INVERTIDO]\n";

    Resultado r3 =
        executarOrdenacao(vetor);

    imprimirResultado(
        nomeArquivo,
        tamanho,
        r3
    );
}

int main() {

    std::string arquivo1 =
        "../../../Dados/valores.dat";

    std::string arquivo2 =
        "../../../Dados/valores-semelhantes.dat";

    for (int i = 0;
         i < TOTAL_TAMANHOS;
         i++) {

        int tamanho = tamanhos[i];

        std::vector<int> dados1 =
            lerArquivo(arquivo1, tamanho);

        std::vector<int> dados2 =
            lerArquivo(arquivo2, tamanho);

        if (
            dados1.empty() ||
            dados2.empty()
        ) {
            return 1;
        }

        std::cout << "\n\n";

        std::cout
            << "#########################################\n";

        std::cout
            << "TESTE COM 10^"
            << (int)std::log10(tamanho)
            << " ELEMENTOS\n";

        std::cout
            << "#########################################\n\n";

        executarCenario(
            "=== Valores Espalhados ===",
            dados1,
            tamanho,
            "valores.dat"
        );

        executarCenario(
            "=== Valores Semelhantes ===",
            dados2,
            tamanho,
            "valores-semelhantes.dat"
        );
    }

    return 0;
}
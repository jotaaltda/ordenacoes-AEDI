#include "introsort.h"

#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>
#include <chrono>
#include <algorithm>

size_t consumoMemoriaBytes(size_t quantidade) {
    return quantidade * sizeof(int);
}

void inverterVetor(std::vector<int>& vetor) {
    std::reverse(vetor.begin(), vetor.end());
}

std::vector<int> lerArquivo(
    const std::string& nomeArquivo,
    int quantidade
) {

    std::ifstream arquivo(nomeArquivo);

    if (!arquivo.is_open()) {

        std::cout
            << "Erro ao abrir arquivo: "
            << nomeArquivo
            << "\n";

        return {};
    }

    std::vector<int> vetor;
    vetor.reserve(quantidade);

    int valor;

    for (int i = 0; i < quantidade; i++) {

        if (!(arquivo >> valor)) {

            std::cout
                << "Erro lendo valor "
                << i
                << "\n";

            return {};
        }

        vetor.push_back(valor);
    }

    return vetor;
}

static void insertionSort(
    std::vector<int>& vetor,
    int inicio,
    int fim
) {

    for (int i = inicio + 1; i <= fim; i++) {

        int chave = vetor[i];
        int j = i - 1;

        while (
            j >= inicio &&
            vetor[j] > chave
        ) {

            vetor[j + 1] = vetor[j];
            j--;
        }

        vetor[j + 1] = chave;
    }
}

static void heapify(
    std::vector<int>& vetor,
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

        std::swap(
            vetor[offset + i],
            vetor[offset + maior]
        );

        heapify(vetor, n, maior, offset);
    }
}

static void heapSort(
    std::vector<int>& vetor,
    int inicio,
    int fim
) {

    int n = fim - inicio + 1;

    for (int i = n / 2 - 1; i >= 0; i--) {
        heapify(vetor, n, i, inicio);
    }

    for (int i = n - 1; i > 0; i--) {

        std::swap(
            vetor[inicio],
            vetor[inicio + i]
        );

        heapify(vetor, i, 0, inicio);
    }
}

static int particionar(
    std::vector<int>& vetor,
    int inicio,
    int fim
) {

    int pivo = vetor[fim];

    int i = inicio - 1;

    for (int j = inicio; j < fim; j++) {

        if (vetor[j] <= pivo) {

            i++;

            std::swap(
                vetor[i],
                vetor[j]
            );
        }
    }

    std::swap(
        vetor[i + 1],
        vetor[fim]
    );

    return i + 1;
}

static void introsortUtil(
    std::vector<int>& vetor,
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

    int pivo = particionar(
        vetor,
        inicio,
        fim
    );

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

void introsort(std::vector<int>& vetor) {

    int profundidadeMaxima =
        2 * log(vetor.size());

    introsortUtil(
        vetor,
        0,
        vetor.size() - 1,
        profundidadeMaxima
    );
}

Resultado executarOrdenacao(
    std::vector<int>& vetor
) {

    Resultado r;

    auto inicio =
        std::chrono::high_resolution_clock::now();

    introsort(vetor);

    auto fim =
        std::chrono::high_resolution_clock::now();

    std::chrono::duration<double> duracao =
        fim - inicio;

    r.tempo = duracao.count();

    r.memoria =
        consumoMemoriaBytes(vetor.size());

    return r;
}

void imprimirResultado(
    const std::string& arquivo,
    int tamanho,
    Resultado r
) {

    std::cout
        << arquivo
        << " - vetor de tamanho 10^"
        << (int)std::log10(tamanho)
        << "\n";

    std::cout
        << "Tempo de execucao: "
        << r.tempo
        << " segundos\n";

    std::cout
        << "Consumo aproximado de memoria: "
        << (double)r.memoria / 1024.0
        << " KB\n\n";
}
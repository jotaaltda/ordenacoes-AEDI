#ifndef INTROSORT_H
#define INTROSORT_H

#include <string>
#include <vector>

struct Resultado {
    double tempo;
    size_t memoria;
};

std::vector<int> lerArquivo(
    const std::string& nomeArquivo,
    int quantidade
);

void introsort(
    std::vector<int>& vetor
);

void inverterVetor(
    std::vector<int>& vetor
);

Resultado executarOrdenacao(
    std::vector<int>& vetor
);

void imprimirResultado(
    const std::string& arquivo,
    int tamanho,
    Resultado r
);

#endif
#include <iostream>
#include <vector>
#include <fstream>
#include "io.h"

using namespace std;

vector<int> lerArquivo(const string& caminho, int tamanho) {
    ifstream arquivo(caminho);

    if (!arquivo.is_open()) {
        cerr << "Erro ao abrir arquivo\n";
        return {};
    }

    vector<int> vetor(tamanho);

    for (int i = 0; i < tamanho; i++) {
        if (!(arquivo >> vetor[i])) {
            cerr << "Erro na leitura\n";
            return {};
        }
    }

    return vetor;
}
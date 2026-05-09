#include <vector>
#include <iostream>
#include <algorithm>
#include <chrono>
#include <iomanip>
#include "io.h"
#include "timsort.h"

const int TAMANHO_MAX_VETOR = 1000000;

using namespace std;

int main(){
    double tempo;
    double total;
    double media;
    int tamanho = 100; //1000, 10000, 100000, 1000000

    vector<int> vetor = lerArquivo("../../../Dados/valores.dat", TAMANHO_MAX_VETOR);
    if (vetor.empty()) {
        cerr << "Erro na leitura\n";
        return 1;
    }
    vector<int> vetor_semelhante = lerArquivo("../../../Dados/valores-semelhantes.dat", TAMANHO_MAX_VETOR);
    if (vetor_semelhante.empty()) {
        cerr << "Erro na leitura\n";
        return 1;
    }
    vector<int> copia = vetor;
    vector<int> ordenado = vetor;
    vector<int> invertido = vetor;

    cout << fixed << setprecision(6);

    for(int i = 0; i < 5; i++){

    //-----------------------Ordenação vetor aleatório-----------------------
        tempo = 0;
        total = 0;
        media = 0;
        cout << "-------Tamanho " << tamanho << "-------\n";
        cout << "..........Aleatorio.........\n";
        for(int j = 0; j < 10; j++){

            copy(vetor.begin(), vetor.begin() + tamanho, copia.begin());
            
            auto start = chrono::high_resolution_clock::now();
            timsort(copia.data(), tamanho);
            auto end = chrono::high_resolution_clock::now();

            chrono::duration<double> duracao = end - start;
            tempo = duracao.count();

            cout << "...  Tempo " << j << ": "<< tempo << "s  ...\n";
            total += tempo;
        }
        media = total / 10;
        cout << "...   Media: " << media << "s   ...\n";
        cout << "............................\n";

    //-----------------------Ordenação vetor ordenado------------------------
        tempo = 0;
        total = 0;
        media = 0;
        cout << "..........Ordenado..........\n";

        copy(vetor.begin(), vetor.begin() + tamanho, ordenado.begin());
        timsort(ordenado.data(), tamanho);

        for(int j = 0; j < 10; j++){

            copy(ordenado.begin(), ordenado.begin() + tamanho, copia.begin());

            auto start = chrono::high_resolution_clock::now();
            timsort(copia.data(), tamanho);
            auto end = chrono::high_resolution_clock::now();

            chrono::duration<double> duracao = end - start;
            tempo = duracao.count();

            cout << "...  Tempo " << j << ": "<< tempo << "s  ...\n";
            total += tempo;
        }
        media = total / 10;
        cout << "...   Media: " << media << "s   ...\n";
        cout << "............................\n";

    //-----------------------Ordenação vetor invertido-----------------------
        tempo = 0;
        total = 0;
        media = 0;
        
        copy(ordenado.begin(), ordenado.begin() + tamanho, invertido.begin());
        reverse(invertido.begin(), invertido.begin() + tamanho);

        cout << "..........Invertido.........\n";
        for(int j = 0; j < 10; j++){

            copy(invertido.begin(), invertido.begin() + tamanho, copia.begin());

            auto start = chrono::high_resolution_clock::now();
            timsort(copia.data(), tamanho);
            auto end = chrono::high_resolution_clock::now();

            chrono::duration<double> duracao = end - start;
            tempo = duracao.count();

            cout << "...  Tempo " << j << ": "<< tempo << "s  ...\n";
            total += tempo;
        }
        media = total / 10;
        cout << "...   Media: " << media << "s   ...\n";
        cout << "............................\n";
        
    //-----------------------Ordenação vetor semelhante----------------------
        tempo = 0;
        total = 0;
        media = 0;
        cout << ".....Valores Semelhantes....\n";
        for(int j = 0; j < 10; j++){

            copy(vetor_semelhante.begin(), vetor_semelhante.begin() + tamanho, copia.begin());

            auto start = chrono::high_resolution_clock::now();
            timsort(copia.data(), tamanho);
            auto end = chrono::high_resolution_clock::now();

            chrono::duration<double> duracao = end - start;
            tempo = duracao.count();

            cout << "...  Tempo " << j << ": "<< tempo << "s  ...\n";
            total += tempo;
        }
        media = total / 10;
        cout << "...   Media: " << media << "s   ...\n";
        cout << "............................\n";

    //-----------------------------------------------------------------------
        tamanho = tamanho*10;
    }
}
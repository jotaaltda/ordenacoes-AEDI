# Ordenações AEDI

## Descrição

Este repositório contém implementações acadêmicas de algoritmos híbridos de ordenação desenvolvidas em múltiplas linguagens de programação, com o objetivo de comparar desempenho, consumo de memória, comportamento algorítmico e diferenças estruturais entre linguagens compiladas e interpretadas.

Os algoritmos implementados foram:

- IntroSort
- TimSort

As implementações foram desenvolvidas manualmente, sem utilização das funções nativas de ordenação das linguagens, permitindo maior controle experimental e análise do comportamento interno dos algoritmos.

O projeto foi desenvolvido para fins acadêmicos na disciplina de Algoritmos e Estruturas de Dados.

---

# Estrutura do Projeto

```text
ordenacoes-AEDI-main/
│
├── Dados/
│   ├── valores.dat
│   └── valores-semelhantes.dat
│
├── codigos/
│   ├── introsort/
│   │   ├── C/
│   │   ├── CPP/
│   │   ├── CS/
│   │   ├── PY/
│   │   └── COBOL/
│   │
│   └── timsort/
│       ├── C/
│       ├── CPP/
│       ├── CS/
│       ├── PY/
│       └── COBOL/
│
├── slides/
│   └── Slide_AEDI (2).pdf
│
└── README.md
```

---

# Conjuntos de Dados

Os testes utilizam arquivos contendo conjuntos de inteiros gerados aleatoriamente.

## Arquivos

### `valores.dat`

Contém valores inteiros amplamente distribuídos e aleatórios.

### `valores-semelhantes.dat`

Contém conjuntos de valores com menor dispersão e maior repetição de números semelhantes.

---

# Tamanhos Testados

Todos os algoritmos executam benchmarks com os seguintes tamanhos de entrada:

| Quantidade de Elementos |
|---|
| 10² |
| 10³ |
| 10⁴ |
| 10⁵ |
| 10⁶ |

---

# Algoritmos Implementados

# IntroSort

O IntroSort é um algoritmo híbrido derivado da combinação entre:

- QuickSort
- HeapSort
- InsertionSort

O algoritmo inicia utilizando QuickSort devido ao excelente desempenho médio. Entretanto, quando a profundidade recursiva ultrapassa um limite previamente definido, ocorre uma transição para HeapSort, evitando degradação para complexidade quadrática.

Partições pequenas são tratadas com InsertionSort devido ao menor custo operacional nesse cenário.

## Complexidade

| Caso | Complexidade |
|---|---|
| Melhor caso | O(n log n) |
| Caso médio | O(n log n) |
| Pior caso | O(n log n) |

## Características

- Não estável
- Baixo consumo de memória auxiliar
- Excelente desempenho geral
- Utilizado em implementações reais de bibliotecas padrão

---

# TimSort

O TimSort é um algoritmo híbrido baseado em:

- MergeSort
- InsertionSort

Seu funcionamento consiste em identificar pequenos blocos ordenados (runs), organizando-os inicialmente com InsertionSort e posteriormente realizando merges progressivos.

O algoritmo apresenta excelente desempenho em dados parcialmente ordenados e em conjuntos contendo muitos valores repetidos.

## Complexidade

| Caso | Complexidade |
|---|---|
| Melhor caso | O(n) |
| Caso médio | O(n log n) |
| Pior caso | O(n log n) |

## Características

- Estável
- Excelente desempenho em dados reais
- Consome memória auxiliar adicional
- Utilizado em linguagens modernas como Python e Java

---

# Linguagens Utilizadas

O projeto possui implementações completas em:

| Linguagem | IntroSort | TimSort |
|---|---|---|
| C | Sim | Sim |
| C++ | Sim | Sim |
| C# | Sim | Sim |
| Python | Sim | Sim |
| COBOL | Sim | Sim |

---

# Implementações

# IntroSort em C

A implementação em C foi construída utilizando exclusivamente recursos da linguagem C padrão.

## Estratégia

- QuickSort como algoritmo principal
- HeapSort como fallback para profundidade excessiva
- InsertionSort em pequenas partições

## Bibliotecas Utilizadas

```c
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <string.h>
```

## Recursos Utilizados

- Ponteiros
- Recursão explícita
- Alocação dinâmica com `malloc`
- Liberação manual com `free`
- Leitura textual com `fscanf`

## Recursos Não Utilizados

A função:

```c
qsort()
```

não foi utilizada.

## Medição Temporal

Realizada utilizando:

```c
clock()
```

## Medição de Memória

Estimativa baseada em:

```c
quantidade * sizeof(int)
```

---

# IntroSort em C++

A implementação em C++ manteve equivalência estrutural com a versão em C, porém utilizando recursos modernos da STL.

## Bibliotecas Utilizadas

```cpp
#include <iostream>
#include <vector>
#include <fstream>
#include <cmath>
#include <chrono>
#include <algorithm>
```

## Recursos Utilizados

- `std::vector<int>`
- `std::swap`
- `std::ifstream`
- `std::chrono`

## Recursos Não Utilizados

A função:

```cpp
std::sort()
```

não foi utilizada.

## Medição Temporal

Realizada utilizando:

```cpp
std::chrono
```

---

# IntroSort em C#

A implementação em C# foi desenvolvida utilizando a plataforma .NET.

## Bibliotecas Utilizadas

```csharp
using System;
using System.IO;
using System.Diagnostics;
```

## Recursos Utilizados

- Arrays `int[]`
- `Stopwatch`
- `File.ReadAllLines`
- `Array.Reverse`

## Recursos Não Utilizados

A função:

```csharp
Array.Sort()
```

não foi utilizada.

## Medição Temporal

Realizada utilizando:

```csharp
Stopwatch
```

## Observação

O gerenciamento de memória é realizado automaticamente pelo Garbage Collector da CLR.

---

# IntroSort em Python

A implementação em Python buscou manter equivalência estrutural com as demais linguagens.

## Bibliotecas Utilizadas

```python
import math
import time
import sys
import os
```

## Recursos Utilizados

- Listas Python
- Recursão explícita
- `time.perf_counter()`
- `sys.getsizeof()`

## Recursos Não Utilizados

As funções:

```python
sort()
sorted()
```

não foram utilizadas.

## Observação

Inteiros em Python são objetos completos (`PyObject`) e apresentam overhead significativamente maior em memória.

---

# IntroSort em COBOL

A implementação em COBOL foi desenvolvida com foco experimental e acadêmico, demonstrando a adaptação de algoritmos modernos de ordenação para linguagens clássicas de processamento corporativo.

## Características

- Implementação manual
- Manipulação de arrays em COBOL
- Controle procedural explícito
- Leitura textual de arquivos `.dat`

## Objetivo

Avaliar a viabilidade e o comportamento de algoritmos híbridos em linguagens historicamente utilizadas em sistemas legados e aplicações financeiras.

---

# TimSort em C

A implementação em C combina:

- InsertionSort
- MergeSort

## Características

- Uso de vetores auxiliares
- Merge incremental
- Estrutura procedural
- Controle manual de memória

---

# TimSort em C++

A implementação em C++ utiliza STL básica, mantendo o algoritmo completamente manual.

## Recursos Utilizados

- `std::vector`
- `std::ifstream`
- `std::chrono`

## Recursos Não Utilizados

```cpp
std::stable_sort()
```

não foi utilizado.

---

# TimSort em C#

A implementação em C# utiliza arrays `int[]` e merges manuais.

## Recursos Utilizados

- `Stopwatch`
- Vetores auxiliares temporários
- `File.ReadAllLines`

## Características

- Estável
- Excelente desempenho em dados parcialmente ordenados

---

# TimSort em Python

A implementação em Python reproduz manualmente a lógica geral do TimSort.

## Características

- Runs ordenados com InsertionSort
- Merge progressivo
- Estrutura baseada em listas Python

## Recursos Não Utilizados

```python
sort()
sorted()
```

não foram utilizados.

---

# TimSort em COBOL

A implementação em COBOL adapta a lógica do TimSort para estruturas procedurais clássicas da linguagem.

## Objetivo

Demonstrar a aplicação de algoritmos híbridos modernos em ambientes legados.

---

# Benchmarks

Todos os algoritmos executam testes considerando:

1. Vetor original
2. Vetor previamente ordenado
3. Vetor invertido

Cada execução imprime:

- Tipo da entrada
- Quantidade de elementos
- Tempo de execução

---

# Estratégia de Medição Temporal

As implementações utilizam mecanismos específicos de cada linguagem:

| Linguagem | Ferramenta |
|---|---|
| C | `clock()` |
| C++ | `std::chrono` |
| C# | `Stopwatch` |
| Python | `time.perf_counter()` |
| COBOL | Temporização procedural |

---

# Estratégia de Medição de Memória

As implementações estimam memória principalmente através do tamanho teórico dos vetores utilizados.

Exemplo:

```c
quantidade * sizeof(int)
```

Em Python, foi utilizado:

```python
sys.getsizeof()
```

devido ao overhead interno dos objetos Python.

---

# Compilação e Execução

# Linux (Ubuntu/Debian)

## Dependências Gerais

```bash
sudo apt update
sudo apt install build-essential python3
```

---

# C e C++

## Compilação

```bash
make
```

## Execução

```bash
make run
```

---

# Python

## Execução

```bash
make run
```

---

# C#

## Dependência

Instalar o .NET SDK:

https://dotnet.microsoft.com/download

## Execução

```bash
make run
```

---

# COBOL

## Dependência

Instalar o compilador GnuCOBOL:

```bash
sudo apt install gnucobol
```

## Compilação

```bash
make
```

## Execução

```bash
make run
```

---

# Makefiles

Cada implementação possui seu próprio `Makefile`, permitindo:

- Compilação automatizada
- Execução automatizada
- Limpeza de arquivos temporários

Comandos disponíveis:

```bash
make
make run
make clean
```

---

# Considerações Sobre Desempenho

As diferenças observadas entre as implementações estão diretamente relacionadas às características internas das linguagens, incluindo:

- Overhead de runtime
- Garbage Collector
- Eficiência das estruturas de dados
- Custo de abstrações
- Profundidade recursiva
- Representação interna de inteiros
- Gerenciamento de memória

As implementações em C e C++ apresentaram os menores tempos de execução e menor consumo de memória.

As implementações em C# apresentaram desempenho intermediário, beneficiadas pelo JIT da CLR.

As implementações em Python apresentaram maior consumo de memória e maior tempo de execução, especialmente em vetores ordenados ou contendo muitos valores semelhantes.

As implementações em COBOL possuem foco experimental e acadêmico, priorizando compatibilidade estrutural e estudo algorítmico em ambientes legados.

O TimSort apresentou desempenho superior em conjuntos parcialmente ordenados e em entradas contendo muitos valores semelhantes.

---

# Objetivos Acadêmicos

Este projeto possui finalidade exclusivamente educacional e experimental.

Os principais objetivos incluem:

- Comparação entre linguagens
- Comparação entre algoritmos híbridos
- Estudo de complexidade computacional
- Análise de desempenho
- Estudo de consumo de memória
- Experimentação com grandes volumes de dados
- Adaptação de algoritmos modernos para linguagens legadas

---

# Slides

O diretório `slides` contém material complementar utilizado na apresentação acadêmica do projeto.

Arquivo disponível:

```text
Slide_AEDI (2).pdf
```

---

# Licença

Projeto desenvolvido para fins acadêmicos.

# Créditos

Projeto desenvolvido por:

- Ítalo Xavier Fonseca
- João Paulo de Abreu Duarte
- Matheus Tavares de Bessas
- Thales Guerreiro Lima Gomes de Castro

README desenvolvido com auxílio do ChatGPT (OpenAI) para estruturação técnica, documentação e padronização acadêmica do projeto.
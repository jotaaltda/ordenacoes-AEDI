import math
import time
import sys

def inverter_vetor(vetor):
    vetor.reverse()

def consumo_memoria_bytes(vetor):
    return sys.getsizeof(vetor) + (
        len(vetor) * sys.getsizeof(0)
    )

def ler_arquivo(nome_arquivo, quantidade):

    vetor = []

    with open(nome_arquivo, "r") as arquivo:

        for i in range(quantidade):

            linha = arquivo.readline()

            if not linha:
                raise Exception(
                    f"Erro lendo linha {i}"
                )

            vetor.append(int(linha.strip()))

    return vetor

def insertion_sort(vetor, inicio, fim):

    for i in range(inicio + 1, fim + 1):

        chave = vetor[i]

        j = i - 1

        while (
            j >= inicio and
            vetor[j] > chave
        ):

            vetor[j + 1] = vetor[j]

            j -= 1

        vetor[j + 1] = chave

def heapify(vetor, n, i, offset):

    maior = i

    esquerda = 2 * i + 1
    direita = 2 * i + 2

    if (
        esquerda < n and
        vetor[offset + esquerda] >
        vetor[offset + maior]
    ):
        maior = esquerda

    if (
        direita < n and
        vetor[offset + direita] >
        vetor[offset + maior]
    ):
        maior = direita

    if maior != i:

        vetor[offset + i], vetor[offset + maior] = (
            vetor[offset + maior],
            vetor[offset + i]
        )

        heapify(vetor, n, maior, offset)


def heap_sort(vetor, inicio, fim):

    n = fim - inicio + 1

    for i in range(n // 2 - 1, -1, -1):
        heapify(vetor, n, i, inicio)

    for i in range(n - 1, 0, -1):

        vetor[inicio], vetor[inicio + i] = (
            vetor[inicio + i],
            vetor[inicio]
        )

        heapify(vetor, i, 0, inicio)

def particionar(vetor, inicio, fim):

    meio = (inicio + fim) // 2

    candidatos = [
        (vetor[inicio], inicio),
        (vetor[meio], meio),
        (vetor[fim], fim)
    ]

    candidatos.sort(key=lambda x: x[0])

    indice_pivo = candidatos[1][1]

    vetor[indice_pivo], vetor[fim] = (
        vetor[fim],
        vetor[indice_pivo]
    )

    pivo = vetor[fim]

    i = inicio - 1

    for j in range(inicio, fim):

        if vetor[j] <= pivo:

            i += 1

            vetor[i], vetor[j] = (
                vetor[j],
                vetor[i]
            )

    vetor[i + 1], vetor[fim] = (
        vetor[fim],
        vetor[i + 1]
    )

    return i + 1

def introsort_util(
    vetor,
    inicio,
    fim,
    profundidade_maxima
):

    tamanho = fim - inicio + 1

    if tamanho <= 16:

        insertion_sort(vetor, inicio, fim)
        return

    if profundidade_maxima == 0:

        heap_sort(vetor, inicio, fim)
        return

    pivo = particionar(vetor, inicio, fim)

    introsort_util(
        vetor,
        inicio,
        pivo - 1,
        profundidade_maxima - 1
    )

    introsort_util(
        vetor,
        pivo + 1,
        fim,
        profundidade_maxima - 1
    )


def introsort(vetor):

    profundidade_maxima = (
        2 * int(math.log2(len(vetor)))
    )

    introsort_util(
        vetor,
        0,
        len(vetor) - 1,
        profundidade_maxima
    )

def executar_ordenacao(vetor):

    inicio = time.perf_counter()

    introsort(vetor)

    fim = time.perf_counter()

    return {
        "tempo": fim - inicio,
        "memoria":
            consumo_memoria_bytes(vetor)
    }


def imprimir_resultado(
    arquivo,
    tamanho,
    resultado
):

    print(
        f"{arquivo} - vetor de tamanho "
        f"10^{int(math.log10(tamanho))}"
    )

    print(
        f"Tempo de execucao: "
        f"{resultado['tempo']:.6f} segundos"
    )

    print(
        f"Consumo aproximado de memoria: "
        f"{resultado['memoria'] / 1024:.2f} KB\n"
    )
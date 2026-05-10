import time

from pathlib import Path

TAMANHO_VETOR_MAX = 1_000_000
MINRUN = 32


def ler_arquivo(caminho, tamanho):
    vetor = []

    with open(caminho, "r") as arquivo:
        for i, linha in enumerate(arquivo):
            if i >= tamanho:
                break
            vetor.append(int(linha.strip()))

    if len(vetor) < tamanho:
        raise ValueError("Arquivo possui menos valores que o esperado")

    return vetor


def insertion_sort(vetor, esquerda, direita):
    for i in range(esquerda + 1, direita + 1):
        x = vetor[i]
        j = i - 1

        while j >= esquerda and vetor[j] > x:
            vetor[j + 1] = vetor[j]
            j -= 1

        vetor[j + 1] = x


def merge(vetor, esquerda, meio, direita):
    esquerda_vetor = vetor[esquerda:meio + 1]
    direita_vetor = vetor[meio + 1:direita + 1]

    i = 0
    j = 0
    k = esquerda

    while i < len(esquerda_vetor) and j < len(direita_vetor):
        if esquerda_vetor[i] <= direita_vetor[j]:
            vetor[k] = esquerda_vetor[i]
            i += 1
        else:
            vetor[k] = direita_vetor[j]
            j += 1
        k += 1

    while i < len(esquerda_vetor):
        vetor[k] = esquerda_vetor[i]
        i += 1
        k += 1

    while j < len(direita_vetor):
        vetor[k] = direita_vetor[j]
        j += 1
        k += 1


def timsort(vetor, n):
    for inicio in range(0, n, MINRUN):
        fim = min(inicio + MINRUN - 1, n - 1)
        insertion_sort(vetor, inicio, fim)

    tamanho = MINRUN

    while tamanho < n:
        for esquerda in range(0, n, 2 * tamanho):
            meio = min(esquerda + tamanho - 1, n - 1)
            direita = min(esquerda + 2 * tamanho - 1, n - 1)

            if meio < direita:
                merge(vetor, esquerda, meio, direita)

        tamanho *= 2


def medir_cenario(nome, base, tamanho):
    print(f"..........{nome}.........")

    total = 0.0

    for j in range(10):
        copia = base[:tamanho]

        inicio = time.perf_counter()
        timsort(copia, tamanho)
        fim = time.perf_counter()

        tempo = fim - inicio
        total += tempo

        print(f"...  Tempo {j}: {tempo:.6f}s  ...")

    media = total / 10
    print(f"...   Media: {media:.6f}s   ...")
    print("............................")


def main():
    base = Path(__file__).resolve().parent

    caminho_valores = base / "../../../Dados/valores.dat"
    caminho_semelhantes = base / "../../../Dados/valores-semelhantes.dat"

    vetor = ler_arquivo(caminho_valores, TAMANHO_VETOR_MAX)
    vetor_semelhante = ler_arquivo(caminho_semelhantes, TAMANHO_VETOR_MAX)

    tamanho = 100

    for _ in range(5):
        print(f"-------Tamanho {tamanho}-------")

        medir_cenario("Aleatorio", vetor, tamanho)

        ordenado = vetor[:tamanho]
        timsort(ordenado, tamanho)
        medir_cenario("Ordenado", ordenado, tamanho)

        invertido = ordenado[::-1]
        medir_cenario("Invertido", invertido, tamanho)

        medir_cenario("Valores Semelhantes", vetor_semelhante, tamanho)

        tamanho *= 10


if __name__ == "__main__":
    main()
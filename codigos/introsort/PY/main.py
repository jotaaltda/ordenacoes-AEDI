import math

from introsort import (
    ler_arquivo,
    inverter_vetor,
    executar_ordenacao,
    imprimir_resultado
)

TAMANHOS = [
    100,
    1000,
    10000,
    100000,
    1000000
]


def executar_cenario(
    titulo,
    dados_originais,
    tamanho,
    nome_arquivo
):

    print("=====================================")
    print(titulo)
    print("=====================================\n")

    vetor = dados_originais.copy()

    r1 = executar_ordenacao(vetor)

    imprimir_resultado(
        nome_arquivo,
        tamanho,
        r1
    )

    print("[ORDENADO]")

    r2 = executar_ordenacao(vetor)

    imprimir_resultado(
        nome_arquivo,
        tamanho,
        r2
    )

    inverter_vetor(vetor)

    print("[INVERTIDO]")

    r3 = executar_ordenacao(vetor)

    imprimir_resultado(
        nome_arquivo,
        tamanho,
        r3
    )


def main():

    arquivo1 = "../../../Dados/valores.dat"

    arquivo2 = (
        "../../../Dados/"
        "valores-semelhantes.dat"
    )

    for tamanho in TAMANHOS:

        dados1 = ler_arquivo(
            arquivo1,
            tamanho
        )

        dados2 = ler_arquivo(
            arquivo2,
            tamanho
        )

        print("\n#########################################")

        print(
            f"TESTE COM "
            f"10^{int(math.log10(tamanho))} "
            f"ELEMENTOS"
        )

        print("#########################################\n")

        executar_cenario(
            "=== Valores Espalhados ===",
            dados1,
            tamanho,
            "valores.dat"
        )

        executar_cenario(
            "=== Valores Semelhantes ===",
            dados2,
            tamanho,
            "valores-semelhantes.dat"
        )


if __name__ == "__main__":
    main()
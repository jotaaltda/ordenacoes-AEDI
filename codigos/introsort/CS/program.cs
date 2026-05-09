using System;

class Program
{
    static readonly int[] tamanhos =
    {
        100,
        1000,
        10000,
        100000,
        1000000
    };

    static void ExecutarCenario(
        string titulo,
        int[] dadosOriginais,
        int tamanho,
        string nomeArquivo
    )
    {
        Console.WriteLine(
            "====================================="
        );

        Console.WriteLine(titulo);

        Console.WriteLine(
            "=====================================\n"
        );

        int[] vetor =
            (int[])dadosOriginais.Clone();

        Resultado r1 =
            IntrosortUtil.ExecutarOrdenacao(vetor);

        IntrosortUtil.ImprimirResultado(
            nomeArquivo,
            tamanho,
            r1
        );

        Console.WriteLine("[ORDENADO]");

        Resultado r2 =
            IntrosortUtil.ExecutarOrdenacao(vetor);

        IntrosortUtil.ImprimirResultado(
            nomeArquivo,
            tamanho,
            r2
        );

        IntrosortUtil.InverterVetor(vetor);

        Console.WriteLine("[INVERTIDO]");

        Resultado r3 =
            IntrosortUtil.ExecutarOrdenacao(vetor);

        IntrosortUtil.ImprimirResultado(
            nomeArquivo,
            tamanho,
            r3
        );
    }

    static void Main()
    {
        string arquivo1 =
            "../../../Dados/valores.dat";

        string arquivo2 =
            "../../../Dados/valores-semelhantes.dat";

        foreach (int tamanho in tamanhos)
        {
            int[] dados1 =
                IntrosortUtil.LerArquivo(
                    arquivo1,
                    tamanho
                );

            int[] dados2 =
                IntrosortUtil.LerArquivo(
                    arquivo2,
                    tamanho
                );

            Console.WriteLine(
                "\n#########################################"
            );

            Console.WriteLine(
                $"TESTE COM 10^{(int)Math.Log10(tamanho)} ELEMENTOS"
            );

            Console.WriteLine(
                "#########################################\n"
            );

            ExecutarCenario(
                "=== Valores Espalhados ===",
                dados1,
                tamanho,
                "valores.dat"
            );

            ExecutarCenario(
                "=== Valores Semelhantes ===",
                dados2,
                tamanho,
                "valores-semelhantes.dat"
            );
        }
    }
}
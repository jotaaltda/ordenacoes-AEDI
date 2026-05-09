using System;
using System.Diagnostics;
using System.IO;

public struct Resultado
{
    public double Tempo;
    public long Memoria;
}

public static class TimsortUtil
{
    private const int RUN = 32;
    
    public static int[] LerArquivo(
        string nomeArquivo,
        int quantidade
    )
    {
        string[] linhas =
            File.ReadAllLines(nomeArquivo);

        int[] vetor =
            new int[quantidade];

        for (int i = 0; i < quantidade; i++)
        {
            vetor[i] = int.Parse(linhas[i]);
        }

        return vetor;
    }

    public static void InverterVetor(int[] vetor)
    {
        Array.Reverse(vetor);
    }

    public static long ConsumoMemoriaBytes(int quantidade)
    {
        return quantidade * sizeof(int);
    }

    private static void InsertionSort(
        int[] vetor,
        int esquerda,
        int direita
    )
    {
        for (int i = esquerda + 1; i <= direita; i++)
        {
            int temp = vetor[i];

            int j = i - 1;

            while (
                j >= esquerda &&
                vetor[j] > temp
            )
            {
                vetor[j + 1] = vetor[j];
                j--;
            }

            vetor[j + 1] = temp;
        }
    }

    private static void Merge(
        int[] vetor,
        int esquerda,
        int meio,
        int direita
    )
    {
        int tamanho1 = meio - esquerda + 1;
        int tamanho2 = direita - meio;

        int[] esquerdaTemp =
            new int[tamanho1];

        int[] direitaTemp =
            new int[tamanho2];

        for (int i = 0; i < tamanho1; i++)
        {
            esquerdaTemp[i] =
                vetor[esquerda + i];
        }

        for (int i = 0; i < tamanho2; i++)
        {
            direitaTemp[i] =
                vetor[meio + 1 + i];
        }

        int x = 0;
        int y = 0;
        int k = esquerda;

        while (
            x < tamanho1 &&
            y < tamanho2
        )
        {
            if (
                esquerdaTemp[x] <=
                direitaTemp[y]
            )
            {
                vetor[k] =
                    esquerdaTemp[x];

                x++;
            }
            else
            {
                vetor[k] =
                    direitaTemp[y];

                y++;
            }

            k++;
        }

        while (x < tamanho1)
        {
            vetor[k] =
                esquerdaTemp[x];

            x++;
            k++;
        }

        while (y < tamanho2)
        {
            vetor[k] =
                direitaTemp[y];

            y++;
            k++;
        }
    }

    public static void Timsort(int[] vetor)
    {
        int n = vetor.Length;

        for (
            int i = 0;
            i < n;
            i += RUN
        )
        {
            InsertionSort(
                vetor,
                i,
                Math.Min(
                    i + RUN - 1,
                    n - 1
                )
            );
        }

        for (
            int tamanho = RUN;
            tamanho < n;
            tamanho *= 2
        )
        {
            for (
                int esquerda = 0;
                esquerda < n;
                esquerda += 2 * tamanho
            )
            {
                int meio =
                    esquerda + tamanho - 1;

                int direita =
                    Math.Min(
                        esquerda + 2 * tamanho - 1,
                        n - 1
                    );

                if (meio < direita)
                {
                    Merge(
                        vetor,
                        esquerda,
                        meio,
                        direita
                    );
                }
            }
        }
    }

    public static Resultado ExecutarOrdenacao(
        int[] vetor
    )
    {
        Stopwatch sw =
            Stopwatch.StartNew();

        Timsort(vetor);

        sw.Stop();

        return new Resultado
        {
            Tempo = sw.Elapsed.TotalSeconds,
            Memoria =
                ConsumoMemoriaBytes(vetor.Length)
        };
    }

    public static void ImprimirResultado(
        string arquivo,
        int tamanho,
        Resultado r
    )
    {
        Console.WriteLine(
            $"{arquivo} - vetor de tamanho 10^{(int)Math.Log10(tamanho)}"
        );

        Console.WriteLine(
            $"Tempo de execucao: {r.Tempo:F6} segundos"
        );

        Console.WriteLine(
            $"Consumo aproximado de memoria: {(double)r.Memoria / 1024:F2} KB\n"
        );
    }
}
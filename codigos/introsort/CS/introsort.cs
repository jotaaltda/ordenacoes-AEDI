using System;
using System.Diagnostics;
using System.IO;

public struct Resultado
{
    public double Tempo;
    public long Memoria;
}

public static class IntrosortUtil
{
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
        int inicio,
        int fim
    )
    {
        for (int i = inicio + 1; i <= fim; i++)
        {
            int chave = vetor[i];
            int j = i - 1;

            while (
                j >= inicio &&
                vetor[j] > chave
            )
            {
                vetor[j + 1] = vetor[j];
                j--;
            }

            vetor[j + 1] = chave;
        }
    }
        private static void Heapify(
        int[] vetor,
        int n,
        int i,
        int offset
    )
    {
        int maior = i;

        int esquerda = 2 * i + 1;
        int direita = 2 * i + 2;

        if (
            esquerda < n &&
            vetor[offset + esquerda] >
            vetor[offset + maior]
        )
        {
            maior = esquerda;
        }

        if (
            direita < n &&
            vetor[offset + direita] >
            vetor[offset + maior]
        )
        {
            maior = direita;
        }

        if (maior != i)
        {
            int temp = vetor[offset + i];
            vetor[offset + i] = vetor[offset + maior];
            vetor[offset + maior] = temp;

            Heapify(
                vetor,
                n,
                maior,
                offset
            );
        }
    }

    private static void HeapSort(
        int[] vetor,
        int inicio,
        int fim
    )
    {
        int n = fim - inicio + 1;

        for (int i = n / 2 - 1; i >= 0; i--)
        {
            Heapify(vetor, n, i, inicio);
        }

        for (int i = n - 1; i > 0; i--)
        {
            int temp = vetor[inicio];
            vetor[inicio] = vetor[inicio + i];
            vetor[inicio + i] = temp;

            Heapify(vetor, i, 0, inicio);
        }
    }

    private static int Particionar(
        int[] vetor,
        int inicio,
        int fim
    )
    {
        int pivo = vetor[fim];

        int i = inicio - 1;

        for (int j = inicio; j < fim; j++)
        {
            if (vetor[j] <= pivo)
            {
                i++;

                int temp = vetor[i];
                vetor[i] = vetor[j];
                vetor[j] = temp;
            }
        }

        int troca = vetor[i + 1];
        vetor[i + 1] = vetor[fim];
        vetor[fim] = troca;

        return i + 1;
    }

    private static void IntrosortUtilRec(
        int[] vetor,
        int inicio,
        int fim,
        int profundidadeMaxima
    )
    {
        int tamanho = fim - inicio + 1;

        if (tamanho <= 16)
        {
            InsertionSort(vetor, inicio, fim);
            return;
        }

        if (profundidadeMaxima == 0)
        {
            HeapSort(vetor, inicio, fim);
            return;
        }

        int pivo =
            Particionar(vetor, inicio, fim);

        IntrosortUtilRec(
            vetor,
            inicio,
            pivo - 1,
            profundidadeMaxima - 1
        );

        IntrosortUtilRec(
            vetor,
            pivo + 1,
            fim,
            profundidadeMaxima - 1
        );
    }

    public static void Introsort(int[] vetor)
    {
        int profundidadeMaxima =
            2 * (int)Math.Log(vetor.Length);

        IntrosortUtilRec(
            vetor,
            0,
            vetor.Length - 1,
            profundidadeMaxima
        );
    }
    
    public static Resultado ExecutarOrdenacao(
        int[] vetor
    )
    {
        Stopwatch sw =
            Stopwatch.StartNew();

        Introsort(vetor);

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
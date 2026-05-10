       IDENTIFICATION DIVISION.
       PROGRAM-ID. INTROSORT.

       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQUIVO
               ASSIGN TO "../../../../Dados/valores.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT ARQUIVO_SEMELHANTE
               ASSIGN TO "../../../../Dados/valores-semelhantes.dat"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.

       FILE SECTION.

       FD ARQUIVO.

       01 REGISTRO-ARQUIVO.
           05 NUMERO-LIDO PIC X(9).


       FD ARQUIVO_SEMELHANTE.

       01 REGISTRO-SEMELHANTE.
           05 NUMERO-LIDO-SEM PIC X(9).

       WORKING-STORAGE SECTION.
       01 TAMANHO          PIC 9(9) COMP.*>Define o tamanho do vetor ordenado
       01 TAMANHO-ARQUIVO  PIC 9(9) COMP.
       01 REPETE           PIC 9(9).
       01 I_MAIN           PIC 9(2) COMP.
       01 I_TEMPO          PIC 9(2).
       01 MEDIA            PIC 99V9(6).
       01 MEDIA-EXECUCAO   PIC 99V9(6).
       01 TOTAL-MEDIAS     PIC 999V9(9).

       01 TEMPO-INICIO.
           05 HORA-I PIC 99.
           05 MIN-I  PIC 99.
           05 SEG-I  PIC 99.
           05 CENT-I PIC 99.

       01 TEMPO-FIM.
           05 HORA-F PIC 99.
           05 MIN-F  PIC 99.
           05 SEG-F  PIC 99.
           05 CENT-F PIC 99.

       01 TOTAL-INICIO PIC 9(10).
       01 TOTAL-FIM    PIC 9(10).
       01 TEMPO-GASTO  PIC 9(10)V99.
       01 TEMPO_CS     PIC 9(10)V99.*>TEMPO DE COPIA E SORT
       01 TEMPO_C      PIC 9(10)V99.*>TEMPO SÓ DE COPIA
       01 TEMPO-FINAL  PIC 9(10)V99.

       01 VETOR_ORIGINAL.
           05 N_ORIG OCCURS 1000000 TIMES PIC 9(9).

       01 VETOR_INVERTIDO.
           05 N_INV OCCURS 1000000 TIMES PIC 9(9).

       01 VETOR_ORDENADO.
           05 N_ORD OCCURS 1000000 TIMES PIC 9(9).
       01 IND_INV PIC 9(9) COMP.

      *****Variaveis usadas para a leitura do arquivo*****

       01 VETOR.
           05 NUMERO OCCURS 1000000 TIMES PIC 9(9).

       01 VETOR_SEMELHANTE.
           05 N_SEMELHANTE OCCURS 1000000 TIMES PIC 9(9).

       01 INDICE   PIC 9(9) COMP VALUE 1.
       01 FIM      PIC X VALUE 'N'.
       01 VALOR    PIC 9(9).

      ****************************************************
      **********Variaveis usadas para o sorting***********

       01 ESQ PIC 9(9) COMP.
       01 DIR PIC 9(9) COMP.
       01 A   PIC 9(9) COMP.

      *INSERTION
       01 I_INS        PIC 9(9) COMP. *>Usado pro loop
       01 J            PIC S9(9) COMP. *>Usado pro loop
       01 X            PIC 9(9). *>Usado para atribuir os valores
       01 K            PIC 9(9) COMP. *>(J+1)
       01 ESQ_MAIS_1   PIC 9(9).

      *HEAPSORT
       01 HEAP-ESQ        PIC 9(9) COMP.
       01 HEAP-DIR        PIC 9(9) COMP.
       01 HEAP-N          PIC 9(9) COMP.
       01 HEAP-I          PIC 9(9) COMP.
       01 HEAP-ROOT       PIC 9(9) COMP.
       01 HEAP-LARGEST    PIC 9(9) COMP.
       01 HEAP-LEFT       PIC 9(9) COMP.
       01 HEAP-RIGHT      PIC 9(9) COMP.
       01 ABS-ROOT        PIC 9(9) COMP.
       01 ABS-LARGEST     PIC 9(9) COMP.
       01 ABS-LEFT        PIC 9(9) COMP.
       01 ABS-RIGHT       PIC 9(9) COMP.
       01 HEAP-END        PIC 9(9) COMP.

      *INTROSORT
       01 PROF-MAX     PIC 9(9) COMP.
       01 PROF         PIC 9(9) COMP.
       01 AUX-TAM      PIC 9(9) COMP.
       01 INTERVALO    PIC 9(9) COMP.
       01 LEFT-LEN        PIC 9(9) COMP.
       01 RIGHT-LEN       PIC 9(9) COMP.
       01 PIVO            PIC 9(9).
       01 PIVO-INDEX      PIC 9(9) COMP.
       01 PART-I          PIC S9(9) COMP.
       01 PART-J          PIC 9(9) COMP.
       01 TEMP            PIC 9(9).

       01 STACK-TOP       PIC 9(9) COMP VALUE 0.
       01 PILHA.
          05 PILHA-ESQ   OCCURS 10000 TIMES PIC 9(9) COMP.
          05 PILHA-DIR   OCCURS 10000 TIMES PIC 9(9) COMP.
          05 PILHA-PROF  OCCURS 10000 TIMES PIC S9(9) COMP.


      ******************************************************************

       PROCEDURE DIVISION.

       MAIN-PROCEDURE.

           PERFORM 100-LEITURA
           MOVE 100 TO TAMANHO
           MOVE 10000 TO REPETE

      ******************************************************************

           PERFORM VARYING I_MAIN FROM 1 BY 1 UNTIL I_MAIN > 5
               DISPLAY "-------Tamanho " TAMANHO "-------"
               DISPLAY "..........Aleatorio..........."
               MOVE 0 TO TOTAL-MEDIAS
               PERFORM VARYING I_TEMPO FROM 1 BY 1 UNTIL I_TEMPO > 10
      *    REPETE ALGUMAS VEZES PARA MAIOR PRECISÃO(SE NÃO SAI 0.00s),
      *    DEPOIS EXCLUI OVERHEAD DO MOVE VETOR_ORIGINAL TO VETOR
                   ACCEPT TEMPO-INICIO FROM TIME
                   PERFORM REPETE TIMES
                       MOVE VETOR_ORIGINAL TO VETOR
                       PERFORM 400-INTROSORT
                   END-PERFORM
                   ACCEPT TEMPO-FIM FROM TIME

                   PERFORM 500-TEMPO
                   MOVE TEMPO-GASTO TO TEMPO_CS

                   ACCEPT TEMPO-INICIO FROM TIME
                   PERFORM REPETE TIMES
                       MOVE VETOR_ORIGINAL TO VETOR
                   END-PERFORM
                   ACCEPT TEMPO-FIM FROM TIME

                   PERFORM 500-TEMPO
                   MOVE TEMPO-GASTO TO TEMPO_C

                   COMPUTE TEMPO-FINAL =
                       TEMPO_CS - TEMPO_C

                   COMPUTE MEDIA-EXECUCAO = TEMPO-FINAL / REPETE
                   ADD MEDIA-EXECUCAO TO TOTAL-MEDIAS
                  DISPLAY "...  Tempo "I_TEMPO": "MEDIA-EXECUCAO"s  ..."

               END-PERFORM

               COMPUTE MEDIA = TOTAL-MEDIAS / 10
               DISPLAY "...   Media: " MEDIA "s   ..."
               DISPLAY "............................"

      ******************************************************************

               DISPLAY "..........Ordenado..........."
               MOVE 0 TO TOTAL-MEDIAS
               MOVE 1 TO I_TEMPO

               MOVE VETOR_ORIGINAL TO VETOR
               PERFORM 400-INTROSORT
               MOVE VETOR TO VETOR_ORDENADO

               PERFORM VARYING I_TEMPO FROM 1 BY 1 UNTIL I_TEMPO > 10
      *    REPETE ALGUMAS VEZES PARA MAIOR PRECISÃO(SE NÃO SAI 0.00s)
      *    DEPOIS EXCLUI OVERHEAD DO MOVE VETOR_ORIGINAL TO VETOR

                   ACCEPT TEMPO-INICIO FROM TIME
                   PERFORM REPETE TIMES
                       MOVE VETOR_ORDENADO TO VETOR
                       PERFORM 400-INTROSORT
                   END-PERFORM
                   ACCEPT TEMPO-FIM FROM TIME

                   PERFORM 500-TEMPO
                   MOVE TEMPO-GASTO TO TEMPO_CS

                   ACCEPT TEMPO-INICIO FROM TIME
                   PERFORM REPETE TIMES
                       MOVE VETOR_ORDENADO TO VETOR
                   END-PERFORM
                   ACCEPT TEMPO-FIM FROM TIME

                   PERFORM 500-TEMPO
                   MOVE TEMPO-GASTO TO TEMPO_C

                   COMPUTE TEMPO-FINAL =
                       TEMPO_CS - TEMPO_C

                   COMPUTE MEDIA-EXECUCAO = TEMPO-FINAL / REPETE
                   ADD MEDIA-EXECUCAO TO TOTAL-MEDIAS
                  DISPLAY "...  Tempo "I_TEMPO": "MEDIA-EXECUCAO"s  ..."

               END-PERFORM

               COMPUTE MEDIA = TOTAL-MEDIAS / 10
               DISPLAY "...   Media: " MEDIA "s   ..."
               DISPLAY "............................"

      ******************************************************************

               DISPLAY "..........Invertido..........."
               MOVE 0 TO TOTAL-MEDIAS
               MOVE 1 TO I_TEMPO
               MOVE 1 TO A

               PERFORM VARYING A FROM 1 BY 1 UNTIL A > TAMANHO
                   COMPUTE IND_INV = TAMANHO - A + 1
                   MOVE N_ORD(IND_INV) TO N_INV(A)
               END-PERFORM

               PERFORM VARYING I_TEMPO FROM 1 BY 1 UNTIL I_TEMPO > 10
      *    REPETE ALGUMAS VEZES PARA MAIOR PRECISÃO(SE NÃO SAI 0.00s),
      *    DEPOIS EXCLUI OVERHEAD DO MOVE VETOR_ORIGINAL TO VETOR
                   ACCEPT TEMPO-INICIO FROM TIME
                   PERFORM REPETE TIMES
                       MOVE VETOR_INVERTIDO TO VETOR
                       PERFORM 400-INTROSORT
                   END-PERFORM
                   ACCEPT TEMPO-FIM FROM TIME

                   PERFORM 500-TEMPO
                   MOVE TEMPO-GASTO TO TEMPO_CS

                   ACCEPT TEMPO-INICIO FROM TIME
                   PERFORM REPETE TIMES
                       MOVE VETOR_INVERTIDO TO VETOR
                   END-PERFORM
                   ACCEPT TEMPO-FIM FROM TIME

                   PERFORM 500-TEMPO
                   MOVE TEMPO-GASTO TO TEMPO_C

                   COMPUTE TEMPO-FINAL =
                       TEMPO_CS - TEMPO_C

                   COMPUTE MEDIA-EXECUCAO = TEMPO-FINAL / REPETE
                   ADD MEDIA-EXECUCAO TO TOTAL-MEDIAS
                  DISPLAY "...  Tempo "I_TEMPO": "MEDIA-EXECUCAO"s  ..."

               END-PERFORM

               COMPUTE MEDIA = TOTAL-MEDIAS / 10
               DISPLAY "...   Media: " MEDIA "s   ..."
               DISPLAY "............................"

      ******************************************************************

               DISPLAY "..........Semelhante..........."
               MOVE 0 TO TOTAL-MEDIAS
               MOVE 1 TO I_TEMPO
               PERFORM VARYING I_TEMPO FROM 1 BY 1 UNTIL I_TEMPO > 10
      *    REPETE ALGUMAS VEZES PARA MAIOR PRECISÃO(SE NÃO SAI 0.00s),
      *    DEPOIS EXCLUI OVERHEAD DO MOVE VETOR_ORIGINAL TO VETOR
                   ACCEPT TEMPO-INICIO FROM TIME
                   PERFORM REPETE TIMES
                       MOVE VETOR_SEMELHANTE TO VETOR
                       PERFORM 400-INTROSORT
                   END-PERFORM
                   ACCEPT TEMPO-FIM FROM TIME

                   PERFORM 500-TEMPO
                   MOVE TEMPO-GASTO TO TEMPO_CS

                   ACCEPT TEMPO-INICIO FROM TIME
                   PERFORM REPETE TIMES
                       MOVE VETOR_SEMELHANTE TO VETOR
                   END-PERFORM
                   ACCEPT TEMPO-FIM FROM TIME

                   PERFORM 500-TEMPO
                   MOVE TEMPO-GASTO TO TEMPO_C

                   COMPUTE TEMPO-FINAL =
                       TEMPO_CS - TEMPO_C

                   COMPUTE MEDIA-EXECUCAO = TEMPO-FINAL / REPETE
                   ADD MEDIA-EXECUCAO TO TOTAL-MEDIAS
                  DISPLAY "...  Tempo "I_TEMPO": "MEDIA-EXECUCAO"s  ..."

               END-PERFORM

               COMPUTE MEDIA = TOTAL-MEDIAS / 10
               DISPLAY "...   Media: " MEDIA "s   ..."
               DISPLAY "............................"

      ******************************************************************

               COMPUTE TAMANHO = TAMANHO * 10
               COMPUTE REPETE = REPETE / 10
           END-PERFORM

           DISPLAY "FIM"
           STOP RUN.

      ******************************************************************
      *******************Função de leitura de arquivo*******************
      ******************************************************************
       100-LEITURA.
           OPEN INPUT ARQUIVO
           PERFORM UNTIL FIM = 'S'
               READ ARQUIVO
                   AT END
                       MOVE 'S' TO FIM
                   NOT AT END
                       MOVE FUNCTION NUMVAL(NUMERO-LIDO) TO VALOR
                       IF INDICE <= 1000000
                           MOVE VALOR TO N_ORIG(INDICE)
                           ADD 1 TO INDICE
                       ELSE
                           DISPLAY "LIMITE EXCEDIDO NO ARQUIVO"
                           MOVE 'S' TO FIM
                       END-IF
               END-READ
           END-PERFORM
           SUBTRACT 1 FROM INDICE GIVING TAMANHO-ARQUIVO
           CLOSE ARQUIVO
      **************************Arquivo Semelhante**********************
           OPEN INPUT ARQUIVO_SEMELHANTE
           MOVE 1 TO INDICE
           MOVE 'N' TO FIM
           PERFORM UNTIL FIM = 'S'
               READ ARQUIVO_SEMELHANTE
                   AT END
                       MOVE 'S' TO FIM
                   NOT AT END
                       MOVE FUNCTION NUMVAL(NUMERO-LIDO-SEM) TO VALOR
                       IF INDICE <= 1000000
                           MOVE VALOR TO N_SEMELHANTE(INDICE)
                           ADD 1 TO INDICE
                       ELSE
                           DISPLAY "LIMITE EXCEDIDO NO ARQUIVO"
                           MOVE 'S' TO FIM
                       END-IF
               END-READ
           END-PERFORM
           SUBTRACT 1 FROM INDICE GIVING TAMANHO-ARQUIVO
           CLOSE ARQUIVO_SEMELHANTE.

      ******************************************************************
      *********************Funções para o INTROSORT*********************
      ******************************************************************
       200-INSERTION.
           COMPUTE ESQ_MAIS_1 = ESQ + 1
           PERFORM VARYING I_INS FROM ESQ_MAIS_1 BY 1 UNTIL I_INS > DIR
               MOVE NUMERO(I_INS) TO X
               SUBTRACT 1 FROM I_INS GIVING J

               PERFORM UNTIL J < ESQ OR NUMERO(J) <= X
                   COMPUTE K = J + 1
                   MOVE NUMERO(J) TO NUMERO(K)
                   SUBTRACT 1 FROM J
               END-PERFORM

               COMPUTE K = J + 1
               MOVE X TO NUMERO(K)
           END-PERFORM.

       300-PARTICIONAR.
           MOVE NUMERO(DIR) TO PIVO
           COMPUTE PART-I = ESQ - 1

           PERFORM VARYING PART-J FROM ESQ BY 1 UNTIL PART-J >= DIR
               IF NUMERO(PART-J) <= PIVO
                   ADD 1 TO PART-I
                   IF PART-I NOT = PART-J
                       MOVE NUMERO(PART-I) TO TEMP
                       MOVE NUMERO(PART-J) TO NUMERO(PART-I)
                       MOVE TEMP TO NUMERO(PART-J)
                   END-IF
               END-IF
           END-PERFORM

           COMPUTE PIVO-INDEX = PART-I + 1

           MOVE NUMERO(PIVO-INDEX) TO TEMP
           MOVE NUMERO(DIR) TO NUMERO(PIVO-INDEX)
           MOVE TEMP TO NUMERO(DIR).

       310-HEAPIFY.
           MOVE HEAP-ROOT TO HEAP-LARGEST
           COMPUTE HEAP-LEFT = HEAP-ROOT * 2
           COMPUTE HEAP-RIGHT = HEAP-LEFT + 1

           COMPUTE ABS-LARGEST = HEAP-ESQ + HEAP-LARGEST - 1
           COMPUTE ABS-LEFT = HEAP-ESQ + HEAP-LEFT - 1
           COMPUTE ABS-RIGHT = HEAP-ESQ + HEAP-RIGHT - 1

           IF HEAP-LEFT <= HEAP-N
               IF NUMERO(ABS-LEFT) > NUMERO(ABS-LARGEST)
                   MOVE HEAP-LEFT TO HEAP-LARGEST
                   MOVE ABS-LEFT TO ABS-LARGEST
               END-IF
           END-IF

           IF HEAP-RIGHT <= HEAP-N
               IF NUMERO(ABS-RIGHT) > NUMERO(ABS-LARGEST)
                   MOVE HEAP-RIGHT TO HEAP-LARGEST
                   MOVE ABS-RIGHT TO ABS-LARGEST
               END-IF
           END-IF

           IF HEAP-LARGEST NOT = HEAP-ROOT
               COMPUTE ABS-ROOT = HEAP-ESQ + HEAP-ROOT - 1

               MOVE NUMERO(ABS-ROOT) TO TEMP
               MOVE NUMERO(ABS-LARGEST) TO NUMERO(ABS-ROOT)
               MOVE TEMP TO NUMERO(ABS-LARGEST)

               MOVE HEAP-LARGEST TO HEAP-ROOT
               PERFORM 310-HEAPIFY
           END-IF.

       320-HEAPSORT.
           MOVE ESQ TO HEAP-ESQ
           MOVE DIR TO HEAP-DIR
           COMPUTE HEAP-N = HEAP-DIR - HEAP-ESQ + 1

           DIVIDE HEAP-N BY 2 GIVING HEAP-I

           PERFORM VARYING HEAP-I FROM HEAP-I BY -1 UNTIL HEAP-I < 1
               MOVE HEAP-I TO HEAP-ROOT
               PERFORM 310-HEAPIFY
           END-PERFORM

           PERFORM VARYING HEAP-END FROM HEAP-N BY -1
               UNTIL HEAP-END <= 1

               COMPUTE K = HEAP-ESQ + HEAP-END - 1

               MOVE NUMERO(HEAP-ESQ) TO TEMP
               MOVE NUMERO(K) TO NUMERO(HEAP-ESQ)
               MOVE TEMP TO NUMERO(K)

               SUBTRACT 1 FROM HEAP-N

               MOVE 1 TO HEAP-ROOT
               PERFORM 310-HEAPIFY
           END-PERFORM.

       400-INTROSORT.
           MOVE TAMANHO TO AUX-TAM
           MOVE 0 TO PROF-MAX

           PERFORM UNTIL AUX-TAM <= 1
               DIVIDE AUX-TAM BY 2 GIVING AUX-TAM
               ADD 1 TO PROF-MAX
           END-PERFORM

           COMPUTE PROF-MAX = PROF-MAX * 2

           MOVE 1 TO STACK-TOP
           MOVE 1 TO PILHA-ESQ(STACK-TOP)
           MOVE TAMANHO TO PILHA-DIR(STACK-TOP)
           MOVE PROF-MAX TO PILHA-PROF(STACK-TOP)

           PERFORM UNTIL STACK-TOP = 0

               MOVE PILHA-ESQ(STACK-TOP) TO ESQ
               MOVE PILHA-DIR(STACK-TOP) TO DIR
               MOVE PILHA-PROF(STACK-TOP) TO PROF
               SUBTRACT 1 FROM STACK-TOP

               PERFORM UNTIL ESQ >= DIR

                   COMPUTE INTERVALO = DIR - ESQ + 1

                   IF INTERVALO <= 16
                       PERFORM 200-INSERTION
                       MOVE DIR TO ESQ
                   ELSE
                       IF PROF <= 0
                           PERFORM 320-HEAPSORT
                           MOVE DIR TO ESQ
                       ELSE
                           PERFORM 300-PARTICIONAR
                           SUBTRACT 1 FROM PROF

                           COMPUTE LEFT-LEN = PIVO-INDEX - ESQ
                           COMPUTE RIGHT-LEN = DIR - PIVO-INDEX

                           IF LEFT-LEN < RIGHT-LEN

                               IF PIVO-INDEX + 1 < DIR

                                   IF STACK-TOP < 10000
                                       ADD 1 TO STACK-TOP
                                   ELSE
                                       DISPLAY "STACK OVERFLOW"
                                       STOP RUN
                                   END-IF

                                   COMPUTE PILHA-ESQ(STACK-TOP) =
                                       PIVO-INDEX + 1
                                   MOVE DIR TO PILHA-DIR(STACK-TOP)
                                   MOVE PROF TO PILHA-PROF(STACK-TOP)
                               END-IF

                               COMPUTE DIR = PIVO-INDEX - 1

                           ELSE

                               IF ESQ < PIVO-INDEX - 1

                                   IF STACK-TOP < 10000
                                       ADD 1 TO STACK-TOP
                                   ELSE
                                       DISPLAY "STACK OVERFLOW"
                                       STOP RUN
                                   END-IF

                                   MOVE ESQ TO PILHA-ESQ(STACK-TOP)
                                   COMPUTE PILHA-DIR(STACK-TOP) =
                                       PIVO-INDEX - 1
                                   MOVE PROF TO PILHA-PROF(STACK-TOP)
                               END-IF

                               COMPUTE ESQ = PIVO-INDEX + 1

                           END-IF
                       END-IF
                   END-IF

               END-PERFORM

           END-PERFORM.

       500-TEMPO.
               COMPUTE TOTAL-INICIO =
           (HORA-I * 360000) + (MIN-I * 6000) + (SEG-I * 100) + CENT-I

               COMPUTE TOTAL-FIM =
           (HORA-F * 360000) + (MIN-F * 6000) + (SEG-F * 100) + CENT-F

               COMPUTE TEMPO-GASTO = (TOTAL-FIM - TOTAL-INICIO) / 100.

       END PROGRAM INTROSORT.

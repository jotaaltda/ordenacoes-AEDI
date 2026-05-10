229    IDENTIFICATION DIVISION.
       PROGRAM-ID. TIMSORT.

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

      *INSERTION
       01 I_INS        PIC 9(9) COMP. *>Usado pro loop
       01 J            PIC S9(9) COMP. *>Usado pro loop
       01 X            PIC 9(9). *>Usado para atribuir os valores
       01 K            PIC 9(9) COMP. *>(J+1)
       01 ESQ_MAIS_1   PIC 9(9).

      *MERGE
       01 ARRAY_ESQ.
           05 NUM_ESQ OCCURS 1000000 TIMES PIC 9(9).

       01 ARRAY_DIR.
           05 NUM_DIR OCCURS 1000000 TIMES PIC 9(9).

       01 ESQ  PIC 9(9) COMP.
       01 MEIO PIC 9(9) COMP.
       01 DIR  PIC 9(9) COMP.

       01 LEN1 PIC 9(9) COMP.*>Tamanho da metade esquerda
       01 LEN2 PIC 9(9) COMP.*>Tamanho da metade direita

       01 A    PIC 9(9) COMP.
       01 B    PIC 9(9) COMP.
       01 C    PIC 9(9) COMP.

      *TIMSORT
       01 RUN_TAM              PIC 9(3) COMP VALUE 32.
       01 TAMANHO_BLOCO        PIC 9(9) COMP.
       01 TAMANHO_BLOCO_X_2    PIC 9(9) COMP.
       01 INDICE_ESQ           PIC 9(9) COMP.
       01 FINAL_BLOCO          PIC 9(9).
       01 I_RUN                PIC 9(9).

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
                       PERFORM 400-TIMSORT
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
               PERFORM 400-TIMSORT
               MOVE VETOR TO VETOR_ORDENADO

               PERFORM VARYING I_TEMPO FROM 1 BY 1 UNTIL I_TEMPO > 10
      *    REPETE ALGUMAS VEZES PARA MAIOR PRECISÃO(SE NÃO SAI 0.00s)
      *    DEPOIS EXCLUI OVERHEAD DO MOVE VETOR_ORIGINAL TO VETOR

                   ACCEPT TEMPO-INICIO FROM TIME
                   PERFORM REPETE TIMES
                       MOVE VETOR_ORDENADO TO VETOR
                       PERFORM 400-TIMSORT
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
                       PERFORM 400-TIMSORT
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
                       PERFORM 400-TIMSORT
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
      **********************Funções para o Timsort**********************
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

       300-MERGE.
           COMPUTE LEN1 = MEIO - ESQ + 1
           COMPUTE LEN2 = DIR - MEIO

           PERFORM VARYING A FROM 1 BY 1 UNTIL A > LEN1
               COMPUTE K = ESQ + A - 1

               IF K > 1000000
                   DISPLAY "K ESTOUROU: " K
                   STOP RUN
               END-IF

               MOVE NUMERO(K) TO NUM_ESQ(A)
           END-PERFORM

           PERFORM VARYING A FROM 1 BY 1 UNTIL A > LEN2
               COMPUTE K = MEIO + A

               IF K > 1000000
                   DISPLAY "K ESTOUROU: " K
                   STOP RUN
               END-IF

               MOVE NUMERO(K) TO NUM_DIR(A)
           END-PERFORM

           MOVE 1 TO A
           MOVE 1 TO B
           MOVE ESQ TO C

           PERFORM UNTIL A > LEN1 OR B > LEN2
               IF NUM_ESQ(A) <= NUM_DIR(B)
                   MOVE NUM_ESQ(A) TO NUMERO(C)
                   ADD 1 TO A
               ELSE
                   MOVE NUM_DIR(B) TO NUMERO(C)
                   ADD 1 TO B
               END-IF

               ADD 1 TO C
           END-PERFORM

           PERFORM UNTIL A > LEN1
               MOVE NUM_ESQ(A) TO NUMERO(C)
               ADD 1 TO A
               ADD 1 TO C
           END-PERFORM

           PERFORM UNTIL B > LEN2
               MOVE NUM_DIR(B) TO NUMERO(C)
               ADD 1 TO B
               ADD 1 TO C
           END-PERFORM.

       400-TIMSORT.
           PERFORM VARYING I_RUN FROM 1 BY RUN_TAM UNTIL I_RUN > TAMANHO
               COMPUTE DIR = I_RUN + RUN_TAM - 1

               IF DIR > TAMANHO
                   MOVE TAMANHO TO DIR
               END-IF

               MOVE I_RUN TO ESQ
               PERFORM 200-INSERTION
           END-PERFORM

           MOVE RUN_TAM TO TAMANHO_BLOCO
           PERFORM UNTIL TAMANHO_BLOCO >= TAMANHO
               COMPUTE TAMANHO_BLOCO_X_2 = TAMANHO_BLOCO * 2

               MOVE 1 TO INDICE_ESQ
               PERFORM UNTIL INDICE_ESQ > TAMANHO
                   COMPUTE ESQ = INDICE_ESQ
                   COMPUTE MEIO = INDICE_ESQ + TAMANHO_BLOCO - 1

                   IF MEIO > TAMANHO
                       MOVE TAMANHO TO MEIO
                   END-IF

                   IF MEIO >= TAMANHO
                       EXIT PERFORM
                   END-IF

                   COMPUTE DIR = INDICE_ESQ + TAMANHO_BLOCO_X_2 - 1

                   IF DIR > TAMANHO
                       MOVE TAMANHO TO DIR
                   END-IF

                   PERFORM 300-MERGE

                   ADD TAMANHO_BLOCO_X_2 TO INDICE_ESQ

               END-PERFORM

               COMPUTE TAMANHO_BLOCO = TAMANHO_BLOCO * 2
           END-PERFORM.

       500-TEMPO.
               COMPUTE TOTAL-INICIO =
           (HORA-I * 360000) + (MIN-I * 6000) + (SEG-I * 100) + CENT-I

               COMPUTE TOTAL-FIM =
           (HORA-F * 360000) + (MIN-F * 6000) + (SEG-F * 100) + CENT-F

               COMPUTE TEMPO-GASTO = (TOTAL-FIM - TOTAL-INICIO) / 100.

       END PROGRAM TIMSORT.

; Arquivo: Div.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Divide R0 por R1 e armazena o resultado em R2.
; (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
; divisao para numeros inteiros positivos

  leaw $R0, %A
  movw (%A), %D
  movw %A, %S

loop:
  leaw $R1 , %A
  subw %D,(%A), %D
  incw %S

  leaw $loop, %A
  jg %D
  nop

  leaw $fim, %A
  je %D
  nop

  decw %S
  nop

fim:
  leaw $R2, %A
  movw %S, (%A)

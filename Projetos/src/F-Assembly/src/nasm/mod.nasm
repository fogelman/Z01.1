; Arquivo: Mod.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Divide o número posicionado na RAM[1] pelo número posicionado no RAM[2] e armazena o resultado na RAM[0].


  leaw $R1, %A
  movw (%A), %D

loop:
  movw %D, %S
  leaw $R2 , %A
  subw %D,(%A), %D

  leaw $loop, %A
  jge %D
  nop

  leaw $R0, %A
  movw %S, (%A)

; Arquivo: Abs.nasm
; Curso: Elementos de Sistemas
; Criado por: Luciano Soares
; Data: 27/03/2017

; Multiplica o valor de RAM[1] com RAM[0] salvando em RAM[3]

leaw $0, %A
movw %A , %S
movw (%A), %D
LOOP:
leaw $ELSE, %A
je %D
nop
    leaw $1,%A
    addw %S,(%A), %S
    subw %D, $1, %D  ;Subtrai 1 de D
    leaw $LOOP, %A
    jmp
    nop

ELSE:
    leaw $3, %A
    movw %S, (%A)

END:
    leaw  $END , %A
    jmp
    nop
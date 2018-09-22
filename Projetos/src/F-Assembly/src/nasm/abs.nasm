leaw $1, %A
movw (%A) , %D
leaw $ELSE , %A  ;Coloca o endereco de Else para %a (prepara o pulo)
jge %D ; se a for maior ou igual a zero
nop
negw %D
ELSE:
leaw $0, %A
movw %D , (%A)
END:
leaw  $END , %A
jmp
nop
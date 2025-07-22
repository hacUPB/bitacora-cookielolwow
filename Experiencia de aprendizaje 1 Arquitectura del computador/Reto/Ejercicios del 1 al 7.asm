// Carga en D el valor 1978
@1978
D=A

// Guarda en la posición 100 de la RAM el número 69
@69
D=A
@100
M=D

// Guarda en la posición 200 de la RAM el contenido de la posición 24 de la RAM
@24
D=M
@200
M=D

// Lee lo que hay en la posición 100 de la RAM, resta 15 y guarda el resultado en la posición 100
@100
D=M
@15
D=D-A
@100
M=D

// Suma RAM[0] + RAM[1] + 69 y guarda en RAM[2]
@0
D=M
@1
D=D+M
@69
D=D+A
@2
M=D

// Si D es igual a 0, salta a la posición 100 de la ROM
@100
D;JEQ

// Si el valor en RAM[100] es menor que 100, salta a la posición 20 de la ROM
@100
D=M
@100
D=D-A
@20
D;JLT// EN ESTE EMULADOR EL -1 = 65535 

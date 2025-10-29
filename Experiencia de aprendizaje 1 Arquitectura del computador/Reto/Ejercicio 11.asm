//11. Considera el siguiente programa:
    i = 1000
    LOOP:
    if (i == 0) goto CONT
    i = i - 1
    goto LOOP
    CONT:
    
    //La traducción a lenguaje ensamblador del programa anterior es:
    
   
    // i = 1000
    @1000
    D=A
    @i
    M=D
    (LOOP)
    // if (i == 0) goto CONT
    @i
    D=M
    @CONT
    D;JEQ
    // i = i - 1
    @i
    M=M-1
    // goto LOOP
    @LOOP
    0;JMP
    (CONT)
    
// - ¿Qué hace este programa?

//- ¿En qué memoria está almacenada la variable i? ¿En qué dirección de esa memoria?
// i está en la memoria RAM, en la dirección 16 (RAM[16]).

// - ¿En qué memoria y en qué dirección de memoria está almacenado el comentario //`i = 1000?`
//Los comentarios no se almacenan en la memoria del computador.

// - ¿Cuál es la primera instrucción del programa anterior? ¿En qué memoria y en qué dirección de memoria está almacenada esa instrucción?
//La primera instrucción es @1000 y está almacenada en ROM[0].

// - ¿Qué son CONT y LOOP?
//CONT y LOOP son etiquetas o labels. Cont se usa como contador y LOOP para realizar bucles.

//- ¿Cuál es la diferencia entre los símbolos `i` y `CONT`?
//i es una variable de datos, almacenada en RAM.
//CONT es una etiqueta de control, usada para saltos de ejecución en ROM.


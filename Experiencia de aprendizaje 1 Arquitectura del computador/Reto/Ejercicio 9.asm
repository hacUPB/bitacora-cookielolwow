//9. Considera el siguiente programa:
    

    i = 1
    sum = 0
    sum = sum + i
    i = i + 1

    
    La traducción a lenguaje ensamblador del programa anterior es:
    
    // i = 1
    @i
    M=1
    // sum = 0
    @sum
    M=0
    // sum = sum + i
    @i
    D=M
    @sum
    M=D+M
    // i = i + 1
    @i
    D=M+1
    @i
    M=D
    
    //- ¿Qué hace este programa?
    // Respuesta: Este programa inicializa la variable `i` en 1, la variable `sum` en 0, luego suma el valor de `i` a `sum` y finalmente incrementa `i` en 1.

    //- ¿En qué parte de la memoria RAM está la variable `i` y `sum`? ¿Por qué en esas posiciones?
    // Respuesta: La variable `i` está en la posición 16 y `sum` en la posición 17, ya que las variables se asignan a partir de la posición 16 en adelante.
   
    //- Optimiza esta parte del código para que use solo dos instrucciones:
  @i
   M=M+1

1. Escribe un programa en lenguaje ensamblador que sume los primeros 100 números naturales.
    
    ```cpp
    int i = 1;
    int sum = 0;
    While (i <= 100){
       sum += i;
       i++;
    }
    ```

**RAE1**
```asm
@i
M=1         
@sum
M=0         
@limit
M=100       

(LOOP)
@i
D=M         
@limit
D=D-M       
@END
D;JGT       

@i
D=M         
@sum
M=M+D       

@i
M=M+1       

@LOOP
0;JMP       

(END)
@END
0;JMP       
```
    
**¿Cómo están implementadas las variables `i` y `sum`?**
- Se definen con etiquetas simbólicas (@i, @sum), i esta en RAM[16], sum en RAM[17].

**¿En qué direcciones de memoria están estas variables?**
- i → RAM[16]

- sum → RAM[17]

- limit → RAM[18]


**¿Cómo está implementado el ciclo `while`?**
Con etiquetas de bucle ((LOOP), (END)) y comparaciones/saltos:

- Se compara i con limit.

- Si i > limit, se va a (END).

- Si no, ejecuta el cuerpo del ciclo y vuelve a (LOOP).


**¿Cómo se implementa la variable `i`?**
- Como una posición de memoria con nombre (@i). 


**¿En qué parte de la memoria se almacena la variable `i`?**
- RAM[16]


**Después de todo lo que has hecho, ¿Qué es entonces una variable?**
- Una variable es un nombre simbólico que se asocia a una posición de memoria RAM


**¿Qué es la dirección de una variable?**
- Es la posición en RAM que el nombre representa.


**¿Qué es el contenido de una variable?**
- El número almacenado en esa dirección de memoria.

**RAE2**
Primero probé que las variables i, sum y limit se inicializaran correctamente.Luego para probar la condición, usé valores distintos para i (como 50, 100 y 101) y observé si el programa saltaba correctamente a END. Esto me ayudó a validar que el ciclo se detendría en el momento justo cuando i > 100. Después verifiqué si la suma funcionaba bien y el incremento de i. Finalmente, ejecuté todo el programa completo, con la suma de los primeros 100 números naturales y el progfama funciono como queria.
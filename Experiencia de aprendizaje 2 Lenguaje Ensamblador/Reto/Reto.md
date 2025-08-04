## RETO 1

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

## RETO 2
Transforma el programa en alto nivel anterior para que utilice un ciclo for en vez de un ciclo while.


**RAE1**
```cpp
int sum = 0;
for (int i = 1; i <= 100; i++) {
    sum += i;
}

```

**RAE2**

Primero verifiqué que la variable sum comenzara en 0 y que i empezara en 1.Luego verifiqué que el ciclo se repitiera solo hasta que i fuera 100. Verifiqué que se sumaran correctamente los valores en cada iteración.
Probar el programa por partes me permitió asegurarme de que cada componente (inicialización, condición, acumulación e incremento) funcionara de forma independiente antes de ejecutar el ciclo completo. 

## RETO 3
Escribe un programa en lenguaje ensamblador que implemente el programa anterior.
**RAE1**
```asm
// Inicialización
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

// sum += i
@i
D=M
@sum
M=M+D

// i++
@i
M=M+1

@LOOP
0;JMP         

(END)
@END
0;JMP         
```
**RAE2**


Primero probé por separado la inicialización de las variables i, sum y limit, observando en la RAM que tuvieran los valores esperados (1, 0 y 100 respectivamente). Luego verifiqué que la condición del ciclo (i <= 100) se evaluara correctamente, modificando manualmente el valor de i para comprobar que el salto al final (END) solo ocurriera cuando i fuera mayor a 100. También probé que la acumulación (sum += i) funcionara correctamente asignando valores conocidos a i y sum y verificando el resultado después de la suma. Finalmente, verifiqué que el incremento (i++) aumentara el valor correctamente. Después de confirmar que cada parte funcionaba de forma individual, corrí el programa completo desde el simulador y comprobé que el valor final de sum fuera 5050.

## RETO 4
4. Ahora vamos a acercarnos al concepto de puntero. Un puntero es una variable que almacena la dirección de memoria de otra variable. Observa el siguiente programa escrito en C++:
    
    ```cpp
    int a = 10;
    int *p;
    p = &a;
    *p = 20;
    ```


El programa anterior modifica el contenido de la variable `a` por medio de la variable `p`. `p` es un puntero porque almacena la dirección de memoria de la variable `a`. En este caso el valor de la variable `a` será 20 luego de ejecutar `*p = 20;`. 
    
**¿Cómo se declara un puntero en C++?** 


- `int *p;`. `p` es una variable que almacenará la dirección de un variable que almacena enteros.

**¿Cómo se define un puntero en C++?** 
- `p = &a;`. Definir el puntero es inicializar el valor del puntero, es decir, guardar la dirección de una variable. En este caso `p` contendrá la dirección de `a`.


**¿Cómo se almacena en C++ la dirección de memoria de una variable?** 
- Con el operador `&`. `p = &a;`


**¿Cómo se escribe el contenido de la variable a la que apunta un puntero?**

- Con el operador . `p = 20;`. En este caso como `p` contiene la dirección de `a` entonces `p` a la izquierda del igual indica que quieres actualizar el valor de la variable `a`.




## RETO 5

Traduce este programa a lenguaje ensamblador:
 ```CPP
int a = 10;
int *p;
p = &a;
*p = 20;
```

**RAE1**
 
 ```asm
@10
D=A
@var
M=D
@var
D=A
@p
M=D
@20
D=A
@p
A=M
M=D

```

**RAE2**


Inicialmente comprobé que el valor 10 se almacenara correctamente en la variable var, observando en la RAM que la dirección asignada a var (por ejemplo, RAM[16]) tuviera ese valor. Luego, verifiqué que p guardara la dirección de var, comprobando que p (por ejemplo, RAM[17]) contuviera el número 16. Posteriormente, revisé que la instrucción @p seguida de A=M permitiera acceder indirectamente a la dirección guardada en p, y que efectivamente allí se almacenara el nuevo valor 20. Para confirmar que todo funcionaba correctamente, ejecuté el programa completo paso a paso en el simulador Hack y observé que inicialmente var = 10, luego p contenía la dirección de var, y al final var era actualizado a 20 a través de esa dirección guardada.

## RETO 6 & 7
6. Ahora vas a usar un puntero para leer la posición de memoria a la que este apunta, es decir, vas a leer por medio del puntero la variable cuya dirección está almacenada en él.
  
```CPP
int a = 10;
int b = 5;
int *p;
p = &a;
b = *p;
```
7.  Traduce este programa a lenguaje ensamblador


**RAE1**

    ```asm
@10
D=A
@VAR1
M=D
@5
D=A
@VAR2
M=D
@VAR1
D=A
@P
M=D
@P
A=M
D=M
@VAR2
M=D
   
    ```

**RAE2**


Para lograr traducir este programa primero a cree las variables y les puse sus respectivos valores (VAR1=10 Y VAR2=5), cree el puntero para asia asi asignarle la direccion de VAR1. Luego use el puntero para irme a la direccion que tenia asignada y le saque su valor para lluego asignarselo a la VAR2.

## RETO 8

Vas a parar un momento y tratarás de recodar de memoria lo siguiente. Luego verifica con un compañero o con el profesor.
1. ¿Qué hace esto `int *pvar;`?

- Crea un puntero.
      
2. ¿Qué hace esto `pvar = var;`?

- No existe. Hace falta un "&" o "*"
    
3. ¿Qué hace esto `var2 = *pvar`?

- Le asigna a var2 el valor al que apunta el puntero.

  
4. ¿Qué hace esto `pvar = &var3`?

- Apunta a la dirección de var3.

## RETO 9

Vas a proponer una posible traducción a lenguaje ensamblador de la función `suma`, cómo llamar a suma y cómo regresar a `std::cout  << "El valor de c es: " << c << std::endl; ` una vez suma termine.
#include <iostream>
```CPP
int suma(int a, int b) {
   int var = a + b;
   return var;
}


int main() {
   int c = suma(6, 9);
   std::cout << "El valor de c es: " << c << std::endl;
   return 0;
}
```
```asm
(MAIN)
ASYFGDJSFI
@SUMA



(SUMA)
RUPORFUGPRUGPI
@MAIN




```


    

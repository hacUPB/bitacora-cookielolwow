## EJERCICIOS DEL 1 AL 7 ##
* En este conjunto de ejercicios tuve que aplicar los conceptos iniciales que vimos en clase, sobre las instrucciones basicas de hack, como la aplicacion de la A y el uso de registros como D y M, así como el manejo de direcciones de memoria. Esto me ayudo a recordar lo que vi en clase y a mejorar mi afinidad con el tema.


Adicionalmente, aprendi que el -1 en el simulador que estoy usando es 65535 


## EJERCICIO 8 ##
* En el ejercicio ocho tuve que responder unas preguntas del tema de variables.
Entendi mejor que las variables se almacenan a partir de la dirección 16 en adelante, siguiendo el orden en que se utilizan.

## EJERCICIO 9 ##
* En este reto subio la dificultad del tema de las variables. Para optimizar el fragmento del ejercicio inicie la variable i y luego le incremente directamente el valor almacenado en esa direccion de la memoria  (i = i + 1).

## EJERCICIO 10 ##
* Para este ejercicio cargue el valor M de R0 en el registro  D, para multiplicarlo por 2 asigne en D la suma D + D. Luego fui a R1 y guarde el resultado en el.

## EJERCICIO 11 ##
* En este ejercicio hice un programa que cuenta de 1000 a 0 usando un ciclo. Entendi mejor que las etiquetas (LOOP, CONT) sirven para saltar a partes del código. Me ayudó a entender mejor cómo funcionan los ciclos y condiciones.

## EJERCICIO 12 ##
* Lograr enteter como funciona el porgrama fue dificil pero no imposible, el tema de las etiquetas loop y cont es bastante confuso, pero al final el programa verificó si R0 es mayor o igual que cero, guardo 1 o -1 dn R1 dependiendo de si o era o no. 

## EJERCICIO 14 ##
* En este ejercicio tenia que poner el valor de la ram de R1 en R4, fue usando las primeras cosas que aplicamos en el curso.

## EJERCICIO 15 ##
* Para hacer este ejercicio inicie poniendo un (loop), luego fui al registro R0 y su M la use como address en la Ram, luego puse el -1 en m para asi en la direccion de R1 restarselo ahi a la m, el resultado lo guarde en d y de ahi fui nuevamente a R1 para sumarle 1 y puse una condicion que revisara si d era diferente de 0, si lo era repetiria este bucle la cantidad de veces que decia en R1 para en esa seccion poner los -1.

## EJERCICIO 16 ##
* En este ejercicio primero inicialice arr en 10 para establecer el tamaño del arreglo, sum en 0 y j en 0 ; luego, cree una etiqueta (LOOP)en la cual cargue j y inicialice el contador para acceder a arr, contar los espacios que tenia y cada uno lo sume a sum,  incremente j y comparecon 10 para decidir si repetir el ciclo o finalizarlo en (END)

## EJERCICIO 17 ##
* Para este ejercicio primero cargue el número 7 en A ,luego a en D puse D - 7 para verificar que el numero fuera igual a 0 D = D - 7 , luego me dirigi a la direccion 69 por Si (D - 7) == 0, salta a ROM[69].

## EJERCICIO 18 ##
* ![alt text](image.png)

## EJERCICIO 19 ## 
* Este programa parece estar diseñado para USAR con la pantalla y el teclado, utiliza direcciones como el @24576 que corresponden a estos dispositivos.

## EJERCICIO 20 ##
* En este ejercicio cree antes del (draw) un sistema que detectara si la tecla d esta presionada, en este use el @24567 que es el correspondiente a la tecla, si este valor era igual a 100 (valor que se ponia si se presionaba) saltaba al (draw).



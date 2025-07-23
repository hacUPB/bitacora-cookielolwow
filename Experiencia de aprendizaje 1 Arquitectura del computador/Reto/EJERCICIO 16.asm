//16. Implementa en lenguaje ensamblador el siguiente programa:
    

    int[] arr = new int[10];
    int sum = 0;
    for (int j = 0; j < 10; j++)
{
        sum = sum + arr[j];
}

@10
D=A
@arr
M=D
D=M
@sum
M=0
@j
M=0
(LOOP)
@j
A=D+M
D=M
@sum
M=M+D
@j
M=M+1
@10
D=A
@j
D=D-M
@LOOP
D;JLE
(END)
@END
0;JMP



    //- ¿Qué hace este programa?
- Este programa tiene un arreglo de 10 direcciones y una variable sum, el programa lo que hace es recorrer el arreglo y sumarle uno por uno los numeros del arreglo al sum. Este se detiene cuando cuando completa el recorrido.
    //- ¿Cuál es la dirección base de arr en la memoria RAM?
- La direccion de arr es 16 es la ram
    //- ¿Cuál es la dirección base de sum en la memoria RAM y por qué?
- La direccion de sum es la 17, ya que se creo previamente la arr y se organizan secuencialmente.
    //- ¿Cuál es la dirección base de j en la memoria RAM y por qué?
- La direccion de j es la 18 , ya que se creo previamente la arr y sum, se organizan secuencialmente.



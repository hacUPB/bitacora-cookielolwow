//16. Implementa en lenguaje ensamblador el siguiente programa:
    

    int[] arr = new int[10];
    int sum = 0;
    for (int j = 0; j < 10; j++) {
        sum = sum + arr[j];
    }
@10
A=D
@arr
M=D
D=M
(loop)
@j
A=D+M





    //- ¿Qué hace este programa?
    //- ¿Cuál es la dirección base de arr en la memoria RAM?
    //- ¿Cuál es la dirección base de sum en la memoria RAM y por qué?
    //- ¿Cuál es la dirección base de j en la memoria RAM y por qué?


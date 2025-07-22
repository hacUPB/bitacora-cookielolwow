//12. Implemente en ensamblador:
    R4 = R1 + R2 + 69
    @R1
    D=M
    @R2
    D=D+M
    @69
    D=D+A
    @R4
    M=D

    
//13. Implementa en ensamblador:
    if R0 >= 0 then R1 = 1
    else R1 = –1
    
    (LOOP)
    goto LOOP
    ```
@R0         
D=M          
@0           
D=D-A        
@R1         
D;JGE        

// Si R0 < 0
@R1          
M=-1       
@LOOP      
0;JMP        

// Si R0 >= 0
@R1         
M=1          
@LOOP       
0;JMP        
(LOOP)       

    
//14. Implementa en ensamblador:
    R4 = RAM[R1]
    @R1
    D=M
    @R4
    M=D

    
    
//15. Implementa en ensamblador el siguiente problema.
//En la posición R0 está almacenada la dirección inicial de una región de memoria.
//En la posición R1 está almacenado el tamaño de la región de memoria.
//Almacena un -1 en esa región de memoria.
NO ENTENDI
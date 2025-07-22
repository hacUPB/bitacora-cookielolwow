## Actividad 1


### - ¿Qué es un computador digital moderno?


Es una máquina electrónica que trabaja con ceros y unos (lo digital) y sirve para procesar información. Básicamente, uno le da instrucciones (por medio de programas), y él hace cálculos, toma decisiones, guarda datos o los muestra. Está en todo lo que usamos hoy: desde celulares hasta computadores portátiles.

### - ¿Cuáles son sus partes?


1. **CPU (Unidad Central de Procesamiento)**: Es como el cerebro del computador. Lee las instrucciones y hace los cálculos o decisiones necesarias.

2. **RAM (Memoria principal)**: Guarda temporalmente los datos y programas que se están usando. Cuando se apaga el computador, esta memoria se borra.

3. **ROM (Memoria de solo lectura):** Contiene instrucciones que no se pueden cambiar y que el computador necesita para arrancar y funcionar correctamente. A diferencia de la RAM, esta memoria no se borra al apagar el equipo.

4. **Dispositivos de entrada:** Son cosas como el teclado, el mouse o una cámara. Sirven para enviarle información al computador.

5. **Dispositivos de salida:** Son como la pantalla o los audífonos. Muestran o reproducen la información que el computador procesa.




## Actividad 2

### - ¿Qué es entonces un programa?
- Un programa es un conjunto de instrucciones que le dicen al computador qué hacer. 

### - ¿Qué es un lenguaje ensamblador?
- Es un tipo de lenguaje que se usa para escribir instrucciones que están muy cerca del lenguaje que entiende el computador. Es como un "puente" entre los lenguajes humanos y el lenguaje que entiende directamente la maquina.

### - ¿Qué es lenguaje de máquina?
- Es el lenguaje más básico que entiende un computador. Está compuesto solo por ceros y unos (binario). Cada combinación de ceros y unos es una instrucción para el procesador.

## Actividad 3


### - ¿Qué son PC, D y A?
- **PC (Program Counter)**: Es como un marcador que le dice a la CPU en qué parte del programa va. Guarda la dirección de la siguiente instrucción que se debe ejecutar.

- **D (Registro D)**: Es uno de los registros de la CPU. Sirve para guardar datos temporales, como resultados de operaciones o valores que se van a usar en cálculos.

- **A (Registro A)**: Tiene dos usos. Puede guardar una dirección de memoria a la que se quiere acceder, o puede guardar un número que se va a usar en una operación.

### - ¿Para qué los usa la CPU?
-  Usa el **PC** para saber qué instrucción viene después y poder ejecutarla en orden.

- Usa el **registro D** para guardar valores intermedios mientras hace cálculos o toma decisiones.

- Usa el **registro A** cuando necesita saber a qué parte de la memoria ir o qué valor usar para hacer una operación.

## Actividad 4

```asm
@16384
D = A
@16
M = D
```

### El resultado de este programa es que guarda en la posición 16 de la RAM el valor 16384. Ahora escribe un programa en lenguaje ensamblador que guarde en la posición 32 de la RAM un 100.

```@100  

D=A  

@32  

M=D
```
### Sumarle 20 a la que ya está en el registro 16 
```
@16  

M=D  

@20  

D=A 

@16 

M=D+M  
```

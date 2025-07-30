## Actividad 1
- **¿Qué es la entrada-salida mapeada a memoria?** 
Ciertas direcciones de la memoria RAM están reservadas para comunicarse con dispositivos externos, como la pantalla (monitor) o el teclado.

- **¿Cómo se implementa en la plataforma Hack?**
 - Para mostrar datos en la pantalla, se escriben valores en las direcciones desde @SCREEN hasta @SCREEN + 8191 (ya que la pantalla tiene 512 × 256 bits = 8192 palabras de 16 bits).

 - Para leer una tecla presionada, se consulta el valor en @KBD


- **Inventa un programa que haga uso de la entrada-salida mapeada a memoria.**
Darles valores de -1 a numeros a partir del 16384

```
.asm
// Dirección de la pantalla
@SCREEN
D=A
@addr
M=D          // addr = SCREEN (posición base)

// Loop principal
(LOOP)
  // Leer valor del teclado
  @KBD
  D=M

  // Comparar con ASCII de 'd' (100)
  @100
  D=D-A      // D = KBD - 100
  @DRAW
  D;JEQ      // Si es igual, ir a DRAW

// Si no es 'd', borrar el pixel
  @addr
  A=M
  M=0        // Apagar píxel

  @LOOP
  0;JMP

// Dibujar si se presiona 'd'
(DRAW)
  @addr
  A=M
  M=-1       // Encender píxel (todos los bits = 1)

  @LOOP
  0;JMP

``` 
Investiga el funcionamiento del programa con el simulador.
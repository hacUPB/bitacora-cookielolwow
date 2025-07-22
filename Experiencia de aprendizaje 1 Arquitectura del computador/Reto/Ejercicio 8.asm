//8. Considera el siguiente programa:
    
    
    @var1
    D = M
    @var2
    D = D + M
    @var3
    M = D

    
   // - ¿Qué hace este programa?
    // Respuesta: Este programa suma el valor almacenado en `var1` con el valor almacenado en `var2` y guarda el resultado en `var3`.
   // - En qué posición de la memoria está `var1`, `var2` y `var3`? ¿Por qué en esas posiciones?
   //Respuesta: `var1`, `var2` y `var3` estan posicionados en la posicion 16, 17 y 18 , ya que a las variables se les asigna una dirección de memoria a partir de la posición 16 en adelante.
# Investigación
## Actividad 1
- ¿Qué son los vértices?
  - Los vértices son como los puntos base de una figura. Son coordenadas que marcan las esquinas o posiciones clave de un objeto 3D.
- ¿Con qué figura geométrica se dibuja en 3D?
  -  En 3D casi todo se construye con triángulos. La razón es que un triángulo es la figura más simple posible y siempre está en un mismo plano, lo que hace que los cálculos sean más rápidos y estables para la GPU.
- ¿Qué es un shader?
  - Un shader es un mini programa que corre dentro de la GPU. Se encarga de decirle a la tarjeta gráfica cómo debe dibujar o cómo debe verse algo en la pantalla, por ejemplo, el color, la iluminación o los efectos visuales.
- ¿Cómo se le llaman a los grupos de píxeles de un mismo triángulo?
  - A esos grupos se les llama fragmentos.
- ¿Qué es un fragment shader?
  - Es el shader que trabaja en cada fragmento (o píxel) del dibujo.
- ¿Qué es un vertex shader?
  - Es el shader que trabaja con los vértices. Se encarga de transformar la posición de los puntos del modelo 3D (vértices) para ubicarlos correctamente en la pantalla.
- ¿Al proceso de determinar qué pixels del display va a cubrir cada triángulo de una mesh se le llama?
  - Ese proceso se llama rasterización.
- ¿Qué es el render pipeline?
  - Es toda la secuencia de pasos que sigue la GPU para dibujar algo. Va desde leer los vértices, pasarlos por los shaders, rasterizarlos y finalmente pintar los píxeles en la pantalla. Es como una cadena de producción de imágenes.
- ¿Hay alguna diferencia entre aplicar un color a una superficie de una mesh o aplicar una textura?
  - Sí. Aplicar un color significa darle un solo tono a toda la superficie, mientras que una textura es una imagen que se “pega” sobre el objeto, lo que permite que tenga más detalle, como madera, metal o piel.
- ¿Cuál es la diferencia entre una textura y un material?
  - Una textura es solo una imagen o patrón visual, mientras que un material es algo más completo: incluye las propiedades de cómo ese objeto reacciona a la luz (brillo, reflexión, transparencia, etc.), y puede usar varias texturas a la vez.
- ¿Qué transformaciones se requieren para mover un vértice del 3D world al View Screen?
  - Primero se aplica la transformación del modelo , luego la transformación de vista , y finalmente la proyección.
- ¿Al proceso de convertir los triángulos en fragmentos se le llama?
  - También se llama rasterización
- ¿Qué es el framebuffer?
  - El framebuffer es como una memoria temporal donde se guardan todos los píxeles que se van a mostrar en pantalla antes de que se actualice la imagen completa.
- ¿Para qué se usa el Z-buffer o depth buffer en el render pipeline?
  - Se usa para manejar la profundidad. Guarda qué tan lejos o cerca está cada píxel respecto a la cámara, así la GPU sabe qué objeto está delante de otro y puede dibujar correctamente sin que se mezclen.
- Luego de ver el segundo video entiendes por qué la GPU tiene que funcionar tan rápido y de manera paralela. ¿Por qué?
  - Porque la GPU no trabaja con un solo dato a la vez, sino con miles o millones de píxeles y vértices al mismo tiempo. Necesita hacer muchos cálculos en paralelo para que todo se vea fluido y en tiempo real, sobre todo en videojuegos, animaciones o simulaciones.
 ## Actividad 2
 **PRIMER EJEMPLO**


- ¿Cómo funciona?
  - El código lo que hace es cargar un shader y aplicarlo a un rectángulo que cubre toda la pantalla. En el draw(), empieza el shader, dibuja el rectángulo y luego lo cierra. Todo lo que se dibuja entre shader.begin() y shader.end() pasa por la GPU y se ve afectado por el shader.
  
- ¿Qué resultados obtuviste?
<img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/09c4befa-de8e-4059-b6f8-4037eb32d99c" />


<img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/83221da6-13c0-44b1-8902-498bae61b9dc" />

- ¿Estás usando un vertex shader?
  - Sí, se está usando un vertex shader.
- ¿Estás usando un fragment shader?
  - sí, se está usando un fragment shader.
- Analiza el código de los shaders. ¿Qué hace cada uno?
  - El vertex shader simplemente toma las coordenadas del rectángulo y las pasa al pipeline para que se dibujen donde deben estar. Es decir, solo posiciona los vértices. El fragment shader es el que define el color.


 **SEGUNDO EJEMPLO**
- ¿Cómo funciona?
  - Crea un plano en tres dimensiones en la mitad de la pantalla que de deforma con el shader. El color del plano cambia dependiendo de la posición del mouse en X (de magenta a cian) y la rotación del plano cambia con el mouse en Y.
- ¿Qué resultados obtuviste?
<img width="505" height="400" alt="image" src="https://github.com/user-attachments/assets/a4a2a0bb-ede9-4586-86e1-db3c6879de49" />

  
- ¿Estás usando un vertex shader?
  - Sí. El vertex shader se encarga de modificar la posición de cada vértice del plano.

- ¿Estás usando un fragment shader?
  - También. El fragment shader se encarga de calcular el color de cada fragmento (pixel) del plano.
- Analiza el código de los shaders. ¿Qué hace cada uno?
  - Vertex Shader: Usa la variable time para animar los vértices del plano.
  - Fragment Shader: Usa la variable globalColor que se envía automáticamente cuando se llama a ofSetColor().
**TERCER EJEMPLO**

- ¿Cómo funciona?
    - El programa crea una especie de plano que ocupa toda la pantalla y le aplica un shader. Ese shader hace que el plano cambie visualmente según donde muevas el mouse.
Básicamente, el código calcula la posición del mouse y el color que debería tener (entre morado y azul) y se lo manda al shader. Entonces, cuando uno mueve el mouse, el shader reacciona cambiando el color y generando un  efecto visual como de ojo de pescado en la posicion del mouse.
- ¿Qué resultados obtuviste?

  
  <img width="400" height="286" alt="image" src="https://github.com/user-attachments/assets/9a3924bc-8660-4592-bf67-4567d57c40f0" />


- ¿Estás usando un vertex shader?
    - Sí. Es el que se encarga de deformar el plano.
- ¿Estás usando un fragment shader?
    - Sí. Ese se encarga del color, hace que cambie entre morado y azul dependiendo de la posicion del mouse.
- Analiza el código de los shaders. ¿Qué hace cada uno?
    - El vertex shader edita el plano, deforma el plano con el cursor.
    - El fragment shader se encarga del color final que vemos en pantalla, y por eso es el que genera el cambio de color de un lado al otro.

```cpp
  
// color changes from magenta to blue when moving the mouse from left to right.
float percentX = mouseX / (float)ofGetWidth();
percentX = ofClamp(percentX, 0, 1);
ofFloatColor colorLeft = ofColor::magenta;
ofFloatColor colorRight = ofColor::blue;
ofFloatColor colorMix = colorLeft.getLerped(colorRight, percentX);
```

**CUARTO EJEMPLO**

- ¿Cómo funciona?
    - Se carga una imagen sobre un plano y el shader se encarga de seguir el movimiento del mouse para poder mover el plano o la imagen por decirlo asi.
      
- ¿Qué resultados obtuviste?

  <img width="490" height="467" alt="image" src="https://github.com/user-attachments/assets/a636d786-2224-4797-978f-cb1738cac7dc" />



- ¿Estás usando un vertex shader?
 - Sí, el código lo usa. Es la parte del shader que se encarga de crear los vertices para crear el plano
- ¿Estás usando un fragment shader?
 - Si, el fragment shader toma texturas de la imagen y decide como acomodar cada pedazo del plano.
   

**QUINTO EJEMPLO**

- ¿Cómo funciona?
    - 
      
- ¿Qué resultados obtuviste?

<img width="392" height="296" alt="image" src="https://github.com/user-attachments/assets/c33329ad-1dc4-478e-8c19-856f469db3a0" />


- ¿Estás usando un vertex shader?
 - 
- ¿Estás usando un fragment shader?
 - 

**SEXTO EJEMPLO**

- ¿Cómo funciona?
    - 
      
- ¿Qué resultados obtuviste?



- ¿Estás usando un vertex shader?
 - 
- ¿Estás usando un fragment shader?
 -   

**SEPTIMO EJEMPLO**

- ¿Cómo funciona?
    - 
      
- ¿Qué resultados obtuviste?



- ¿Estás usando un vertex shader?
 - 
- ¿Estás usando un fragment shader?
 -      


**OCTAVO EJEMPLO**

- ¿Cómo funciona?
    - 
      
- ¿Qué resultados obtuviste?



- ¿Estás usando un vertex shader?
 - 
- ¿Estás usando un fragment shader?
 -   
**NOVENO EJEMPLO**

- ¿Cómo funciona?
    - 
      
- ¿Qué resultados obtuviste?



- ¿Estás usando un vertex shader?
 - 
- ¿Estás usando un fragment shader?
 -   
## Actividad 3

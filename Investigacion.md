## Sesión 1: la naturaleza de los objetos en C++ ##
### Introducción a los Objetos 
```c++
class Particle {
public:
    float x, y;
    void move(float dx, float dy) {
        x += dx;
        y += dy;
    }
};
```
1. ¿Qué representa la clase Particle?

  
   Una posicion de un objeto  y el movimiento de estos valores.

  
2.  ¿Cómo interactúan sus atributos y métodos?


   El metodo de move edita la posicion de los atributos sumandoles una.
  
  
3. Prompt para ChatGPT: explícame en detalle qué es un objeto en C++ y cómo se relaciona con una clase. Usa el ejemplo de una clase Particle con atributos `x` y `y` y un método `move`.
- Qué es un objeto en C++?

  Un objeto es una instancia concreta de una clase. Es decir, cuando usas la clase para crear una variable que contiene datos reales y puede ejecutar métodos.
  Una clase es una definición abstracta.

  Un objeto es una variable basada en esa clase.

  Puedes crear muchos objetos a partir de una misma clase, cada uno con sus propios datos.

  En nuestro ejemplo:



  - Particle es la clase.

  - p1 es un objeto de tipo Particle.

  - x y y son atributos del objeto.

  - move es un método que cambia esos atributos.

### Explorando la memoria

1. Los atributos están almacenados de forma contigua?

  
    Si, como ambos son float, se almacenan contiguamente.
  

2. ¿Qué indica el tamaño del objeto sobre su estructura interna?
    - sizeof(Particle) te dice cuantos bytes ocupa.
  
  


3. Prompt para ChatGPT: ¿Cómo se almacenan los objetos en memoria en C++? Si tengo dos instancias de Particle, ¿Cómo se relacionan sus direcciones de memoria? ¿Los atributos están contiguos?
  - Si ambos objetos están en la pila (stack), como en tu ejemplo, sus direcciones estarán una después de la otra (con posible separación por alineación).

  Ejemplo: &p1 = 0x7ffeeb30, &p2 = 0x7ffeeb38 si sizeof(Particle) == 8.

  - Si estuvieran en el montón (heap) (usando new), no hay garantía de que estén contiguos.


### Análisis de diferencias
<img width="423" height="97" alt="image" src="https://github.com/user-attachments/assets/93a7deff-86aa-4d58-bdd9-4995900638a6" />

1. ¿Cómo afectan los datos estáticos al tamaño de la instancia?

      - No afectan el tamaño de una instancia de la clase. La variables estaticas son compartidas por toda la clase, no por cada objeto.
      - Se almacenan en una zona separada. Por eso el operador sizeof() no las incluye.
  
2. ¿Qué diferencias hay entre datos estáticos y dinámicos en términos de memoria?


| Característica                   | **Datos Estáticos**                       | **Datos Dinámicos**                              |
| -------------------------------- | ----------------------------------------- | ------------------------------------------------ |
| **Dónde se almacenan**           | Segmento de datos del ejecutable (global) | Heap (memoria dinámica)                          |
| **Duración de vida**             | Durante toda la ejecución del programa    | Manual: controlado con `new`/`delete`            |
| **Acceso**                       | Por clase (e.g., `Clase::variable`)       | Por puntero (e.g., `obj->ptr`)                   |
| **Afecta el tamaño del objeto?** | No                                     | Sí (solo el puntero, no el contenido apuntado)|
| **Responsabilidad de liberar**   | No (automática)                           | Sí, tú debes liberar con `delete`                |



3. Prompt para ChatGPT: explícame cómo el uso de variables estáticas y dinámicas en una clase afecta el tamaño de sus instancias. ¿Las variables estáticas ocupan espacio en cada objeto?
    - El uso de variables estáticas en una clase no afecta el tamaño de sus instancias, ya que estas variables pertenecen a la clase en sí y se almacenan en una zona de memoria separada (segmento de datos estáticos), compartida por todos los objetos. Por lo tanto, no ocupan espacio en cada objeto. En cambio, las variables dinámicas (como punteros que apuntan a memoria en el heap) sí afectan el tamaño de la instancia en cuanto al puntero en sí, pero no incluye el tamaño de la memoria que apuntan, ya que esa memoria está fuera del objeto, en el heap.

### Reflexión
¿Qué es un objeto desde la perspectiva de la memoria?


¿Cómo influyen los atributos y métodos en el tamaño y estructura del objeto?


Conclusión: resumir los hallazgos y cómo esto impacta el diseño de clases.



## Sesión 2: ubicación en memoria de datos y métodos
### Análisis de la estructura de una clase

Prompt para ChatGPT: ¿Dónde se almacenan los datos y métodos de una clase en C++ en la memoria? Explica el concepto de vtable y cómo se relaciona con los métodos virtuales.


¿Cómo afecta la presencia de métodos virtuales al tamaño del objeto?


 ¿Qué papel juegan las vtables en el polimorfismo?

 
 Prompt para ChatGPT: ¿Cómo se implementan los métodos virtuales en C++? Explica el concepto de vtable y cómo se utiliza para resolver llamadas a métodos virtuales.

 ### Uso de punteros y referencias
**Analizar el impacto en memoria:**
**Reflexión Guiada**

Cuál es la relación entre los punteros a métodos y la vtable?


¿Cómo afectan estos mecanismos al rendimiento del programa?


Prompt para ChatGPT: ¿Qué diferencia hay entre punteros a funciones y punteros a métodos miembro en C++? ¿Cómo afectan al tamaño de los objetos y al rendimiento?


**Reflexión individual:**


¿Dónde residen los datos y métodos de una clase en la memoria?


¿Cómo interactúan las diferentes partes en tiempo de ejecución?


Conclusión: cómo esta comprensión afecta el diseño de sistemas.


## Sesión 3: implementación Interna de Encapsulamiento, Herencia y Polimorfismo
### Profundizando en el encapsulamiento

Prompt para ChatGPT: ¿Cómo implementa el compilador el encapsulamiento en C++? Si los miembros privados aún ocupan espacio en el objeto, ¿Qué impide que se acceda a ellos desde fuera de la clase?

### Hagamos un poco de hackers y rompamos el encapsulamiento

 ¿Qué es el encapsulamiento y cuál es su propósito en la programación orientada a objetos?

 
¿Por qué es importante proteger los datos de una clase y restringir el acceso desde fuera de la misma?


¿Qué significa reinterpret_cast y cómo afecta la seguridad del programa?


¿Por qué crees que se pudo acceder a los miembros privados de MyClass en este experimento, a pesar de que el compilador normalmente lo impediría?


¿Cuáles podrían ser las consecuencias de utilizar técnicas como las mostradas en este experimento en un programa real?


¿Qué implicaciones tiene este experimento sobre la confianza en las barreras de encapsulamiento que proporciona C++?


### Herencia y la Relación en Memoria


¿Cómo se organizan los atributos en memoria?


¿Qué sucede si agregamos más niveles de herencia?


Prompt para ChatGPT: explícame cómo se organiza en memoria un objeto de una clase derivada en C++. ¿Cómo se almacenan los atributos de la clase base y de la derivada?

### Polimorfismo y Vtables en detalle
1. Analizar con un depurador: observa cómo se resuelven las llamadas a makeSound() en tiempo de ejecución.

   
    ¿Cómo utiliza el programa las vtables para el polimorfismo?


    ¿Cuál es el impacto en el rendimiento?


Prompt para ChatGPT: ¿Cómo funciona el polimorfismo en C++ a nivel interno? Explica cómo se utilizan las vtables para resolver métodos virtuales en una jerarquía de herencia.

2. Reflexión Individual:

   
    ¿Cómo se implementan internamente el encapsulamiento, la herencia y el polimorfismo?


    Análisis: ventajas y desventajas en términos de eficiencia y complejidad.




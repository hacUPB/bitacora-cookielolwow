## Sesión 1: la naturaleza de los objetos en C++ ##
# Introducción a los Objetos #
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

## Explorando la memoria

1. Los atributos están almacenados de forma contigua?

  
    Si, como ambos son float, se almacenan contiguamente.
  

2. ¿Qué indica el tamaño del objeto sobre su estructura interna?
    - sizeof(Particle) te dice cuantos bytes ocupa.
  
  


3. Prompt para ChatGPT: ¿Cómo se almacenan los objetos en memoria en C++? Si tengo dos instancias de Particle, ¿Cómo se relacionan sus direcciones de memoria? ¿Los atributos están contiguos?
  - Si ambos objetos están en la pila (stack), como en tu ejemplo, sus direcciones estarán una después de la otra (con posible separación por alineación).

  Ejemplo: &p1 = 0x7ffeeb30, &p2 = 0x7ffeeb38 si sizeof(Particle) == 8.

  - Si estuvieran en el montón (heap) (usando new), no hay garantía de que estén contiguos.


## Análisis de diferencias
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

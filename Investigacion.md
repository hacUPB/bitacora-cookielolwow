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

- Un objeto en memoria es básicamente un pedazo de memoria seguido, reservado para guardar los datos de una clase. Ahí se almacenan los atributos y, si la clase usa memoria dinámica, también se guardan punteros que apuntan al heap.

¿Cómo influyen los atributos y métodos en el tamaño y estructura del objeto?

- Los atributos determinan directamente el tamaño del objeto (ejemplo: 2 floats = 8 bytes).

- Los métodos no afectan el tamaño, ya que son funciones compartidas para todas las instancias.

- Los atributos estáticos tampoco cambian el tamaño.

- Los punteros a memoria dinámica sí cuentan en el tamaño, pero no incluyen el contenido al que apuntan.

Conclusión: resumir los hallazgos y cómo esto impacta el diseño de clases.
    - Un objeto en C++ no es solo un concepto abstracto: es un espacio físico en memoria que contiene atributos y, a veces, punteros. El hecho de que los atributos estén contiguos y de que sizeof() solo cuente la memoria propia del objeto (sin incluir lo estático o lo dinámico externo) es clave para entender cómo se diseñan las clases.


## Sesión 2: ubicación en memoria de datos y métodos
### Análisis de la estructura de una clase

Prompt para ChatGPT: 

¿Dónde se almacenan los datos y métodos de una clase en C++ en la memoria? Explica el concepto de vtable y cómo se relaciona con los métodos virtuales.
- Los atributos de un objeto se guardan en el stack o en el heap dependiendo de cómo lo cree. Los métodos no se guardan en cada objeto, sino en la sección de código del programa. Cuando una clase tiene métodos virtuales, aparece la vtable, que es como una tabla con direcciones de funciones para resolver qué método se ejecuta en tiempo de ejecución.

¿Cómo afecta la presencia de métodos virtuales al tamaño del objeto?

- El objeto aumenta de tamaño porque ahora debe guardar ese puntero oculto a la vtable.

¿Qué papel juegan las vtables en el polimorfismo?
- Son las que permiten que el programa decida en tiempo de ejecución qué método ejecutar según el tipo real del objeto, no según el tipo de la referencia.
 

 ### Uso de punteros y referencias
**Analizar el impacto en memoria:**
**Reflexión Guiada**

Cuál es la relación entre los punteros a métodos y la vtable?


¿Cómo afectan estos mecanismos al rendimiento del programa?


Prompt para ChatGPT: ¿Qué diferencia hay entre punteros a funciones y punteros a métodos miembro en C++? ¿Cómo afectan al tamaño de los objetos y al rendimiento?

- Los punteros a funciones son manuales: yo los asigno directamente. La vtable en cambio se gestiona sola y se encarga de los métodos virtuales. Ambos guardan direcciones de funciones, pero funcionan distinto.
- Al usar vtables o punteros a funciones hay un salto indirecto antes de llamar al método, entonces es un poquito más lento que una llamada normal. Pero esa diferencia normalmente es mínima frente a la ventaja de tener polimorfismo o flexibilidad.
- Los punteros a funciones normales apuntan a funciones globales o estáticas.
- Los punteros a métodos miembro necesitan además saber a qué objeto pertenecen para poder usarse.
En términos de memoria, un puntero ocupa lo mismo, pero un puntero a método requiere más pasos para ejecutarse porque debe ligarse al objeto.


**Reflexión individual:**


¿Dónde residen los datos y métodos de una clase en la memoria?
- Los datos del objeto están en el stack o en el heap, los métodos están en la parte de código, y la vtable está en memoria estática global.

¿Cómo interactúan las diferentes partes en tiempo de ejecución?
- El objeto guarda sus datos, más un puntero a la vtable si tiene virtuales. Cuando llamo un método virtual, el programa usa ese puntero a la vtable para buscar la dirección de la función y ejecutarla.

Conclusión: cómo esta comprensión afecta el diseño de sistemas.
- Saber cómo se organiza la memoria me ayuda a entender por qué el tamaño de un objeto cambia, por qué conviene o no usar virtuales, y cómo optimizar cuando quiero rendimiento. También me deja más claro que los métodos no se “repiten” en cada objeto, sino que todos apuntan al mismo código.

## Sesión 3: implementación Interna de Encapsulamiento, Herencia y Polimorfismo
### Profundizando en el encapsulamiento

Prompt para ChatGPT: 

¿Cómo implementa el compilador el encapsulamiento en C++? Si los miembros privados aún ocupan espacio en el objeto, ¿Qué impide que se acceda a ellos desde fuera de la clase?
- El compilador es el que hace cumplir las reglas de acceso (private, protected, public). Los miembros privados sí ocupan espacio dentro del objeto, pero el compilador no deja que yo los use directamente desde afuera. Es más una regla de compilación que una barrera física.

  
### Hagamos un poco de hackers y rompamos el encapsulamiento

 ¿Qué es el encapsulamiento y cuál es su propósito en la programación orientada a objetos?
- Es esconder los detalles internos de una clase para que solo se pueda interactuar con ella a través de lo que se expone (métodos públicos). Sirve para proteger los datos y que no cualquiera pueda cambiarlos sin control.
 
¿Por qué es importante proteger los datos de una clase y restringir el acceso desde fuera de la misma?
- Porque evita errores, mantiene consistencia en los objetos y asegura que la lógica de la clase se respete.

¿Qué significa reinterpret_cast y cómo afecta la seguridad del programa?
- reinterpret_cast permite tratar un bloque de memoria como si fuera otro tipo. Esto rompe la seguridad porque puedo saltarme las reglas de acceso y leer datos privados directamente.

¿Por qué crees que se pudo acceder a los miembros privados de MyClass en este experimento, a pesar de que el compilador normalmente lo impediría?
- Porque al final los atributos privados siguen estando en memoria. El compilador solo me prohíbe accederlos por sintaxis, pero si yo “hago trampa” con punteros puedo leerlos igual.

¿Cuáles podrían ser las consecuencias de utilizar técnicas como las mostradas en este experimento en un programa real?
- Podría dañar datos internos, romper la lógica de las clases, generar errores muy difíciles de depurar y además abrir huecos de seguridad.

¿Qué implicaciones tiene este experimento sobre la confianza en las barreras de encapsulamiento que proporciona C++?
- Me deja claro que el encapsulamiento es una convención fuerte, pero no una barrera absoluta. Si alguien quiere forzar el acceso, puede hacerlo. La responsabilidad recae en el programador en respetar el modelo

### Herencia y la Relación en Memoria


¿Cómo se organizan los atributos en memoria?

- Cuando una clase hereda de otra, los atributos de la clase base se guardan primero, y después siguen los de la clase derivada. Es como si el objeto derivado “contuviera” la parte base más su propia parte.

¿Qué sucede si agregamos más niveles de herencia?
- Se va acumulando. Cada nivel agrega sus propios atributos después de los de la clase padre. Eso quiere decir que un objeto con herencia múltiple o con varias capas de herencia puede crecer bastante en memoria.

Prompt para ChatGPT: explícame cómo se organiza en memoria un objeto de una clase derivada en C++. ¿Cómo se almacenan los atributos de la clase base y de la derivada?

### Polimorfismo y Vtables en detalle
1. Analizar con un depurador: observa cómo se resuelven las llamadas a makeSound() en tiempo de ejecución.

   
    ¿Cómo utiliza el programa las vtables para el polimorfismo?
    - Cada objeto con métodos virtuales guarda un puntero oculto a una vtable. Esa vtable tiene las direcciones de las funciones que corresponden al tipo real del objeto. Cuando llamo un método virtual desde un puntero a la clase base, el programa va a la vtable para decidir qué función ejecutar. Por eso un Dog ladra y un Cat maúlla, aunque los llame desde un Animal*.

    ¿Cuál es el impacto en el rendimiento?
    - al impacto en el rendimiento del polimorfismo, entendí que sí existe un pequeño costo porque cada vez que se llama a un método virtual el programa no va directo a la función, sino que primero consulta la vtable para saber a dónde saltar. Eso significa que hay una especie de “paso intermedio” en cada llamada, lo que lo hace un poco más lento que una función normal.

Prompt para ChatGPT: ¿Cómo funciona el polimorfismo en C++ a nivel interno? Explica cómo se utilizan las vtables para resolver métodos virtuales en una jerarquía de herencia.
- Cuando me puse a revisar cómo funciona el polimorfismo en C++ por dentro, entendí que todo gira alrededor de las vtables. Cada clase que tiene métodos virtuales guarda una tabla (la vtable) que básicamente es una lista de punteros a las funciones correspondientes.

    Cuando yo creo un objeto de una clase con herencia polimórfica, ese objeto lleva un puntero oculto llamado vptr, que apunta a la vtable de su clase real. Entonces, cuando llamo a un método virtual a través de un puntero o referencia de la clase base, el programa no va directo a la función, sino que usa ese vptr para buscar en la vtable cuál implementación ejecutar.


2. Reflexión Individual:
- En esta sesión me di cuenta de que el encapsulamiento no es una barrera física sino una regla del compilador. Los datos privados siguen estando en memoria y es posible leerlos con punteros, aunque no sea seguro. También entendí que en herencia los atributos se organizan de forma lineal (primero los de la base, luego los de la derivada), y que el polimorfismo funciona gracias a las vtables que guardan las direcciones de los métodos correctos en tiempo de ejecución.


    Encapsulamiento → protege la lógica, pero depende de que los programadores respetemos las reglas.

    Herencia → se refleja directamente en cómo se apilan los datos en memoria.

    Polimorfismo → se hace posible gracias a un mecanismo interno (vtable) que conecta cada objeto con su comportamiento real.

    Esto me ayuda a entender que C++ me da poder y flexibilidad, pero también mucha responsabilidad en cómo uso la memoria y diseño las clases.


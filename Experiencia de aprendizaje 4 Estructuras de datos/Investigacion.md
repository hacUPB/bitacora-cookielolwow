## ACTIVIDAD 1
1. 
* El programa crea una “serpiente” usando una lista enlazada de nodos (Node).

* Cada nodo tiene coordenadas (x, y) y un puntero al siguiente nodo.

* La clase LinkedList administra los nodos, permitiendo agregar, actualizar y dibujar la serpiente.

* En update(), la cabeza sigue al mouse y los demás nodos siguen a la cabeza.

* En display(), se dibuja un círculo rojo por cada nodo.

* Con la tecla c se limpia toda la lista liberando la memoria.

3. Una lista enlazada es una estructura de datos compuesta por nodos que se enlazan entre sí mediante punteros.

4. Mediante el atributo Node* next. Cada nodo almacena un puntero al siguiente, creando una “cadena”.

5. 

* Los nodos se crean con new Node(...) → memoria dinámica en el heap.

* Se destruyen con delete current en clear().

6. 
* Inserción y eliminación en posiciones intermedias es más eficiente (O(1) si tienes el puntero al nodo).

* En un arreglo, mover elementos implica reacomodar memoria.

7. El destructor de LinkedList llama a clear(). Esto asegura que, cuando el objeto snake se destruye, también se libere toda la memoria dinámica de sus nodos.

8. 
* Se recorre la lista nodo por nodo.

* Cada nodo es eliminado con delete.

* Los punteros head y tail se ponen en nullptr.

* El contador size se resetea a 0.

9. 
* Se crea un nuevo Node en memoria dinámica.

* Se conecta el tail->next al nuevo nodo.

* Se actualiza el puntero tail al nuevo nodo.

10. Ejemplo: en un programa de arte generativo donde los elementos entran y salen constantemente de la pantalla. Con listas enlazadas puedes insertar/eliminar sin mover grandes bloques de memoria.

11. Si diseñara una estructura personalizada para animaciones:

* Usaria nodos para representar partículas.

* Incluiria un buen manejo de memoria con clear() y destructores.

* Evitaria fugas usando punteros inteligentes (std::unique_ptr) en lugar de new/delete manuales.

12. 
* En C++ gestionas memoria manualmente → control total, pero mayor riesgo de fugas.

* En C# el Garbage Collector lo hace por ti → más cómodo, pero menos control sobre el rendimiento.

13. 
* Usar nodos para representar trazos, partículas o agentes.

* Limpiar nodos que ya no se usan (clear() o al salir de pantalla).

* Usar destructores y punteros inteligentes para evitar fugas.

14. 
* Prueba unitaria de addNode(): verificar que size aumenta y que tail apunta al nuevo nodo.


## ACTIVIDAD 2
**1. Entendiendo la aplicación**

Primero revisé muy despacio el código del stack y de la queue. Con la ayuda del depurador en Visual Studio pude ir viendo cómo se crean los nodos con new y cómo se liberan con delete cuando hago pop() o dequeue().
Me llamó la atención que, a diferencia de usar directamente std::stack o std::queue, aquí tengo control total de la memoria, lo que me obligó a fijarme en qué pasa con los punteros.
En el stack, siempre se trabaja con el puntero top (último en entrar). En la queue, debo controlar tanto front como rear, lo que lo hace un poco más complejo porque si me olvido de actualizar uno, puedo perder referencias.

**2. Evaluaciones formativas**

Le pedí a ChatGPT que me hiciera preguntas de repaso. Algunas de las que más me ayudaron:

- ¿Qué pasa si no libero memoria cuando hago pop() en el stack?

- ¿Cómo cambia el orden en el que se dibujan los círculos en un stack frente a una queue?

- ¿Qué pasa con los punteros front y rear si hago dequeue() cuando solo hay un nodo?

Usé el depurador para confirmar lo que sospechaba y, al verlo paso a paso, entendí mejor. Por ejemplo, comprobé que al eliminar el último nodo en una queue debo actualizar también rear = nullptr, si no quedaba apuntando a memoria inválida.



**3. Pruebas**

Para probar el programa hice lo siguiente:

- Presioné varias veces 'a' en el stack y confirmé que los círculos se apilan en el orden inverso al que los añadí (LIFO).

- En la queue, en cambio, al encolar varios círculos, se dibujan en el orden exacto en el que los agregué (FIFO).

- Probé también a desapilar o desencolar más veces de las que había nodos y comprobé que el programa no se crashea porque ya hay validación (if (top != nullptr) y if (front != nullptr)).

- Finalmente revisé que al cerrar la app, los destructores (~Stack y ~Queue) llamaban a clear() y se liberaba toda la memoria.

**4. Preguntas de reflexión – Stack**

- La memoria se gestiona creando nodos con new y liberándolos con delete en pop() o clear(). Esto da control, pero si me olvido de liberar, caigo en fugas de memoria.

- Es importante liberar porque, si no lo hago, en ejecuciones largas la memoria se acumula y se vuelve un problema grave de rendimiento.

- Usar std::stack simplifica mucho porque ya maneja todo esto internamente, pero pierdo el control detallado sobre la memoria.

- El stack es LIFO, o sea que el último en entrar es el primero en salir. Esto funciona bien en problemas como el undo/redo o recorridos recursivos.

- Para almacenar objetos más complejos tendría que manejar constructores y destructores correctamente, e incluso considerar copiar punteros de manera segura (deep copy si es necesario).

**5. Autoevaluación – Stack**

- Sí, puedo explicar cómo funciona apilar y desapilar, con memoria incluida.

- Ya identifico dónde podrían aparecer fugas de memoria.

- Creo que podría añadir una función find() que busque un nodo por coordenadas sin modificar el orden.

- Entiendo claramente cómo la estructura LIFO afecta el flujo de datos.

- Me siento capaz de extender la pila a objetos más complejos si soy cuidadosa con la memoria.

**6. Preguntas de reflexión – Queue**

- La memoria se gestiona de manera parecida al stack: new para encolar y delete para desencolar. La diferencia es que manejo dos punteros: front y rear.

- El reto extra es que tengo que actualizar ambos punteros en casos especiales, por ejemplo, cuando la queue queda vacía.

- La queue es FIFO, lo que la hace ideal para procesos en orden de llegada, como colas de impresión o atención de clientes.

- Una queue circular sería más eficiente en memoria porque reutiliza los espacios, evitando tener que mover nodos o que la estructura crezca innecesariamente.

- Si no manejo bien front y rear, puedo perder nodos (fugas) o dejar punteros colgando. La clave es actualizarlos siempre con cuidado.

**7. Autoevaluación – Queue**

- Puedo explicar cómo se encola y desencola, paso a paso.

- Identifico problemas de punteros y cómo corregirlos.

- Podría implementar una versión circular con algunos cambios en la lógica.

- Entiendo cómo la estructura FIFO resuelve problemas donde el orden es fundamental.

- También podría ampliar la queue para objetos más complejos con gestión correcta de memoria.

* Prueba de update(): seguir con el depurador cómo se mueven las coordenadas.

* Prueba de clear(): confirmar que head y tail quedan en nullptr y que no hay memoria sin liberar (puedes usar herramientas como Visual Leak Detector).

* Prueba completa: ejecutar el programa, mover el mouse y limpiar la lista con la tecla c.

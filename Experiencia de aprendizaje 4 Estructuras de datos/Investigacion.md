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

* Prueba de update(): seguir con el depurador cómo se mueven las coordenadas.

* Prueba de clear(): confirmar que head y tail quedan en nullptr y que no hay memoria sin liberar (puedes usar herramientas como Visual Leak Detector).

* Prueba completa: ejecutar el programa, mover el mouse y limpiar la lista con la tecla c.
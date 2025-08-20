## Actividad 1
```cpp 
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
    ofSetColor(255);
    ofDrawCircle(ofGetMouseX(), ofGetMouseY(), 20);
}


```



¿Cuál es el resultado que se obtiene al ejecutar este programa?
- El resultado es un canva negro con un circulo blanco con un radio de 20 y el circulo se mueve a donde se mueva el mouse.

## Actividad 2 
En el archivo .h lo que hice fue incluir la librería principal de openFrameworks (ofMain.h) para poder usar todas sus funciones y clases. Después declaré mi clase ofApp, que hereda de ofBaseApp, y dentro puse las funciones que voy a usar: setup para iniciar todo, update para actualizar la información, draw para dibujar, y dos funciones especiales que reaccionan a la interacción con el mouse: mouseMoved y mousePressed. También definí dos variables privadas: un vector llamado particles para guardar las posiciones de las partículas (círculos) y una variable particleColor para manejar su color.
 



La aplicación funciona de forma muy sencilla: cada vez que muevo el mouse, se agrega una nueva partícula en esa posición. Si ya hay más de 100 partículas, se borra la más antigua para no acumular demasiadas. Luego, en cada frame, la función draw recorre todas las posiciones que tengo guardadas y dibuja círculos de color particleColor en cada una. Si presiono el mouse, el color cambia aleatoriamente y todas las partículas pasan a dibujarse con ese nuevo color.




La función mouseMoved se encarga de registrar las posiciones por donde paso el mouse y mantener el límite de 100 partículas. La función mousePressed genera un nuevo color aleatorio usando ofRandom y lo guarda en particleColor. La función setup se ejecuta al inicio y pone el fondo en negro y el color inicial de las partículas en blanco. La función update en este caso no hace nada porque no hay cálculos que actualizar cada frame. Por último, la función draw dibuja todas las partículas en pantalla recorriendo el vector y pintando círculos en cada posición.

## Actividad 3

```cpp
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
	ofBackground(0);
	particleColor = ofColor(ofColor(ofRandom(255), ofRandom(255), ofRandom(255)));
}

//--------------------------------------------------------------
void ofApp::update() {
}

//--------------------------------------------------------------
void ofApp::draw() {
	for (auto & pos : particles) {
		ofSetColor(particleColor);
	
		ofDrawRectangle(pos.x - 25, pos.y - 25, 50, 50);
	}
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y) {
	particles.push_back(ofVec2f(x, y));
	if (particles.size() > 100) {
		particles.erase(particles.begin());

	}
	particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {
	particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}

```

- Hice que en el codigo el color de inicio fuera aleatorio
 ```cpp
 particleColor = ofColor(ofColor(ofRandom(255), ofRandom(255), ofRandom(255)));
 ``` y en vez de un circulo ahora es un cuadrado. 
 ```cpp
 ofDrawRectangle(pos.x - 25, pos.y - 25, 50, 50);

 ```
 
 Además, ahora cada que se mueve, cambia de color.

 ```cpp
void ofApp::mouseMoved(int x, int y) {
	particles.push_back(ofVec2f(x, y));
	if (particles.size() > 100) {
		particles.erase(particles.begin());

	}
	particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));

 ```
## Actividad 5

¿Cuál es la definición de un puntero?


-Un puntero es una variable que almacena la dirección de memoria de otra variable u objeto, en lugar de almacenar directamente su valor.


¿Dónde está el puntero?

- En ffApp.H


¿Cómo se inicializa el puntero?

- vector<Sphere*> spheres;
- Sphere* selectedSphere;


¿Para qué se está usando el puntero?

-En este programa el puntero selectedSphere sirve para:

Guardar la referencia (dirección) de la esfera que el usuario selecciona con el mouse.

Moverla en update() modificando sus coordenadas sin afectar a las demás.

- Los punteros en el vector sirven para:

Mantener todas las esferas creadas en memoria dinámica.

Poder acceder a ellas y dibujarlas/actualizarlas cuando sea necesario.


¿Qué es exactamente lo que está almacenado en el puntero?

- SelectedSphere guarda la dirección de la esfera seleccionada.

## Actividad 6

- El problema del codigo es que cuando se selecciona una esfera ya no se puede deseleccionar.

```cpp
ofApp.h

  void mouseReleased(int x, int y, int button);

```
```cpp
ofApp.cpp

void ofApp::mouseReleased(int x, int y, int button) {
    if (button == OF_MOUSE_BUTTON_LEFT) {
        selectedSphere = nullptr;
    }
}


```
En el código implementé la función mouseReleased para que, al soltar el botón izquierdo del mouse, la variable selectedSphere se establezca en nullptr. De esta forma, cuando dejo de presionar el mouse, la esfera deja de actualizar su posición en el método update(), evitando que quede “pegada” al cursor

## Actividad 7

**Primer codigo**
Qué sucede cuando presionas la tecla “c”?Qué sucede cuando presionas la tecla “c”?

- No ocurrió nada, Se creó un objeto en el stack, se guardó su dirección, pero al terminar la función el objeto desapareció.

**Segundo codigo**
¿Qué sucede cuando presionas la tecla “c”?

- Se crea un objeto en el heap, se guarda su dirección en globalVector y el objeto sigue existiendo después de que la función termina.

¿Por qué ocurre esto?

-El heap mantiene los objetos hasta que se liberen explícitamente con delete, por lo que el puntero sigue siendo válido mientras no se libere la memoria.
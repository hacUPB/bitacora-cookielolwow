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
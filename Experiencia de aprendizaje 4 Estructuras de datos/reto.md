# RETO
**ofApp.cpp**
``` py
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
	ofSetWindowShape(800, 400);
	ofSetBackgroundColor(30, 100, 150);
	ofSetFrameRate(60);

	t = 0;
	frames = 120;

	// Guardamos posiciones base de Y (como en tu p5.js cada 5 píxeles)
	for (int y = 0; y < ofGetHeight(); y += 5) {
		baseY.push_back(y);
	}
}

//--------------------------------------------------------------
void ofApp::update() {
	// avanzar tiempo
	t += 1.0 / frames;
}

//--------------------------------------------------------------
void ofApp::draw() {
	// Fondo semitransparente
	ofSetColor(30, 100, 150, 20);
	ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());

	// Dibujar ondas
	for (auto y : baseY) {
		float hue = ofMap(sin((t * TWO_PI + y) * 0.01), -1, 1, 160, 200);
		float bri = ofMap(cos((t * TWO_PI + y) * 0.008), -1, 1, 60, 100);

		ofSetColor(ofColor::fromHsb(hue, 200, bri));

		ofBeginShape();
		for (int x = 0; x < ofGetWidth(); x += 5) {
			float baseWave = sin(t * TWO_PI + x * 0.03 + y * 0.01) * 10;
			float extraWave = sin(t * TWO_PI + x * 0.02) * waveStack.totalAmplitude();
			ofVertex(x, y + baseWave + extraWave);
		}
		ofEndShape();
	}
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
	if (key == 'a') {
		waveStack.push(ofRandom(5, 20)); // apilar nueva ola
	} else if (key == 'd') {
		waveStack.pop(); // desapilar ola
	} else if (key == 'r') {
		waveStack.clear(); // limpiar todas las olas
	}
}

```
**ofApp.h**
```py
#pragma once
#include "ofMain.h"

// Nodo para la pila de olas adicionales
class Node {
public:
	float amplitude;
	Node * next;

	Node(float a) {
		amplitude = a;
		next = nullptr;
	}
};

class Stack {
public:
	Node * top;

	Stack() { top = nullptr; }
	~Stack() { clear(); }

	void push(float a) {
		Node * newNode = new Node(a);
		newNode->next = top;
		top = newNode;
	}

	void pop() {
		if (top != nullptr) {
			Node * temp = top;
			top = top->next;
			delete temp;
		}
	}

	void clear() {
		while (top != nullptr) {
			pop();
		}
	}

	// Suma de amplitudes de todas las olas en la pila
	float totalAmplitude() {
		float sum = 0;
		Node * current = top;
		while (current != nullptr) {
			sum += current->amplitude;
			current = current->next;
		}
		return sum;
	}
};

class ofApp : public ofBaseApp {
public:
	float t; // tiempo
	int frames;
	vector<float> baseY; // posiciones base en el eje Y
	Stack waveStack; // pila de olas adicionales

	void setup();
	void update();
	void draw();
	void keyPressed(int key);
};

```

**1. Descripción de la experiencia**

En esta actividad implementé una obra de arte generativo dinámica en openFrameworks. Partí de un código previo en p5.js que dibujaba ondas animadas, y lo adapté a C++ incorporando estructuras de datos y gestión de memoria.
- Usé un arreglo (vector<float>) para almacenar las posiciones base en el eje Y de las ondas.

- Implementé una pila (Stack) que guarda amplitudes extras que se suman al movimiento de las olas.

- La interacción se da con el teclado:

    - a apila una ola extra.

    - d desapila la última ola agregada.

    - r limpia todas las olas.

* La memoria de cada nodo en la pila se gestiona manualmente usando new y delete, y asegurando la liberación en pop() y clear().

Esto permitió que las olas respondieran en tiempo real a la interacción del usuario y al mismo tiempo practicar cómo controlar el ciclo de vida de objetos creados dinámicamente.

**2. Aprendizajes clave**

- Gestión de memoria: entendí que en C++ es fundamental liberar la memoria de cada nodo eliminado de la pila, de lo contrario se producen fugas que afectan el rendimiento de programas de larga duración.

- Estructuras de datos y visualización: aprendí cómo un arreglo puede dar la estructura base (las líneas de las olas), mientras que una pila controla variaciones dinámicas (olas extra que se suman).

- Naturaleza LIFO: noté que usar una pila (Last In, First Out) hace que las últimas olas agregadas sean las primeras en desaparecer, lo que produce un efecto visual distinto al que tendría una cola (FIFO).

- Interactividad: descubrí cómo mapear teclas a cambios en las estructuras de datos, logrando que el usuario “controle” la memoria visual del programa.

**3. Dificultades y soluciones**

- Adaptar de p5.js a C++: al inicio fue confuso porque openFrameworks no tiene colorMode(HSB) ni transparencia igual que p5.js. Lo resolví usando ofColor::fromHsb() y dibujando rectángulos semitransparentes.

- Fugas de memoria: al principio olvidé limpiar la pila en el destructor y se acumulaban objetos. Revisando con el depurador confirmé que había fugas, y lo solucioné implementando correctamente clear().


**4. Reflexión personal**

Esta práctica me permitió ver cómo las estructuras de datos no son solo teoría, sino que pueden dar vida y dinamismo al arte generativo. La pila, al ser LIFO, le dio una lógica de memoria visual interesante: las últimas olas agregadas son las primeras en desaparecer, casi como si el programa recordara y olvidara en orden inverso.



También confirmé que en C++ la gestión de memoria no es automática como en JavaScript, y eso me obligó a ser mucho más consciente de cada objeto que creaba y destruía.



Siento que logré combinar creatividad con rigor técnico, entendiendo que el arte generativo también necesita estructuras de datos sólidas para ser dinámico y eficiente.



https://github.com/user-attachments/assets/109dc17a-d44d-4a35-b17f-b52c59b4b093


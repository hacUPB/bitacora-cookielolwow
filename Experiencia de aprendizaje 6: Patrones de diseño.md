## Sesión 2: análisis de un caso de estudio
  Ahora te pediré que te tomes un tiempo para analizar el código y entender su funcionamiento.
 
- ¿Qué hace el patrón observer en este caso?
Qué hace el patrón Observer en este caso?


  El patrón Observer  permite que un objeto  notifique automáticamente a los Observers cuando ocurre un cambio de estado.

  La clase Subject  tiene la funcion de mantener una lista de observers y notificarles cuando sucede un evento.

  addObserver() y removeObserver() gestionan la lista de partículas que observan o escuchan.

  notify(const std::string& event) recorre la lista de observadores y llama a su método onNotify(). En este caso cada que presinamos una de las teclas ('s', 'a', 'r', 'n') actuan como disparador.

   La clase Observer es una interfaz (clase base abstracta) que define el método de notificación (onNotify).

  La clase Particle hereda de Observer e implementa onNotify(const std::string& event).

**Función en el código:** Cuando presionamos una de las teclas ('s', 'a', 'r', 'n'), el objeto ofApp (el Sujeto) notifica a todas las partículas (los Observadores) sobre el evento (por ejemplo, "attract", "repel"). Cada partícula responde al evento cambiando su propio estado interno (por ejemplo, a AttractState o RepelState).

- ¿Qué hace el patrón factory en este caso?

  El patrón Factory Method es por decirlo asi una fabrica para crear objetos en una clase padre, pero permite a las clases hijas alterar el tipo de objetos que se crearán. 

  Fábrica: La clase ParticleFactory con  createParticle(const std::string& type).

**Función en el código:** Hace menos desorganizado la creación de diferentes tipos de partículas ("star", "shooting_star", "planet"). La fábrica se encarga de instanciar un objeto base (new Particle()) y luego personalizar sus propiedades iniciales (tamaño, color, velocidad) basándose en el argumento type.


- ¿Qué hace el patrón state en este caso?

  El patrón State  permite que un objeto altere su comportamiento cuando su estado interno cambia.

  Contexto: La clase Particle tiene una referencia al objeto de estado actual (State* state).

  State: La clase abstracta State y sus usos (NormalState, AttractState, RepelState, StopState).

**Función en el código:** Define los diferentes comportamientos que una partícula puede tener.

  Cuando la partícula está en NormalState, simplemente va parchadita por ahi.

  En AttractState o RepelState, es  atraída o repelida por la posición del mouse.

  En StopState, se detienen las bolitas.

Experimenta con el código y realiza algunas modificaciones para entender mejor su funcionamiento. Por ejemplo:

- Adiciona un nuevo tipo de partícula.
    Añadi un nuevo tipo de particula llamado "comet". Su tamaño varia de 1 a 3, es de colores randoms y se mueve mas rapido o mas lento.
  <img width="631" height="444" alt="image" src="https://github.com/user-attachments/assets/9bb00c3c-5070-46c6-8d27-7f6f22631393" />
```cpp
	} else if (type == "comet") {
		particle->size = ofRandom(1, 3);
		particle->color = ofColor(ofRandom(0, 255), ofRandom(0, 255), ofRandom(0, 255)); // Color verde/azulado
		particle->velocity *= 4.0; 
	}
```
- Adiciona un nuevo estado. Modifica el comportamiento de las partículas.


```cpp
  
class WarpState : public State {
public:
	void update(Particle * particle) override;

};

```

```cpp
void WarpState::update(Particle * particle) {
	particle->position.x += ofRandom(-5, 5); 
	particle->position.y += ofRandom(-5, 5);
}
```

  Añadi un estado que se llama "warp", este hace que las particulas se muevan menos por la panatlla pero hace que se sacudan erraticamente.
    
- Crea otros eventos para notificar a las partículas.
    Cada que se presiona la tecla w se activa el estado de warp.
```cpp
  } else if (key == 'w') { 
	notify("warp");
}
```

## RETO
**Idea:** un sistema de ondas que se comporta distinto según su “estado emocional”:


- **CalmState:** ondas suaves y lentas.


- **ChaosState:** ondas turbulentas y con ruido.


- **PulseState:** ondas que responden al movimiento del mouse o clics.

Cada vez que el usuario interactue con el sistema las ondas tendran diferentes estilos visuales, generados por una Factory (líneas, puntos, curvas).
**Cómo aplicaria los patrones¿¿**

**Observer:**

	InputSubject notifica a los observadores (las ondas y el gestor de estado) cuando el usuario mueva el mouse o haga clic.

	Así el input está desacoplado de la lógica de las ondas.

**Factory:**

	WaveFactory crea distintos tipos de ondas (LineWave, DotWave, CurveWave).

	Permite que el sistema sea extensible sin modificar código existente.

**State:**

	CalmState, ChaosState, PulseState implementan el comportamiento dinámico de las ondas.

	El estado se cambia desde los eventos observados.




### OfApp.cpp ###

```cpp
#include "ofApp.h"

// ----------------------------------------------------
// STATE IMPLEMENTATIONS
// ----------------------------------------------------

// Calm: ondas suaves
void CalmState::update(Wave* wave, float time){
    wave->amplitude = ofLerp(wave->amplitude, 50, 0.02);
    wave->frequency = ofLerp(wave->frequency, 0.005, 0.02);
}

// Chaos: alta frecuencia y ruido
void ChaosState::update(Wave* wave, float time){
    wave->amplitude = ofNoise(time) * 200;
    wave->frequency = 0.02 + ofNoise(time * 2) * 0.03;
}

// Pulse: responde al tiempo
void PulseState::update(Wave* wave, float time){
    wave->amplitude = 80 + sin(time * 5) * 50;
    wave->frequency = 0.015 + 0.005 * sin(time * 3);
}

// ----------------------------------------------------
// APP
// ----------------------------------------------------
void ofApp::setup(){
    ofBackground(10);
    ofSetFrameRate(60);
    ofSetCircleResolution(80);

    // Creamos 3 tipos de ondas usando la Factory
    waves.push_back(WaveFactory::createWave(LINE));
    waves.push_back(WaveFactory::createWave(DOT));
    waves.push_back(WaveFactory::createWave(CURVE));

    // Las registramos como observadores
    for(auto* w : waves) addObserver(w);
}

void ofApp::update(){
    float t = ofGetElapsedTimef();
    for(auto* w : waves) w->update(t);
}

void ofApp::draw(){
    for(auto* w : waves) w->draw();

    // UI
    ofDrawBitmapStringHighlight("Press any key → Calm waves", 20, 20);
    ofDrawBitmapStringHighlight("Move mouse → Pulse waves", 20, 40);
    ofDrawBitmapStringHighlight("Click → Chaos waves", 20, 60);
    ofDrawBitmapStringHighlight("Current FPS: " + ofToString(ofGetFrameRate(), 0), 20, 80);
}

void ofApp::mousePressed(int x, int y, int button){ notify("mousePressed"); }
void ofApp::mouseMoved(int x, int y ){ notify("mouseMoved"); }
void ofApp::keyPressed(int key){ notify("keyPressed"); }

```

### OfApp.h ###

```h
#pragma once
#include "ofMain.h"

// ----------------------------------------------------
// OBSERVER PATTERN
// ----------------------------------------------------
class IObserver {
public:
    virtual void onNotify(const std::string& event) = 0;
};

class Subject {
protected:
    std::vector<IObserver*> observers;
public:
    void addObserver(IObserver* o){ observers.push_back(o); }
    void removeObserver(IObserver* o){
        observers.erase(std::remove(observers.begin(), observers.end(), o), observers.end());
    }
    void notify(const std::string& event){
        for(auto* o : observers) o->onNotify(event);
    }
};

// ----------------------------------------------------
// STATE PATTERN
// ----------------------------------------------------
class Wave; // forward declaration

class WaveState {
public:
    virtual ~WaveState() = default;
    virtual void update(Wave* wave, float time) = 0;
    virtual std::string name() const = 0;
};

class CalmState : public WaveState {
public:
    void update(Wave* wave, float time) override;
    std::string name() const override { return "Calm"; }
};

class ChaosState : public WaveState {
public:
    void update(Wave* wave, float time) override;
    std::string name() const override { return "Chaos"; }
};

class PulseState : public WaveState {
public:
    void update(Wave* wave, float time) override;
    std::string name() const override { return "Pulse"; }
};

// ----------------------------------------------------
// WAVE CLASS
// ----------------------------------------------------
class Wave : public IObserver {
public:
    ofColor color;
    float amplitude, frequency;
    WaveState* state;
    int styleType; // para diferenciar visualmente los tipos creados por la Factory

    Wave(): amplitude(100), frequency(0.01f), state(nullptr), styleType(0) {
        color = ofColor::fromHsb(ofRandom(255), 200, 255);
    }

    void setState(WaveState* newState){
        if(state) delete state;
        state = newState;
    }

    void update(float time){
        if(state) state->update(this, time);
    }

    void draw(){
        ofNoFill();
        ofSetColor(color);
        ofSetLineWidth(2);

        // Visual diferente según el estilo generado por la Factory
        if(styleType == 0){ // Línea simple
            ofBeginShape();
            for(int x = 0; x < ofGetWidth(); x++){
                float y = ofGetHeight()/2 + sin(x * frequency + ofGetElapsedTimef()) * amplitude;
                ofVertex(x, y);
            }
            ofEndShape();
        }
        else if(styleType == 1){ // Puntos
            for(int x = 0; x < ofGetWidth(); x+=5){
                float y = ofGetHeight()/2 + sin(x * frequency + ofGetElapsedTimef()) * amplitude;
                ofDrawCircle(x, y, 1.5);
            }
        }
        else if(styleType == 2){ // Curva irregular
            ofBeginShape();
            for(int x = 0; x < ofGetWidth(); x+=3){
                float noise = ofNoise(x * 0.01, ofGetElapsedTimef()) * 50;
                float y = ofGetHeight()/2 + sin(x * frequency + ofGetElapsedTimef()) * amplitude + noise;
                ofVertex(x, y);
            }
            ofEndShape();
        }
    }

    void onNotify(const std::string& event) override {
        if(event == "mousePressed") setState(new ChaosState());
        else if(event == "mouseMoved") setState(new PulseState());
        else if(event == "keyPressed") setState(new CalmState());
    }
};

// ----------------------------------------------------
// FACTORY PATTERN
// ----------------------------------------------------
enum WaveType { LINE, DOT, CURVE };

class WaveFactory {
public:
    static Wave* createWave(WaveType type){
        Wave* w = new Wave();
        w->styleType = static_cast<int>(type);
        if(type == DOT) w->color.setSaturation(255);
        if(type == CURVE) w->color.setHue(ofRandom(255));
        w->setState(new CalmState());
        return w;
    }
};

// ----------------------------------------------------
// MAIN APPLICATION
// ----------------------------------------------------
class ofApp : public ofBaseApp, public Subject {
public:
    std::vector<Wave*> waves;

    void setup() override;
    void update() override;
    void draw() override;

    void mousePressed(int x, int y, int button) override;
    void mouseMoved(int x, int y ) override;
    void keyPressed(int key) override;
};

```

**RESULTADO VIDEO**


https://youtu.be/-jwHAJAK9Y0


**NOTAS**


Corregi la apmlitud que tiene la onda line para que asi no se combine con la de dot y se puedan diferenciar las tres :)

**Reto del profe**


profe casi me cuelgo pero para hacer que solo uno recibiera los cambios hice esto 
| Línea                                | Descripción                                       |
| ------------------------------------ | ------------------------------------------------- |
| `WaveType type;`                     | Nueva variable para saber si es LINE, DOT o CURVE |
| `if(type != DOT) return;`            | Ignora los eventos si no es DOT                   |
| `w->type = type;`                    | La Factory asigna el tipo real                    |
| `if(w->type == DOT) addObserver(w);` | Solo las DOT se suscriben                         |


off.h

```cpp
#pragma once
#include "ofMain.h"

// ----------------------------------------------------
// OBSERVER PATTERN
// ----------------------------------------------------
class IObserver {
public:
	virtual void onNotify(const std::string & event) = 0;
};

class Subject {
protected:
	std::vector<IObserver *> observers;

public:
	void addObserver(IObserver * o) { observers.push_back(o); }
	void removeObserver(IObserver * o) {
		observers.erase(std::remove(observers.begin(), observers.end(), o), observers.end());
	}
	void notify(const std::string & event) {
		for (auto * o : observers)
			o->onNotify(event);
	}
};

// ----------------------------------------------------
// STATE PATTERN
// ----------------------------------------------------
class Wave; 

class WaveState {
public:
	virtual ~WaveState() = default;
	virtual void update(Wave * wave, float time) = 0;
	virtual std::string name() const = 0;
};

class CalmState : public WaveState {
public:
	void update(Wave * wave, float time) override;
	std::string name() const override { return "Calm"; }
};

class ChaosState : public WaveState {
public:
	void update(Wave * wave, float time) override;
	std::string name() const override { return "Chaos"; }
};

class PulseState : public WaveState {
public:
	void update(Wave * wave, float time) override;
	std::string name() const override { return "Pulse"; }
};

// ----------------------------------------------------
// WAVE CLASS
// ----------------------------------------------------
enum WaveType { LINE,
	DOT,
	CURVE }; 
class Wave : public IObserver {
public:
	ofColor color;
	float amplitude, frequency;
	WaveState * state;
	int styleType;
	WaveType type; 

	Wave()
		: amplitude(100)
		, frequency(0.01f)
		, state(nullptr)
		, styleType(0)
		, type(LINE) {
		color = ofColor::fromHsb(ofRandom(255), 200, 255);
	}

	void setState(WaveState * newState) {
		if (state) delete state;
		state = newState;
	}

	void update(float time) {
		if (state) state->update(this, time);
	}

	void draw() {
		ofNoFill();
		ofSetColor(color);
		ofSetLineWidth(2);

		
		if (styleType == 0) { // Línea simple
			ofBeginShape();
			for (int x = 0; x < ofGetWidth(); x++) {
				float y = ofGetHeight() / 2 + sin(x * frequency + ofGetElapsedTimef()) * amplitude;
				ofVertex(x, y);
			}
			ofEndShape();
		} else if (styleType == 1) { // Puntos
			for (int x = 0; x < ofGetWidth(); x += 5) {
				float y = ofGetHeight() / 2 + sin(x * frequency + ofGetElapsedTimef()) * amplitude;
				ofDrawCircle(x, y, 1.5);
			}
		} else if (styleType == 2) { // Curva irregular
			ofBeginShape();
			for (int x = 0; x < ofGetWidth(); x += 3) {
				float noise = ofNoise(x * 0.01, ofGetElapsedTimef()) * 50;
				float y = ofGetHeight() / 2 + sin(x * frequency + ofGetElapsedTimef()) * amplitude + noise;
				ofVertex(x, y);
			}
			ofEndShape();
		}
	}

	void onNotify(const std::string & event) override {
		if (type != DOT) return; 
		if (event == "mousePressed")
			setState(new ChaosState());
		else if (event == "mouseMoved")
			setState(new PulseState());
		else if (event == "keyPressed")
			setState(new CalmState());
	}
};

// ----------------------------------------------------
// FACTORY PATTERN
// ----------------------------------------------------
class WaveFactory {
public:
	static Wave * createWave(WaveType type) {
		Wave * w = new Wave();
		w->styleType = static_cast<int>(type);
		w->type = type; 
		if (type == DOT) w->color.setSaturation(255);
		if (type == CURVE) w->color.setHue(ofRandom(255));
		w->setState(new CalmState());
		return w;
	}
};

// ----------------------------------------------------
// MAIN APPLICATION
// ----------------------------------------------------
class ofApp : public ofBaseApp, public Subject {
public:
	std::vector<Wave *> waves;

	void setup() override;
	void update() override;
	void draw() override;

	void mousePressed(int x, int y, int button) override;
	void mouseMoved(int x, int y) override;
	void keyPressed(int key) override;
};

```

off.cpp


```cpp
#include "ofApp.h"

// ----------------------------------------------------
// STATE IMPLEMENTATIONS
// ----------------------------------------------------

// Calm: ondas suaves
void CalmState::update(Wave * wave, float time) {
	wave->amplitude = ofLerp(wave->amplitude, 50, 0.02);
	wave->frequency = ofLerp(wave->frequency, 0.005, 0.02);
}

// Chaos: alta frecuencia y ruido
void ChaosState::update(Wave * wave, float time) {
	wave->amplitude = ofNoise(time) * 200;
	wave->frequency = 0.02 + ofNoise(time * 2) * 0.03;
}

// Pulse: responde al tiempo
void PulseState::update(Wave * wave, float time) {
	wave->amplitude = 80 + sin(time * 5) * 50;
	wave->frequency = 0.015 + 0.005 * sin(time * 3);
}

// ----------------------------------------------------
// APP
// ----------------------------------------------------
void ofApp::setup() {
	ofBackground(10);
	ofSetFrameRate(60);
	ofSetCircleResolution(80);


	waves.push_back(WaveFactory::createWave(LINE));
	waves.push_back(WaveFactory::createWave(DOT));
	waves.push_back(WaveFactory::createWave(CURVE));

	for (auto * w : waves) {
		if (w->type == DOT)
			addObserver(w);
	}
}

void ofApp::update() {
	float t = ofGetElapsedTimef();
	for (auto * w : waves)
		w->update(t);
}

void ofApp::draw() {
	for (auto * w : waves)
		w->draw();

	// UI
	ofDrawBitmapStringHighlight("Press any key → Calm (only DOT reacts)", 20, 20);
	ofDrawBitmapStringHighlight("Move mouse → Pulse (only DOT reacts)", 20, 40);
	ofDrawBitmapStringHighlight("Click → Chaos (only DOT reacts)", 20, 60);
	ofDrawBitmapStringHighlight("Current FPS: " + ofToString(ofGetFrameRate(), 0), 20, 80);
}

void ofApp::mousePressed(int x, int y, int button) { notify("mousePressed"); }
void ofApp::mouseMoved(int x, int y) { notify("mouseMoved"); }
void ofApp::keyPressed(int key) { notify("keyPressed"); }

```
profe no se ve pero la verde es la unica que reacciona


<img width="1025" height="769" alt="image" src="https://github.com/user-attachments/assets/5ee79cd7-3087-4202-8239-52ce9a117814" />



profe pq me puso ese reto 😭😭😭😭😭

<img width="236" height="253" alt="image" src="https://github.com/user-attachments/assets/4781126c-ffb7-47b8-9eca-ab4e57ee69f7" />

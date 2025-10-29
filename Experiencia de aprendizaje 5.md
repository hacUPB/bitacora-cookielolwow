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
- 
## Exploración de métodos virtuales
¿En qué parte de la memoria se encuentran las vtable de cada objeto?
- EL vtable esta en la memoria global.
<img width="510" height="61" alt="image" src="https://github.com/user-attachments/assets/0129c365-6bb2-476b-afff-eccfcf25b9ae" />

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


### **Reflexión individual:**


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

<img width="785" height="68" alt="image" src="https://github.com/user-attachments/assets/ed74a284-178a-42c8-bae6-32d0a69a81a2" />


  
### Hagamos un poco de hackers y rompamos el encapsulamiento

**Antes**


<img width="407" height="23" alt="image" src="https://github.com/user-attachments/assets/eb800bc0-94a1-4dc5-b075-78a0b5fc881a" />

**Despúes**


<img width="325" height="62" alt="image" src="https://github.com/user-attachments/assets/c43fb644-14b7-419a-a39f-2f5b9b25c809" />

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


<img width="623" height="76" alt="image" src="https://github.com/user-attachments/assets/f2e448a7-7c09-4a38-9c83-96bd0bb5783e" />


¿Cómo se organizan los atributos en memoria?

- Cuando una clase hereda de otra, los atributos de la clase base se guardan primero, y después siguen los de la clase derivada. Es como si el objeto derivado “contuviera” la parte base más su propia parte.

¿Qué sucede si agregamos más niveles de herencia?
- Se va acumulando. Cada nivel agrega sus propios atributos después de los de la clase padre. Eso quiere decir que un objeto con herencia múltiple o con varias capas de herencia puede crecer bastante en memoria.

Prompt para ChatGPT: explícame cómo se organiza en memoria un objeto de una clase derivada en C++. ¿Cómo se almacenan los atributos de la clase base y de la derivada?

### Polimorfismo y Vtables en detalle

<img width="389" height="75" alt="image" src="https://github.com/user-attachments/assets/165e3a6e-1b24-4b25-881f-7aeeb77b1258" />

1. Analizar con un depurador: observa cómo se resuelven las llamadas a makeSound() en tiempo de ejecución.

   
    ¿Cómo utiliza el programa las vtables para el polimorfismo?
    - Cada objeto con métodos virtuales guarda un puntero oculto a una vtable. Esa vtable tiene las direcciones de las funciones que corresponden al tipo real del objeto. Cuando llamo un método virtual desde un puntero a la clase base, el programa va a la vtable para decidir qué función ejecutar. Por eso un Dog hace bark y un Cat hace meow, aunque los llame desde un Animal*.

    ¿Cuál es el impacto en el rendimiento?
    - al impacto en el rendimiento del polimorfismo, entendí que sí existe un pequeño costo porque cada vez que se llama a un método virtual el programa no va directo a la función, sino que primero consulta la vtable para saber a dónde saltar. Eso significa que hay una especie de “paso intermedio” en cada llamada, lo que lo hace un poco más lento que una función normal.

Prompt para ChatGPT: ¿Cómo funciona el polimorfismo en C++ a nivel interno? Explica cómo se utilizan las vtables para resolver métodos virtuales en una jerarquía de herencia.
- Cuando me puse a revisar cómo funciona el polimorfismo en C++ por dentro, entendí que todo gira alrededor de las vtables. Cada clase que tiene métodos virtuales guarda una tabla (la vtable) que básicamente es una lista de punteros a las funciones correspondientes.

    Cuando yo creo un objeto de una clase con herencia polimórfica, ese objeto lleva un puntero oculto llamado vptr, que apunta a la vtable de su clase real. Entonces, cuando llamo a un método virtual a través de un puntero o referencia de la clase base, el programa no va directo a la función, sino que usa ese vptr para buscar en la vtable cuál implementación ejecutar.


### Reflexión Individual:
- En esta sesión me di cuenta de que el encapsulamiento no es una barrera física sino una regla del compilador. Los datos privados siguen estando en memoria y es posible leerlos con punteros, aunque no sea seguro. También entendí que en herencia los atributos se organizan de forma lineal (primero los de la base, luego los de la derivada), y que el polimorfismo funciona gracias a las vtables que guardan las direcciones de los métodos correctos en tiempo de ejecución.


    Encapsulamiento → protege la lógica, pero depende de que los programadores respetemos las reglas.

    Herencia → se refleja directamente en cómo se apilan los datos en memoria.

    Polimorfismo → se hace posible gracias a un mecanismo interno (vtable) que conecta cada objeto con su comportamiento real.

    Esto me ayuda a entender que C++ me da poder y flexibilidad, pero también mucha responsabilidad en cómo uso la memoria y diseño las clases.
# RETO

CODIGOS 
```c++
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
	ofSetWindowShape(800, 400);
	ofSetBackgroundColor(30, 100, 150);
	ofSetFrameRate(60);

	t = 0.0f;
	frames = 120;

	baseY.clear();
	for (int y = 0; y < ofGetHeight(); y += 5) {
		baseY.push_back((float)y);
	}

	// Empezar con una SimpleWave por defecto
	waveStack.push(std::make_unique<SimpleWave>(8.0f, 0.03f, 0.0f, 1.0f));
}

//--------------------------------------------------------------
void ofApp::update() {
	t += 1.0f / frames;
	if (t > 10000.0f) {
		t = fmod(t, 1000.0f);
	}
}

//--------------------------------------------------------------
void ofApp::draw() {
	// Fondo semitransparente para estela
	ofSetColor(30, 100, 150, 20);
	ofDrawRectangle(0, 0, ofGetWidth(), ofGetHeight());

	const auto & waves = waveStack.getWaves();

	for (auto y : baseY) {
		float hue = ofMap(sinf((t * TWO_PI + y) * 0.01f), -1.0f, 1.0f, 160, 200);
		float bri = ofMap(cosf((t * TWO_PI + y) * 0.008f), -1.0f, 1.0f, 60, 100);
		ofSetColor(ofColor::fromHsb((int)hue, 200, (int)bri));

		ofBeginShape();
		for (int x = 0; x < ofGetWidth(); x += 5) {
			float baseWave = sinf(t * TWO_PI + x * 0.03f + y * 0.01f) * 10.0f;
			float stacked = 0.0f;

			for (const auto & wptr : waves) {
				stacked += wptr->sample((float)x, (float)y, t * TWO_PI);
			}

			float extraWave = stacked;
			ofVertex(x, y + baseWave + extraWave);
		}
		ofEndShape();
	}
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
	if (key == 'a') {
		addRandomWave();
	} else if (key == 'd') {
		waveStack.pop();
	} else if (key == 'r') {
		waveStack.clear();
	}
}

//--------------------------------------------------------------
void ofApp::addRandomWave() {
	if (ofRandom(1.0f) < 0.5f) {
		// SimpleWave aleatoria
		float amp = ofRandom(5.0f, 20.0f);
		float freq = ofRandom(0.01f, 0.06f);
		float phase = ofRandom(0.0f, TWO_PI);
		float speed = ofRandom(0.2f, 2.0f);
		waveStack.push(std::make_unique<SimpleWave>(amp, freq, phase, speed));
	} else {
		// NoiseWave aleatoria
		float amp = ofRandom(2.0f, 10.0f);
		float scale = ofRandom(0.05f, 0.2f);
		float speed = ofRandom(0.5f, 2.0f);
		waveStack.push(std::make_unique<NoiseWave>(amp, scale, speed));
	}
}


```


```C++
#pragma once
#include "ofMain.h"
class Wave {
public:
	virtual ~Wave() = default;

	virtual float sample(float x, float baseY, float t) const = 0;

	virtual float amplitude() const = 0;
};
class SimpleWave : public Wave {
private:
	float _amplitude;
	float _frequency;
	float _phase;
	float _speed;

public:
	SimpleWave(float amplitude = 10.0f, float frequency = 0.03f, float phase = 0.0f, float speed = 1.0f)
		: _amplitude(amplitude)
		, _frequency(frequency)
		, _phase(phase)
		, _speed(speed) {
	}

	float sample(float x, float baseY, float t) const override {
		float phaseNow = _phase + t * _speed;
		return sinf(x * _frequency + baseY * 0.01f + phaseNow) * _amplitude;
	}

	float amplitude() const override { return _amplitude; }

	void setAmplitude(float a) { _amplitude = a; }
	void setFrequency(float f) { _frequency = f; }
	void setPhase(float p) { _phase = p; }
	void setSpeed(float s) { _speed = s; }
};
class NoiseWave : public Wave {
private:
	float _amplitude;
	float _scale; // escala espacial
	float _speed; // velocidad de cambio temporal

public:
	NoiseWave(float amplitude = 5.0f,
		float scale = 0.1f,
		float speed = 1.0f)
		: _amplitude(amplitude)
		, _scale(scale)
		, _speed(speed) { }

	float sample(float x, float baseY, float t) const override {
		// Usamos ofNoise de openFrameworks
		float nx = x * _scale;
		float ny = baseY * _scale;
		float nt = t * _speed;
		float noiseVal = ofNoise(nx, ny, nt); // [0,1]
		float shifted = (noiseVal - 0.5f) * 2.0f; // [-1,1]
		return shifted * _amplitude;
	}

	float amplitude() const override {
		return _amplitude;
	}

	void setAmplitude(float a) { _amplitude = a; }
	void setScale(float s) { _scale = s; }
	void setSpeed(float s) { _speed = s; }
};

class WaveStack {
private:
	std::vector<std::unique_ptr<Wave>> waves;

public:
	WaveStack() = default;
	~WaveStack() = default;

	void push(std::unique_ptr<Wave> w) {
		waves.push_back(std::move(w));
	}

	void pop() {
		if (!waves.empty()) waves.pop_back();
	}

	void clear() {
		waves.clear();
	}

	float totalAmplitude() const {
		float s = 0;
		for (const auto & w : waves)
			s += w->amplitude();
		return s;
	}

	const std::vector<std::unique_ptr<Wave>> & getWaves() const { return waves; }
	size_t size() const { return waves.size(); }
};


class ofApp : public ofBaseApp {
public:
	void setup() override;
	void update() override;
	void draw() override;
	void keyPressed(int key) override;

private:
	float t; // tiempo normalizado
	int frames;
	std::vector<float> baseY;
	WaveStack waveStack;

	void addRandomWave(); // auxiliar para agregar onda aleatoria
};

```

## Pruebas


<img width="838" height="451" alt="image" src="https://github.com/user-attachments/assets/3fc1daac-afa5-40aa-936a-205a89ebe143" />


## RAE 1

<img width="791" height="409" alt="image" src="https://github.com/user-attachments/assets/c77e6152-184f-414f-856b-23f45a42537e" />


- Para agregar nuevas olas se usa la tecla a, esto modifica el patron con las noisy waves. 

<img width="776" height="405" alt="image" src="https://github.com/user-attachments/assets/1d2fd854-6888-42e3-96c6-de972f2e1e58" />

-  Para eliminar olas se usa la tecla d, esto ajusta el comportamiento

<img width="773" height="398" alt="image" src="https://github.com/user-attachments/assets/c87808fb-46fb-4bfa-a6be-585c1f5522ba" />

- Para borrar todas las olas se usa la tecla r, esto muestra e sistema limpio.

**Resultado final**




https://github.com/user-attachments/assets/d4f5af8f-96a9-46c7-9b00-4343ea7744a8



## RAE 2
<img width="403" height="147" alt="image" src="https://github.com/user-attachments/assets/57d7f1bc-aeac-4798-8eb6-f00f24c3d1a1" />


Durante la prueba de la pila de ondas (WaveStack) presioné las teclas configuradas:

- Con la tecla a agregué ondas nuevas y se volvian "noisy" . En la consola aparecieron mensajes confirmando el push con la amplitud de la onda y el tamaño actualizado de la pila.
- Con la tecla d eliminé la última onda agregada (pop). En la consola apareció el mensaje con la amplitud eliminada y el tamaño de la pila después de la operación. 
- Con la tecla r limpié toda la pila (clear). En la consola se imprimió el número total de ondas eliminadas y en la aplicación quedó solo la onda base.

  
En este proyecto, implementé el concepto de polimorfismo con la clae padre "Wave" que declara métodos virtuales puros como sample() y amplitude(). Luego, creé clases hijas de esta ( SimpleWave y NoiseWave), cada una con su propia implementación de estos métodos. Gracias al polimorfismo, cada tipo de onda respondió de manera adecuada a la llamada al método sample().


 Reducir llamadas de dibujo innecesarias:
- Dibujar menos vértices o reducir la resolución de las ondas (por ejemplo, aumentar el paso de x += 5 a x += 10) baja la carga en la GPU sin perder demasiado en lo visual.

Evitar cálculos repetidos:
- Precalcular valores que no cambian en cada frame (como posiciones base en Y) y solo recalcular lo que depende del tiempo.



En Visual Studio se puede medir el uso de memoria para ver si los cambios realmente afectan al rendimiento.

<img width="1181" height="500" alt="image" src="https://github.com/user-attachments/assets/f89f47a7-28cf-43b0-bb1c-ec18a2213230" />


Al aumentar la amplitud de las olas, el rendimiento seguia igual y no se veia afectado.

# Investigación
## Actividad 1
- ¿Qué son los vértices?
  - Los vértices son como los puntos base de una figura. Son coordenadas que marcan las esquinas o posiciones clave de un objeto 3D.
- ¿Con qué figura geométrica se dibuja en 3D?
  -  En 3D casi todo se construye con triángulos. La razón es que un triángulo es la figura más simple posible y siempre está en un mismo plano, lo que hace que los cálculos sean más rápidos y estables para la GPU.
- ¿Qué es un shader?
  - Un shader es un mini programa que corre dentro de la GPU. Se encarga de decirle a la tarjeta gráfica cómo debe dibujar o cómo debe verse algo en la pantalla, por ejemplo, el color, la iluminación o los efectos visuales.
- ¿Cómo se le llaman a los grupos de píxeles de un mismo triángulo?
  - A esos grupos se les llama fragmentos.
- ¿Qué es un fragment shader?
  - Es el shader que trabaja en cada fragmento (o píxel) del dibujo.
- ¿Qué es un vertex shader?
  - Es el shader que trabaja con los vértices. Se encarga de transformar la posición de los puntos del modelo 3D (vértices) para ubicarlos correctamente en la pantalla.
- ¿Al proceso de determinar qué pixels del display va a cubrir cada triángulo de una mesh se le llama?
  - Ese proceso se llama rasterización.
- ¿Qué es el render pipeline?
  - Es toda la secuencia de pasos que sigue la GPU para dibujar algo. Va desde leer los vértices, pasarlos por los shaders, rasterizarlos y finalmente pintar los píxeles en la pantalla. Es como una cadena de producción de imágenes.
- ¿Hay alguna diferencia entre aplicar un color a una superficie de una mesh o aplicar una textura?
  - Sí. Aplicar un color significa darle un solo tono a toda la superficie, mientras que una textura es una imagen que se “pega” sobre el objeto, lo que permite que tenga más detalle, como madera, metal o piel.
- ¿Cuál es la diferencia entre una textura y un material?
  - Una textura es solo una imagen o patrón visual, mientras que un material es algo más completo: incluye las propiedades de cómo ese objeto reacciona a la luz (brillo, reflexión, transparencia, etc.), y puede usar varias texturas a la vez.
- ¿Qué transformaciones se requieren para mover un vértice del 3D world al View Screen?
  - Primero se aplica la transformación del modelo , luego la transformación de vista , y finalmente la proyección.
- ¿Al proceso de convertir los triángulos en fragmentos se le llama?
  - También se llama rasterización
- ¿Qué es el framebuffer?
  - El framebuffer es como una memoria temporal donde se guardan todos los píxeles que se van a mostrar en pantalla antes de que se actualice la imagen completa.
- ¿Para qué se usa el Z-buffer o depth buffer en el render pipeline?
  - Se usa para manejar la profundidad. Guarda qué tan lejos o cerca está cada píxel respecto a la cámara, así la GPU sabe qué objeto está delante de otro y puede dibujar correctamente sin que se mezclen.
- Luego de ver el segundo video entiendes por qué la GPU tiene que funcionar tan rápido y de manera paralela. ¿Por qué?
  - Porque la GPU no trabaja con un solo dato a la vez, sino con miles o millones de píxeles y vértices al mismo tiempo. Necesita hacer muchos cálculos en paralelo para que todo se vea fluido y en tiempo real, sobre todo en videojuegos, animaciones o simulaciones.
 ## Actividad 2
 **PRIMER EJEMPLO**


- ¿Cómo funciona?
  - El código lo que hace es cargar un shader y aplicarlo a un rectángulo que cubre toda la pantalla. En el draw(), empieza el shader, dibuja el rectángulo y luego lo cierra. Todo lo que se dibuja entre shader.begin() y shader.end() pasa por la GPU y se ve afectado por el shader.
  
- ¿Qué resultados obtuviste?
<img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/09c4befa-de8e-4059-b6f8-4037eb32d99c" />


<img width="200" height="200" alt="image" src="https://github.com/user-attachments/assets/83221da6-13c0-44b1-8902-498bae61b9dc" />

- ¿Estás usando un vertex shader?
  - Sí, se está usando un vertex shader.
- ¿Estás usando un fragment shader?
  - sí, se está usando un fragment shader.
- Analiza el código de los shaders. ¿Qué hace cada uno?
  - El vertex shader simplemente toma las coordenadas del rectángulo y las pasa al pipeline para que se dibujen donde deben estar. Es decir, solo posiciona los vértices. El fragment shader es el que define el color.


 **SEGUNDO EJEMPLO**
- ¿Cómo funciona?
  - Crea un plano en tres dimensiones en la mitad de la pantalla que de deforma con el shader. El color del plano cambia dependiendo de la posición del mouse en X (de magenta a cian) y la rotación del plano cambia con el mouse en Y.
- ¿Qué resultados obtuviste?
<img width="505" height="400" alt="image" src="https://github.com/user-attachments/assets/a4a2a0bb-ede9-4586-86e1-db3c6879de49" />

  
- ¿Estás usando un vertex shader?
  - Sí. El vertex shader se encarga de modificar la posición de cada vértice del plano.

- ¿Estás usando un fragment shader?
  - También. El fragment shader se encarga de calcular el color de cada fragmento (pixel) del plano.
- Analiza el código de los shaders. ¿Qué hace cada uno?
  - Vertex Shader: Usa la variable time para animar los vértices del plano.
  - Fragment Shader: Usa la variable globalColor que se envía automáticamente cuando se llama a ofSetColor().
**TERCER EJEMPLO**

- ¿Cómo funciona?
    - El programa crea una especie de plano que ocupa toda la pantalla y le aplica un shader. Ese shader hace que el plano cambie visualmente según donde muevas el mouse.
Básicamente, el código calcula la posición del mouse y el color que debería tener (entre morado y azul) y se lo manda al shader. Entonces, cuando uno mueve el mouse, el shader reacciona cambiando el color y generando un  efecto visual como de ojo de pescado en la posicion del mouse.
- ¿Qué resultados obtuviste?

  
  <img width="400" height="286" alt="image" src="https://github.com/user-attachments/assets/9a3924bc-8660-4592-bf67-4567d57c40f0" />


- ¿Estás usando un vertex shader?
    - Sí. Es el que se encarga de deformar el plano.
- ¿Estás usando un fragment shader?
    - Sí. Ese se encarga del color, hace que cambie entre morado y azul dependiendo de la posicion del mouse.
- Analiza el código de los shaders. ¿Qué hace cada uno?
    - El vertex shader edita el plano, deforma el plano con el cursor.
    - El fragment shader se encarga del color final que vemos en pantalla, y por eso es el que genera el cambio de color de un lado al otro.

```cpp
  
// color changes from magenta to blue when moving the mouse from left to right.
float percentX = mouseX / (float)ofGetWidth();
percentX = ofClamp(percentX, 0, 1);
ofFloatColor colorLeft = ofColor::magenta;
ofFloatColor colorRight = ofColor::blue;
ofFloatColor colorMix = colorLeft.getLerped(colorRight, percentX);
```

**CUARTO EJEMPLO**

- ¿Cómo funciona?
    - Se carga una imagen sobre un plano y el shader se encarga de seguir el movimiento del mouse para poder mover el plano o la imagen por decirlo asi.
      
- ¿Qué resultados obtuviste?

  <img width="490" height="467" alt="image" src="https://github.com/user-attachments/assets/a636d786-2224-4797-978f-cb1738cac7dc" />



- ¿Estás usando un vertex shader?
   - Sí, el código lo usa. Es la parte del shader que se encarga de crear los vertices para crear el plano
- ¿Estás usando un fragment shader?
   - Si, el fragment shader toma texturas de la imagen y decide como acomodar cada pedazo del plano.
   

**QUINTO EJEMPLO**

- ¿Cómo funciona?
    - Carga dos imagenes, una normal y otra que va a funcionar como mascara. Luego se usa un shader que las va a combinar como con el efecto de masking.
      
- ¿Qué resultados obtuviste?

<img width="392" height="296" alt="image" src="https://github.com/user-attachments/assets/c33329ad-1dc4-478e-8c19-856f469db3a0" />


- ¿Estás usando un vertex shader?
   - Si, su funcion en este caso es simplemente preparar vertices y coordenadas UV para que el fragment shader pueda apicar los efectos visuales.
- ¿Estás usando un fragment shader?
   - Si, este hace la parte visual. Combina la imagen con la mascara pixel por pixel de acuerdo a los valores del mask.
- Analiza el código de los shaders. ¿Qué hace cada uno?
    - El vertex shader procesa los vertices de la imagen, o sea los puntos que van a definir su posicion en pantalla.
```cpp

	// draw a white rectangle for background.
	ofDrawRectangle(0, 0, image.getWidth(), image.getHeight());
```
 - El fragment shader combino las imagenes con el efecto de masking. 
    
```cpp
shader.setUniformTexture("imageMask", imageMask.getTexture(), 1);
shader.setUniform2f("resolution", image.getWidth(), image.getHeight());

```
**SEXTO EJEMPLO**

- ¿Cómo funciona?
    - Tenemos una camara, una imagen y un video. Y luego usando un shader con una mascara se combinan los tres. La mascara se mueve con la posicion del mouse y el shader se encarga de mezclar las tres texturas según los valores RGB de la mascara, o sea dependiando del color de cada zona de la mascara.
      
- ¿Qué resultados obtuviste?

<img width="638" height="749" alt="image" src="https://github.com/user-attachments/assets/19e7a130-916f-4048-be3f-c2c22759bd56" />


- ¿Estás usando un vertex shader?
 	- SI, pero nuevamente para manejar las coordenadas y pasar esta información al fragment shader.
- ¿Estás usando un fragment shader?
	 - SI, este decide el color de cada pixel en vase a las texturas y la mascara.

- Analiza el código de los shaders. ¿Qué hace cada uno?
	- El vertex shader sirve como puente nada mas de las coordenadas.
    - Recibe las tres texturas (tex0, tex1, tex2) y la máscara (imageMask). Usa los canales R, G y B de la máscara para mezclar las imágenes.
      
**SEPTIMO EJEMPLO**

- ¿Cómo funciona?
    - Es un canva que va dibujando en tiempo real. En este caso, usamos un FBO  donde se va pintando con una brochita. Esa brocha puede ser normal o tipo borrador, y lo que dibuja sirve como una textura de máscara para combinar otras imágenes  dentro del shader.
      
- ¿Qué resultados obtuviste?

<img width="485" height="363" alt="image" src="https://github.com/user-attachments/assets/2de2188f-b8d9-4c7a-bf6e-3cc526e02d31" />


- ¿Estás usando un vertex shader?
 	- SI, lo mismo de procesar coordenadas.
- ¿Estás usando un fragment shader?
 	- SI, el fragment shader hace la mezcla visual.

- Analiza el código de los shaders. ¿Qué hace cada uno?
    - El vertex shader recibe la informacion de los vertices del plano y pasa las coordenadas al fragment shader.
	- El fragment shader combina las texturas usando la mascara. Toma el color de las texturas y decide el color que va ausar la brocha asi como pinturita.

   
**OCTAVO EJEMPLO**

- ¿Cómo funciona?
    - Es un plano que se arruga asi todo cool cuando mueves el mouse hacia la esquina superior derecha. Lo que pasa es que se genera un plano que se mueve con ruide de Perlin. Crea una imagen que los pixeles reciven un valor de ruido que cambia con el tiempo. 
      
      
- ¿Qué resultados obtuviste?

<img width="983" height="704" alt="image" src="https://github.com/user-attachments/assets/7ab5e628-3479-44bf-bf99-838f1f7e8fe5" />


- ¿Estás usando un vertex shader?
  	- Sí. Manipula la posicion de los vertices del plano, mueve la malla permitiendo que la superficie se mueva asi cool.
- ¿Estás usando un fragment shader?
 	-   Si, el fragment define el color de cada pixel.
- Analiza el código de los shaders. ¿Qué hace cada uno?
    - El vertex shader usa los valores de la textura para modificar los valores de la posicion en z para dar esa sensacion como de paño arrugado como por el relieve.
 
      
**NOVENO EJEMPLO**

- ¿Cómo funciona?
    - La misma imagen que llevamos usando le aplica un desenfoque, usa dos shaders para cada eje ( x & y).
- ¿Qué resultados obtuviste?

<img width="404" height="308" alt="image" src="https://github.com/user-attachments/assets/8d5079fd-7952-4954-af1a-8715d0898476" />


- ¿Estás usando un vertex shader?
	 - Si, lo usamos para manejar las coordenadas de los vertices y la imagen.
- ¿Estás usando un fragment shader?
 	-   SI, calcula el color de los pixeles simulando el bllur.
- Analiza el código de los shaders. ¿Qué hace cada uno?
    - El vertex shader recibe la informacion de los vertices del plano.
	- Segun yo, el fragment shader usa dos shaders. Primero el shaderBlurx que desenfoca horizontalmente. Y el shaderBlurY para desenfocar pero verticalmente.
## Actividad 3
- ¿Qué es un uniform?
	- Un uniform es una variable que le puedo enviar desde mi programa principal (C++) a los shaders, y su valor se mantiene igual durante toda la ejecución del shader mientras se dibuja. Es decir, no cambia por cada vértice o por cada píxel, sino que tiene el mismo valor para todos.
  
- ¿Cómo funciona el código de aplicación, los shaders y cómo se comunican estos?


	Básicamente todo parte desde el ofApp.cpp. Ahí se configuran las formas (como el plano) y se carga el shader con shader.load(). Luego, cuando se ejecuta shader.begin() y shader.end(), lo que se dibuje entre esas dos líneas pasa por los shaders (el vertex y el fragment).

	El vertex shader trabaja con cada vértice del plano (por ejemplo, moviéndolos con una onda usando sin(time)), y el fragment shader se encarga de cada píxel, decidiendo qué color tiene.

	Los dos shaders reciben la información que uno les pasa desde el código con shader.setUniform...(). Por ejemplo, si hago shader.setUniform1f("time", ofGetElapsedTimef());, le estoy mandando el tiempo al shader para que lo use en sus cálculos. Así es como se comunican.


- Modifica el código de la actividad para cambiar el color de cada uno de los píxeles de la pantalla personalizando el fragment shader.


<img width="1023" height="787" alt="image" src="https://github.com/user-attachments/assets/598212cd-70f8-4d7f-9ee2-69482f965acc" />


En esta parte modifiqué el fragment shader para que cambiara el color de cada píxel según su posición y el paso del tiempo. La idea era usar el uniforme time (que viene desde el programa principal) junto con las coordenadas del píxel (gl_FragCoord) para generar una animación de color en movimiento.

El shader quedó así:
```
#version 150

uniform float time;
uniform vec4 globalColor;

out vec4 outputColor;

void main()
{
    vec2 uv = gl_FragCoord.xy / vec2(1024.0, 768.0); // usa el tamaño de la ventana

    float wave = sin((uv.x + time * 0.5) * 6.2831) * 0.5 + 0.5;

    vec3 color = mix(vec3(uv.y, wave, 1.0 - uv.x), globalColor.rgb, 0.3);

    outputColor = vec4(color, 1.0);
}

```

Con este código, el color de cada píxel debería cambiar de forma continua creando un efecto tipo “ondas de color”.


## Actividad 4

<img width="826" height="649" alt="image" src="https://github.com/user-attachments/assets/ec0ef3fb-49e7-4261-8e28-dab4ea59804f" />

- ¿Qué hace el código del ejemplo?
	- El código hace que el plano cambie y se mueva según la posición del mouse. Cuando paso el cursor por encima, los vértices del plano se deforman un poco, como si se repelieran del mouse, y además el color va cambiando de magenta a azul dependiendo de dónde esté el cursor.
- ¿Cómo funciona el código de aplicación, los shaders y cómo se comunican estos?
  	- En el código principal se envían datos al shader, como la posición del mouse o los colores, y el shader usa esa información para modificar lo que se ve en pantalla. El vertex shader cambia la forma del plano, moviendo los puntos según la distancia al mouse, y el fragment shader cambia el color. Básicamente, el código y los shaders están conectados: uno manda los datos y los otros los usan para crear los efectos visuales.
- Realiza modificaciones a ofApp.cpp y al vertex shader para conseguir otros comportamientos.
- Realiza modificaciones al fragment shader para conseguir otros comportamientos.
<img width="829" height="616" alt="image" src="https://github.com/user-attachments/assets/b1d138f0-85f0-4faa-94ab-825e72ade994" />


Empecé modificando el archivo ofApp.cpp, donde mantuve la estructura principal del código, pero cambié el valor de mouseRange para hacerlo más amplio y que el efecto se notara a mayor distancia del cursor. También ajusté la forma en la que el color cambia: en lugar de depender de la posición horizontal del mouse, lo hice variar según su posición vertical. Así, al mover el cursor de abajo hacia arriba, el color del plano pasa de tonos amarillos a cian, creando una transición más llamativa y diferente a la original.

Luego pasé al vertex shader, donde quise alterar el comportamiento de los vértices. En el ejemplo original, los vértices se alejaban del mouse, generando un efecto de repulsión. Yo invertí esa lógica para que, en cambio, los vértices fueran atraídos hacia el cursor, como si el plano tuviera un movimiento de “succión” o respiración. Además, reduje un poco la fuerza de ese desplazamiento para que el efecto se sintiera más suave y fluido visualmente.

Finalmente, en el fragment shader probé algo más visual: añadí una variación de brillo en el color, haciendo que el tono se vuelva más intenso dependiendo de la posición del fragmento. Esto genera una especie de brillo dinámico sobre la superficie, que le da más vida al plano y hace que no se vea estático.

## Reto


Para esta actividad desarrollé una aplicación interactiva en openFrameworks que utiliza shaders para modificar una malla. La aplicación crea un plano lleno de vértices que se van deformando constantemente, generando un efecto de ondas y movimiento. Además, el movimiento del mouse influye sobre los vértices, haciendo que se eleven o bajen dependiendo de la distancia. Esto le da una sensación de interacción directa, como si el cursor “tocara” la superficie.



El fragment shader cambia los colores de cada parte del plano dependiendo de su posición y del tiempo, logrando un efecto de degradado dinámico que cambia lentamente mientras la aplicación corre. Cuando se acerca el mouse, los colores también se iluminan un poco más, simulando una luz suave sobre el área que uno toca.



![Grabación-2025-10-27-174522](https://github.com/user-attachments/assets/175ee3f4-63c6-4643-ba56-a633579249a6)


OfApp.h
```
#pragma once
#include "ofMain.h"

class ofApp : public ofBaseApp {
public:
	void setup() override;
	void update() override;
	void draw() override;

	void mouseMoved(int x, int y) override;
	void keyPressed(int key) override;

private:
	ofPlanePrimitive plane;
	ofVboMesh mesh; 
	ofShader shader;
	float timeSeconds = 0.0f;
	glm::vec2 mousePos = { 0.0f, 0.0f };
	bool useWireframe = false;
};

```
OfApp.cpp
```
#include "ofApp.h"

void ofApp::setup() {
	ofSetVerticalSync(true);
	ofDisableArbTex(); 
	ofBackground(10);

	//cpu a gpu
	float planeScale = 0.9f;
	int planeWidth = ofGetWidth() * planeScale;
	int planeHeight = ofGetHeight() * planeScale;
	int gridSize = 10; 
	int columns = planeWidth / gridSize;
	int rows = planeHeight / gridSize;

	plane.set(planeWidth, planeHeight, columns, rows, OF_PRIMITIVE_TRIANGLES);
	plane.setPosition(ofGetWidth() * 0.5f, ofGetHeight() * 0.5f, 0);
	mesh = plane.getMesh();


	if (ofIsGLProgrammableRenderer()) {
		shader.load("shadersGL3/shader.vert", "shadersGL3/shader.frag");
	} else {
		ofLogError() << "Se recomienda usar renderer programable (GL3).";
		shader.load("shadersGL2/shader"); 
	}
//cpu a gpu
	mousePos = glm::vec2(ofGetMouseX(), ofGetMouseY());
}

void ofApp::update() {
	timeSeconds = ofGetElapsedTimef();
}

void ofApp::draw() {
	ofEnableDepthTest();

	shader.begin();
// cpu a gpu
	shader.setUniform1f("uTime", timeSeconds);
	shader.setUniform2f("uResolution", ofGetWidth(), ofGetHeight());
	shader.setUniform2f("uMouse", mousePos);
	shader.setUniform1i("uWireframe", useWireframe ? 1 : 0);

	
	mesh.draw();
//cpu a gpu
	shader.end();

	ofDisableDepthTest();


	ofSetColor(255);
	ofDrawBitmapString("Move mouse to deform. Press 'w' to toggle wireframe. Press 's' to save screenshot.", 10, 20);
}


//cpu a gpu
void ofApp::mouseMoved(int x, int y) {
	mousePos = glm::vec2(x, y);
}
//cpu a la gpu
void ofApp::keyPressed(int key) {
	if (key == 'w') useWireframe = !useWireframe;
	if (key == 's') {
		std::string filename = "screenshot_" + ofGetTimestampString() + ".png";
		ofSaveScreen(filename);
		ofLogNotice() << "Saved " << filename;
	}
}

```

Vertex
```
#version 150
//Entrada
uniform mat4 modelViewProjectionMatrix;
in vec4 position;
in vec3 normal;
in vec2 texcoord;

out vec3 vNormal;
out vec2 vTexcoord;
out vec3 vPositionWorld;
//Los uniforms
uniform float uTime;
uniform vec2 uResolution;
uniform vec2 uMouse;
uniform int uWireframe;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

// Se crea el ruido
float noise(in vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    float a = hash(i + vec2(0.0,0.0));
    float b = hash(i + vec2(1.0,0.0));
    float c = hash(i + vec2(0.0,1.0));
    float d = hash(i + vec2(1.0,1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a)* u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

void main() {
 
    vNormal = normal;
    vTexcoord = texcoord;

   //Normaliza coordenadas del mouse y del vértice para tener valores entre -1 y 1.
    vec2 mouseN = (uMouse / uResolution) * 2.0 - 1.0; // -1..1
    vec2 posN = (position.xy / uResolution) * 2.0 - 1.0;

   //Calcula la distancia de los vertices al mouse
    float dist = length((position.xy / uResolution) - (uMouse / uResolution));

// Aca se crea la onda
    float freq = 6.0;
    float amp = 30.0; // amplitud en pixeles para la Z
    float wave = sin((position.x + position.y) * 0.01 * freq + uTime * 2.0) * 0.5;

  
    float n = noise(texcoord * 10.0 + vec2(uTime * 0.2));


    float mouseInfluence = exp(-dist * 12.0); // caida exponencial
// Se combina las olas y el ruido  para dar el efermo de deformación
    float zOffset = (wave * 0.6 + n * 0.4) * amp * (0.5 + mouseInfluence * 2.5);
    vec4 newPos = position;
    newPos.z += zOffset;

// Aca se crea el efecto de atraccion al mouse
    newPos.xy += (normalize(posN - mouseN) * mouseInfluence * 15.0) * 0.1;

    vPositionWorld = newPos.xyz;

    gl_Position = modelViewProjectionMatrix * newPos;
}

```

Frag
```
#version 150

in vec3 vNormal;
in vec2 vTexcoord;
in vec3 vPositionWorld;

out vec4 outputColor;

uniform float uTime;
uniform vec2 uResolution;
uniform vec2 uMouse;
uniform int uWireframe;

void main() {
 
    vec3 N = normalize(vNormal);

   
    float nY = (vPositionWorld.y + (uResolution.y * 0.5)) / uResolution.y; // 0..1
    float nX = (vPositionWorld.x + (uResolution.x * 0.5)) / uResolution.x; // 0..1

    vec3 colA = vec3(0.15, 0.45, 0.8); // azul
    vec3 colB = vec3(0.9, 0.45, 0.2);  // naranja
// Se crea el color base degradado que se ve al fondo
    vec3 base = mix(colA, colB, nY * 0.9 + 0.1 * sin(uTime));

// Esta es la iluminación basica que es frontal
    float light = clamp(dot(N, vec3(0.0, 0.0, 1.0)), 0.0, 1.0);
    vec3 color = base * (0.5 + light * 0.6);

  
    vec2 fragPos = (gl_FragCoord.xy / uResolution);
    vec2 mouseN = uMouse / uResolution;

  // iluminacion alrededor del mouse
    float dist = distance(fragPos, mouseN);
    float highlight = smoothstep(0.2, 0.0, dist); // 0..1
    color += vec3(1.0, 0.9, 0.6) * highlight * 0.4;

// Aca se muestra el wireframe
    if (uWireframe == 1) {
        
        vec2 f = fract(vTexcoord * 40.0);
        float line = step(0.02, min(f.x, f.y)) * step(0.02, min(1.0 - f.x, 1.0 - f.y));
        color *= mix(0.2, 1.0, line);
    }

    outputColor = vec4(color, 1.0);
}

```
En el código de ofApp, se manejan los uniformes del shader, se actualiza el tiempo y la posición del mouse, y se dibuja la malla con los efectos del vertex y fragment shader. También añadí la opción de presionar la tecla "w" para cambiar a un modo de tipo “wireframe”, donde se pueden ver las líneas de la malla, y "s" para guardar capturas de pantalla como evidencia.

**Pruebas en ofApp.cpp:**
- Primero verifiqué que la aplicación cargara bien los shaders y mostrara el plano. Después probé que el movimiento del mouse se detectara correctamente y que los uniformes se enviaran al shader. También revisé que las teclas "w" y "s" cumplieran su función, alternando el wireframe y guardando imágenes del resultado.

**Pruebas del vertex shader:**
- Aquí comprobé que los vértices realmente se deformaran. Para eso observé si el plano tenía movimiento ondulado y si se elevaba más en las zonas donde movía el mouse. Cuando la malla se movía con fluidez y respondía bien al cursor, supe que el vertex shader estaba funcionando.

**Pruebas del fragment shader:**
- En este caso, revisé que los colores cambiaran de manera progresiva con el tiempo y que se vieran más brillantes cerca del mouse. También cambié valores dentro del shader para ver el impacto de cada parámetro (por ejemplo, la intensidad del color o la distancia del brillo), comprobando que respondiera como esperaba.

**Pruebas del funcionamiento completo:**
- Finalmente, probé toda la aplicación ejecutándola varias veces y observando el comportamiento general. Revisé que no hubiera errores en la consola, que los FPS se mantuvieran estables y que el efecto visual se mantuviera sin cortes. La aplicación se comportó bien: los vértices se movían, los colores cambiaban suavemente y la interacción con el mouse era fluida.

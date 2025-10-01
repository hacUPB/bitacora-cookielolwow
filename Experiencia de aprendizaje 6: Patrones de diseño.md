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


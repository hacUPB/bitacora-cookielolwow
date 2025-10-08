´´´cpp
// ofApp.h
#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);
    void mousePressed(int x, int y, int button);

    void convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd);
    bool rayIntersectsSphere(const glm::vec3& rayStart, const glm::vec3& rayDir, const glm::vec3& sphereCenter, float sphereRadius, glm::vec3& intersectionPoint);

    // Datos
    vector<glm::vec3> spherePositions;
    glm::vec3 selectedSphere;
    bool sphereSelected = false;

    // Parámetros controlables
    int xStep = 80;
    int yStep = 80;
    float distDiv = 100.0f;
    float amplitud = 100.0f;

    // Cámara
    ofEasyCam cam;
};

´´´cpp
// ofApp.cpp
#include "ofApp.h"

void ofApp::setup() {
    ofBackground(0);
    ofEnableDepthTest();
    
    // Generar posiciones iniciales
    spherePositions.clear();
    for (int x = -ofGetWidth() / 2; x < ofGetWidth() / 2; x += xStep) {
        for (int y = -ofGetHeight() / 2; y < ofGetHeight() / 2; y += yStep) {
            float z = cos(ofDist(x, y, 0, 0) / distDiv) * amplitud;
            spherePositions.push_back(glm::vec3(x, y, z));
        }
    }
}

void ofApp::update() {}

void ofApp::draw() {
    cam.begin();

    for (auto& pos : spherePositions) {
        if (sphereSelected && pos == selectedSphere) {
            ofSetColor(255, 0, 0); // resaltada
            ofDrawSphere(pos, 8);
        } else {
            ofSetColor(200);
            ofDrawSphere(pos, 5);
        }
    }

    cam.end();

    // Mostrar información en pantalla
    ofSetColor(255);
    if (sphereSelected) {
        ofDrawBitmapString("Esfera seleccionada: " + 
                           ofToString(selectedSphere.x) + ", " + 
                           ofToString(selectedSphere.y) + ", " + 
                           ofToString(selectedSphere.z), 20, 20);
    }
}

// Interacción con teclado
void ofApp::keyPressed(int key) {
    if (key == 'a') amplitud += 10;
    if (key == 'z') amplitud -= 10;
    if (key == 's') distDiv += 10;
    if (key == 'x') distDiv -= 10;
    if (key == 'd') xStep += 10;
    if (key == 'c') xStep -= 10;
    if (key == 'f') yStep += 10;
    if (key == 'v') yStep -= 10;

    // Regenerar esferas con nuevos parámetros
    setup();
}

// Selección con mouse
void ofApp::mousePressed(int x, int y, int button) {
    glm::vec3 rayStart, rayEnd;
    convertMouseToRay(x, y, rayStart, rayEnd);

    sphereSelected = false;
    for (auto& pos : spherePositions) {
        glm::vec3 intersectionPoint;
        if (rayIntersectsSphere(rayStart, rayEnd - rayStart, pos, 5.0, intersectionPoint)) {
            sphereSelected = true;
            selectedSphere = pos;
            break;
        }
    }
}

// Conversión coordenadas mouse → rayo
void ofApp::convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd) {
    glm::mat4 modelview = cam.getModelViewMatrix();
    glm::mat4 projection = cam.getProjectionMatrix();
    ofRectangle viewport = ofGetCurrentViewport();

    float x = 2.0f * (mouseX - viewport.x) / viewport.width - 1.0f;
    float y = 1.0f - 2.0f * (mouseY - viewport.y) / viewport.height;

    glm::vec4 rayStartNDC(x, y, -1.0f, 1.0f);
    glm::vec4 rayEndNDC(x, y, 1.0f, 1.0f);

    glm::vec4 rayStartWorld = glm::inverse(projection * modelview) * rayStartNDC;
    glm::vec4 rayEndWorld = glm::inverse(projection * modelview) * rayEndNDC;

    rayStartWorld /= rayStartWorld.w;
    rayEndWorld /= rayEndWorld.w;

    rayStart = glm::vec3(rayStartWorld);
    rayEnd = glm::vec3(rayEndWorld);
}

// Intersección rayo-esfera
bool ofApp::rayIntersectsSphere(const glm::vec3& rayStart, const glm::vec3& rayDir, const glm::vec3& sphereCenter, float sphereRadius, glm::vec3& intersectionPoint) {
    glm::vec3 oc = rayStart - sphereCenter;
    float a = glm::dot(rayDir, rayDir);
    float b = 2.0f * glm::dot(oc, rayDir);
    float c = glm::dot(oc, oc) - sphereRadius * sphereRadius;

    float discriminant = b * b - 4 * a * c;
    if (discriminant < 0) return false;

    float t = (-b - sqrt(discriminant)) / (2.0f * a);
    intersectionPoint = rayStart + t * rayDir;
    return true;
}

´´´

´´´cpp
// ofApp.cpp
#include "ofApp.h"

void ofApp::setup() {
    ofBackground(0);
    ofEnableDepthTest();
    
    // Generar posiciones iniciales
    spherePositions.clear();
    for (int x = -ofGetWidth() / 2; x < ofGetWidth() / 2; x += xStep) {
        for (int y = -ofGetHeight() / 2; y < ofGetHeight() / 2; y += yStep) {
            float z = cos(ofDist(x, y, 0, 0) / distDiv) * amplitud;
            spherePositions.push_back(glm::vec3(x, y, z));
        }
    }
}

void ofApp::update() {}

void ofApp::draw() {
    cam.begin();

    for (auto& pos : spherePositions) {
        if (sphereSelected && pos == selectedSphere) {
            ofSetColor(255, 0, 0); // resaltada
            ofDrawSphere(pos, 8);
        } else {
            ofSetColor(200);
            ofDrawSphere(pos, 5);
        }
    }

    cam.end();

    // Mostrar información en pantalla
    ofSetColor(255);
    if (sphereSelected) {
        ofDrawBitmapString("Esfera seleccionada: " + 
                           ofToString(selectedSphere.x) + ", " + 
                           ofToString(selectedSphere.y) + ", " + 
                           ofToString(selectedSphere.z), 20, 20);
    }
}

// Interacción con teclado
void ofApp::keyPressed(int key) {
    if (key == 'a') amplitud += 10;
    if (key == 'z') amplitud -= 10;
    if (key == 's') distDiv += 10;
    if (key == 'x') distDiv -= 10;
    if (key == 'd') xStep += 10;
    if (key == 'c') xStep -= 10;
    if (key == 'f') yStep += 10;
    if (key == 'v') yStep -= 10;

    // Regenerar esferas con nuevos parámetros
    setup();
}

// Selección con mouse
void ofApp::mousePressed(int x, int y, int button) {
    glm::vec3 rayStart, rayEnd;
    convertMouseToRay(x, y, rayStart, rayEnd);

    sphereSelected = false;
    for (auto& pos : spherePositions) {
        glm::vec3 intersectionPoint;
        if (rayIntersectsSphere(rayStart, rayEnd - rayStart, pos, 5.0, intersectionPoint)) {
            sphereSelected = true;
            selectedSphere = pos;
            break;
        }
    }
}

// Conversión coordenadas mouse → rayo
void ofApp::convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd) {
    glm::mat4 modelview = cam.getModelViewMatrix();
    glm::mat4 projection = cam.getProjectionMatrix();
    ofRectangle viewport = ofGetCurrentViewport();

    float x = 2.0f * (mouseX - viewport.x) / viewport.width - 1.0f;
    float y = 1.0f - 2.0f * (mouseY - viewport.y) / viewport.height;

    glm::vec4 rayStartNDC(x, y, -1.0f, 1.0f);
    glm::vec4 rayEndNDC(x, y, 1.0f, 1.0f);

    glm::vec4 rayStartWorld = glm::inverse(projection * modelview) * rayStartNDC;
    glm::vec4 rayEndWorld = glm::inverse(projection * modelview) * rayEndNDC;

    rayStartWorld /= rayStartWorld.w;
    rayEndWorld /= rayEndWorld.w;

    rayStart = glm::vec3(rayStartWorld);
    rayEnd = glm::vec3(rayEndWorld);
}

// Intersección rayo-esfera
bool ofApp::rayIntersectsSphere(const glm::vec3& rayStart, const glm::vec3& rayDir, const glm::vec3& sphereCenter, float sphereRadius, glm::vec3& intersectionPoint) {
    glm::vec3 oc = rayStart - sphereCenter;
    float a = glm::dot(rayDir, rayDir);
    float b = 2.0f * glm::dot(oc, rayDir);
    float c = glm::dot(oc, oc) - sphereRadius * sphereRadius;

    float discriminant = b * b - 4 * a * c;
    if (discriminant < 0) return false;

    float t = (-b - sqrt(discriminant)) / (2.0f * a);
    intersectionPoint = rayStart + t * rayDir;
    return true;
}

´´´
**Actividad**

- Stack: Aquí se guardan variables temporales como rayStart, rayEnd o intersectionPoint. Su vida útil termina al salir de la función.

- Heap: El contenedor std::vector<glm::vec3> spherePositions almacena las posiciones de todas las esferas en memoria dinámica. Cada vez que regeneramos la cuadrícula (setup()), se reserva memoria nueva para almacenar las posiciones.

- Memoria global: Los parámetros de control (xStep, yStep, distDiv, amplitud, etc.) y las variables de estado (sphereSelected, selectedSphere) están en la clase ofApp, que se instancia al inicio de la aplicación y persiste durante toda la ejecución.
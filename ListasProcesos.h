#ifndef LISTASPROCESOS_H
#define LISTASPROCESOS_H

#include <string>

// El molde de tu estructura dinámica para el Gestor de Procesos
struct NodoProceso {
    int id;                       // Identificador del proceso
    std::string nombreProceso;    // Nombre de la aplicación (ej: chrome.exe)
    int prioridad;                // Nivel de prioridad
    NodoProceso* siguiente;       // Enlace al siguiente vagón de la lista

    // Constructor para inicializar el nodo
    NodoProceso(int _id, std::string _nombre, int _prioridad);
};

// Declaración de tus 3 funciones obligatorias (los prototipos)
void registrarProceso(NodoProceso*& inicio, int id, std::string nombre, int prioridad);
void buscarProceso(NodoProceso* inicio, int idBuscado);
void eliminarProceso(NodoProceso*& inicio, int idEliminar);

#endif

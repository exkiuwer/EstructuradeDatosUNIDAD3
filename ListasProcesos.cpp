#include <iostream>
#include "ListasProcesos.h" // Conecta con tu archivo de cabecera

using namespace std;

// 1. DESARROLLO DEL CONSTRUCTOR
NodoProceso::NodoProceso(int _id, string _nombre, int _prioridad) {
    id = _id;
    nombreProceso = _nombre;
    prioridad = _prioridad;
    siguiente = NULL; // Al iniciar, el nodo apunta a la nada
}

// 2. OPERACIÓN DE INSERCION: Registrar un proceso al inicio
void registrarProceso(NodoProceso*& inicio, int id, string nombre, int prioridad) {
    NodoProceso* nuevo = new NodoProceso(id, nombre, prioridad);
    
    nuevo->siguiente = inicio; // El nuevo nodo apunta al que antes era el primero
    inicio = nuevo;            // Ahora el inicio de la lista es el nuevo nodo
    
    cout << "--> [Lista] Proceso '" << nombre << "' registrado correctamente.\n";
}

// 3. OPERACION DE BUSQUEDA: Buscar por ID
void buscarProceso(NodoProceso* inicio, int idBuscado) {
    if (inicio == NULL) {
        cout << "--> [Lista] El registro esta vacio. No hay procesos.\n";
        return;
    }

    NodoProceso* actual = inicio; // Puntero auxiliar para recorrer la lista
    
    while (actual != NULL) {
        if (actual->id == idBuscado) {
            cout << "--> [Lista] ¡Proceso Encontrado!\n";
            cout << "    ID: " << actual->id << " | Nombre: " << actual->nombreProceso << " | Prioridad: " << actual->prioridad << "\n";
            return; // Termina la función porque ya lo encontramos
        }
        actual = actual->siguiente; // Avanzamos al siguiente nodo
    }
    cout << "--> [Lista] El ID " << idBuscado << " no se encuentra registrado.\n";
}

// 4. OPERACION DE ELIMINACION: Dar de baja y liberar memoria
void eliminarProceso(NodoProceso*& inicio, int idEliminar) {
    if (inicio == NULL) {
        cout << "--> [Lista] El registro esta vacio. Nada que eliminar.\n";
        return;
    }

    NodoProceso* actual = inicio;
    NodoProceso* anterior = NULL;

    // Caso A: Si el nodo que queremos borrar es el primero de la lista
    if (actual != NULL && actual->id == idEliminar) {
        inicio = actual->siguiente; // El inicio se mueve al segundo vagón
        delete actual;              // Destruimos el nodo de la memoria RAM
        cout << "--> [Lista] Proceso " << idEliminar << " eliminado del inicio.\n";
        return;
    }

    // Caso B: Buscar el nodo en las posiciones intermedias o finales
    while (actual != NULL && actual->id != idEliminar) {
        anterior = actual;          // Guardamos el actual como el anterior
        actual = actual->siguiente; // Avanzamos al siguiente
    }

    // Si caminamos toda la lista y no encontramos el ID
    if (actual == NULL) {
        cout << "--> [Lista] El ID " << idEliminar << " no existe para eliminar.\n";
        return;
    }

    // Si lo encontramos en el medio, hacemos el puente saltándonos el nodo actual
    anterior->siguiente = actual->siguiente;
    delete actual; // Liberamos los recursos de la memoria
    cout << "--> [Lista] Proceso " << idEliminar << " eliminado con exito.\n";
}

#include <iostream>
#include <string>
#include <fstream> 

using namespace std;

// =========================================================
// 1. LOS MOLDES DE LAS TRES ESTRUCTURAS (Nodos dinámicos)
// =========================================================

struct NodoProceso {
    int id;
    string nombreProceso;
    int prioridad;
    NodoProceso* siguiente;
    NodoProceso(int _id, string _nombre, int _prio) {
        id = _id; nombreProceso = _nombre; prioridad = _prio; siguiente = NULL;
    }
};

struct NodoCola {
    int id;
    int prioridad;
    NodoCola* siguiente;
    NodoCola(int _id, int _prio) {
        id = _id; prioridad = _prio; siguiente = NULL;
    }
};

struct NodoPila {
    int idProceso;
    int bloquesRAM;
    NodoPila* siguiente;
    NodoPila(int _id, int _bloques) {
        idProceso = _id; bloquesRAM = _bloques; siguiente = NULL;
    }
};

// =========================================================
// 2. LAS FUNCIONES DE ESTRUCTURA DINAMICA
// =========================================================

// --- FUNCIONES LISTAS  ---
void registrarProceso(NodoProceso*& inicio, int id, string nombre, int prioridad) {
    NodoProceso* nuevo = new NodoProceso(id, nombre, prioridad);
    nuevo->siguiente = inicio;
    inicio = nuevo;
    cout << "\n--> [Lista] Proceso '" << nombre << "' registrado con exito.\n";
}

void buscarProceso(NodoProceso* inicio, int idBuscado) {
    NodoProceso* actual = inicio;
    while (actual != NULL) {
        if (actual->id == idBuscado) {
            cout << "\n--> [Lista] Encontrado: ID " << actual->id << " | " << actual->nombreProceso << " | Prio: " << actual->prioridad << "\n";
            return;
        }
        actual = actual->siguiente;
    }
    cout << "\n--> [Lista] El ID " << idBuscado << " no existe.\n";
}

void eliminarProceso(NodoProceso*& inicio, int idEliminar) {
    if (inicio == NULL) {
        cout << "\n--> [Lista] Registro vacio.\n";
        return;
    }
    NodoProceso* actual = inicio;
    NodoProceso* anterior = NULL;
    if (actual != NULL && actual->id == idEliminar) {
        inicio = actual->siguiente;
        delete actual;
        cout << "\n--> [Lista] Proceso " << idEliminar << " eliminado del inicio.\n";
        return;
    }
    while (actual != NULL && actual->id != idEliminar) {
        anterior = actual;
        actual = actual->siguiente;
    }
    if (actual == NULL) {
        cout << "\n--> [Lista] ID no encontrado.\n";
        return;
    }
    anterior->siguiente = actual->siguiente;
    delete actual;
    cout << "\n--> [Lista] Proceso " << idEliminar << " eliminado con exito.\n";
}

// --- FUNCIONES COLAS  ---
void encolarProceso(NodoCola*& frente, NodoCola*& fin, int id, int prio) {
    NodoCola* nuevo = new NodoCola(id, prio);
    if (frente == NULL) {
        frente = nuevo; fin = nuevo;
    } else {
        fin->siguiente = nuevo; fin = nuevo;
    }
    cout << "\n--> [Cola] Proceso " << id << " enviado al planificador.\n";
}

void desencolarProceso(NodoCola*& frente, NodoCola*& fin) {
    if (frente == NULL) {
        cout << "\n--> [Cola] No hay procesos en fila.\n";
        return;
    }
    NodoCola* temp = frente;
    cout << "\n--> [CPU] Ejecutando proceso ID: " << temp->id << "\n";
    frente = frente->siguiente;
    if (frente == NULL) fin = NULL;
    delete temp;
}

// --- FUNCIONES PILAS ---
void apilarMemoria(NodoPila*& tope, int id, int bloques) {
    NodoPila* nuevo = new NodoPila(id, bloques);
    nuevo->siguiente = tope;
    tope = nuevo;
    cout << "\n--> [Pila] Asignados " << bloques << " bloques al proceso " << id << ".\n";
}

void desapilarMemoria(NodoPila*& tope) {
    if (tope == NULL) {
        cout << "\n--> [Pila] Memoria vacia.\n";
        return;
    }
    NodoPila* temp = tope;
    cout << "\n--> [Pila] Liberando RAM del proceso ID: " << temp->idProceso << "\n";
    tope = tope->siguiente;
    delete temp;
}

// =========================================================
// 3. PERSISTENCIA EN ARCHIVOS (Integrante 4)
// =========================================================
void guardarTodo(NodoProceso* lista) {
    ofstream archivo("sistema.txt");
    if (!archivo.is_open()) return;

    NodoProceso* actL = lista;
    archivo << "[LISTA]\n";
    while (actL != NULL) {
        archivo << actL->id << "," << actL->nombreProceso << "," << actL->prioridad << "\n";
        actL = actL->siguiente;
    }
    archivo.close();
    cout << "\n--> ¡Datos guardados correctamente en 'sistema.txt'!\n";
}

// =========================================================
// 4. MENu INTERACTIVO PRINCIPAL 
// =========================================================
int main() {
    NodoProceso* miLista = NULL;
    NodoCola* frenteCola = NULL;
    NodoCola* finCola = NULL;
    NodoPila* topePila = NULL;

    int opcion, idIn, prioIn, ramIn;
    string nameIn;

    do {
        cout << "\n=========================================\n";
        cout << "   SIMULADOR DE SISTEMA OPERATIVO (S.O.) \n";
        cout << "=========================================\n";
        cout << " 1. [Lista] Registrar Proceso Nuevo\n";
        cout << " 2. [Lista] Buscar Proceso por ID\n";
        cout << " 3. [Lista] Eliminar Proceso de la Lista\n";
        cout << " 4. [Cola]  Insertar Tarea en Fila de CPU\n";
        cout << " 5. [Cola]  Despachar Tarea (Ejecutar en CPU)\n";
        cout << " 6. [Pila]  Asignar Bloques de Memoria RAM\n";
        cout << " 7. [Pila]  Liberar Recursos (Desapilar RAM)\n";
        cout << " 8. [Save]  Guardar Simulacion en Archivo\n";
        cout << " 9. Salir\n";
        cout << " Seleccione una opcion: ";
        
        if (!(cin >> opcion)) { // Si el usuario ingresa una letra en vez de un número
            cout << "\nError: Ingrese solo numeros.\n";
            cin.clear();            // Limpia el estado de error de cin
            cin.ignore(10000, '\n'); // Descarta la entrada incorrecta
            continue;
        }

        switch (opcion) {
            case 1:
                cout << "Ingrese ID numerico: "; cin >> idIn;
                cout << "Ingrese nombre (.exe): "; cin >> nameIn;
                cout << "Ingrese prioridad (1-5): "; cin >> prioIn;
                registrarProceso(miLista, idIn, nameIn, prioIn);
                break;
            case 2:
                cout << "ID a buscar: "; cin >> idIn;
                buscarProceso(miLista, idIn);
                break;
            case 3:
                cout << "ID a eliminar: "; cin >> idIn;
                eliminarProceso(miLista, idIn);
                break;
            case 4:
                cout << "ID para CPU: "; cin >> idIn;
                cout << "Prioridad: "; cin >> prioIn;
                encolarProceso(frenteCola, finCola, idIn, prioIn);
                break;
            case 5:
                desencolarProceso(frenteCola, finCola);
                break;
            case 6:
                cout << "ID para RAM: "; cin >> idIn;
                cout << "Bloques: "; cin >> ramIn;
                apilarMemoria(topePila, idIn, ramIn);
                break;
            case 7:
                desapilarMemoria(topePila);
                break;
            case 8:
                guardarTodo(miLista);
                break;
            case 9:
                cout << "\nSaliendo del simulador de forma segura.\n";
                break;
            default:
                cout << "\nOpcion no valida. Intente nuevamente.\n";
        }
        
        cin.clear();
        cin.ignore(10000, '\n');

    } while (opcion != 9);

    return 0;
}

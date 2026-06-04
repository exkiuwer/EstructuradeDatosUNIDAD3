#include <iostream>

using namespace std;

struct Proceso {
    char id[10];        
    char nombre[20];    
    int prioridad;      
    Proceso* siguiente; 
};

void insertarProceso(Proceso* &inicio, const char* nuevoId, const char* nuevoNombre, int nuevaPrio) {
    Proceso* nuevo = new Proceso();
    
    int i = 0;
    while (nuevoId[i] != '\0') {
        nuevo->id[i] = nuevoId[i];
        i++;
    }
    nuevo->id[i] = '\0';

    int j = 0;
    while (nuevoNombre[j] != '\0') {
        nuevo->nombre[j] = nuevoNombre[j];
        j++;
    }
    nuevo->nombre[j] = '\0';

    nuevo->prioridad = nuevaPrio;
    nuevo->siguiente = NULL;

    if (inicio == NULL || nuevo->prioridad > inicio->prioridad) {
        nuevo->siguiente = inicio;
        inicio = nuevo;
        return;
    }

    Proceso* aux = inicio;
    while (aux->siguiente != NULL && aux->siguiente->prioridad >= nuevo->prioridad) {
        aux = aux->siguiente; 
    }
    
    nuevo->siguiente = aux->siguiente;
    aux->siguiente = nuevo;
}

void eliminarProceso(Proceso* &inicio) {
    if (inicio == NULL) {
        cout << "La cola esta vacia, no hay nada que ejecutar.\n";
        return;
    }
    
    Proceso* temporal = inicio;
    
    cout << "\n>>> EJECUTANDO EN CPU: " << temporal->id 
         << " (" << temporal->nombre << ") con prioridad: " 
         << temporal->prioridad << " <<<\n";
    
    inicio = inicio->siguiente;
    
    delete temporal; 
}

void buscarProceso(Proceso* inicio, const char* idBuscar) {
    Proceso* aux = inicio;
    bool encontrado = false;

    while (aux != NULL) {
        int i = 0;
        while (aux->id[i] != '\0' && idBuscar[i] != '\0' && aux->id[i] == idBuscar[i]) {
            i++;
        }

        if (aux->id[i] == '\0' && idBuscar[i] == '\0') {
            cout << "\n[Encontrado] Proceso: " << aux->nombre 
                 << " | Prioridad: " << aux->prioridad << "\n";
            encontrado = true;
            break; 
        }
        aux = aux->siguiente;
    }

    if (!encontrado) {
        cout << "\nNo se encontro ningun proceso con ese ID.\n";
    }
}

void mostrarCola(Proceso* inicio) {
    if (inicio == NULL) {
        cout << "\nLa cola esta vacia.\n";
        return;
    }

    cout << "\n--- LISTA DE PROCESOS ESPERANDO CPU ---\n";
    Proceso* aux = inicio;
    while (aux != NULL) {
        cout << "ID: " << aux->id 
             << " | Tarea: " << aux->nombre 
             << " | Prioridad: " << aux->prioridad << "\n";
        aux = aux->siguiente;
    }
    cout << "---------------------------------------\n";
}

void guardarCola(Proceso* inicio) {
    if (inicio == NULL) {
        cout << "\nNo hay datos para guardar.\n";
        return;
    }
    cout << "\n--- COPIA ESTA LINEA PARA TU RESPALDO ---\n";
    Proceso* aux = inicio;
    while (aux != NULL) {
        cout << aux->id << " " << aux->nombre << " " << aux->prioridad << "\n";
        aux = aux->siguiente;
    }
    cout << "-----------------------------------------\n";
}

int main() {
    Proceso* miCola = NULL; 
    
    int opcion;
    char idTmp[10];
    char nomTmp[20];
    int prioTmp;

    while (true) {
        cout << "\n=== MENU PLANIFICADOR ===\n";
        cout << "1. Registrar proceso (Insertar)\n";
        cout << "2. Ejecutar proceso (Eliminar)\n";
        cout << "3. Ver cola de prioridad (Mostrar)\n";
        cout << "4. Buscar por ID (Buscar)\n";
        cout << "5. Guardar estado actual\n";
        cout << "6. Cargar un registro\n";
        cout << "7. Salir\n";
        cout << "Opcion: ";
        cin >> opcion;

        if (opcion == 1) {
            cout << "ID del proceso: ";
            cin >> idTmp;
            cout << "Nombre de tarea: ";
            cin >> nomTmp;
            cout << "Prioridad: ";
            cin >> prioTmp;
            
            insertarProceso(miCola, idTmp, nomTmp, prioTmp);
            cout << "Proceso agregado.\n";
        }
        else if (opcion == 2) {
            eliminarProceso(miCola);
        }
        else if (opcion == 3) {
            mostrarCola(miCola);
        }
        else if (opcion == 4) {
            cout << "ID a buscar: ";
            cin >> idTmp;
            buscarProceso(miCola, idTmp);
        }
        else if (opcion == 5) {
            guardarCola(miCola);
        }
        else if (opcion == 6) {
            cout << "Escribe los datos guardados (ID Nombre Prioridad): ";
            cin >> idTmp >> nomTmp >> prioTmp;
            insertarProceso(miCola, idTmp, nomTmp, prioTmp);
            cout << "Registro cargado con exito.\n";
        }
        else if (opcion == 7) {
            cout << "Saliendo...\n";
            break;
        }
        else {
            cout << "Opcion invalida.\n";
        }
    }

    return 0;
}

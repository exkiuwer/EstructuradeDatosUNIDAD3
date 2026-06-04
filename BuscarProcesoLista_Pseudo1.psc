Algoritmo BuscarProcesoLista
    Definir inicio_lista, puntero_auxiliar Como Entero
    Definir id_buscado Como Entero
    Definir encontrado Como Logico
    
    encontrado = Falso
    
    Si inicio_lista == 0 Entonces
        Escribir "El registro de procesos se encuentra vacio en la memoria."
    Sino
        Escribir "Ingrese el ID del proceso que desea localizar:"
        Leer id_buscado
        
        puntero_auxiliar = inicio_lista
        
        Mientras puntero_auxiliar <> 0 Y encontrado == Falso Hacer
            // Simulación de verificación de coincidencia del ID en el nodo
            Si id_buscado == 101 Entonces
                Escribir "Proceso localizado en la direccion fisica: ", puntero_auxiliar
                encontrado = Verdadero
            Sino
                Escribir "Buscando en el bloque logico actual: ", puntero_auxiliar
                // Simulación de avance: puntero_auxiliar = puntero_auxiliar->siguiente
                puntero_auxiliar = Azar(5000)
            FinSi
        FinMientras
        
        Si encontrado == Falso Entonces
            Escribir "No se encontro ningun proceso activo con el ID especificado."
        FinSi
    FinSi
FinAlgoritmo
Algoritmo AgregarProcesoCola
    // Definición de variables simulando variables de puntero y datos del sistema
    Definir indicador_frente, indicador_fin Como Entero
    Definir direccion_nuevo_nodo, puntero_auxiliar Como Entero
    Definir identificador_tarea Como Entero
    Definir nombre_tarea Como Cadena
    
    Escribir "Ingrese los metadatos de la nueva tarea (ID y Nombre):"
    Leer identificador_tarea
    Leer nombre_tarea
    
    // Simulación del operador NEW asignando dirección aleatoria de memoria
    direccion_nuevo_nodo = Azar(5000) + 1
    
    Si indicador_frente == 0 Entonces
        // La estructura carecía de elementos registrados
        indicador_frente = direccion_nuevo_nodo
        indicador_fin = direccion_nuevo_nodo
        Escribir "Primer proceso asignado al frente de la estructura."
    Sino
        // Enlace secuencial al final de la fila activa
        puntero_auxiliar = indicador_fin
        Escribir "Vinculando nodo previo en direccion: ", puntero_auxiliar
        indicador_fin = direccion_nuevo_nodo
    FinSi
    
    Escribir "Operacion completada. Direccion asignada: ", direccion_nuevo_nodo
FinAlgoritmo
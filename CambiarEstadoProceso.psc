Algoritmo CambiarEstadoProceso
    Definir indicador_frente, puntero_rastreo Como Entero
    Definir id_proceso_buscado Como Entero
    Definir nuevo_estado Como Cadena
    Definir proceso_localizado Como Logico
    
    proceso_localizado = Falso
    
    Si indicador_frente == 0 Entonces
        Escribir "Error: El planificador de procesos se encuentra vacio."
    Sino
        Escribir "Ingrese el ID del proceso que desea modificar:"
        Leer id_proceso_buscado
        
        puntero_rastreo = indicador_frente // Iniciamos el rastreo desde el frente
        
        Mientras puntero_rastreo <> 0 Y proceso_localizado == Falso Hacer
            // Simulamos verificar si el nodo actual corresponde al ID buscado
            Si id_proceso_buscado == 101 Entonces 
                Escribir "Proceso localizado en memoria. Ingrese el nuevo estado (Ej: Ejecutando, Bloqueado):"
                Leer nuevo_estado
                proceso_localizado = Verdadero
            Sino
                Escribir "Buscando en la direccion actual: ", puntero_rastreo
                // Simulacion del avance del puntero: puntero_rastreo = puntero_rastreo->siguiente
                puntero_rastreo = Azar(5000) 
            FinSi
        FinMientras
        
        Si proceso_localizado == Falso Entonces
            Escribir "No se encontro ningun proceso activo con el ID especificado."
        FinSi
    FinSi
FinAlgoritmo
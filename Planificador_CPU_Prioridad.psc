SubProceso ordenarPorPrioridad(lista_ids Por Referencia, lista_nombres Por Referencia, lista_prioridades Por Referencia, total_procesos)
	Definir i, j, temp_prio Como Entero
	Definir temp_id, temp_nom Como Cadena
	
	// Metodo de la burbuja para ordenar de mayor a menor prioridad
	Para i <- 1 Hasta total_procesos - 1 Con Paso 1 Hacer
		Para j <- 1 Hasta total_procesos - i Con Paso 1 Hacer
			Si lista_prioridades[j] < lista_prioridades[j+1] Entonces
				// Intercambiar las prioridades en el arreglo
				temp_prio <- lista_prioridades[j]
				lista_prioridades[j] <- lista_prioridades[j+1]
				lista_prioridades[j+1] <- temp_prio
				
				// Intercambiar los IDs para que sigan sincronizados
				temp_id <- lista_ids[j]
				lista_ids[j] <- lista_ids[j+1]
				lista_ids[j+1] <- temp_id
				
				// Intercambiar los Nombres de las tareas
				temp_nom <- lista_nombres[j]
				lista_nombres[j] <- lista_nombres[j+1]
				lista_nombres[j+1] <- temp_nom
			FinSi
		FinPara
	FinPara
FinSubProceso

SubProceso eliminarProceso(lista_ids Por Referencia, lista_nombres Por Referencia, lista_prioridades Por Referencia, total_procesos Por Referencia)
	Definir i Como Entero
	Si total_procesos = 0 Entonces
		Escribir "La cola esta vacia, no hay nada que ejecutar."
	Sino
		Escribir ""
		Escribir ">>> EJECUTANDO EN CPU: ", lista_ids[1], " (", lista_nombres[1], ") con prioridad: ", lista_prioridades[1], " <<<"
		
		// Desplazar todos los procesos una posicion hacia adelante (elimina el primero)
		Para i <- 1 Hasta total_procesos - 1 Con Paso 1 Hacer
			lista_ids[i] <- lista_ids[i+1]
			lista_nombres[i] <- lista_nombres[i+1]
			lista_prioridades[i] <- lista_prioridades[i+1]
		FinPara
		
		// Disminuir el contador de procesos activos
		total_procesos <- total_procesos - 1
	FinSi
FinSubProceso

SubProceso mostrarCola(lista_ids, lista_nombres, lista_prioridades, total_procesos)
	Definir i Como Entero
	Si total_procesos = 0 Entonces
		Escribir "La cola esta vacia."
	Sino
		Escribir ""
		Escribir "--- LISTA DE PROCESOS ESPERANDO CPU ---"
		Para i <- 1 Hasta total_procesos Con Paso 1 Hacer
			Escribir "ID: ", lista_ids[i], " | Tarea: ", lista_nombres[i], " | Prioridad: ", lista_prioridades[i]
		FinPara
		Escribir "---------------------------------------"
	FinSi
FinSubProceso

SubProceso buscarProceso(lista_ids, lista_nombres, lista_prioridades, total_procesos, id_buscar)
	Definir i Como Entero
	Definir encontrado Como Logico
	encontrado <- Falso
	
	Si total_procesos = 0 Entonces
		Escribir "La cola esta vacia."
	Sino
		Para i <- 1 Hasta total_procesos Con Paso 1 Hacer
			Si lista_ids[i] = id_buscar Entonces
				Escribir ""
				Escribir "[Encontrado] Proceso: ", lista_nombres[i], " | Prioridad: ", lista_prioridades[i]
				encontrado <- Verdadero
				i <- total_procesos // Forzar la salida del bucle
			FinSi
		FinPara
		
		Si encontrado = Falso Entonces
			Escribir "No se encontro ningun proceso con ese ID."
		FinSi
	FinSi
FinSubProceso

SubProceso guardarCola(lista_ids, lista_nombres, lista_prioridades, total_procesos)
	Definir i Como Entero
	Si total_procesos = 0 Entonces
		Escribir "No hay datos para guardar."
	Sino
		Escribir ""
		Escribir "--- COPIA ESTA LINEA PARA TU RESPALDO ---"
		Para i <- 1 Hasta total_procesos Con Paso 1 Hacer
			Escribir lista_ids[i], " ", lista_nombres[i], " ", lista_prioridades[i]
		FinPara
		Escribir "-----------------------------------------"
	FinSi
FinSubProceso

Algoritmo Planificador_CPU_Prioridad
	// Limite maximo de almacenamiento para el simulador
	Definir MAX_PROCESOS Como Entero
	MAX_PROCESOS <- 20
	
	// Estructuras de almacenamiento (Arreglos en paralelo)
	Definir lista_ids Como Cadena
	Definir lista_nombres Como Cadena
	Definir lista_prioridades Como Entero
	Dimension lista_ids[MAX_PROCESOS]
	Dimension lista_nombres[MAX_PROCESOS]
	Dimension lista_prioridades[MAX_PROCESOS]
	
	// Contador de procesos encolados
	Definir total_procesos Como Entero
	total_procesos <- 0
	
	// Variables para interactuar con el usuario
	Definir opcion, prio_tmp Como Entero
	Definir id_tmp, nombre_tmp Como Cadena
	Definir id_buscar_tmp Como Cadena
	Definir ya_existe Como Logico
	Definir k Como Entero
	
	Repetir
		Escribir ""
		Escribir "=== MENU PLANIFICADOR ==="
		Escribir "1. Registrar proceso (Insertar)"
		Escribir "2. Ejecutar proceso (Eliminar)"
		Escribir "3. Ver cola de prioridad (Mostrar)"
		Escribir "4. Buscar por ID (Buscar)"
		Escribir "5. Guardar estado actual"
		Escribir "6. Cargar un registro"
		Escribir "7. Salir"
		Escribir "Opcion: " Sin Saltar
		Leer opcion
		
		Segun opcion Hacer
			1:
				Si total_procesos >= MAX_PROCESOS Entonces
					Escribir "La cola de procesos esta llena."
				Sino
					Escribir "ID del proceso: " Sin Saltar
					Leer id_tmp
					
					// Validar que el ID sea unico
					ya_existe <- Falso
					Para k <- 1 Hasta total_procesos Con Paso 1 Hacer
						Si lista_ids[k] = id_tmp Entonces
							ya_existe <- Verdadero
						FinSi
					FinPara
					
					Si ya_existe = Verdadero Entonces
						Escribir "Error: El ID ya existe."
					Sino
						Escribir "Nombre de tarea: " Sin Saltar
						Leer nombre_tmp
						Escribir "Prioridad: " Sin Saltar
						Leer prio_tmp
						
						// Insertar al final del arreglo
						total_procesos <- total_procesos + 1
						lista_ids[total_procesos] <- id_tmp
						lista_nombres[total_procesos] <- nombre_tmp
						lista_prioridades[total_procesos] <- prio_tmp
						
						// Ordenar los arreglos inmediatamente para organizar por prioridad
						ordenarPorPrioridad(lista_ids, lista_nombres, lista_prioridades, total_procesos)
						
						Escribir "Proceso agregado y ordenado."
					FinSi
				FinSi
				
			2:
				eliminarProceso(lista_ids, lista_nombres, lista_prioridades, total_procesos)
				
			3:
				mostrarCola(lista_ids, lista_nombres, lista_prioridades, total_procesos)
				
			4:
				Escribir "ID a buscar: " Sin Saltar
				Leer id_buscar_tmp
				buscarProceso(lista_ids, lista_nombres, lista_prioridades, total_procesos, id_buscar_tmp)
				
			5:
				guardarCola(lista_ids, lista_nombres, lista_prioridades, total_procesos)
				
			6:
				Si total_procesos >= MAX_PROCESOS Entonces
					Escribir "La cola esta llena."
				Sino
					Escribir "Escribe los datos guardados (ID Nombre Prioridad): " Sin Saltar
					Leer id_tmp, nombre_tmp, prio_tmp
					
					// Insertar al final
					total_procesos <- total_procesos + 1
					lista_ids[total_procesos] <- id_tmp
					lista_nombres[total_procesos] <- nombre_tmp
					lista_prioridades[total_procesos] <- prio_tmp
					
					// Volver a ordenar todo
					ordenarPorPrioridad(lista_ids, lista_nombres, lista_prioridades, total_procesos)
					Escribir "Registro cargado con exito."
				FinSi
				
			7:
				Escribir "Saliendo del programa..."
				
			De Otro Modo:
				Escribir "Opcion invalida. Intente de nuevo."
		FinSegun
	Hasta Que opcion = 7
FinAlgoritmo
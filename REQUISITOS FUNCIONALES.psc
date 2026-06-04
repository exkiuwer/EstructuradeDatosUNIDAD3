Proceso SistemaEstructurasLineales
	// 1. DECLARACIÓN DE VARIABLES Y ARREGLOS
	Definir MAX_CANTIDAD Como Entero
	MAX_CANTIDAD <- 100
	// --- ESTRUCTURA LINEAL A (Comportamiento por Enlaces de Posición) ---
	Definir ea_valores Como Entero
	Dimensionar ea_valores(100)
	Definir ea_siguiente Como Entero
	Dimensionar ea_siguiente(100)
	Definir ea_origen, ea_total Como Entero
	ea_origen <- 0
	ea_total <- 0
	// Administrar LISTA ENLAZADA
	Definir eb_valores Como Entero
	Dimensionar eb_valores(100)
	Definir eb_tope Como Entero
	eb_tope <- 0
	// Administrar PILA
	Definir ec_valores Como Entero
	Dimensionar ec_valores(100)
	Definir ec_inicio, ec_final Como Entero
	ec_inicio <- 1
	ec_final <- 0
	// Administrar COLA
	Definir b_ea_valores Como Entero
	Dimensionar b_ea_valores(100)
	Definir b_ea_siguiente Como Entero
	Dimensionar b_ea_siguiente(100)
	Definir b_ea_origen, b_ea_total Como Entero
	b_ea_origen <- 0
	b_ea_total <- 0
	Definir b_eb_valores Como Entero
	Dimensionar b_eb_valores(100)
	Definir b_eb_tope Como Entero
	b_eb_tope <- 0
	Definir b_ec_valores Como Entero
	Dimensionar b_ec_valores(100)
	Definir b_ec_inicio, b_ec_final Como Entero
	b_ec_inicio <- 1
	b_ec_final <- 0
	// --- VARIABLES AUXILIARES DE CONTROL ---
	Definir opc_menu, opc_sub, elemento, i, actual, anterior, detectado, pos_logica Como Entero
	Definir salir_sistema, salir_submenu Como Lógico
	Definir entrada_pausa Como Cadena
	salir_sistema <- Falso
	// 2. INTERFAZ DE USUARIO CONSOLIDADA
	Mientras salir_sistema=Falso Hacer
		Limpiar Pantalla
		Escribir '    SISTEMA DE GESTIÓN DE ESTRUCTURAS LINEALES   '
		Escribir '1. Administrar LISTA ENLAZADA'
		Escribir '2. Administrar PILA'
		Escribir '3. Administrar COLA'
		Escribir '4. GUARDAR ESTADO ACTUAL (Persistencia)'
		Escribir '5. CARGAR ESTADO ANTERIOR (Persistencia)'
		Escribir '6. Salir del Programa'
		Escribir 'Seleccione una opción (1-6): 'Sin Saltar
		Leer opc_menu
		Según opc_menu Hacer
			1:
				// SUBMENÚ: ESTRUCTURA LINEAL A (Inserción, Eliminación, Búsqueda)
				salir_submenu <- Falso
				Mientras salir_submenu=Falso Hacer
					Limpiar Pantalla
					Escribir '==== MENÚ: LISTA ENLAZADA ===='
					Escribir '1. Insertar Elemento'
					Escribir '2. Eliminar Elemento'
					Escribir '3. Buscar Elemento'
					Escribir '4. Mostrar Contenido'
					Escribir '5. Volver al Menú Principal'
					Escribir 'Seleccione opción (1-5): 'Sin Saltar
					Leer opc_sub
					Según opc_sub Hacer
						1:
							Escribir 'Ingrese el valor a incorporar: 'Sin Saltar
							Leer elemento
							Si ea_total<MAX_CANTIDAD Entonces
								ea_total <- ea_total+1
								ea_valores[ea_total] <- elemento
								ea_siguiente[ea_total] <- 0
								Si ea_origen=0 Entonces
									ea_origen <- ea_total
								SiNo
									actual <- ea_origen
									Mientras ea_siguiente[actual]<>0 Hacer
										actual <- ea_siguiente[actual]
									FinMientras
									ea_siguiente[actual] <- ea_total
								FinSi
								Escribir '-> Elemento incorporado correctamente.'
							SiNo
								Escribir '[!] Estructura al límite de capacidad.'
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						2:
							Si ea_origen=0 Entonces
								Escribir '[!] La estructura se encuentra vacía.'
							SiNo
								Escribir 'Ingrese el valor a retirar: 'Sin Saltar
								Leer elemento
								actual <- ea_origen
								anterior <- 0
								detectado <- 0
								Mientras actual<>0 Hacer
									Si ea_valores[actual]=elemento Entonces
										detectado <- 1
										Si anterior=0 Entonces
											ea_origen <- ea_siguiente[actual]
										SiNo
											ea_siguiente[anterior] <- ea_siguiente[actual]
										FinSi
										actual <- 0
									SiNo
										anterior <- actual
										actual <- ea_siguiente[actual]
									FinSi
								FinMientras
								Si detectado=1 Entonces
									Escribir '-> Elemento retirado con éxito.'
								SiNo
									Escribir '[!] El elemento no fue localizado.'
								FinSi
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						3:
							Si ea_origen=0 Entonces
								Escribir '[!] La estructura se encuentra vacía.'
							SiNo
								Escribir 'Ingrese el valor a buscar: 'Sin Saltar
								Leer elemento
								actual <- ea_origen
								detectado <- 0
								pos_logica <- 1
								Mientras actual<>0 Hacer
									Si ea_valores[actual]=elemento Entonces
										detectado <- pos_logica
										actual <- 0
									SiNo
										actual <- ea_siguiente[actual]
										pos_logica <- pos_logica+1
									FinSi
								FinMientras
								Si detectado>0 Entonces
									Escribir '-> Localizado en la posición de secuencia: ', detectado
								SiNo
									Escribir '[!] El elemento no existe en esta estructura.'
								FinSi
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						4:
							Escribir 'Elementos en Estructura Lineal A:'
							Si ea_origen=0 Entonces
								Escribir '[Vacía]'
							SiNo
								actual <- ea_origen
								Mientras actual<>0 Hacer
									Escribir ea_valores[actual], ' [Siguiente] 'Sin Saltar
									actual <- ea_siguiente[actual]
								FinMientras
								Escribir 'Fin'
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						5:
							salir_submenu <- Verdadero
					FinSegún
				FinMientras
			2:
				// SUBMENÚ: ESTRUCTURA LINEAL B (Inserción, Eliminación, Búsqueda)
				salir_submenu <- Falso
				Mientras salir_submenu=Falso Hacer
					Limpiar Pantalla
					Escribir '==== MENÚ: PILA ===='
					Escribir '1. Insertar Elemento'
					Escribir '2. Eliminar Elemento'
					Escribir '3. Buscar Elemento'
					Escribir '4. Mostrar Contenido'
					Escribir '5. Volver al Menú Principal'
					Escribir 'Seleccione opción (1-5): 'Sin Saltar
					Leer opc_sub
					Según opc_sub Hacer
						1:
							Escribir 'Ingrese el valor a registrar: 'Sin Saltar
							Leer elemento
							Si eb_tope<MAX_CANTIDAD Entonces
								eb_tope <- eb_tope+1
								eb_valores[eb_tope] <- elemento
								Escribir '-> Elemento registrado en la cima.'
							SiNo
								Escribir '[!] Capacidad máxima alcanzada.'
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						2:
							Si eb_tope=0 Entonces
								Escribir '[!] Estructura sin elementos para retirar.'
							SiNo
								Escribir '-> Elemento extraído: ', eb_valores[eb_tope]
								eb_tope <- eb_tope-1
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						3:
							Si eb_tope=0 Entonces
								Escribir '[!] Estructura vacía.'
							SiNo
								Escribir 'Ingrese el valor a buscar: 'Sin Saltar
								Leer elemento
								detectado <- 0
								Para i<-eb_tope Hasta 1 Con Paso -1 Hacer
									Si eb_valores[i]=elemento Entonces
										detectado <- i
									FinSi
								FinPara
								Si detectado>0 Entonces
									Escribir '-> Localizado. Nivel de proximidad superficial: ', (eb_tope-detectado+1)
								SiNo
									Escribir '[!] Elemento no mapeado en la estructura.'
								FinSi
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						4:
							Escribir 'Representación de la Estructura Lineal B:'
							Si eb_tope=0 Entonces
								Escribir '[Vacía]'
							SiNo
								Para i<-eb_tope Hasta 1 Con Paso -1 Hacer
									Escribir '[ ', eb_valores[i], ' ]'
								FinPara
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						5:
							salir_submenu <- Verdadero
					FinSegún
				FinMientras
			3:
				// SUBMENÚ: ESTRUCTURA LINEAL C (Inserción, Eliminación, Búsqueda)
				salir_submenu <- Falso
				Mientras salir_submenu=Falso Hacer
					Limpiar Pantalla
					Escribir '==== MENÚ: COLA ===='
					Escribir '1. Insertar Elemento'
					Escribir '2. Eliminar Elemento'
					Escribir '3. Buscar Elemento'
					Escribir '4. Mostrar Contenido'
					Escribir '5. Volver al Menú Principal'
					Escribir 'Seleccione opción (1-5): 'Sin Saltar
					Leer opc_sub
					Según opc_sub Hacer
						1:
							Escribir 'Ingrese el valor a agendar: 'Sin Saltar
							Leer elemento
							Si ec_final<MAX_CANTIDAD Entonces
								ec_final <- ec_final+1
								ec_valores[ec_final] <- elemento
								Escribir '-> Elemento agregado al término de la fila.'
							SiNo
								Escribir '[!] Espacio de almacenamiento saturado.'
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						2:
							Si ec_inicio>ec_final Entonces
								Escribir '[!] No existen elementos pendientes.'
							SiNo
								Escribir '-> Elemento procesado: ', ec_valores[ec_inicio]
								ec_inicio <- ec_inicio+1
								Si ec_inicio>ec_final Entonces
									ec_inicio <- 1
									ec_final <- 0
								FinSi
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						3:
							Si ec_inicio>ec_final Entonces
								Escribir '[!] Estructura vacía.'
							SiNo
								Escribir 'Ingrese el valor a buscar: 'Sin Saltar
								Leer elemento
								detectado <- 0
								Para i<-ec_inicio Hasta ec_final Hacer
									Si ec_valores[i]=elemento Entonces
										detectado <- i
									FinSi
								FinPara
								Si detectado>0 Entonces
									Escribir '-> Localizado. Orden de salida asignado: ', (detectado-ec_inicio+1)
								SiNo
									Escribir '[!] Elemento no registrado.'
								FinSi
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						4:
							Escribir 'Distribución de Estructura Lineal C:'
							Si ec_inicio>ec_final Entonces
								Escribir '[Vacía]'
							SiNo
								Para i<-ec_inicio Hasta ec_final Hacer
									Escribir '<', ec_valores[i], '> 'Sin Saltar
								FinPara
								Escribir ''
							FinSi
							Escribir 'Presione Enter para continuar...'
							Leer entrada_pausa
						5:
							salir_submenu <- Verdadero
					FinSegún
				FinMientras
			4:
				// PERSISTENCIA: RESPALDAR DATOS
				Escribir 'Volcando instantánea de datos al bloque de persistencia...'
				b_ea_origen <- ea_origen
				b_ea_total <- ea_total
				b_eb_tope <- eb_tope
				b_ec_inicio <- ec_inicio
				b_ec_final <- ec_final
				Para i<-1 Hasta MAX_CANTIDAD Hacer
					b_ea_valores[i] <- ea_valores[i]
					b_ea_siguiente[i] <- ea_siguiente[i]
					b_eb_valores[i] <- eb_valores[i]
					b_ec_valores[i] <- ec_valores[i]
				FinPara
				Escribir '[ÉXITO] Copia de seguridad guardada con éxito.'
				Escribir 'Presione Enter para continuar...'
				Leer entrada_pausa
			5:
				// PERSISTENCIA: VOLVER A CARGAR DATOS
				Escribir 'Extrayendo instantánea del bloque de persistencia...'
				ea_origen <- b_ea_origen
				ea_total <- b_ea_total
				eb_tope <- b_eb_tope
				ec_inicio <- b_ec_inicio
				ec_final <- b_ec_final
				Para i<-1 Hasta MAX_CANTIDAD Hacer
					ea_valores[i] <- b_ea_valores[i]
					ea_siguiente[i] <- b_ea_siguiente[i]
					eb_valores[i] <- b_eb_valores[i]
					ec_valores[i] <- b_ec_valores[i]
				FinPara
				Escribir '[ÉXITO] Datos restaurados a su estado anterior.'
				Escribir 'Presione Enter para continuar...'
				Leer entrada_pausa
			6:
				salir_sistema <- Verdadero
				Escribir 'Desconectando del sistema. Proceso Finalizado.'
		FinSegún
	FinMientras
FinProceso

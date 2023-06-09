#!/usr/bin/bash
# set -x
# Permite el uso de pattern-matching más avanzado (usado en los case)
# En el caso del case no se pueden usar regex con lo cual para poder
# obtener resultados similares activamos esta variable
shopt -s extglob



#Variables
#Cada vez que se dice que una variable ha sido utilizada en X funcion,
#quiere decir que se utiliza por primera vez en esa funcion,
#luego puede utilizarse en más partes del programa

#Globales
p=0;
#Utilizada en todo el programa, son los Procesos
tamMem=0;
#Utilizada en todo el programa, es el size de la memoria total
marcosMem=0;
#Utilizada en todo el programa, es el número de marcos que caben en la memoria
tamQuant=10;
#Utilizada en todo el programa, es el quantum de ejecución
tamPag=0;
#Utilizada en todo el programa, es el size de las páginas
ord=0;
#Utilizada en todo el programa, son los procesos ordenados según orden de llegada
nProc=0;
#Utilizada en todo el programa, es el número total de procesos

# REUBICACIÓN DE MEMORIA
# Factor de reubicación (nº de marcos vacios en memoria necesarios para reubicar la memoria)
# Es necesario debido a que la memoria es no continua
# Si está a 0 durante la ejecución no se reubicará ni comprobará la memoria
# Si está a 0 es como desactivar la posibilidad de reubicar
factReub=0;


#Globales generales


bool=0;	
#Utilizado en varias funciones como booleano auxiliar
counter=0;
#Utilizado en varias funciones como contador para bucles etc
letra="a";
#Utilizado en varias funciones que piden que se escriba s o n
auxiliar=0;
#auxiliar numerico
tMedioEspera=0;
#utilizada en la funcion diagramaResumen, para calcular el tiempo medio de espera de los procesos que hay en memoria
tMedioRetorno=0;
#utilizada en la funcion diagramaResumen, para calcular el tiempo medio de retono de los proceos que hay en memoria


#imprimeprocesos
improcesos=0;
#Utilizada en las funciones imprimeProcesos, para imprimir las lineas de procesos
impaginillas=0;
#Utilizada en las funciones imprimeProcesos, para imprimir las páginas de cada proceso
maxpaginas=0;

#asignaColores
color=0;
#Utilizada para inicializar el vector de colores

#ordenacion
pep=0;
#Utilizado en la funcion ordenacion, para inicializar el vector ordenados con los datos correspondientes
kek=0;
#Utilizado en la funcion ordenacion, para recorrer todos los procesos y asignar el nro de procesos al vector ordenados
jej=0;
#Utilizado en la funcion ordenacion, para recorrer todos los procesos y comprar sus tiempos de llegada
lel=0;
#Utilizado en la funcion ordenacion, para recorrer los procesos ya ordenados y comparar si el actual proceso ha sido ordenado ya
aux=0;
#Utilizado en la funcion ordenacion, para recoger el dato del proceso que se va a introducir en el vector ordenados
max=0;
#Utilizado en la funcion ordenacion, para guardar el dato actual del Maximo tiempo de llegada
one=0;
#Utilizado en la funcion ordenacion, como booleano para comprobar si el actual proceso ha sido ordenado ya

#menuInicio
menu=0;
#Utilizada en la funcion menuInicio, para elegir el algoritmo o la ayuda

#Informe
informe="./Informes/informeBN.txt"; # El nombre del fichero donde se guardará el informe
informeColor="./Informes/informeCOLOR.txt"; # El nombre del fichero donde se guardará el informe a color
bufferEscritura=""; # Variable donde se almacenará el contenido a escribir en el fichero

#seleccionEntrada
opcionIn=0;
#selecciona si introducir los datos por fichero o por teclado

#entradaFichero
ficheroIn=0;
#indica el nombre del fichero de entrada
fichExiste=0;
#indica si el fichero introducido existe
posic=0;                            #
fila=0;	                            #
maxFilas=0;	                        #
tamArchivo=0;                       #
lectura1=0;
lectura2=0;
lectura3=0;
lectura4=0;

#entradaTeclado
otroProc='s';
otraMemoria='s';
#Utilizada en la funcion datosteclado, para comprobar si se quiere introducir o no un nuevo proceso

ficheroAMano="./Datos/datosdefault.txt";
#!#
ficheroUltimaEjecucion="./Datos/datoslast.txt";
ficheroPorDefecto="./Datos/datosdefault.txt";
ficheroRangosUltimaEjecucion="./DatosRangos/datosrangoslast.txt";
ficheroRangosPorDefecto="./DatosRangos/datosrangosdefault.txt";

# # Entrada aleatoria
# ficheroAleatorio="./datosScript/datos.txt";
# ficheroParametrosAleatorios="./datosScript/datosrangos.txt";

# Segundos a esperar en la ejecución automática del algoritmo
segAuto=1;
anchoPorBloque=3;

# Parámetros para la creación de los datos aleatorios.
# Generales
minMarcMem=0;
maxMarcMem=0;
minTamPag=0;
maxTamPag=0;
# 02-05 INICIALIZO EL MINIMO Y EL MAXIMO DEL QUANTUM DE TIEMPO
minQuant=0;
maxQuant=99;
minReub=0;
maxReub=0;
minProcesosAGenerar=0;
maxProcesosAGenerar=0;
procesosAGenerar=0;
# Específicos para los procesos
minMarc=0;  
maxMarc=0;
minTll=0;
maxTll=0;
minPagProc=0;
maxPagProc=0;
minPag=0;
maxPag=0;

# diagramaMemoria

# Nº máximo de procesos
readonly maximoProcesos=99
# Ancho del proceso, usado para rellenar los 0s en los nombrs de los procesos
readonly anchoNumeroProceso=${#maximoProcesos}
# Array con los nombres de los procesos, ej P01
nombreProceso=()
# Al igual que la variable anterior más las secuencias de color de cada proceso
nombreProcesoColor=()



#Utilizada en la funcion diagramaMemoria, el número entero truncado de lo que ocupa cada proceso
tMedioEspera=0;
#utilizada en la funcion diagramaMemoria, para calcular el tiempo medio de espera de los procesos que hay en memoria
tMedioRetorno=0;
#utilizada en la funcion diagramaMemoria, para calcular el tiempo medio de retono de los proceos que hay en memoria
laMedia=0;

#Utilizado en varias funciones para colorear los procesos
colorines=();

tLlegada=();
#Vector que recoge los timepos de llegada
tEjec=();
#Vector que recoge los tiempos de ejecución
tamProceso=();
#Vector que recoge los sizes mínimos estructurales
nMarcos=();
#Vector que recoge la cantidad de marcos de cada proceso
ordenados=();

# 15-05 Agrego vector para prioridad
prProcesos=();

#Vector que recoge el número de páginas por proceso
maxpags=();
#Vector que recoge el número máximo de páginas de los procesos
marcosIni=();
declare -A direcciones
#Vector que recoge las direcciones de página de cada proceso
declare -A paginas
#Vector que recoge las páginas de cada proceso



max=0;
i=0;
fichSelect=0;

ordenados=()            #Guarda el nº de los procesos en orden de llegada.
count=0;                #Para movernos por el vector ordenados.
acabado=0;              #Indica cuando se ha acabado de ordenar los procesos.
nproceso=0;

# número de parametros del sistemas que son generales, no de los procesos.
nParametrosGenerales=5;

hayLog=1

#####################################Tiempo de Entrada CPU#####################
ƒ
# parametro para la entrada de datos por teclado
conEntradaCPU='';

tiempoPorPagina=0;

# Por Proceso
paginasCodigo=();

# Rangos para los tiempos por página
minTiempoPorPagina=0
maxTiempoPorPagina=0

# Rangos para las páginas de código de cada proceso
minPaginasCodigo=0
maxPaginasCodigo=0

# 08-05
prioridadMayorMMenorN="0"
maximoPrioridad=0
minimoPrioridad=0
#####################################Tiempo de Entrada CPU#####################





###################################################################################
######       ##########       ##########       ##########       ##########       ##
###       ##########       ##########       ##########       ##########       #####
##     ##########       ##########       ##########       ##########       ########
##  ##########       ##########       ##########       ##########       ###########
###########       ##########       ##########       ##########       ##########  ##
########       ##########      ############################       ##########     ##
#####       ##########       ####-----------------######       ##########       ###
##       ##########       #######--LAS-CABECERAS--###       ##########       ######
#####       ##########       ####-----------------######       ##########       ###
########       ##########      ############################       ##########     ##
###########       ##########       ##########       ##########       ##########  ##
##  ##########       ##########       ##########       ##########       ###########
##     ##########       ##########       ##########       ##########       ########
###       ##########       ##########       ##########       ##########       #####
######       ##########       ##########       ##########       ##########       ##
###################################################################################

# Cabecera mostrada al inicio del programa
# 08-05 Introduzco mi nombre como autor actual
cabecera()
{
    clear;

    echo -e "\n"\
    "\e[1;48;5;85m                                                  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m                                              \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m               Creative Commons               \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m                                              \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m             BY - Atribución (BY)             \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m          NC - No uso Comercial (NC)          \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m           SA - Compartir Igual (SA)          \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m                                              \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m                                                  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m                                              \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m       \e[1;4;31mALGORITMO RR + OPTIMO + PAGINACIÓN:\e[0m    \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m            \e[1;32mEnrique Padilla Padilla\e[0m           \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m                                              \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m             Autores anteriores:              \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m             Mario Hurtado Ubierna            \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m               David Cezar Toderas            \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m   	 RR+LRU+P  Diego García Muñoz	         \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m  RR+LRU+SP 1º: Fernando Antón, Daniel Beato  \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m RR+LRU+SP 2º: Daniel Mellado, Noelia Ubierna \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m        RR+LFU+SP: Diego Miguel Lozano        \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m LRU 1º: Ruben Uruñuela, Alejandro caballero  \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m   LRU 2º: Daniel Delgado, Ruben Marcos       \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m Entrada datos (Prioridades NFU Paginación):  \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m       Marcos García, Mario de la Parte       \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m                                              \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m       Sistemas Operativos 2º Semestre        \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m Grado en ingeniería informática (2021-2022)  \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m                                              \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m       \e[33mTutor: Jose Manuel Saiz Diez\e[0m           \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m  \e[0m                                              \e[1;48;5;85m  \e[0m\n" \
    "\e[1;48;5;85m                                                  \e[0m\n" \
    "\n" \
    "Pulse \e[1;31mcualquier tecla\e[0m para continuar.";

    read -n 1;
    clear;
}

# Otra cabecera mostrada en la ejecución del algoritmo
cabeceraInicio(){
    echo -e "\n" \
    "\e[1;48;5;159m                                                      \e[0m\n" \
    "\e[1;48;5;159m  \e[0m\e[107m                                                  \e[0m\e[1;48;5;159m  \e[0m\n" \
    "\e[1;48;5;159m  \e[0m\e[1;34;107m                     ALGORITMO                    \e[0m\e[1;48;5;159m  \e[0m\n" \
    "\e[1;48;5;159m  \e[0m\e[34;107m            GESTIÓN DE MEMORIA VIRTUAL            \e[0m\e[1;48;5;159m  \e[0m\n" \
    "\e[1;48;5;159m  \e[0m\e[1;94;107m       -----------------------------------        \e[0m\e[1;48;5;159m  \e[0m\n" \
    "\e[1;48;5;159m  \e[0m\e[1;94;107m       -----------------------------------        \e[0m\e[1;48;5;159m  \e[0m\n" \
    "\e[1;48;5;159m  \e[0m\e[107m                                                  \e[0m\e[1;48;5;159m  \e[0m\n" \
    "\e[1;48;5;159m                                                      \e[0m\n";

}

# Función que imprime las cabeceras al inicio de los informes tanto a color como 
# a blanco y negro
cabeceraInforme(){

    # Cabezera del informe sin color
    
    # 08-05 Modifico cabecera de información con mi nombre

    bufferEscritura="
    ###################################################
    #                                                 #
    #                Creative Commons                 #
    #                                                 #
    #              BY - Atribución (BY)               #
    #           NC - No uso Comercial (NC)            #
    #            SA - Compartir Igual (SA)            #
    #                                                 #
    ###################################################
    #                                                 #
    #               ALGORITMO PRIORIDAD               #
    #          MAYOR/MENOR + NRU + PAGINACIÓN:        #
    #             Enrique Padilla Padilla             #
    #                                                 #
    #              Autores anteriores:                #
    #              Mario Hurtado Ubierna              #
    #              David Cezar Toderas                #
    #       RR + LRU + Segmentación paginada:         #
    # Fernando Antón Ortega, Daniel Beato de la Torre #
    #   LRU 1º: Ruben Uruñuela, Alejandro caballero   #
    #    LRU 2º: Daniel Delgado, Ruben Marcos         #
    #  Entrada datos (Prioridades NFU Paginación):    #
    #        Marcos García, Mario de la Parte         #
    #                                                 #
    #        Sistemas Operativos 2º Semestre          #
    #  Grado en ingeniería informática (2021-2022)    #
    #                                                 #
    #        Tutor: Jose Manuel Saiz Diez             #
    #                                                 #
    ###################################################



    ####################################################
    #                                                  #
    #               INFORME DE PRÁCTICA                #
    #           GESTIÓN DE MEMORIA VIRTUAL             #
    #       -----------------------------------        #
    #       -----------------------------------        #
    #                                                  #
    ####################################################
    ";
    
    printf "$bufferEscritura" > $informe;
    
    # Cabezera del informe con color
    bufferEscritura="
    \e[1;48;5;85m                                                      \e[0m
    \e[1;48;5;85m  \e[0m                                                  \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m                 Creative Commons                 \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m                                                  \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m               BY - Atribución (BY)               \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m            NC - No uso Comercial (NC)            \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m             SA - Compartir Igual (SA)            \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m                                                  \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m                                                      \e[0m
    \e[1;48;5;85m                                                      \e[0m
    \e[1;48;5;85m  \e[0m                                                  \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m         \e[1;4;31mALGORITMO PRIORIDAD MAYOR/MENOR + NRU + PAGINACIÓN:\e[0m         \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m                                                  \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m                \e[1;mEnrique Padilla Padilla\e[0m             \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m                                                  \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m               Autores anteriores:                \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m               Mario Hurtado Ubierna              \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m                David Cezar Toderas               \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m        RR + LRU + Segmentación paginada:         \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m Fernando Antón Ortega, Daniel Beato de la Torre  \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m   LRU 1º: Ruben Uruñuela, Alejandro caballero    \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m     LRU 2º: Daniel Delgado, Ruben Marcos         \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m   Entrada datos (Prioridades NFU Paginación):    \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m         Marcos García, Mario de la Parte         \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m                                                  \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m                                                  \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m         Sistemas Operativos 2º Semestre          \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m   Grado en ingeniería informática (2021-2022)    \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m                                                  \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m         \e[33mTutor: Jose Manuel Saiz Diez\e[0m             \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m  \e[0m                                                  \e[1;48;5;85m  \e[0m
    \e[1;48;5;85m                                                      \e[0m


    \e[1;48;5;159m                                                      \e[0m
    \e[1;48;5;159m  \e[0m\e[107m                                                  \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[1;34;107m               INFORME DE PRÁCTICA                \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[34;107m           GESTIÓN DE MEMORIA VIRTUAL             \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[1;94;107m       -----------------------------------        \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[1;94;107m       -----------------------------------        \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[107m                                                  \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m                                                      \e[0m
    ";

    printf "$bufferEscritura" > $informeColor;
}

# Cabecera mostrada al final de la ejecución del script
cabeceraFinal(){

    # Informe sin color
    bufferEscritura="
    ############################################################
    #                                                          #
    #                   INFORME DE PRÁCTICA                    #
    #               GESTIÓN DE MEMORIA VIRTUAL                 #
    #       -------------------------------------------        #
    #       --------------      FIN       -------------        #
    #       -------------------------------------------        #
    #       -------------------------------------------        #
    #                                                          #
    ############################################################
    ";

    printf "$bufferEscritura" >> $informe;

    # Informe con color
    bufferEscritura="
    \e[1;48;5;159m                                                              \e[0m
    \e[1;48;5;159m  \e[0m\e[107m                                                          \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[1;34;107m                        ALGORITMO                         \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[107m               \e[0m\e[34;107mGESTIÓN DE MEMORIA VIRTUAL\e[0m\e[107m                 \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[107m       \e[0m\e[1;94;107m-------------------------------------------\e[0m\e[107m        \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[107m       \e[0m\e[1;94;107m--------------\e[0m\e[107m      \e[0m\e[1;32;107mFIN\e[0m\e[107m      \e[0m\e[1;94;107m-------------\e[0m\e[107m         \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[107m       \e[0m\e[1;94;107m-------------------------------------------\e[0m\e[107m        \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[107m       \e[0m\e[1;94;107m---------\e[0m\e[107m      \e[0m\e[33;107m           \e[0m\e[107m        \e[0m\e[1;94;107m---------\e[0m\e[107m        \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m  \e[0m\e[107m                                                          \e[0m\e[1;48;5;159m  \e[0m
    \e[1;48;5;159m                                                              \e[0m
    ";

    printf "$bufferEscritura" >> $informeColor;
}

# Cabecera mostrada en la introducción de datos por teclado
cabeceraTeclado(){

    printf "\n \e[1;4;33mINTRODUCCIÓN DE DATOS POR TECLADO PARA EL ALGORITMO\e[0m\n\n"
    printf "\e[1;33m Parámetros generales:\e[0m\n"
    printf " Tamaño de la memoria principal (en direcciones):                           \e[1m%6s\e[0m\n" "${tamMem}"
    printf " Tamaño de cada marco de página (en direcciones):                           \e[1m%6s\e[0m\n" "${tamPag}"
    printf " Marcos de página de la memoria principal:                                  \e[1m%6s\e[0m\n" "${marcosMem}"
    printf " Prioridad Mayor/menor:                                                     \e[1m%6s\e[0m\n" "$(case $prioridadMayorMMenorN in m) echo 'Mayor' ;; n) echo 'Menor';; 0) echo 'Sin definir';; esac)"
    printf " Prioridad mínima:                                                          \e[1m%6s\e[0m\n" "${minimoPrioridad}"
    printf " Prioridad máxima:                                                          \e[1m%6s\e[0m\n" "${maximoPrioridad}"
    
    # 02-05 COMENTO LA LINEA DONDE MUESTRO POR PANTALLA EL QUANTUM DE TIEMPO 
    # printf " Quantum de tiempo:                                                         \e[1m%6s\e[0m\n" "${tamQuant}"
    if [[ "$conEntradaCPU" == 's' || "$conEntradaCPU" == "1"  ]]
    then
        printf " Coste en tiempo por página:                                                \e[1m%6s\e[0m\n" "${tiempoPorPagina}"
    fi
    printf " Factor de reubicación (máximo nº de marcos de página para la reubicación): \e[1m%6s\e[0m\n" "${factReub}"


    printf "\n\e[1;33m Procesos:\e[0m\n"

    # 15-05 Agrego cabeceras para prioridad

    echo -e " Ref Tll Pri Tej nMar Cod Dirección-Página." | tee -a $informeColor
    echo -e " Ref Tll Pri Tej nMar Cod Dirección-Página." >> $informe


    ordenacion
    asignaColores

    if [[ ${#ordenados[@]} -eq 0 ]]; then
        printf " No hay procesos aún.\n\n"
        return 0
    fi
    
    #|Pro|TLl|TEj|nMar|T.M.E|Dir.-Pag.
    # ... ... ... .... ..... ............................
    #  3   3   3    4    5
    for (( improcesos = 1; improcesos <= $p; improcesos++ ))
        do
            ord=${ordenados[$improcesos]}
            if [[ ord -lt 10 ]]
            then
               
                printf " \e[1;3${colorines[$ord]}mP0$ord %3u %3u %4u %3u %3u \e[0m"   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}" | tee -a $informeColor
                printf " P0$ord %3u %3u %4u %3u "   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}"  >> $informe

            else
                printf " \e[1;3${colorines[$ord]}mP$ord %3u %3u %4u %3u %3u  \e[0m"   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}" | tee -a $informeColor
                printf " P$ord %3u %3u %4u %3u "   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}"  >> $informe

            fi
            counter=0;
            maxpaginas=${maxpags[$ord]} 
                for (( impaginillas = 0; impaginillas <  maxpaginas ; impaginillas++ ))
                do
                            echo -en "\e[3${colorines[$ord]}m${direcciones[$ord,$impaginillas]}-\e[1m${paginas[$ord,$impaginillas]}\e[0m " | tee -a $informeColor
                            echo -en "${direcciones[$ord,$impaginillas]}-${paginas[$ord,$impaginillas]} " >> $informe
                done
            echo -e ""
            echo -e "" >> $informeColor
            echo -e "" >> $informe
            maxpaginas=0;
        done

}

# Cabecera mostrada cuando se usan datos aleatorios mediante rangos
CabeceraAleatorio() {

    ##!##
    #printf "\n \e[1;4;33mGENERACIÓN DE DATOS ALEATORIOS PARA EL ALGORITMO\e[0m\n\n"
    printf "\n GENERACIÓN DE DATOS ALEATORIOS PARA EL ALGORITMO\n\n"
    printf "\e[1;33m Rutas de los ficheros que se generarán:\e[0m\n"
    printf " Fichero con los rangos de aleatoriedad: \e[1m%s\e[0m\n" "'${ficheroRangosPorDefecto}'"
    printf " Fichero con los datos ya generados: \e[1m%s\e[0m\n\n" "'${ficheroPorDefecto}'"
    
    


    printf "\e[1;33m Parámetros ya calculados:\t\t\t\t\t\t  Rangos:\e[0m\n"
    printf " Marcos de página de la memoria principal:                        \e[1m%6s\e[0m  Min: \e[1m%6s\e[0m Max: \e[1m%6s\e[0m\n" "${marcosMem}" "${minMarcMem}" "${maxMarcMem}"
    printf " Tamaño de cada marco de página (en direcciones):                 \e[1m%6s\e[0m  Min: \e[1m%6s\e[0m Max: \e[1m%6s\e[0m\n" "${tamPag}" "${minTamPag}" "${maxTamPag}"
    printf " Tamaño de la memoria principal (en direcciones):                 \e[1m%6s\e[0m\n" "${tamMem}"
    printf " Factor de reubicación:                                           \e[1m%6s\e[0m  Min: \e[1m%6s\e[0m Max: \e[1m%6s\e[0m\n" "${factReub}" "${minReub}" "${maxReub}"
    # 02-05 COMENTO LA LINEA DONDE MUESTRO POR PANTALLA EL QUANTUM DE TIEMPO
    # printf " Quantum de tiempo:                                               \e[1m%6s\e[0m  Min: \e[1m%6s\e[0m Max: \e[1m%6s\e[0m\n" "${tamQuant}" "${minQuant}" "${maxQuant}"
    if [[  "$conEntradaCPU" == 's' || "$conEntradaCPU" == "1" ]]
    then
        printf " Coste de tiempo por pagina:                                      \e[1m%6s\e[0m  Min: \e[1m%6s\e[0m Max: \e[1m%6s\e[0m\n" "${tiempoPorPagina}" "${minTiempoPorPagina}" "${maxTiempoPorPagina}"
    fi
    printf " Procesos a generar:                                              \e[1m%6s\e[0m  Min: \e[1m%6s\e[0m Max: \e[1m%6s\e[0m\n" "${procesosAGenerar}" "${minProcesosAGenerar}" "${maxProcesosAGenerar}"
    printf " Número de marcos asociados a cada proceso (solo rangos).                 Min: \e[1m%6s\e[0m Max: \e[1m%6s\e[0m\n" "${minMarc}" "${maxMarc}"
    printf " Tiempo de llegada de cada proceso (solo rangos).                         Min: \e[1m%6s\e[0m Max: \e[1m%6s\e[0m\n" "${minTll}" "${maxTll}"
    printf " Número de direcciones a ejecutar de cada proceso (solo rangos).          Min: \e[1m%6s\e[0m Max: \e[1m%6s\e[0m\n" "${minPagProc}" "${maxPagProc}"
    if [[ "$conEntradaCPU" == "1" || "$conEntradaCPU" == 's' ]]
    then
        printf " Páginas de código                                                        Min: \e[1m%6s\e[0m Max: \e[1m%6s\e[0m\n" "${minPaginasCodigo}" "${maxPaginasCodigo}"
    fi
    printf " Tamaño de cada proceso (en direcciones) (solo rangos).                   Min: \e[1m%6s\e[0m Max: \e[1m%6s\e[0m\n\n" "${minPag}" "${maxPag}"

}

# Función que imprime un aviso de poner la terminal a pantalla completa
imprimeTamano(){

    echo -e "
    
    Para una correcta visualización del programa,
    Se recomienda poner la terminal en \e[1;31mpantalla completa\e[0m

    ";
    read -p "   Pulse INTRO cuando haya ajustado el Tamaño";
    anchoDeTerminal=$COLUMNS;
    clear;
    cabeceraInicio;

}

###################################################################################
######                           #################                           ######
########                           #############                           ########
##   #########################################################################   ##
##     #####                           #####                           #####     ##
##       #####                           #                           #####       ##
##        ############################### ###############################        ##
##         ##########  ########---------------------########  ##########         ##
##         ########      ######--ENTRADA-DE-DATOS---######      ########         ##
##         ##########  ########---------------------########  ##########         ##
##        ############################### ###############################        ##
##       #####                           #                           #####       ##
##     #####                           #####                           #####     ##
##   #########################################################################   ##
########                           #############                           ########
######                           #################                           ######
###################################################################################

# Menú de selección entre Ejecución del algoritmo y mostrar la ayuda
menuInicio(){
    
    clear;
    cabeceraInicio;
    echo -e "
    \e[1;38;5;81m¿Desea leer el fichero de ayuda o ejecutar el algoritmo?\e[0m

    \e[1;32m   [1]\e[0m -> Ejecutar el algoritmo
    \e[1;32m   [2]\e[0m -> Visualizar la ayuda
    ";
    read -p "   Seleccione la opción: " menu;

    until [[ "$menu" = "1" || "$menu" = "2" ]]
        do
            echo -en "\n\e[1;31m    Valor incorrecto, escriba \e[1;33m1\e[0m \e[1;31mo\e[0m \e[1;33m2\e[0m\e[1;31m: \e[0m";
            read menu;
        done
    if [ "$menu" = 2 ]
        then
            clear;
            cabeceraInicio;
            echo -e "
    \e[1;38;5;81m¿Desea leer el fichero de ayuda o ejecutar el algoritmo?\e[0m
    
    \e[1;32m   [1]\e[0m -> Ejecutar el algoritmo
    \e[1;38;5;64;48;5;7m   [2]\e[90m -> Visualizar la ayuda	\e[0m\n";
            sleep 0.5;

        else
            clear;
            cabeceraInicio;
            echo -e "
    \e[1;38;5;81m¿Desea leer el fichero de ayuda o ejecutar el algoritmo?\e[0m
    
    \e[1;38;5;64;48;5;7m   [1]\e[90m -> Ejecutar el algoritmo   \e[0m
    \e[1;32m   [2]\e[0m -> Visualizar la ayuda\n";
            sleep 0.5;
    fi
}

# Menú para elegir los nombres con los que se guardarán los informes
seleccionInforme(){

    clear;
    cabeceraInicio;
    echo -e "
    \e[1;38;5;81mLos nombres por defecto de los informes son:\e[0m \e[1;32minformeBN.txt\e[0m \e[1;38;5;81me\e[0m \e[1;33minformeCOLOR.txt\e[0m
    \e[1;38;5;81m¿Desea cambiarlos?\e[0m
    
    \e[1;32m   [s]\e[0m -> Sí
    \e[1;32m   [n]\e[0m -> No
    ";
    read -p "   Seleccione la opción: " cambiarInformes;

    until [[ "$cambiarInformes" =~ [sSnN] ]]
        do
            echo -e -n "\n\e[1;31m   Valor incorrecto, escriba \e[1;33ms\e[0m \e[1;31mo\e[0m \e[1;33mn\e[0m\e[1;31m: \e[0m";
            read cambiarInformes;
        done
    if [[ "$cambiarInformes" =~ [sS] ]]
        then
            clear;
            cabeceraInicio;
            echo -e "
    \e[1;38;5;81mLos nombres por defecto de los informes son:\e[0m \e[1;32minformeBN.txt\e[0m \e[1;38;5;81me\e[0m \e[1;33minformeCOLOR.txt\e[0m
    \e[1;38;5;81m¿Desea cambiarlos?\e[0m
    
    \e[1;38;5;64;48;5;7m   [s]\e[90m -> Sí   \e[0m
    \e[1;32m   [n]\e[0m -> No\n";
            sleep 0.5;
            clear;
            cabeceraInicio;
            echo -n -e "\n\e[1m   Por favor introduzca el nombre del informe de texto plano \e[31m(sin incluir \".txt\")\e[0m: ";
            read informe;
            informe="./Informes/${informe}.txt";
            sleep 0.2;
            clear;
            cabeceraInicio;
            echo -n -e "\n\e[1m   Por favor introduzca el nombre del informe a color \e[31m(sin incluir \".txt\")\e[0m: ";
            read informeColor;
            informeColor="./Informes/${informeColor}.txt";
            sleep 0.2;
            clear;
        else
            clear;
            cabeceraInicio;
            echo -e "
    \e[1;38;5;81mLos nombres por defecto de los informes son:\e[0m \e[1;32minformeBN.txt\e[0m \e[1;38;5;81me\e[0m \e[1;33minformeCOLOR.txt\e[0m
    \e[1;38;5;81m¿Desea cambiarlos?\e[0m

    \e[1;32m   [s]\e[0m -> Sí
    \e[1;38;5;64;48;5;7m   [n]\e[90m -> No   \e[0m\n";
            sleep 0.5;
            clear;
    fi
	# echo "$informeColor  $informe"
	# sleep 2
    touch $informe;
    touch $informeColor;
    cabeceraInforme;
    
}


# Función que permite elegir el modo de entrada de datos
seleccionEntrada(){

    local reg='^[1-9]{1}$'

    clear;
    cabeceraInicio;
    echo -e "\e[1;38;5;81m¿Desea introducir los datos por teclado, por fichero o de forma aleatoria?: \e[0m\n\n"\
            "\e[1;32m   [1]\e[0m -> Introducir por teclado\n"\
            "\e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)\n"\
            "\e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)\n"\
            "\e[1;32m   [4]\e[0m -> Otro fichero de datos\n"\
            "\e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales\n"\
            "\e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)\n"\
            "\e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)\n"\
            "\e[1;32m   [8]\e[0m -> Otro fichero de rangos\n"\
            "\e[1;32m   [9]\e[0m -> Aleatorio Total\n\n";
            
    read -p "   Seleccione la opción: " opcionIn;

    until [[ "$opcionIn" =~ $reg ]]
        do
            echo -e -n "\n\e[1;31m   Valor incorrecto, escriba un \e[1;33mnúmero entre 1 y 9\e[0m\e[1;31m: ";
            read opcionIn;
        done
        
    echo -e "\n¿Desea  introducir los datos por teclado, por fichero o de forma aleatoria?: " >> $informe
    echo -e "\n\e[1;38;5;81m¿Desea introducir los datos por teclado, por fichero o de forma aleatoria?: \e[0m" >> $informeColor

    case $opcionIn in
        1) # Introducir por teclado
        clear;
        cabeceraInicio;
        echo -e "\e[1;38;5;81m¿Desea introducir los datos por teclado, por fichero o de forma aleatoria?:\n\n"\
                "\e[1;38;5;64;48;5;7m   [1]\e[90m -> Introducir por teclado	\e[0m\n"\
                "\e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)\n"\
                "\e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)\n"\
                "\e[1;32m   [4]\e[0m -> Otro fichero de datos\n"\
                "\e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales\n"\
                "\e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)\n"\
                "\e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)\n"\
                "\e[1;32m   [8]\e[0m -> Otro fichero de rangos\n"\
                "\e[1;32m   [9]\e[0m -> Aleatorio Total\n\n";
        
        # Log al informe
        bufferEscritura="
    \e[1;38;5;64;48;5;7m   [1]\e[90m -> Introducir por teclado	\e[0m
    \e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)
    \e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)
    \e[1;32m   [4]\e[0m -> Otro fichero de datos
    \e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales
    \e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)
    \e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)
    \e[1;32m   [8]\e[0m -> Otro fichero de rangos
    \e[1;32m   [9]\e[0m -> Aleatorio Total\n";

        echo -e "$bufferEscritura" >> $informeColor;

        bufferEscritura="
    -> Introducir por teclado <-
       Fichero de datos de última ejecución (datoslast.txt)
       Fichero de datos por defecto (datosdefault.txt)
       Otro fichero de datos
       Utilizar datos aleatorios manuales
       Fichero de rangos de última ejecución (datosrangoslast.txt)
       Fichero de rangos por defecto (datosrangosdefault.txt)
       Otro fichero de rangos
       Aleatorio Total\n"

        echo -e "$bufferEscritura" >> $informe;

        sleep 0.5;
        entradaTeclado;
        ;;
        2) #Fichero de datos de última ejecución
        clear;
        cabeceraInicio;

        echo -e "\e[1;38;5;81m¿Desea introducir los datos por teclado, por fichero o de forma aleatoria?:\n\n"\
                "\e[1;32m   [1]\e[0m -> Introducir por teclado\n"\
                "\e[1;38;5;64;48;5;7m   [2]\e[90m -> Fichero de datos de última ejecución (datoslast.txt)\e[0m\n"\
                "\e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)\n"\
                "\e[1;32m   [4]\e[0m -> Otro fichero de datos\n"\
                "\e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales\n"\
                "\e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)\n"\
                "\e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)\n"\
                "\e[1;32m   [8]\e[0m -> Otro fichero de rangos\n"\
                "\e[1;32m   [9]\e[0m -> Aleatorio Total\n\n";
        


        # Log al informe
        bufferEscritura="
    \e[1;32m   [1]\e[0m -> Introducir por teclado
    \e[1;38;5;64;48;5;7m   [2]\e[90m -> Fichero de datos de última ejecución (datoslast.txt)\e[0m
    \e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)
    \e[1;32m   [4]\e[0m -> Otro fichero de datos
    \e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales
    \e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)
    \e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)
    \e[1;32m   [8]\e[0m -> Otro fichero de rangos
    \e[1;32m   [9]\e[0m -> Aleatorio Total\n";

        echo -e "$bufferEscritura" >> $informeColor;

    bufferEscritura="
       Introducir por teclado
    -> Fichero de datos de última ejecución (datoslast.txt) <-
       Fichero de datos por defecto (datosdefault.txt)
       Otro fichero de datos
       Utilizar datos aleatorios manuales
       Fichero de rangos de última ejecución (datosrangoslast.txt)
       Fichero de rangos por defecto (datosrangosdefault.txt)
       Otro fichero de rangos
       Aleatorio Total\n"

        echo -e "$bufferEscritura" >> $informe;

        sleep 0.5;
        # entradaUltimoFichero;
        IntroduccionDeDatosPorFichero $ficheroUltimaEjecucion
        imprimeProcesosFichero;

        ;;
        3) #Fichero de datos por defecto
        clear;
        cabeceraInicio;
        
        echo -e "\e[1;38;5;81m¿Desea introducir los datos por teclado, por fichero o de forma aleatoria?:\n\n"\
                "\e[1;32m   [1]\e[0m -> Introducir por teclado\n"\
                "\e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)\n"\
                "\e[1;38;5;64;48;5;7m   [3]\e[90m -> Fichero de datos por defecto (datosdefault.txt)\e[0m\n"\
                "\e[1;32m   [4]\e[0m -> Otro fichero de datos\n"\
                "\e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales\n"\
                "\e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)\n"\
                "\e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)\n"\
                "\e[1;32m   [8]\e[0m -> Otro fichero de rangos\n"\
                "\e[1;32m   [9]\e[0m -> Aleatorio Total\n\n";
        # Log al informe
        bufferEscritura="
    \e[1;32m   [1]\e[0m -> Introducir por teclado	\e[0m
    \e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)
    \e[1;38;5;64;48;5;7m   [3]\e[90m -> Fichero de datos por defecto (datosdefault.txt)\e[0m
    \e[1;32m   [4]\e[0m -> Otro fichero de datos
    \e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales
    \e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)
    \e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)
    \e[1;32m   [8]\e[0m -> Otro fichero de rangos
    \e[1;32m   [9]\e[0m -> Aleatorio Total\n";

        echo -e "$bufferEscritura" >> $informeColor;

        bufferEscritura="
       Introducir por teclado
       Fichero de datos de última ejecución (datoslast.txt) 
    -> Fichero de datos por defecto (datosdefault.txt) <-
       Otro fichero de datos
       Utilizar datos aleatorios manuales
       Fichero de rangos de última ejecución (datosrangoslast.txt)
       Fichero de rangos por defecto (datosrangosdefault.txt)
       Otro fichero de rangos
       Aleatorio Total\n"

        echo -e "$bufferEscritura" >> $informe;

        sleep 0.5;
        IntroduccionDeDatosPorFichero $ficheroPorDefecto
        copiarAUltimaEjecucion "$ficheroPorDefecto"
        imprimeProcesosFichero
        ;;
        4) # Otro fichero de datos
        clear;
        cabeceraInicio;
  
        echo -e "\e[1;38;5;81m¿Desea introducir los datos por teclado, por fichero o de forma aleatoria?:\n\n"\
                "\e[1;32m   [1]\e[0m -> Introducir por teclado\n"\
                "\e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)\n"\
                "\e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)\n"\
                "\e[1;38;5;64;48;5;7m   [4]\e[90m -> Otro fichero de datos\e[0m\n"\
                "\e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales\n"\
                "\e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)\n"\
                "\e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)\n"\
                "\e[1;32m   [8]\e[0m -> Otro fichero de rangos\n"\
                "\e[1;32m   [9]\e[0m -> Aleatorio Total\n\n";

                bufferEscritura="
    \e[1;32m   [1]\e[0m -> Introducir por teclado	\e[0m
    \e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)
    \e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)
    \e[1;38;5;64;48;5;7m   [4]\e[90m -> Otro fichero de datos\e[0m
    \e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales
    \e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)
    \e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)
    \e[1;32m   [8]\e[0m -> Otro fichero de rangos
    \e[1;32m   [9]\e[0m -> Aleatorio Total\n";

        echo -e "$bufferEscritura" >> $informeColor;

        bufferEscritura="
       Introducir por teclado
       Fichero de datos de última ejecución (datoslast.txt) 
       Fichero de datos por defecto (datosdefault.txt) 
    -> Otro fichero de datos <-
       Utilizar datos aleatorios manuales
       Fichero de rangos de última ejecución (datosrangoslast.txt)
       Fichero de rangos por defecto (datosrangosdefault.txt)
       Otro fichero de rangos
       Aleatorio Total\n"

        echo -e "$bufferEscritura" >> $informe;

        sleep 0.5;
        entradaFichero;
        IntroduccionDeDatosPorFichero "./Datos/$ficheroIn"
        copiarAUltimaEjecucion "./Datos/$ficheroIn"
        imprimeProcesosFichero

        ;;
        5) #Introduccion manual rangos
        clear;
        cabeceraInicio;

        
        echo -e "\e[1;38;5;81m¿Desea introducir los datos por teclado, por fichero o de forma aleatoria?:\n\n"\
                "\e[1;32m   [1]\e[0m -> Introducir por teclado\n"\
                "\e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)\n"\
                "\e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)\n"\
                "\e[1;32m   [4]\e[0m -> Otro fichero de datos\n"\
                "\e[1;38;5;64;48;5;7m   [5]\e[90m -> Utilizar datos aleatorios manuales\e[0m\n"\
                "\e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)\n"\
                "\e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)\n"\
                "\e[1;32m   [8]\e[0m -> Otro fichero de rangos\n"\
                "\e[1;32m   [9]\e[0m -> Aleatorio Total\n\n";

        bufferEscritura="
    \e[1;32m   [1]\e[0m -> Introducir por teclado	
    \e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)
    \e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)
    \e[1;32m   [4]\e[0m -> Otro fichero de datos
    \e[1;38;5;64;48;5;7m   [5]\e[90m -> Utilizar datos aleatorios manuales\e[0m
    \e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)
    \e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)
    \e[1;32m   [8]\e[0m -> Otro fichero de rangos
    \e[1;32m   [9]\e[0m -> Aleatorio Total\n";
        echo -e "$bufferEscritura" >> $informeColor;

        bufferEscritura="
       Introducir por teclado
       Fichero de datos de última ejecución (datoslast.txt) 
       Fichero de datos por defecto (datosdefault.txt) 
       Otro fichero de datos 
    -> Utilizar datos aleatorios manuales <-
       Fichero de rangos de última ejecución (datosrangoslast.txt)
       Fichero de rangos por defecto (datosrangosdefault.txt)
       Otro fichero de rangos
       Aleatorio Total\n"


        echo -e "$bufferEscritura" >> $informe;

        sleep 0.5;
        entradaAleatoria;
        copiarAUltimaEjecucion "$ficheroPorDefecto"

        ;;
        6) # Datos rangos de última ejecución
        clear;
        cabeceraInicio;

        echo -e "\e[1;38;5;81m¿Desea introducir los datos por teclado, por fichero o de forma aleatoria?:\n\n"\
                "\e[1;32m   [1]\e[0m -> Introducir por teclado\n"\
                "\e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)\n"\
                "\e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)\n"\
                "\e[1;32m   [4]\e[0m -> Otro fichero de datos\n"\
                "\e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales\n"\
                "\e[1;38;5;64;48;5;7m   [6]\e[90m -> Fichero de rangos de última ejecución (datosrangoslast.txt)\e[0m\n"\
                "\e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)\n"\
                "\e[1;32m   [8]\e[0m -> Otro fichero de rangos\n"\
                "\e[1;32m   [9]\e[0m -> Aleatorio Total\n\n";


        bufferEscritura="
    \e[1;32m   [1]\e[0m -> Introducir por teclado
    \e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)
    \e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)
    \e[1;32m   [4]\e[0m -> Otro fichero de datos
    \e[1;32m   [5]\e[00m -> Utilizar datos aleatorios manuales
    \e[1;38;5;64;48;5;7m   [6]\e[90m -> Fichero de rangos de última ejecución (datosrangoslast.txt)\e[0m
    \e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)
    \e[1;32m   [8]\e[0m -> Otro fichero de rangos
    \e[1;32m   [9]\e[0m -> Aleatorio Total\n";

        echo -e "$bufferEscritura" >> $informeColor;

        bufferEscritura="
       Introducir por teclado
       Fichero de datos de última ejecución (datoslast.txt) 
       Fichero de datos por defecto (datosdefault.txt) 
       Otro fichero de datos 
       Utilizar datos aleatorios manuales 
    -> Fichero de rangos de última ejecución (datosrangoslast.txt) <-
       Fichero de rangos por defecto (datosrangosdefault.txt)
       Otro fichero de rangos
       Aleatorio Total\n"

        echo -e "$bufferEscritura" >> $informe;

        # entradaUltimosParametrosAleatorios;
        IntroduccionDeRangosPorFichero "$ficheroRangosUltimaEjecucion"
        sleep 0.5;

        ;;
       7) # Datos de rangos por defecto
        clear;
        cabeceraInicio;

        echo -e "\e[1;38;5;81m¿Desea introducir los datos por teclado, por fichero o de forma aleatoria?:\n\n"\
                "\e[1;32m   [1]\e[0m -> Introducir por teclado	\n"\
                "\e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)\n"\
                "\e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)\n"\
                "\e[1;32m   [4]\e[0m -> Otro fichero de datos\n"\
                "\e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales\n"\
                "\e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)\n"\
                "\e[1;38;5;64;48;5;7m   [7]\e[90m -> Fichero de rangos por defecto (datosrangosdefault.txt)\e[0m\n"\
                "\e[1;32m   [8]\e[0m -> Otro fichero de rangos\n"\
                "\e[1;32m   [9]\e[0m -> Aleatorio Total\n\n";

        bufferEscritura="
    \e[1;32m   [1]\e[0m -> Introducir por teclado	
    \e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)
    \e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)
    \e[1;32m   [4]\e[0m -> Otro fichero de datos
    \e[1;32m   [5]\e[00m -> Utilizar datos aleatorios manuales
    \e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)
    \e[1;38;5;64;48;5;7m   [7]\e[90m -> Fichero de rangos por defecto (datosrangosdefault.txt)\e[0m
    \e[1;32m   [8]\e[0m -> Otro fichero de rangos
    \e[1;32m   [9]\e[0m -> Aleatorio Total\n";

        echo -e "$bufferEscritura" >> $informeColor;

        bufferEscritura="
       Introducir por teclado
       Fichero de datos de última ejecución (datoslast.txt) 
       Fichero de datos por defecto (datosdefault.txt) 
       Otro fichero de datos 
       Utilizar datos aleatorios manuales 
       Fichero de rangos de última ejecución (datosrangoslast.txt)
    -> Fichero de rangos por defecto (datosrangosdefault.txt) <-
       Otro fichero de rangos
       Aleatorio Total\n"

        echo -e "$bufferEscritura" >> $informe;
        # entradaParametrosAleatorios;
        IntroduccionDeRangosPorFichero "$ficheroRangosPorDefecto"
        sleep 0.5;
       ;;
       8) # Otro fichero de rangos
        clear;
        cabeceraInicio;

        echo -e "\e[1;38;5;81m¿Desea introducir los datos por teclado, por fichero o de forma aleatoria?:\n\n"\
                "\e[1;32m   [1]\e[0m -> Introducir por teclado	\n"\
                "\e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)\n"\
                "\e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)\n"\
                "\e[1;32m   [4]\e[0m -> Otro fichero de datos\n"\
                "\e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales\n"\
                "\e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)\n"\
                "\e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)\n"\
                "\e[1;38;5;64;48;5;7m   [8]\e[90m -> Otro fichero de rangos\e[0m\n"\
                "\e[1;32m   [9]\e[0m -> Aleatorio Total\n\n";

        bufferEscritura="
    \e[1;32m   [1]\e[0m -> Introducir por teclado	
    \e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)
    \e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)
    \e[1;32m   [4]\e[0m -> Otro fichero de datos
    \e[1;32m   [5]\e[00m -> Utilizar datos aleatorios manuales
    \e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)
    \e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)
    \e[1;38;5;64;48;5;7m   [8]\e[90m -> Otro fichero de rangos\e[0m
    \e[1;32m   [9]\e[0m -> Aleatorio Total\n";
        echo -e "$bufferEscritura" >> $informeColor;


        bufferEscritura="
       Introducir por teclado
       Fichero de datos de última ejecución (datoslast.txt) 
       Fichero de datos por defecto (datosdefault.txt) 
       Otro fichero de datos 
       Utilizar datos aleatorios manuales 
       Fichero de rangos de última ejecución (datosrangoslast.txt)
       Fichero de rangos por defecto (datosrangosdefault.txt)
    -> Otro fichero de rangos <-
       Aleatorio Total\n"
        echo -e "$bufferEscritura" >> $informe;

        entradaParametrosAleatorios;
        sleep 0.5;

       ;;
       9) # Aleatorio total
            clear;
            cabeceraInicio;

        echo -e "\e[1;38;5;81m¿Desea introducir los datos por teclado, por fichero o de forma aleatoria?:\n\n"\
                "\e[1;32m   [1]\e[0m -> Introducir por teclado\n"\
                "\e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)\n"\
                "\e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)\n"\
                "\e[1;32m   [4]\e[0m -> Otro fichero de datos\n"\
                "\e[1;32m   [5]\e[0m -> Utilizar datos aleatorios manuales\n"\
                "\e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)\n"\
                "\e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)\n"\
                "\e[1;32m   [8]\e[0m -> Otro fichero de rangos\n"\
                "\e[1;38;5;64;48;5;7m   [9]\e[90m -> Aleatorio Total\e[0m\n\n";

        bufferEscritura="
    \e[1;32m   [1]\e[0m -> Introducir por teclado	
    \e[1;32m   [2]\e[0m -> Fichero de datos de última ejecución (datoslast.txt)
    \e[1;32m   [3]\e[0m -> Fichero de datos por defecto (datosdefault.txt)
    \e[1;32m   [4]\e[0m -> Otro fichero de datos
    \e[1;32m   [5]\e[00m -> Utilizar datos aleatorios manuales
    \e[1;32m   [6]\e[0m -> Fichero de rangos de última ejecución (datosrangoslast.txt)
    \e[1;32m   [7]\e[0m -> Fichero de rangos por defecto (datosrangosdefault.txt)
    \e[1;32m   [8]\e[0m -> Otro fichero de rangos
    \e[1;38;5;64;48;5;7m   [9]\e[90m -> Aleatorio Total\e[0m\n";
            echo -e "$bufferEscritura" >> $informeColor;


        bufferEscritura="
       Introducir por teclado
       Fichero de datos de última ejecución (datoslast.txt) 
       Fichero de datos por defecto (datosdefault.txt) 
       Otro fichero de datos 
       Utilizar datos aleatorios manuales 
       Fichero de rangos de última ejecución (datosrangoslast.txt)
       Fichero de rangos por defecto (datosrangosdefault.txt)
       Otro fichero de rangos
    -> Aleatorio Total <-\n"

            echo -e "$bufferEscritura" >> $informe;
            IntroduccionDeRangosPorFichero "./DatosRangos/datosaleatoriototal.txt"
            sleep 0.5;
    ;; 
    esac
}

# Función de entrada de datos de ejecución del algoritmo por teclado
entradaTeclado(){

    local temp=""

    # Preguntar por los nombres de los ficheros

    clear
    echo -en "\n \e[1;4;33mINTRODUCCIÓN DE DATOS POR TECLADO PARA EL ALGORITMO\e[0m\n\n"\
             " \e[1;33mNombre del fichero de datos a crear: \e[0m\n"\
             " \e[1;33m[1]\e[0m => Nombre por defecto: \e[1mdatosdefault.txt\e[0m\n"\
             " \e[1;33m[2]\e[0m => Otro nombre.\n\n"\
             " Elige una de las opciones anteriores: "
    read -r temp

    until [[ "$temp" =~ [1-2] ]]; do
        echo -en "\n\e[1;31m  Valor incorrecto, escriba \e[1;33m1 o 2\e[0m\e[1;31m: ";
        read temp;
    done

    if [[ "$temp" -eq 2 ]]; then
        echo -en "\n  Introduce el \e[1;33mnombre\e[0m que debe tener el \e[1;33mfichero de datos a crear\e[0m \e[1m(sin '.txt')\e[0m: "
        read -r temp
        ficheroAMano="./Datos/${temp}.txt"
    else
        #!#
        ficheroAMano="./Datos/datosdefault.txt";
    fi

    touch "$ficheroAMano";
    
    # Pedir datos
    
    clear;
    cabeceraTeclado;
    
    echo -n -e " Introduzca el Tamaño de la \e[1;33mmemoria\e[0m: ";
    read tamMem;
    echo -n " Introduzca el Tamaño de la memoria: " >> $informe;
    echo -n -e " Introduzca el Tamaño de la \e[1;33mmemoria\e[0m: " >> $informeColor;
    until [[ $tamMem =~ [0-9] && $tamMem -gt 0 ]]
        do
            echo -e "\n\e[1;31m El Tamaño de memoria debe ser mayor que \e[0m\e[1;33m0\e[0m";
            echo -n -e " Introduzca el Tamaño de la \e[1;33mmemoria\e[0m: ";
            read tamMem;
        done
    echo "$tamMem" >> $informe;
    echo -e "\e[1;32m$tamMem\e[0m" >> $informeColor;

    sleep 0.2;
    clear;
    cabeceraTeclado;
    
    echo -n -e " Introduzca el Tamaño de cada \e[1;33mmarco\e[0m: ";
    read tamPag;
    echo -n " Introduzca el Tamaño de cada marco: " >> $informe;
    echo -n -e " Introduzca el Tamaño de cada \e[1;33mmarco\e[0m: " >> $informeColor;

    until [[ $tamPag =~ [0-9] && $tamPag -gt 0 ]]
        do
            echo -e "\n\e[1;31m El Tamaño de cada marco debe ser mayor que 0\e[0m";
            echo -n -e " Introduzca el Tamaño de cada \e[1;33mmarco\e[0m: ";
            read tamPag;
        done
    
    echo -e "$tamPag\n" >> $informe;
    echo -e "\e[1;32m$tamPag\e[0m\n" >> $informeColor;
    
    marcosMem=$(($tamMem/$tamPag));

    sleep 0.2;
    clear;
    cabeceraTeclado;

    # 02-05 COMENTO LA LINEA DONDE PIDO AL USUARIO EL QUANTUM DE TIEMPO
    # echo -n -e " Introduzca el \e[1;33mquantum\e[0m de tiempo de ejecución de Round Robin: ";
    # read tamQuant;
    # echo -n " Introduzca el quantum de tiempo de ejecución de Round Robin: " >> $informe;
    # echo -n -e " Introduzca el \e[1;33mquantum\e[0m de tiempo de ejecución de Round Robin: " >> $informeColor;
    # until [[ $tamQuant =~ [0-9] && $tamQuant -gt 0 ]]
    #     do
    #         echo -e "\n\e[1;31m El quantum debe ser mayor que 0\e[0m";
    #         echo -n -e " Introduzca el \e[1;33mquantum\e[0m de tiempo de ejecución de Round Robin: ";
    #         read tamQuant;
    #     done
    # echo "$tamQuant" >> $informe;
    # echo -e "\e[1;32m$tamQuant\e[0m" >> $informeColor

    # sleep 0.2;
    # clear;
    # cabeceraTeclado;



    echo -n -e " ¿Quiere que haya \e[1;33mtiempos de entrada a CPU\e[0m?(s/n): ";
    echo -n -e " ¿Quiere que haya \e[1;33mtiempos de entrada a CPU\e[0m?(s/n): " >> $informeColor
    echo -n " ¿Quiere que haya tiempos de entrada a CPU?(s/n): " >> $informe
    read conEntradaCPU

    until [[ "$conEntradaCPU" == 's' || "$conEntradaCPU" == 'n' ]]
    do
        echo -n -e " ¿Quiere que haya \e[1;33mtiempos de entrada a CPU\e[0m?(s/n): ";
        read conEntradaCPU
    done
    sleep 0.2;
    clear;
    cabeceraTeclado;

     if [[ "$conEntradaCPU" == 's' ]]
    then
        echo -n -e " Introduzca el \e[1;33mtiempo por pagina\e[0m en entrada a la CPU: ";
        read tiempoPorPagina;
        echo -n " Introduzca el tiempo por pagina en entrada a la CPU: " >> $informe;
        echo -n -e " Introduzca el \e[1;33mtiempo por pagina\e[0m en entrada a la CPU: " >> $informeColor;
        until [[ $tiempoPorPagina =~ [0-9] && $tiempoPorPagina -gt 0 ]]
            do
                echo -e "\n\e[1;31m El coste debe ser mayor que 0\e[0m";
                echo -n -e " Introduzca el \e[1;33mtiempo por pagina\e[0m: ";
                read tiempoPorPagina;
            done
        echo "$tiempoPorPagina" >> $informe;
        echo -e "\e[1;32m$tiempoPorPagina\e[0m" >> $informeColor;
        
        sleep 0.2;
        clear;
        cabeceraTeclado;

        conEntradaCPU=1
        sleep 0.2;
        clear;
        cabeceraTeclado;

    else
        tiempoPorPagina=0
        conEntradaCPU=0
    fi

    # 08-05 Datos de prioridad mayor menor a introducir por teclado

    echo -n -e " ¿Quieres\e[1;33m prioridad\e[0m Mayor (m) o Menor(n)? ";
    read prioridadMayorMMenorN;
    
    prioridadMayorMMenorN=$(echo "$prioridadMayorMMenorN" | tr '[:upper:]' '[:lower:]')
    echo -n " ¿Quieres prioridad Mayor (m) o Menor (n)? " >> $informe;
    echo -n -e " ¿Quieres\e[1;33m prioridad\e[0m Mayor (m) o Menor(n)? " >> $informeColor;

    until [[ "$prioridadMayorMMenorN" == "m" || "$prioridadMayorMMenorN" == "n" ]];
        do
            echo -e "\n\e[1;31m Las opciones validas son m para prioridad mayor y n para prioridad menor \e[0m";
            echo -n -e " ¿Quieres\e[1;33m prioridad\e[0m Mayor (m) o Menor(n)? ";
            read prioridadMayorMMenorN;
            prioridadMayorMMenorN=$(echo "$prioridadMayorMMenorN" | tr '[:upper:]' '[:lower:]')
        done
    echo "$prioridadMayorMMenorN" >> $informe;
    echo -e "\e[1;32m$prioridadMayorMMenorN\e[0m" >> $informeColor;

    sleep 0.2;
    clear;
    cabeceraTeclado;

    # 09-05 Introduzco prioridad maxima y minima

    # Pido prioridad minima y compruebo que sea un número mayor o igual a 0
    echo -n -e " Introduzca la \e[1;33m prioridad mínima \e[0m";
    read minimoPrioridad;
    
    while ! [[ "$minimoPrioridad" =~ ^[0-9]+$ ]]; do
        echo -e "\n\e[1;31m Solo es valido un numero mayor o igual que 0\e[0m";
        echo -n -e " Introduzca la \e[1;33m prioridad mínima \e[0m";
        read minimoPrioridad;
    done

    sleep 0.2;
    clear;
    cabeceraTeclado;

    # Pido prioridad maxima y compruebo que sea un número mayor que la prioridad mínima
    echo -n -e " Introduzca la \e[1;33m prioridad máxima \e[0m";
    read maximoPrioridad;
    
    while ! [ "$maximoPrioridad" -gt "$minimoPrioridad" ] && [[ "$maximoPrioridad" =~ ^[0-9]+$ ]]; do
        echo -e "\n\e[1;31m Solo es valido un numero mayor que ${minimoPrioridad} (prioridad mínima)\e[0m";
        echo -n -e " Introduzca la \e[1;33m prioridad maxima \e[0m";
        read maximoPrioridad;
    done

    sleep 0.2;
    clear;
    cabeceraTeclado;

    echo -n -e " Introduzca el \e[1;33mfactor de reubicación\e[0m para la memoria (nº de huecos vacios para intentar reubicar): ";
    read factReub;
    echo -n " Introduzca el factor de reubicación: " >> $informe;
    echo -n -e " Introduzca el \e[1;33mfactor de reubicación\e[0m de la memoria: " >> $informeColor;

    until [[ $factReub =~ [0-9] && $factReub -ge 0 ]]
        do
            echo -e "\n\e[1;31m El factor de reubicación ha de ser un número positivo (0 si se quiere desactivar al reubicación)\e[0m";
            echo -n -e " Introduzca el \e[1;33mfactor de reubicación\e[0m de la memoria: ";
            read factReub;
        done
    
    echo -e "$factReub\n" >> $informe;
    echo -e "\e[1;32m$factReub\e[0m\n" >> $informeColor;

    
    sleep 0.2;
    clear;
    cabeceraTeclado;

   

    #!#
    #Se imprime en el fichero de datos
    # 02-05 COMENTO LA LINEA DONDE MUESTRO POR PANTALLA EL QUANTUM DE TIEMPO
    # echo -en "${tamMem}\n${tamQuant}\n${tamPag}\n${tiempoPorPagina}\n${factReub}\n" > "${ficheroAMano}"



    #Número de proceso
    p=1;
    clear
    cabeceraTeclado;
    
    #pide los datos de cada proceso hasta que se diga que no se quieren más
    
    otroProc="s";
    otraMemoria="s";
    #!#
    pag=0;

    while [[ $otroProc == "s" ]]
        do

            otraMemoria="s";
            maxpags[$p]=0;
            pag=0;
            
            echo -n -e "\n Introduzca el \e[1;33mtiempo de llegada\e[0m del proceso $p: ";
            read tLlegada[$p]
            echo -en "\n Introduzca el tiempo de llegada del proceso $p: " >> $informe;
            echo -en "\n Introduzca el \e[1;33mtiempo de llegada\e[0m del proceso $p: " >> $informeColor;
            until [[ ${tLlegada[$p]} =~ [0-9] && ${tLlegada[$p]} -ge 0 ]]
                do
                    echo -e "\n\e[1;31m El tiempo de llegada debe ser un número positivo\e[0m";
                    echo -n -e " Introduzca el \e[1;33mtiempo de llegada\e[0m del proceso $p: ";
                    read tLlegada[$p];
                done
            
            echo "${tLlegada[$p]}" >> $informe;
            echo -e "\e[1;32m${tLlegada[$p]}\e[0m" >> $informeColor;
                
            clear
            cabeceraTeclado;

            echo -n -e "\n Introduzca el \e[1;33mnúmero de marcos\e[0m del proceso $p: ";
            read nMarcos[$p];

            echo -en "\n Introduzca el número de marcos del proceso $p: " >> $informe;
            echo -en "\n Introduzca el \e[1;33mnúmero de marcos\e[0m del proceso: " >> $informeColor;

            until [[ ${nMarcos[$p]} =~ [0-9] && ${nMarcos[$p]} -gt 0 &&
                       ${nMarcos[$p]} -le $marcosMem ]]
                do
                    echo -e "\n \e[1;31m El número de marcos del proceso debe ser un número positivo menor que el número de marcos que hay en la memoria (\e[0m\e[1;33m$marcosMem\e[0m\e[1;31m)\e[0m";
                    echo -n -e " Introduzca el \e[1;33mnúmero de marcos\e[0m del proceso $p: ";
                    read nMarcos[$p];
                done

            echo "${nMarcos[$p]}" >> $informe;
            echo -e "\e[1;32m${nMarcos[$p]}\e[0m" >> $informeColor;


            clear
            cabeceraTeclado;



            echo -n -e "\n Introduzca el \e[1;33mnúmero de páginas\e[0m de código del proceso $p: ";
            read paginasCodigo[$p];

            echo -en "\n Introduzca el número de páginas de código del proceso $p: " >> $informe;
            echo -en "\n Introduzca el \e[1;33mnúmero de páginas\e[0m de código del proceso $p: " >> $informeColor;

            until [[ ${paginasCodigo[$p]} =~ [0-9] && ${paginasCodigo[$p]} -gt 0 && ${paginasCodigo[$p]} -lt ${nMarcos[$p]} ]]
                do
                    echo -e "\n \e[1;31m El número de paginas debe de ser mayor o igual que 0 y menor que el número de marcos: \e[0m";
                    echo -n -e " Introduzca el \e[1;33mnúmero de páginas\e[0m de código del proceso $p: ";
                    read paginasCodigo[$p];
                done

            echo "${paginasCodigo[$p]}" >> $informe;
            echo -e "\e[1;32m${paginasCodigo[$p]}\e[0m" >> $informeColor;


            clear
            cabeceraTeclado;



            echo -n "${tLlegada[$p]};${nMarcos[$p]};${paginasCodigo[$p]};;" >> "${ficheroAMano}"

            # 15-05 Almaceno la prioridad de los procesos
            

            echo -n -e "\n Introduzca la \e[1;33mprioridad\e[0m del proceso $p: ";
            read prProcesos[$p];
            #echo "ESTOY EN LA PRIORIDAD ${prProcesos[$p]}"

            echo -en "\n Introduzca la prioridad del proceso $p: " >> $informe;
            echo -en "\n Introduzca la \e[1;33mprioridad\e[0m del proceso $p: " >> $informeColor;

            # REVISAR NO FUNCIONA EL BUCLE
            # while ! [[ "$minimoPrioridad" =~ ^[0-9]+$ ]]; do || $p -gt $minimoPrioridad
            while [[ prProcesos[$p] -gt $maximoPrioridad || prProcesos[$p] -lt $minimoPrioridad ]] 
                do
                    echo "NO ${p} < ${minimoPrioridad} o NO ${p} > ${maximoPrioridad}";
                    echo -e "\n \e[1;31m El número de paginas debe de ser mayor o igual que la prioridad mínima (${minimoPrioridad}) y menor o igual que la prioridad máxima (${maximoPrioridad}): \e[0m";
                    echo -n -e "\n Introduzca la \e[1;33mprioridad\e[0m del proceso $p: ";
                    read prProcesos[$p];
                done

            echo "${prProcesos[$p]}" >> $informe;
            echo -e "\e[1;32m${prProcesos[$p]}\e[0m" >> $informeColor;


            clear
            ordenacion
            cabeceraTeclado;



            echo -n "${tLlegada[$p]};${nMarcos[$p]};${paginasCodigo[$p]};${prProcesos[$p]};;" >> "${ficheroAMano}"


    
    while [[ $otraMemoria == "s" ]]
        do

            echo -en "\n Introduzca la \e[1;33mdirección de página\e[0m $(($pag+1)): ";
            read  direcciones[$p,$pag];
            echo -en "\n Introduzca la dirección de página $(($pag+1)): " >> $informe;
            echo -en "\n Introduzca la \e[1;33mdirección de página\e[0m $(($pag+1)): " >> $informeColor;

            until [[ ${direcciones[$p,$pag]} =~ [0-9] && ${direcciones[$p,$pag]} -ge 0 ]];
                do
                    echo ""
                    echo -e "\e[1;31mLa dirección debe ser un número positivo\e[0m";
                    echo -n -e " Introduzca la \e[1;33mdirección de página\e[0m $(($pag+1)): ";
                    read  direcciones[$p,$pag];
                done

            echo -e "${direcciones[$p,$pag]}" >> $informe;
            echo -e "\e[1;32m${direcciones[$p,$pag]}\e[0m" >> $informeColor;

            paginas[$p,$pag]=$((${direcciones[$p,$pag]}/$tamPag));
            maxpags[$p]=$((${maxpags[$p]} + 1));

            echo -n "${direcciones[$p,$pag]};" >> "${ficheroAMano}"

            clear
            cabeceraTeclado;

            echo -n -e "\n ¿Desea introducir otra direccion de memoria? (s = sí, n = no): ";
            read otraMemoria;
            echo -en "\n ¿Desea introducir otra direccion de memoria? (s = sí, n = no): " >> $informe;
            echo -en "\n ¿Desea introducir otra direccion de memoria? (s = sí, n = no): " >> $informeColor;
            until [[ $otraMemoria == "s" || $otraMemoria == "n" ]]
                do
                    echo -e "\n \e[1;31mPor favor, escriba \"s\" o \"n\" \e[0m";
                    read -p " ¿Desea introducir otra direccion de memoria? (s = sí, n = no): " otraMemoria;
                done
                
            echo "$otraMemoria" >> $informe;
            echo -e "\e[1;32m$otraMemoria\e[0m" >> $informeColor;

            pag=$(($pag + 1));
            maxpags[$p]=$pag
            tEjec[$p]=$(($pag ));

            clear
            cabeceraTeclado;
            
        done

        echo "" >> "${ficheroAMano}"
                
            tamProceso[$p]=$((${nMarcos[$p]}*$tamPag));
            
            if [[ $(( ${nMarcos[$p]} - ${paginasCodigo[$p]} )) -gt ${tEjec[$p]} ]]
                then
                    bool=1;
                else
                    bool=0;
            fi
            while [[ $bool -eq 1 ]]
                do
                    echo -e "\n \e[1;31m El número de marcos de página es mayor que el número de páginas\e[0m" | tee -a $informeColor;
                    echo -e " \e[1;31m Esto es un desperdicio de memoria.\e[0m \e[1;33mNúmero de marcos: ${nMarcos[$p]}\e[0m\e[1;31m,\e[0m \e[1;33mPáginas: ${tEjec[$p]}\e[0m" | tee -a $informeColor;

                    echo -e "\n El número de marcos de página es mayor que el número de páginas" >> $informe;
                    echo " Esto es un desperdicio de memoria. Número de marcos: ${nMarcos[$p]}, Páginas: ${tEjec[$p]}" >> $informe;

                    read -p " ¿Desea cambiar el número de marcos del proceso? (s = sí, n = no): " letra;

                    echo -en " ¿Desea cambiar el número de marcos del proceso? (s = sí, n = no):" >> $informe;
                    echo -en " ¿Desea cambiar el número de marcos del proceso? (s = sí, n = no):" >> $informeColor;
                
                    until [[ $letra == "s" || $letra == "n" ]]
                        do
                            echo -e "\n\e[1;31mPor favor, escriba \"s\" o \"n\" \e[0m";
                            read -p "¿Desea cambiar el número de marcos del proceso? (s = sí, n = no): " letra;
                        done

                    echo "$letra" >> $informe;
                    echo -e "\e[1;32m$letra\e[0m" >> $informeColor;

                    if [[ $letra == "s" ]]
                        then
                            echo -n -e "\n Introduzca el \e[1;33mnúmero de marcos\e[0m del proceso $p: ";
                            read nMarcos[$p];
                            until [[ ${nMarcos[$p]} =~ [0-9] && ${nMarcos[$p]} -gt 0 && ${nMarcos[$p]} -le $marcosMem ]]
                                do
                                    echo -e "\n\n \e[1;31mEl número de marcos del proceso debe ser un número positivo menor que el número de marcos que hay en la memoria (\e[0m\e[1;33m$marcosMem\e[0m\e[1;31m)\e[0m";
                                    echo -n -e " Introduzca el \e[1;33mnúmero de marcos\e[0m del proceso $p: ";
                                    read nMarcos[$p];
                                done
                    
                            tamProceso[$p]=$((${nMarcos[$p]}*$tamPag));
                            
                            if [[ ${nMarcos[$p]} -gt ${tEjec[$p]} ]]
                                then
                                    bool=1;
                                else
                                    bool=0;
                            fi
                        else
                            bool=0;
                    fi
                done
            echo -e " Nuevo número de marcos: ${nMarcos[$p]}\n" >> $informe;
            echo -e " Nuevo \e[1;33mnúmero de marcos\e[0m: \e[1;32m${nMarcos[$p]}\e[0m\n" >> $informeColor;
            clear
            cabeceraTeclado;
          
            
            echo -n -e "\n\n ¿Desea introducir \e[1;33motro\e[0m proceso? (s = sí, n = no): ";
            read otroProc;
            echo -en "\n\n ¿Desea introducir otro proceso? (s = sí, n = no): " >> $informe;
            echo -en "\n\n ¿Desea introducir otro proceso? (s = sí, n = no): " >> $informeColor;

            until [[ $otroProc == "s" || $otroProc == "n" ]]
                do
                    echo -e "\n \e[1;31mPor favor, escriba \"s\" o \"n\" \e[0m";
                    read -p " ¿Desea introducir otro proceso? (s = sí, n = no): " otroProc;
                done
            
            echo "$otroProc" >> $informe;
            echo -e "\e[1;32m$otroProc\e[0m" >> $informeColor;

            p=$(($p + 1))
            clear
            cabeceraTeclado
            
        done
    p=$(($p - 1));
    nProc=$p;
    clear;

    copiarAUltimaEjecucion "$ficheroAMano"
    imprimeProcesosFinal;
    
}



#
#   Función que lista los ficheros .txt que se encuentran el el directorio datosScript. Si se le pasa algún argumento
#   imprime sin resaltar la opción elegida. La opción elegida está guardada en la variable $fichSelect.
#
imprimefiles(){
    max=$(find Datos -maxdepth 1 -type f -name "*.txt" | cut -f2 -d"/" | wc -l);
    echo -e "\e[1;38;5;81m    ARCHIVOS EN EL DIRECTORIO \"Datos\" (.txt) : \e[0m\n";
    if [[ $# -gt 0 ]] #Si se han pasado argumentos.
        then
            for (( i=1; i<=$max; i++ ))
                do
                    #Mostrar solo los nombres de ficheros (no directorios).
                    file=$(find Datos -maxdepth 1 -type f -name "*.txt" | cut -f2 -d"/" | sort | cut -f$i -d$'\n');
                    if [ $i -eq $fichSelect ]
                        then
                            printf '    \e[1;38;5;64;48;5;7m	[%2u.]\e[90m %-20s\e[0m\n' "$i" "$file"; #Resaltar opción escogida.
                        else
                            printf '    \e[1;32m	[%2u.]\e[0m %-20s\e[0m\n' "$i" "$file";
                    fi
                done
        else
            for (( i=1; i<=$max; i++ ))
                do
                    #Mostrar solo los nombres de ficheros (no directorios).
                    file=$(find Datos -maxdepth 1 -type f -name "*.txt" | cut -f2 -d"/" | sort | cut -f$i -d$'\n');
                    printf '    \e[1;32m	[%2u.]\e[0m %-20s\e[0m\n' "$i" "$file";
            done
    fi
}


# Función que imprime los ficheros de datos de rangos que se encuentran en el directorio \DatosRangos
imprimeFilesRangos()
{
    max=$(find DatosRangos -maxdepth 1 -type f -name "*.txt" | cut -f3 -d"/" | wc -l);
    echo -e "\e[1;38;5;81m    ARCHIVOS EN EL DIRECTORIO \"DatosRangos\" (.txt) : \e[0m\n";
    if [[ $# -gt 0 ]] #Si se han pasado argumentos.
    then
        for (( i=1; i<=$max; i++ ))
            do
                #Mostrar solo los nombres de ficheros (no directorios).
                file=$(find DatosRangos -maxdepth 1 -type f -name "*.txt" | cut -f 2 -d"/" | sort | cut -f$i -d$'\n');
                if [ $i -eq $fichSelect ]
                    then
                        printf '    \e[1;38;5;64;48;5;7m	[%2u.]\e[90m %-20s\e[0m\n' "$i" "$file"; #Resaltar opción escogida.
                    else
                        printf '    \e[1;32m	[%2u.]\e[0m %-20s\e[0m\n' "$i" "$file";
                fi
            done
    else
        for (( i=1; i<=$max; i++ ))
            do
                #Mostrar solo los nombres de ficheros (no directorios).
                file=$(find DatosRangos -maxdepth 1 -type f -name "*.txt" | cut -f 2 -d"/" | sort | cut -f$i -d$'\n');
                printf '    \e[1;32m	[%2u.]\e[0m %-20s\e[0m\n' "$i" "$file";
        done
    fi

}


# Función que introduce los datos para la ejecución del algoritmo mediante un fichero de texto
# Parámetros:
#   - $1: Ruta del fichero del que leer
IntroduccionDeDatosPorFichero()
{
    local rutaFichero="$1"

    tamMem=$(awk NR==1 "$rutaFichero");
    tamQuant=$(awk NR==2 "$rutaFichero");
    tamPag=$(awk NR==3 "$rutaFichero");
    tiempoPorPagina=$(awk NR==4 "$rutaFichero")
    if [[ $tiempoPorPagina -eq 0  ]]
    then
        conEntradaCPU=0
    else
        conEntradaCPU=1
    fi
    factReub=$(awk NR==5 "$rutaFichero");
    marcosMem=$(($tamMem/$tamPag));

    nProc=$(wc -l < "$rutaFichero");
    let nProc=$nProc-$nParametrosGenerales;
    p=1;
    maxFilas=$(($nProc+$nParametrosGenerales));

    # El comienzo del indice del bucle for depende de la línea de inicio de los datos de 
    # los procesos
    for (( fila=$nParametrosGenerales+1 ; fila <= $maxFilas; fila++ )) 
        do	
            lectura1=$(awk NR==$fila "$rutaFichero" | cut -f 1 -d ";");
            tLlegada[$p]=$lectura1;

            lectura3=$(awk NR==$fila "$rutaFichero" | cut -f 2 -d ";");
            nMarcos[$p]=$lectura3;
            lectura5=$(awk NR==$fila "$rutaFichero" | cut -f 3 -d ";")
            paginasCodigo[$p]=$lectura5
            tamProceso[$p]=$((${nMarcos[$p]}*$tamPag));
            
        lectura2=$(awk NR==$fila "$rutaFichero" | cut -f 1 -d "");
        posic=5;
        n=0;

        until [[ $(echo $lectura2| cut -f $posic -d ";") == "" ]]
            #for (( n = 0; n < ${maxpags[$p]}; n++ ))
                do
                    lectura4=$(echo $lectura2 | cut -f $posic -d ";");
                    direcciones[$p,$n]=$lectura4;
                    paginas[$p,$n]=$(( ${direcciones[$p,$n]}/$tamPag ));
                    ((n++));
                    posic=$(($n+5));
                done

        tEjec[$p]=$(($n));
        maxpags[$p]=$n;



        p=$(($p+1));

    done
    
    p=$(($p-1));
  


}

# Función que permite elegir el fichero de datos que se va a utilizar para ejecutar el algoritmo
entradaFichero(){

    clear;
    cabeceraInicio;
    imprimefiles;

    echo -en "\nElija un fichero: ";
    echo -en "\nElija un fichero: " >> $informeColor;
    echo -en "\nElija un fichero: " >> $informe;
    read fichSelect;

    #Comprobación de fichero válido
    until [[ $tamMem =~ [0-9] && $fichSelect -gt 0 && $fichSelect -le $max ]]
        do
            echo -e "\n\e[1;31mEl valor introducido no es correcto. Debe estar entre\e[0m \e[1;33m1\e[0m \e[1;31my\e[0m \e[1;33m$max\e[0m";
            echo -n "Elija un fichero: ";
            read fichSelect;
        done
    clear;
    cabeceraInicio;
    imprimefiles 1;
    sleep 0.5;

    #Guardar el nombre del fichero escogido.
    ficheroIn=$(find Datos -maxdepth 1 -type f -name "*.txt" | sort | cut -f2 -d"/" | cut -f$fichSelect -d$'\n');
    
    echo "$ficheroIn" >> $informe;
    echo -e "\e[1;32m$ficheroIn\e[0m" >> $informeColor;
    
   
}

# Copia una ruta dada al fichero de última ejecución (./Datos/datos.txt)
copiarAUltimaEjecucion() {

    local origen="$1"
    local destino="$ficheroUltimaEjecucion"

    cp "$origen" "$destino"

}

# Copia una ruta dada al fichero de rangos de última ejecución (./datosScript/datosrangos.txt)
copiarARangosUltimaEjecucion() {
    
    local origen="$1"
    local destino="$ficheroRangosUltimaEjecucion"

    cp "$origen" "$destino"

}


# Función utilizada en la entrada aleatoria para pedir datos en forma de rangos
# 
# IMPORTANTE: Esta función utiliza la posibilidad de pasar argumetnos como
# referencias. Parecido a C o C++ donde las variables se pueden pasar como
# punteros. Esto es así para poder modificar los valores de las variables pasadas
# fuera de la función. REQUIERE BASH 4.4 O POSTERIOR PARA FUNCIONAR.
# 
# Si se requiere llamar a la función los parámetros $2 y $3 han de ser pasados sin "$"
# esto significa que se pasa la referencia a la variable y no su valor a la función.
# 
# El min y el max de los rangos son los extremos máximos que se pueden seleccionar.
preguntarDatoRango() {

    local temp=""   # String leida
    local err=-1    # Codigo de error
    local prompt=$1 # Mensaje que se muestra al pedir el dato
    local -n n1=$2  # Referencia a la variable donde guardar el min
    local -n n2=$3  # Referencia a la variable donde guardar el max
    local min=$4    # Nº mayor máximo permitido
    local max=$5    # Nº menor mínimo permitido

    while true; do

        clear
        CabeceraAleatorio # Cambiar esto si se quiere mostrar otro mensaje

        # Notificar el error
        case $err in
            0)
                break
            ;;
            1)  # Formato incorrecto
                echo -e "\e[1;31m ERROR:\e[39m Formato incorrecto\n"\
                        "Utiliza el formato (min-max).\n\e[0m"
            ;;
            2)  # Rango no válido
                echo -e "\e[1;31m ERROR:\e[39m Rango no válido\n"\
                        "Introduce dos números entre \e[1;31m${min}\e[1;39m y \e[1;31m${max}\e[0m.\n\e[0m"
            ;;
            3)  # Rango incoherente
                echo -e "\e[1;31m ERROR:\e[39m Valores incoherentes\n"\
                        "El rango introducido no tiene sentido, el valor inferior (\e[1;31m${n1}\e[1;39m) es mayor que el superior (\e[1;31m${n2}\e[0m).\n\e[0m"
            ;;
        esac

        # Preguntar por los valores
        echo -en " Formato del rango: (min-max)\n"\
                 "Extremos del rango: (${min}-${max})\n"\
                 "${prompt}"
        read -r temp

        # Intentar asignar los valores
        n1=$( echo "${temp}" | cut -d "-" -f 1 )
        n2=$( echo "${temp}" | cut -d "-" -f 2 )

        if [[ $(echo "$temp" | grep -E -o "[0-9]+-[0-9]+") != "$temp" ]]; then
            # Error de formato
            err=1
        elif [[ $n1 -lt $min || $n2 -gt $max ]]; then
            # Error de rango
            err=2
        elif [[ $n1 -gt $n2 ]]; then
            # Error de coherencia
            err=3
        else
            # Caso correcto
            err=0
        fi

    done

}

# Se pregunta al usurio por diferentes rangos para los parámetros de ejecución
# tras obtener los rangos se generan los procesos y parámetros de la memoria
# para poder ejecutar el algoritmo.
entradaAleatoria() {

    local prompt=""
    local temp=""

    # Preguntar por los nombres de los ficheros

    clear
    echo -en "\n \e[1;4;33mGENERACIÓN DE DATOS ALEATORIOS PARA EL ALGORITMO\e[0m\n\n"\
             " \e[1;33mNombres de los ficheros aleatorios: \e[0m\n"\
             " \e[1;33m[1]\e[0m => Nombres por defecto: (RANGOS: \e[1mdatosrangosdefault.txt\e[0m) y (DATOS: \e[1mdatosdefault.txt.\e[0m)\n"\
             " \e[1;33m[2]\e[0m => Cambiar nombre solo del fichero de rangos: (DATOS: \e[1mdatosdefault.txt\e[0m)\n"\
             " \e[1;33m[3]\e[0m => Cambiar nombre solo del fichero de datos:  (RANGOS: \e[1mdatosrangosdefault.txt.\e[0m)\n"\
             " \e[1;33m[4]\e[0m => Cambiar nombre de ambos ficheros.\n\n"\
             " Elige una de las opciones anteriores: "
    read -r temp

    until [[ "$temp" =~ [1-4] ]]; do
        echo -en "\n\e[1;31m  Valor incorrecto, elija un valor del \e[1;33m1 al 4\e[0m\e[1;31m: ";
        read temp;
    done

    if [[ "$temp" -eq 1 ]]; then
        ficheroRangosPorDefecto="./DatosRangos/datosrangosdefault.txt"
        ficheroPorDefecto="./Datos/datosdefault.txt"

    elif [[ "$temp" -eq 2 ]]; then
        echo -en "\n  Introduce el \e[1;33mnombre\e[0m que debe tener el \e[1;33mfichero con los rangos aleatorios\e[0m \e[1m(sin '.txt')\e[0m: "
        read -r temp
        ficheroRangosPorDefecto="./DatosRangos/${temp}.txt"
        ficheroPorDefecto="./Datos/datosdefault.txt"
    elif [[ "$temp" -eq 3 ]]; then
        echo -en "\n  Introduce el \e[1;33mnombre\e[0m que debe tener el \e[1;33mfichero con los datos aleatorios\e[0m \e[1m(sin '.txt')\e[0m: "
        read -r temp
        ficheroRangosPorDefecto="./DatosRangos/datosrangosdefault.txt"
        ficheroPorDefecto="./Datos/${temp}.txt"

    elif [[ "$temp" -eq 4 ]]; then
        echo -en "\n  Introduce el \e[1;33mnombre\e[0m que debe tener el \e[1;33mfichero con los rangos aleatorios\e[0m \e[1m(sin '.txt')\e[0m: "
        read -r temp
        ficheroRangosPorDefecto="./DatosRangos/${temp}.txt"
        echo -en "\n  Introduce el \e[1;33mnombre\e[0m que debe tener el \e[1;33mfichero con los datos aleatorios\e[0m \e[1m(sin '.txt')\e[0m: "
        read -r temp
        ficheroPorDefecto="./Datos/${temp}.txt"
    fi

    touch "$ficheroRangosPorDefecto";
    touch "$ficheroPorDefecto";

    # Parámetros generales

    # Marcos de la memoria
    prompt="Introduce el rango para el \e[1;33mnúmero de marcos de la memoria\e[0m: "
    preguntarDatoRango "${prompt}" minMarcMem maxMarcMem 1 99999

    #size de la memoria
    if [[ $minMarcMem -eq $maxMarcMem ]]; then
        marcosMem=$minMarcMem;
    else
        marcosMem=$(( $RANDOM % ($maxMarcMem - $minMarcMem + 1) + $minMarcMem ));
    fi
    maxMarc=$marcosMem;


    # size (en direcciones) de cada marco
    prompt="Introduce el rango para el \e[1;33mtamaño de cada marco\e[0m de la memoria: "
    preguntarDatoRango "${prompt}" minTamPag maxTamPag 1 99999

    if [[ $minTamPag -eq $maxTamPag ]]; then
        tamPag=$minTamPag;
    else
        tamPag=$(( $RANDOM % ($maxTamPag - $minTamPag + 1) + $minTamPag ));
    fi

    tamMem=$(( $marcosMem * $tamPag ));

    

    # Huecos en memoria para la reubicación
    prompt="Introduce el rango para el \e[1;33mfactor de reubicación\e[0m de la memoria (nº de huecos vacios para que sea posible reubicar): "
    preguntarDatoRango "${prompt}" minReub maxReub 0 99999

    if [[ $minReub -eq $maxReub ]]; then
        factReub=$minReub
    else
        factReub=$(( $RANDOM % ($maxReub - $minReub + 1) + $minReub ))
    fi

    # 02-05 COMENTO EL PEDIR POR PANTALLA AL USUARIO EL RANGO DEL QUANTUM
    # Quantum del Round Robin
    # prompt="Introduce el rango para el \e[1;33mquantum\e[0m del Round Robin: "
    # preguntarDatoRango "${prompt}" minQuant maxQuant 1 99999

    # if [[ $minQuant -eq $maxQuant ]]; then
    #     tamQuant=$minQuant;
    # else
    #     tamQuant=$(( $RANDOM % ($maxQuant - $minQuant + 1) + $minQuant ));
    # fi

    echo -n -e " ¿Quiere que haya \e[1;33mtiempos de entrada a la CPU\e[0m?(s/n): ";
    read conEntradaCPU

    until [[ "$conEntradaCPU" == 's' || "$conEntradaCPU" == 'n' ]]
    do
        echo -n -e " ¿Quiere que haya \e[1;33mtiempos de entrada a la CPU\e[0m?(s/n): ";
        read conEntradaCPU
    done

    if [[ "$conEntradaCPU" == 's' ]]
    then
        conEntradaCPU=1
        prompt="Introduce el rango para el \e[1;33mtiempo por pagina\e[0m en la entrada a la CPU: "
        preguntarDatoRango "${prompt}" minTiempoPorPagina maxTiempoPorPagina 1 99999

        if [[ $minTiempoPorPagina -eq $maxTiempoPorPagina ]];
        then
            tiempoPorPagina=$minTiempoPorPagina;
        else
            tiempoPorPagina=$(( $RANDOM % ($maxTiempoPorPagina - $minTiempoPorPagina + 1) + $minTiempoPorPagina ));
        fi

    
    else
        conEntradaCPU=0
        tiempoPorPagina=0
        minTiempoPorPagina=0
        maxTiempoPorPagina=0

    fi

    # Nº de procesos a generar
    prompt="Introduce el rango para el \e[1;33mnúmero de procesos a generar\e[0m: "
    preguntarDatoRango "${prompt}" minProcesosAGenerar maxProcesosAGenerar 1 99
    
    procesosAGenerar=$(( $RANDOM % ($maxProcesosAGenerar - $minProcesosAGenerar + 1) + $minProcesosAGenerar ))

    # Colocar en el fichero las características básicas una vez determinado su valor.
    echo -en "${tamMem}\n${tamQuant}\n${tamPag}\n${tiempoPorPagina}\n${factReub}\n" > "${ficheroPorDefecto}"
    

    # Praámetros de los procesos

    # Marcos de página por proceso
    prompt="Introduce el rango para el \e[1;33mnúmero de marcos asociados a cada proceso\e[0m: "
    preguntarDatoRango "${prompt}" minMarc maxMarc 1 $marcosMem
    

    # Tiempo de llegada de cada proceso
    prompt="Introduce el rango para el \e[1;33mtiempo de llegada de cada proceso\e[0m: "
    preguntarDatoRango "${prompt}" minTll maxTll 0 99999


    # Nº de páginas por proceso
    prompt="Introduce el rango para el \e[1;33mnúmero de direcciones a ejecutar de cada proceso\e[0m: "
    preguntarDatoRango "${prompt}" minPagProc maxPagProc 1 99999


    
    prompt="Introduce el rango para el \e[1;33mnúmero de paginas de codigo de cada proceso\e[0m: "
    preguntarDatoRango "${prompt}" minPaginasCodigo maxPaginasCodigo 0 $marcosMem


    # Rango de direcciones asignable
    prompt="Introduce el rango para el \e[1;33mtamaño de cada proceso\e[0m: "
    preguntarDatoRango "${prompt}" minPag maxPag 0 999999999999


    #!#cuidado el orden
    # Colocar los rangos en el fichero de parámetros
    echo "${minMarcMem}-${maxMarcMem}" > "$ficheroRangosPorDefecto"
    echo "${minTamPag}-${maxTamPag}" >> "$ficheroRangosPorDefecto"
    echo "${minQuant}-${maxQuant}" >> "$ficheroRangosPorDefecto"
    echo "${minTiempoPorPagina}-${maxTiempoPorPagina}" >> $ficheroRangosPorDefecto
    echo "${minReub}-${maxReub}" >> "$ficheroRangosPorDefecto"
    echo "${minProcesosAGenerar}-${maxProcesosAGenerar}" >> "$ficheroRangosPorDefecto"
    echo "${minMarc}-${maxMarc}" >> "$ficheroRangosPorDefecto"
    echo "${minTll}-${maxTll}" >> "$ficheroRangosPorDefecto"
    echo "${minPagProc}-${maxPagProc}" >> "$ficheroRangosPorDefecto"
    echo "${minPaginasCodigo}-${maxPaginasCodigo}" >> "$ficheroRangosPorDefecto"
    echo "${minPag}-${maxPag}" >> "$ficheroRangosPorDefecto"

    copiarARangosUltimaEjecucion "$ficheroRangosPorDefecto"
    # Generar fichero con los datos aleatorios
    genProAleatorios;
}

# Función que genera los procesos aleatorios en base a los parámetros de aleatoriedad
genProAleatorios() {

    local nPagTemp=0;
    local procesoTemp="";         # Proceso que se está generando
    local marcosProcesoTemp=0;    # Nº de marcas del proceso a generar
    local tempPagsCod=0

    # Generar procesos aleatorios e incluirlos al fichero
    for (( i = 0; i < $procesosAGenerar; i++ )); do
        # Asignación del nº de marcos a cada proceso
        marcosProcesoTemp=$(( $RANDOM % ($maxMarc - $minMarc + 1) + $minMarc));

        # Asignar un nº de páginas que dar a cada proceso
        nPagTemp=$(( $RANDOM % ($maxPagProc - $minPagProc + 1) + $minPagProc ));

        if [[ $tiempoPorPagina -ne 0 ]]
        then
            if [[ $marcosProcesoTemp -le $minPaginasCodigo ]]
            then
                minPaginasCodigo=0
            fi
            local pagsCodlimit=0
            if [[ $(($marcosProcesoTemp-1)) -lt  $maxPaginasCodigo ]]
            then
                pagsCodlimit=$(($marcosProcesoTemp-1))
            else
                pagsCodlimit=$maxPaginasCodigo
            fi

            tempPagsCod=$(rand $minPaginasCodigo $pagsCodlimit);
        else
            tempPagsCod=0;
        fi
            
        # Asignación del tiempo de llegada a cada proceso
        procesoTemp="$(( $RANDOM % ($maxTll - $minTll + 1) + $minTll ));${marcosProcesoTemp};${tempPagsCod};;";
        
        for (( j = 0; j < $nPagTemp; j++)); do
            procesoTemp="${procesoTemp}$(( $RANDOM % ($maxPag - $minPag + 1) + $minPag ));";
        done

        echo -e "${procesoTemp}" >> "${ficheroPorDefecto}";
    done

    # Leer el fichero como si fuera una entrada por este
    nProc=$procesosAGenerar;

    #!#
    maxFilas=$(( $nProc + $nParametrosGenerales ));
    p=1;
    #!# indice del bucle
    for (( fila=$nParametrosGenerales + 1 ; fila <= $maxFilas; fila++ )) 
        do	
            lectura1=$(awk NR==$fila "$ficheroPorDefecto" | cut -f 1 -d ";");
            tLlegada[$p]=$lectura1;

            lectura3=$(awk NR==$fila "$ficheroPorDefecto" | cut -f 2 -d ";");
            nMarcos[$p]=$lectura3;
            lectura5=$(awk NR==$fila "$ficheroPorDefecto" | cut -f 3 -d ";")
            paginasCodigo[$p]=$lectura5
            tamProceso[$p]=$((${nMarcos[$p]}*$tamPag));
            
        lectura2=$(awk NR==$fila "$ficheroPorDefecto" | cut -f 1 -d "");
        posic=5;
        n=0;

        until [[ $(echo $lectura2| cut -f $posic -d ";") == "" ]]
            #for (( n = 0; n < ${maxpags[$p]}; n++ ))
                do
                    lectura4=$(echo $lectura2 | cut -f $posic -d ";");
                    direcciones[$p,$n]=$lectura4;
                    paginas[$p,$n]=$(( ${direcciones[$p,$n]}/$tamPag ));
                    ((n++));
                    posic=$(($n+5));
                done

        tEjec[$p]=$n;
        maxpags[$p]=$n;


        p=$(($p+1));

    done
    
    p=$(($p-1));


    copiarAUltimaEjecucion "$ficheroPorDefecto"

    clear;
    imprimeProcesosAleatorio;

}

# Comprueba si un rango es coherente o no
# $1: valor mínimo del rango
# $2: valor máximo del rango
# Sale del programa en caso de haber un rango incoherente.
comprobarRango() {

    local min=$1
    local max=$2

    if [[ $min -gt $max ]]; then
        echo "Rango incoherente / Rango mal formateado."
        exit
    fi

}

# Lee un fichero de parámetros aleatorios y genera unos datos en base a ellos
# Si alguno de los rangos dentro del fichero de parámetros es incoherente se sale
# del programa.
entradaParametrosAleatorios() {

    clear;
    imprimeFilesRangos;

    echo -en "\nElija un fichero: ";
    echo -en "\nElija un fichero: " >> $informeColor;
    echo -en "\nElija un fichero: " >> $informe;
    read fichSelect;

    until [[ $fichSelect =~ [0-9] && $fichSelect -gt 0 && $fichSelect -le $max ]]; do
        echo -e "\n\e[1;31mEl valor introducido no es correcto. Debe estar entre\e[0m \e[1;33m1\e[0m \e[1;31my\e[0m \e[1;33m$max\e[0m";
        echo -n "Elija un fichero: ";
        read fichSelect;
    done

    ficheroParametrosAleatorios="DatosRangos/$(find DatosRangos -maxdepth 1 -type f -name "*.txt" | sort | cut -f2 -d"/" | cut -f$fichSelect -d$'\n')";

    echo "$ficheroParametrosAleatorios" >> "${informeColor}"
    echo "$ficheroParametrosAleatorios" >> "${informe}"
    # Los valores del fichero tienen el siguiente formato (min-max)

    IntroduccionDeRangosPorFichero "$ficheroParametrosAleatorios"

}

# Función que permite introducir datos para la creación de datos aleatorios mediante rangos
# Parámetros:
#   -$1: Ruta del fichero del que leer
IntroduccionDeRangosPorFichero()
{
    local rutaDelFichero=$1

       # Parámetros generales
    minMarcMem=$(awk NR==1 "$rutaDelFichero" | cut -d "-" -f 1);
    maxMarcMem=$(awk NR==1 "$rutaDelFichero" | cut -d "-" -f 2);
    comprobarRango $minMarcMem $maxMarcMem


    minTamPag=$(awk NR==2 "$rutaDelFichero" | cut -d "-" -f 1);
    maxTamPag=$(awk NR==2 "$rutaDelFichero" | cut -d "-" -f 2);

    comprobarRango $minTamPag $maxTamPag


    minQuant=$(awk NR==3 "$rutaDelFichero" | cut -d "-" -f 1);
    maxQuant=$(awk NR==3 "$rutaDelFichero" | cut -d "-" -f 2);

    comprobarRango $minQuant $maxQuant


    minTiempoPorPagina=$(awk NR==4 "$rutaDelFichero" | cut -d "-" -f 1);
    maxTiempoPorPagina=$(awk NR==4 "$rutaDelFichero" | cut -d "-" -f 2);

    comprobarRango $minTiempoPorPagina $maxTiempoPorPagina



    minReub=$(awk NR==5 "$rutaDelFichero" | cut -d "-" -f 1);
    maxReub=$(awk NR==5 "$rutaDelFichero" | cut -d "-" -f 2);

    comprobarRango $minReub $maxReub

    # Parámetros para los procesos
    minProcesosAGenerar=$(awk NR==6 "$rutaDelFichero" | cut -d "-" -f 1);
    maxProcesosAGenerar=$(awk NR==6 "$rutaDelFichero" | cut -d "-" -f 2);

    comprobarRango $minProcesosAGenerar $maxProcesosAGenerar

    minMarc=$(awk NR==7 "$rutaDelFichero" | cut -d "-" -f 1);
    maxMarc=$(awk NR==7 "$rutaDelFichero" | cut -d "-" -f 2);

    comprobarRango $minMarc $maxMarc

    minTll=$(awk NR==8 "$rutaDelFichero" | cut -d "-" -f 1);
    maxTll=$(awk NR==8 "$rutaDelFichero" | cut -d "-" -f 2);

    comprobarRango $minTll $maxTll

    minPagProc=$(awk NR==9 "$rutaDelFichero" | cut -d "-" -f 1);
    maxPagProc=$(awk NR==9 "$rutaDelFichero" | cut -d "-" -f 2);

    comprobarRango $minPagProc $maxPagProc

    minPaginasCodigo=$(awk NR==10 "$rutaDelFichero" | cut -d "-" -f 1);
    maxPaginasCodigo=$(awk NR==10 "$rutaDelFichero" | cut -d "-" -f 2);

    comprobarRango $minPaginasCodigo $maxPaginasCodigo

    minPag=$(awk NR==11 "$rutaDelFichero" | cut -d "-" -f 1);
    maxPag=$(awk NR==11 "$rutaDelFichero" | cut -d "-" -f 2);

    comprobarRango $minPag $maxPag
    # Generación de las características básicas de la memoria

    # Marcos de la memoria
    if [[ $minMarcMem -eq $maxMarcMem ]]; then
        marcosMem=$minMarcMem;
    else
        marcosMem=$(( $RANDOM % ($maxMarcMem - $minMarcMem + 1) + $minMarcMem ));
    fi

    # size de página
    if [[ $minTamPag -eq $maxTamPag ]]; then
        tamPag=$minTamPag;
    else
        tamPag=$(( $RANDOM % ($maxTamPag - $minTamPag + 1) + $minTamPag ));
    fi

    # size de la memoria
    tamMem=$(( $marcosMem * $tamPag ));

    # Quantum del Round Robin
    if [[ $minQuant -eq $maxQuant ]]; then
        tamQuant=$minQuant;
    else
        tamQuant=$(( $RANDOM % ($maxQuant - $minQuant + 1) + $minQuant ));
    fi

    if [[ $minTiempoPorPagina -eq $maxTiempoPorPagina ]]
    then
        tiempoPorPagina=$minTiempoPorPagina
    else
        tiempoPorPagina=$(( $RANDOM % ($maxTiempoPorPagina - $minTiempoPorPagina + 1) + $minTiempoPorPagina ));
    fi

    if [[ $tiempoPorPagina -gt 0 ]]
    then
        conEntradaCPU=1
    else
        conEntradaCPU=0
    fi

    # Factor de reubicación
    if [[ $minReub -eq $maxReub ]]; then
        factReub=$minReub
    else
        factReub=$(( $RANDOM % ($maxReub - $minReub + 1) + $minReub ))
    fi



    touch "$ficheroPorDefecto"
    echo -e "${tamMem}\n${tamQuant}\n${tamPag}\n${tiempoPorPagina}\n${factReub}" > $ficheroPorDefecto

    # Comprobación de paridades
    # Dado que los datos se generan aleatoriamente existe la posibilidad de que
    # aun teniendo los mismo parámetros unas veces estos datos no coincidan entre
    # ellos mismos. Por ejemplo la memoria total y el número de marcos.

    # Mayor nº de marcos por proceso que marcos totales
    if [[ $maxMarc -gt $marcosMem ]]; then
        maxMarc=$marcosMem
        if [[ $maxMarc -lt $marcosMem ]]; then
            minMarc=$marcosMem
        fi
    fi

    copiarARangosUltimaEjecucion "$ficheroRangosPorDefecto"
    
    # Generación de los procesos
    procesosAGenerar=$(( $RANDOM % ($maxProcesosAGenerar - $minProcesosAGenerar + 1) + $minProcesosAGenerar ))
    genProAleatorios

}


###################################################################################
##                                                                               ##
##                                                                               ##
###################################################################################
####     #####     ####                                     ####     #####     ####
#########     #########  #################################  #########     #########
#########     #########  ##                             ##  #########     #########
####     #####     ####  ##                             ##  ####     #####     ####
####     #####     ####  ##   #######################   ##  ####     #####     ####
#########     #########  ##   ##-------------------##   ##  #########     #########
#########     #########  ##   ##--TABLAS-DE-DATOS--##   ##  #########     #########
####     #####     ####  ##   ##-------------------##   ##  ####     #####     ####
####     #####     ####  ##   #######################   ##  ####     #####     ####
#########     #########  ##                             ##  #########     #########
#########     #########  ##                             ##  #########     #########
####     #####     ####  #################################  ####     #####     ####
#######################                                     #######################

# Función que imprime los datos del fichero de datos seleccionados
imprimeProcesosFichero(){
    clear
    echo -e " Has introducido los datos por fichero "| tee -a $informeColor
    echo " Has introducido los datos por fichero " >> $informe
    imprimeProcesosFinal
}

# Función que imprime los procesos generados con datos aleatorios por rangos
imprimeProcesosAleatorio() {
    CabeceraAleatorio;
    echo "$( CabeceraAleatorio )" >> "${informeColor}"
    echo "$( CabeceraAleatorio | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" )" >> "${informe}"
    
    ordenacion
    asignaColores
    generar_nombre_procesos

    echo -e "\e[1;33m Procesos generados:\e[0m" | tee -a $informeColor
    echo -e " Procesos generados:" >> $informe

    if [[ "$conEntradaCPU" == 's' || $tiempoPorPagina -ne 0 ]]
    then

        echo -e " Ref Tll Pri Tej nMar Cod Dirección-Página." | tee -a $informeColor
        echo -e " Ref Tll Pri Tej nMar Cod Dirección-Página."  >> $informe
    else
        echo -e " Ref Tll Pri Tej nMar Dirección-Página." | tee -a $informeColor
        echo -e " Ref Tll Pri Tej nMar Dirección-Página."  >> $informe
    fi


    for (( improcesos = 1; improcesos <= $nProc; improcesos++ ))
        do
            ord=${ordenados[$improcesos]}
            if [[ ord -lt 10 ]]
            then
                if [[ "$conEntradaCPU" == 's' || $tiempoPorPagina -ne 0 ]]
                then
                    printf " \e[1;3${colorines[$ord]}mP0$ord %3u %3u %4u %3u %3u \e[0m"   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}" | tee -a $informeColor
                    printf " P0$ord %3u %3u %4u %3u %3u "   "${tLlegada[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}" >> $informe

                else
                    printf " \e[1;3${colorines[$ord]}mP0$ord %3u %3u %4u %3u \e[0m"   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" | tee -a $informeColor
                    printf " P0$ord %3u %3u %4u %3u "   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}"  >> $informe

                fi
            else
                if [[ "$conEntradaCPU" == 's' || $tiempoPorPagina -ne 0 ]]
                then
                    printf " \e[1;3${colorines[$ord]}mP$ord %3u %3u %4u %3u %3u \e[0m"   "${tLlegada[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}" | tee -a $informeColor
                    printf " P$ord %3u %3u %4u %3u %3u "   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}" >> $informe
                else
                    printf " \e[1;3${colorines[$ord]}mP$ord %3u %3u %4u \e[0m"   "${tLlegada[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" | tee -a $informeColor
                    printf "  P$ord %3u %3u %4u %3u "   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" >> $informe
                fi
            fi
            counter=0;
            maxpaginas=${maxpags[$ord]} 
            for (( impaginillas = 0; impaginillas <  maxpaginas ; impaginillas++ ))
                do
                            echo -n -e "\e[3${colorines[$ord]}m${direcciones[$ord,$impaginillas]}-\e[1m${paginas[$ord,$impaginillas]}\e[0m " | tee -a $informeColor
                            echo -n "${direcciones[$ord,$impaginillas]}-${paginas[$ord,$impaginillas]} " >> $informe
                done
            echo ""	 | tee -a $informeColor
            echo "" >> $informe
            maxpaginas=0;
        done
    
    echo -e " \e[1;31mPulse INTRO para continuar.\e[0m"
    read
}


#   Función que imprime un resumen de los datos con los que se va a ejecutar
#   el algoritmo
imprimeProcesosFinal(){
    ordenacion
    asignaColores
    generar_nombre_procesos

    #imprimimos para el informe a color
    echo -e " Memoria del Sistema:  $tamMem" | tee -a $informeColor
    # 02-05 COMENTO LA LINEA DONDE MUESTRO POR PANTALLA EL QUANTUM DE TIEMPO
    # echo -e " Quantum de   Tiempo:  $tamQuant" | tee -a $informeColor
    echo -e " Tamaño  de   Página:  $tamPag" | tee -a $informeColor
    if [[ $tiempoPorPagina -ne 0 ]]
    then
        echo -e " Coste de tiempo por pagina: $tiempoPorPagina" | tee -a $informeColor

    fi
    echo -e " Factor de reubicación: $factReub" | tee -a $informeColor



    #imprimimos para informe a BN
    echo " Memoria del Sistema:  $tamMem" >> $informe
    # 02-05 COMENTO LA LINEA DONDE MUESTRO POR PANTALLA EL QUANTUM DE TIEMPO
    # echo " Quantum  de  Tiempo:  $tamQuant" >> $informe
    echo " Tamaño   de  Página:  $tamPag" >> $informe
    if [[ $tiempoPorPagina -ne 0 ]]
    then
        echo " Coste de tiempo por pagina: $tiempoPorPagina" >> $informe

    fi
    echo " Factor de reubicación: $factReub" >> $informe


    echo -e "\n Ref Tll Tej nMar Cod Dirección-Página." | tee -a $informeColor
    echo -e "\n Ref Tll Tej nMar Cod Dirección-Página."  >> $informe

    
    for (( improcesos = 1; improcesos <= $nProc; improcesos++ ))
        do
            ord=${ordenados[$improcesos]}
            if [[ ord -lt 10 ]]
            then

                printf " \e[1;3${colorines[$ord]}mP0$ord %3u %3u %4u %3u %3u \e[0m"   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}"| tee -a $informeColor
                printf " P0$ord %3u %3u %4u %3u %3u "   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}"  >> $informe

            else

                printf " \e[1;3${colorines[$ord]}mP$ord %3u %3u %4u %3u %3u \e[0m"   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}" | tee -a $informeColor
                printf "  P$ord %3u %3u %4u %3u %3u "   "${tLlegada[$ord]}" "${prProcesos[$ord]}" "${tEjec[$ord]}" "${nMarcos[$ord]}" "${paginasCodigo[$ord]}" >> $informe

            fi
            counter=0;
            maxpaginas=${maxpags[$ord]} 
            for (( impaginillas = 0; impaginillas <  maxpaginas ; impaginillas++ ))
                do
                            echo -n -e "\e[3${colorines[$ord]}m${direcciones[$ord,$impaginillas]}-\e[1m${paginas[$ord,$impaginillas]}\e[0m " | tee -a $informeColor
                            echo -n "${direcciones[$ord,$impaginillas]}-${paginas[$ord,$impaginillas]} " >> $informe
                done
            echo ""	 | tee -a $informeColor
            echo "" >> $informe
            maxpaginas=0;
        done
    
    echo -e " \e[1;31mPulse INTRO para continuar.\e[0m"
    read

}

# Función que asigna colores a los procesos del algoritmo
asignaColores(){
    for (( counter = 1; counter <= $p; counter++ ))
        do

            color=$(($counter%6))
            color=$(($color+1))
            colorines[$counter]=$color
        done
}

# Función de ordenación de los procesos
ordenacion(){
    vectorSignificativoLimpio=()
    count=1   #Para movernos por el vector ordenados.
    acabado=0 #Indica cuando se ha acabado de ordenar los procesos.
    nproceso=0
    t=0
    while [[ $acabado -eq 0 ]]; do
        for ((nproceso = 1; nproceso <= $p; nproceso++)); do
            if [[ ${tLlegada[$nproceso]} -eq $t ]]; then
                ordenados[$count]=$nproceso
                ((count++))
            fi
        done
        #!# sustiudo p por nProc
        if [[ $count -gt $p ]]; then
            acabado=1
        else
            ((t++))
        fi
    done

    ## ACTUALIZO LA FORMA DE ORDENACION - 01/06/2023

    valorMaximoTllegada=0

    ## Asigno el valor a valorMaximoTllegada si tLlegada tiene elementos
    if [[ ${#tLlegada[@]} -gt 0 ]]; then
        for elemento in "${tLlegada[@]}"; do
            if (( elemento > valorMaximoTllegada )); then
                valorMaximoTllegada=$elemento
            fi
        done
        # echo "ENTRO IF "
        # for valor in "${tLlegada[@]}"
        # do
        #     echo "$valor"
        #     echo "${#tLlegada[-1]}"
        # done
    fi
    

    # echo "$valorMaximoTllegada VALOR MAXIMOTTLEGADA // ${#tLlegada[@]} longitud del mismo ";
    contTllegada=0
    ## Creo un bucle con un contador para ir uno en uno leyendo prioridaddes
    for ((contTllegada = 1; contTllegada <= $valorMaximoTllegada; contTllegada++)); do
        # echo "ENTRO FOR"
        ## Por cada linea almacenare de forma temporal los procesos que tengan el mismo tiempo de llegada
        vectorTemporalProcesosIgualTllegada=()

        ## Recorro todos los procesos buscando el mismo tll

        for proceso in "${ordenados[@]}"; do
            # echo "BUCLE MUESTRO PROCESO $proceso"
            if [[ ${tLlegada[$proceso]} -eq $contTllegada && ${tLlegada[$proceso]} =~ ^[0-9]+$ ]]; then
                vectorTemporalProcesosIgualTllegada+=("$proceso")
            fi
        done

        ## Ahora repito el proceso pero con las prioridades

        if [[ $prioridadMayorMMenorN == "m" ]]; then
            # echo "ENTRO PRI M"
            ## Recorro un bucle desde la maximaPrioridad hasta la minimaPrioridad
            for ((contadorPrioridadesOrdenacion = $maximoPrioridad; contadorPrioridadesOrdenacion >= $minimoPrioridad; contadorPrioridadesOrdenacion--)); do
                ## Recorro todos los procesos que tienen el mismo tiempo de llegada
                for elemento in "${vectorTemporalProcesosIgualTllegada[@]}"; do
                    ## Pregunto si tiene una prioridad igual al contadorPrioridadOrdenacion de este momento
                    if [[ ${prProcesos[$elemento]} -eq contadorPrioridadesOrdenacion ]]; then
                        ## Si se cumple se agrega al vector temporal
                        vectorSignificativoLimpio+=("$elemento")
                        
                    fi
                done
                
            done
            # echo "------EMPIEZO------"
            # for elemento in "${vectorSignificativoLimpio[@]}"; do
            #      echo "$elemento ORDEN DEL MISMO, tamaño actual ${#vectorSignificativoLimpio[@]}"
            # done
            # echo "------FIN------"
          
        else
        echo "ENTRO ELSE"
            ## Recorro un bucle desde la minimaPrioridad hasta la maximaPrioridad
            for ((contadorPrioridadesOrdenacion = $minimoPrioridad; contadorPrioridadesOrdenacion <= $maximoPrioridad; contadorPrioridadesOrdenacion++)); do
                ## Recorro todos los procesos que tienen el mismo tiempo de llegada
                echo "ENTRO BUCLE $contadorPrioridadesOrdenacion"
                for elemento in "${vectorTemporalProcesosIgualTllegada[@]}"; do
                    ## Pregunto si tiene una prioridad igual al contadorPrioridadOrdenacion de este momento
                    if [[ ${prProcesos[$elemento]} -eq contadorPrioridadesOrdenacion ]]; then
                        ## Si se cumple se agrega al vector temporal
                        vectorSignificativoLimpio+=("$elemento")
                        
                    fi
                done
                
            done

            
        fi
    done
    if [ ${#vectorSignificativoLimpio[@]} -eq ${#ordenados[@]} ]; then


        
        #for indice in "${!vectorSignificativoLimpio[@]}"; do
        #    elemento="${vectorSignificativoLimpio[$indice]}"
        #    ordenados[$indice]="$elemento"
        #done

        # echo "INICIO VECTOR PRI"
        # echo ""
        
        # for elemento in "${vectorSignificativoLimpio[@]}"; do
        #     echo "$elemento -DESPUES- EN VECTOR PRIORIDAD"
        # done

        # echo "FIN VECTOR PRI"
        # echo ""
        # echo "INICIO ORDENADOS"
        # for elemento in "${ordenados[@]}"; do
        #    echo "$elemento -DESPUES- EN VECTOR ORDENADOS"
        # done
        # echo "FIN ORDENADOS"
        # echo ""

        # echo "IGUALO"
        # countPr=1
        for indice in "${!vectorSignificativoLimpio[@]}"; do
            ordenados[$indice]="${vectorSignificativoLimpio[$indice]}"
        done

        # echo "INICIO ORDENADOS DEPSUES IGUALAR"
        # for elemento in "${ordenados[@]}"; do
        #     echo "$elemento -DESPUES- EN VECTOR ORDENADOS"
        # done
        # echo "FIN ORDENADOS DESPUES IGUALAR"
    fi
}


###################################################################################
###########################                             ###########################
##################          ###        #####        ###          ##################
############       #############        ###        #############       ############
########      ###################        #        ###################      ########
#####     #####################                     #####################     #####
###     #######################  #################  #######################     ###
##    #########################  ##-------------##  #########################    ##
##    #########################  ##--ALGORITMO--##  #########################    ##
##    #########################  ##-------------##  #########################    ##
###     #######################  #################  #######################     ###
#####     #####################                     #####################     #####
########      ###################        #        ###################      ########
############       #############        ###        #############       ############
##################          ###        #####        ###          ##################
###########################                             ###########################
###################################################################################

# Genera dos arrays con los nombres de los procesos, tanto con formato como sin.
# Son usados en la linea de tiempo y la barra de memoria nuevas
generar_nombre_procesos() {

    local procesoActual
    # echo "${ordenados[@]}"

    nombreProceso[1]="P01"
    nombreProcesoColor[1]="\e[1;3${colorines[((procesoActual + 1))]}m\e[1mP01\e[39m\e[22m"

    for (( i=1 ; i <= nProc ; i++ )); do

        procesoActual=${ordenados[$i]}

        if [[ procesoActual -lt 10 ]]; then

            nombreProceso[$procesoActual]=$(
            printf "P0%d" "$procesoActual"
            )

            local color=${colorines[procesoActual]}

            nombreProcesoColor[$procesoActual]=$(
                printf "\e[1;3${color}m\e[1mP0${procesoActual}\e[39m\e[22m"
            )

        else

            nombreProceso[$procesoActual]=$(
                printf "P%d" "$procesoActual"
            )

            local color=${colorines[$procesoActual]}

            nombreProcesoColor[$procesoActual]=$(
                printf "\e[1;3${color}m\e[1mP${procesoActual}\e[39m\e[22m"
            )

        fi

    done

    # echo -e "${nombreProceso[@]}\n${nombreProcesoColor[@]}"

}

# Función que imprime los parámetros generales con los que se ejecuta el algoritmo
# 02-05 MODIFICO ROUND ROGIN POR PRIORIDAD MAYOR/MENOR
imprimeTiempo(){
    echo  -e " \e[1;39mPRIORIDAD MAYOR/MENOR + PAGINACIÓN + ÓPTIMO + NO CONTINUO + REUBICABLE\e[0m";
    echo -en " \e[39mT=\e[1;31m$tiempoDelSistema\e[0m ";
    echo -en " \e[39mMemTot:\e[1;31m$tamMem\e[0m ";
    echo -en " \e[39mTamMarc:\e[1;31m$tamPag\e[0m ";
    echo -en " \e[39mMarcMem:\e[1;31m$marcosMem\e[0m "
    if [[ "$conEntradaCPU" == 's' || "$conEntradaCPU" == "1" ]]
    then
        echo -en " \e[39mTentradaCPU:\e[1;31m$tiempoPorPagina\e[0m ";
    fi
    echo -en " \e[39mFactReub:\e[1;31m$factReub\e[0m ";
    # 02-05 COMENTO LA LINEA DONDE MUESTRO POR PANTALLA EL QUANTUM DE TIEMPO
    # echo -e " \e[39mQuant:\e[1;31m$tamQuant\e[0m ";
    
}

# Función que selecciona cual de los modos de ejecucion hay que emplear a la hora de ejecutar
# el algoritmo de Round Robin. De manera completa, de manera automática (cada x tiempo) y de
# forma completa.
seleccionRR(){
    clear
    cabeceraInicio
    echo -e "\n\e[1;38;5;81mSeleccione el tipo de ejecución: \e[0m\n"
    echo -e "    \e[1;32m	[1]\e[0m -> Por eventos (Pulsando \e[1m'INTRO'\e[22m en cada cambio de estado)"
    echo -e "    \e[1;32m	[2]\e[0m -> Automático (Temporizada, cada 'x' segundos se realizará una iteración)"
    echo -e "    \e[1;32m	[3]\e[0m -> Completa (Todo de una vez, muestra el resumen final)"
    echo -e "    \e[1;32m	[4]\e[0m -> Por instantes de tiempo"
    echo -e "    \e[1;32m	[5]\e[0m -> Último instante (muestra el estado final)\n"

    read -p "Seleccione la opción: " opcionEjec
    until [[ "$opcionEjec" == "1" || "$opcionEjec" == "2" || "$opcionEjec" == "3" || "$opcionEjec" == "4" || "$opcionEjec" == "5" ]]
        do
            echo -e -n "\n\e[1;31mValor incorrecto, introduzca \e[1;33m1\e[0m\e[1;31m-\e[0m\e[1;33m5\e[0m\e[1;31m: \e[0m"
            read opcionEjec
        done
    case $opcionEjec in
        "1")
        clear
        cabeceraInicio
        echo -e "\n\e[1;38;5;81mSeleccione el tipo de ejecución: \e[0m\n" | tee -a $informeColor
        echo -e "    \e[1;38;5;64;48;5;7m	[1]\e[90m -> Por eventos (Pulsando 'INTRO' en cada cambio de estado)	\e[0m" | tee -a $informeColor
        echo -e "    \e[1;32m	[2]\e[0m -> Automático (Temporizada, cada 'x' segundos se realizará una iteración)" | tee -a $informeColor
        echo -e "    \e[1;32m	[3]\e[0m -> Completa (Todo de una vez, muestra el resumen final)" | tee -a $informeColor
        echo -e "    \e[1;32m	[4]\e[0m -> Por instantes de tiempo" | tee -a $informeColor
        echo -e "    \e[1;32m	[2]\e[0m -> Último instante (muestra el estado final)\n" | tee -a $informeColor

        

        echo -e "\nSeleccione el tipo de ejecución: \n" >> $informe
        echo "	  -> Por eventos (Pulsando 'INTRO' en cada cambio de estado) <-	" >> $informe
        echo -e "	 Automático (Temporizada, cada 'x' segundos se realizará una iteración)" >> $informe
        echo -e "    Completa (Todo de una vez, muestra el resumen final)" >> $informe
        echo -e "    Por instantes de tiempo" >> $informe
        echo -e "   Último instante (muestra el estado final)\n" >> $informe

        sleep 0.5
        ;;
        "2")
        clear
        cabeceraInicio
        echo -e "\n\e[1;38;5;81mSeleccione el tipo de ejecución: \e[0m\n" | tee -a $informeColor
        echo -e "    \e[1;32m	[1]\e[0m -> Por eventos (Pulsando \e[1m'INTRO'\e[22m en cada cambio de estado)" | tee -a $informeColor
        echo -e "    \e[1;38;5;64;48;5;7m	[2]\e[90m -> Automático (Temporizada, cada 'x' segundos se realizará una iteración)\e[0m" | tee -a $informeColor
        echo -e "    \e[1;32m	[3]\e[0m -> Completa (Todo de una vez, muestra el resumen final)" | tee -a $informeColor
        echo -e "    \e[1;32m	[4]\e[0m -> Por instantes de tiempo" | tee -a $informeColor
        echo -e "    \e[1;32m	[2]\e[0m -> Último instante (muestra el estado final)\n" | tee -a $informeColor
        

        echo -e "\nSeleccione el tipo de ejecución: \n" >> $informe
        echo -e "   Por eventos (Pulsando 'INTRO' en cada cambio de estado)" >> $informe
        echo -e "-> Automático (Temporizada, cada 'x' segundos se realizará una iteración) <-" >> $informe
        echo -e "   Completa (Todo de una vez, muestra el resumen final)\n" >> $informe
        echo -e "   Por instantes de tiempo" >> $informe
        echo -e "   Último instante (muestra el estado final)\n" >> $informe


        sleep 0.5

        clear

        echo -en " Número de segundos por iteración: "
        read segAuto

        ;;
        "3")
        clear
        cabeceraInicio
        echo -e "\n\e[1;38;5;81mSeleccione el tipo de ejecución: \e[0m\n" | tee -a $informeColor
        echo -e "    \e[1;32m	[1]\e[0m -> Por eventos (Pulsando \e[1m'INTRO'\e[22m en cada cambio de estado)" | tee -a $informeColor
        echo -e "    \e[1;32m	[2]\e[0m -> Automático (Temporizada, cada 'x' segundos se realizará una iteración)" | tee -a $informeColor
        echo -e "    \e[1;38;5;64;48;5;7m	[3]\e[90m -> Completa (Todo de una vez, muestra el resumen final)\e[0m" | tee -a $informeColor
        echo -e "    \e[1;32m	[4]\e[0m -> Por instantes de tiempo" | tee -a $informeColor
        echo -e "    \e[1;32m	[2]\e[0m -> Último instante (muestra el estado final)\n" | tee -a $informeColor

        

        echo -e "\nSeleccione el tipo de ejecución: \n" >> $informe
        echo -e "   Por eventos (Pulsando 'INTRO' en cada cambio de estado)" >> $informe
        echo -e "   Automático (Temporizada, cada 'x' segundos se realizará una iteración)" >> $informe
        echo -e "-> Completa (Todo de una vez, muestra el resumen final) <-" >> $informe
        echo -e "   Por instantes de tiempo" >> $informe
        echo -e "   Último instante (muestra el estado final)\n" >> $informe


        sleep 0.5
        ;;
        "4")
        clear
        cabeceraInicio
        echo -e "\n\e[1;38;5;81mSeleccione el tipo de ejecución: \e[0m\n" | tee -a $informeColor
        echo -e "    \e[1;32m	[1]\e[0m -> Por eventos (Pulsando \e[1m'INTRO'\e[22m en cada cambio de estado)" | tee -a $informeColor
        echo -e "    \e[1;32m	[2]\e[0m -> Automático (Temporizada, cada 'x' segundos se realizará una iteración)" | tee -a $informeColor
        echo -e "    \e[1;32m	[3]\e[0m -> Completa (Todo de una vez, muestra el resumen final)\e[0m" | tee -a $informeColor
        echo -e "    \e[1;38;5;64;48;5;7m	[4]\e[90m -> Por instantes de tiempo\e[0m" | tee -a $informeColor
        echo -e "    \e[1;32m	[2]\e[0m -> Último instante (muestra el estado final)\n" | tee -a $informeColor
        

        echo -e "\nSeleccione el tipo de ejecución: \n" >> $informe
        echo -e "   Por eventos (Pulsando 'INTRO' en cada cambio de estado)" >> $informe
        echo -e "   Automático (Temporizada, cada 'x' segundos se realizará una iteración)" >> $informe
        echo -e "   Completa (Todo de una vez, muestra el resumen final) <-" >> $informe
        echo -e "-> Por instantes de tiempo" >> $informe
        echo -e "   Último instante (muestra el estado final)\n" >> $informe


        sleep 0.5

        ;;
        "5")
        clear
        cabeceraInicio
        echo -e "\n\e[1;38;5;81mSeleccione el tipo de ejecución: \e[0m\n" | tee -a $informeColor
        echo -e "    \e[1;32m	[1]\e[0m -> Por eventos (Pulsando \e[1m'INTRO'\e[22m en cada cambio de estado)" | tee -a $informeColor
        echo -e "    \e[1;32m	[2]\e[0m -> Automático (Temporizada, cada 'x' segundos se realizará una iteración)" | tee -a $informeColor
        echo -e "    \e[1;32m	[3]\e[0m -> Completa (Todo de una vez, muestra el resumen final)\e[0m" | tee -a $informeColor
        echo -e "    \e[1;32m	[4]\e[0m -> Por instantes de tiempo\e[0m" | tee -a $informeColor
        echo -e "    \e[1;38;5;64;48;5;7m	[5]\e[90m -> Último instante (muestra el estado final)\e[0m\n" | tee -a $informeColor
        

        echo -e "\nSeleccione el tipo de ejecución: \n" >> $informe
        echo -e "   Por eventos (Pulsando 'INTRO' en cada cambio de estado)" >> $informe
        echo -e "   Automático (Temporizada, cada 'x' segundos se realizará una iteración)" >> $informe
        echo -e "   Completa (Todo de una vez, muestra el resumen final) <-" >> $informe
        echo -e "   Por instantes de tiempo" >> $informe
        echo -e "-> Último instante (muestra el estado final)\n" >> $informe
        

        sleep 0.5

        ;;
    esac
    clear
}


# Devuelve el primer índice de un elemnto dentro de un arr dado
# $1 es el valor buscado
# $2-255 expansion del array
indiceEnArr() {

    local value=$1
    shift
    local temp_arr=("$@")

    for i in "${!temp_arr[@]}"; do
        if [[ "${temp_arr[$i]}" = "${value}" ]]; then
            echo "${i}";
            break;
        fi
    done
}

# Devuelve el último índice de un elemento dentro de un arr dado
# $1 valor a buscar
# $2-255 expansión del array
ultimoIndiceEnArr() {

    local value=$1
    shift
    local temp_arr=("$@")
    local last_indx=0

    for i in "${!temp_arr[@]}"; do
        if [[ "${temp_arr[$i]}" = "${value}" ]]; then
            last_indx=$i
        fi
    done

    echo "${last_indx}"
}



# Devuelve el número de caracteres que se necesitarán para el ancho del panel
# de datos, la banda de memoria y la banda de tiempo.
calcularAnchoDeBloque() {

    local comp=0
    local digitos=0

    # Lopear por todas las páginas y quedarnos con la que tenga el nº más alto
    for i in "${paginas[@]}"; do
        if [[ i -gt comp ]]; then
            comp=${i}
        fi
    done

    # Lopear por todos los tiempos de llegada y quedarnos con la que tenga el nº más alto
    for i in "${tLlegada[@]}"; do
        if [[ i -gt comp ]]; then
            comp=${i}
        fi
    done



    #Obtener los dígitos del número
    digitos=${#comp}

    # El ancho mínimo es 3, si hay más dígitos poner dicho nº como ancho + 1
    if [[ digitos -lt 3 ]]; then
        echo "3"
    else
        echo "$(( digitos + 1 ))"
    fi

}



# Permite obtener el siguiente índice dentro de un array de un valor dado o un valor diferente al dado.
# $1 - Valor a buscar / comparar 
#      - Si el valor introducido es un nº, busca el nº y devuelve el índice de la primera ocurrencia.
#      - Si el valor introducido es del tipo (nx) donde n es un número y x es la letra 'x'. La función
#        buscará la primera ocurrencia en la cual se encuentre con un valor diferente al valor de n.
# $2 - Posición dentro del array desde la cual buscar. (igual que los índices, empieza en 0)
# $3-255 - Expansión del array en el cual buscar.
siguienteIndxArr() {

    local found=0

    local value=$1
    shift
    local starting_pos=$1
    shift

    # El array se expande al ser pasado a una función (así funciona bash) es decir, sus elemntos
    # acaban siendo argumentos de la función. Shift quita el primer argumento de los pasados.
    # Se van quitando argumetos hasta tener solo los siguientes al valor de inicio. 
    # (seria como cortar el array desde un punto de inicio hasta el final)
    for (( i=0 ; i < starting_pos ; i++ )); do
        shift
    done

    # Con los argumetnos restantes se reconstruye el array
    local temp_arr=("$@")

    # Si el valor pasado es del tipo (nx), la 'x' indica que queremos buscar la primera ocurrencia
    # diferente al valor de n.
    if [[ "$value" =~ "x" ]]; then
        value="${value/"x"/""}"
        for i in "${!temp_arr[@]}"; do
            if [[ "${temp_arr[$i]}" != "${value}" ]]; then
                echo "$(( i + starting_pos ))";
                found=1
                break;
            fi
        done

    # Por otro lado si no pasamos 'x' en la llamada, se busacará la primera ocurrencia de ese valor.
    else
        for i in "${!temp_arr[@]}"; do
            if [[ "${temp_arr[$i]}" = "${value}" ]]; then
                echo "$(( i + starting_pos ))";
                found=1
                break;
            fi
        done
    fi

    # Si no se encuentra en el array se devuelve -1
    if [[ found -eq 0 ]]; then
        echo "-1"
    fi
}

# Función que devuelve los valores de los trozos en los que está divido un proceso dado en memoria.
# Los valores se devuelven con echos, el propósito de la función es devovler un array. Como en bash
# no se puede nativamente se manda todo a salida estandar, esto significa que se necesita redireccionar
# la salida de esta funcion a una variable. El método mas sencillo de llamarla es la siguiente.
#  
#  COMO LLAMAR LA FUNCIÓN: readarray -td $'\n' array_destino <<< "$( calcularTrozos "n_proceso" )"
# 
# $1 - Proceso del cual obtener sus trozos.
calcularTrozos() {

    local procesoActual=$1
    local marcos=0
    local temp=0
    local temp2=0

    # Iterar por la memoria hasta que todos los trozos del proceso sumen su nº de marcos asociado
    until [[ marcos -eq ${nMarcos[$procesoActual]} ]]; do

        # Obtener el inicio del siguiente trozo
        temp=$( siguienteIndxArr "${procesoActual}" "${temp}" "${VectorMemoriaProceso[@]}" )
        temp2="${temp}"
        # Obtener el final del trozo actual
        temp=$( siguienteIndxArr "${procesoActual}x" "${temp}" "${VectorMemoriaProceso[@]}" )

        if [[ temp2 -eq -1 ]]; then
            break
        elif [[ temp -eq -1 ]]; then
            echo -e "${temp2}\n$(( marcosMem - 1 ))"
            break
        else
            echo -e "${temp2}\n$(( temp - 1))"
        fi

        # Sumar los marcos del trozo actual
        marcos=$(( marcos + (temp - temp2) ))
    done

}


# Nuevo diagrama resumen, es el panel superior de la interfaz donde se muestran las carácterísticas
# básicas de los procesos, su estado y sus direcciones-páginas.
# Esta reescrito para ser mucho más sencillo y menos enrevesado que la iteración anterior. Permite
# a su vez dividir los procesos en caso de que se dividan en la memoria (al ser no continua).
diagramaresumen() {

    local tMedioRetorno=0
    local tMedioEspera=0

    local temp=0
    local tempIndx=0
    local estado=""
    local trozos=()
    local m=0


    # echo "${!arrayEstado[*]}"
    # echo "${arrayEstado[*]}"


    printf " Ref Tll Tej nMar Cod Tesp Tret Trej Mini Mfin Estado            Dirección-Página\n"


    # Iteramos cada proceso e imprimimos unos datos u otros en base a su estado
    for (( proceso=1 ; proceso <= nProc ; proceso++ )); do

        # Información acerca del proceso
        imprDir=1
        trozos=()
        tempIndx=0
        temp=${ordenados[$proceso]}
        estado="${estadosProcesos[$temp]}"

        # Información general del proceso
        if [[ "${estado}" = "Fuera de sistema" ]]; then
            echo -en " ${nombreProcesoColor[temp]}"

                printf "\e[1;3${colorines[$temp]}m%4s%4s%5s%4s%5s%5s%5s%5s%5s%-19s\e[0m" "${tLlegada[$temp]}" "${tEjec[$temp]}" "${nMarcos[$temp]}" "${paginasCodigo[$temp]}" "-" "-" "-" "-" "-" " $estado"


        elif [[ "${estado}" = "Finalizado" ]]; then
            echo -en " ${nombreProcesoColor[temp]}"

            printf "\e[1;3${colorines[$temp]}m%4s%4s%5s%4s%5s%5s%5s%5s%5s%-19s\e[0m" "${tLlegada[$temp]}" "${tEjec[$temp]}" "${nMarcos[$temp]}" "${paginasCodigo[$temp]}" "${tiempoDeEspera[$temp]}" "${tiempoDeRetorno[$temp]}" "-" "-" "-" " $estado"



        elif [[ "${estado}" = "En espera" ]]; then
            # tRetorno[$temp]=$(( tSistema - ${tLlegada[$temp]} ))
            echo -en " ${nombreProcesoColor[temp]}"

            printf "\e[1;3${colorines[$temp]}m%4s%4s%5s%4s%5s%5s%5s%5s%5s%-19s\e[0m" "${tLlegada[$temp]}" "${tEjec[$temp]}" "${nMarcos[$temp]}" "${paginasCodigo[$temp]}" "${tiempoDeEspera[$temp]}" "${tiempoDeRetorno[$temp]}" "-" "-" "-" " $estado"

            
        else

            # Obtener los trozos del proceso y actualizar su tiempo de retorno
            readarray -td $'\n' trozos <<< "$( calcularTrozos "$temp" )"
            #  tRetorno[$temp]=$(( tSistema - ${tLlegada[$temp]} ))

            # echo -e "${!trozos[*]}\n${trozos[*]}"
            

            # Si el proceso no es continuo en memoria imprimir tantas líneas como trozos tiene el proceso
            if [[ "${#trozos[@]}" -gt 2 ]]; then
            
                for (( linea=0 ; linea <= $(( ${#trozos[@]} / 2 )) ; linea++ )); do
                    if [[ linea -eq 0 ]]; then
                        echo -en " ${nombreProcesoColor[temp]}"

                        printf "\e[1;3${colorines[$temp]}m%4s%4s%5s%4s%5s%5s%5s%5s%5s%-19s\e[0m" "${tLlegada[$temp]}" "${tEjec[$temp]}" "${nMarcos[$temp]}" "${paginasCodigo[$temp]}" "${tiempoDeEspera[$temp]}" "${tiempoDeRetorno[$temp]}" "${tiempoPorEjecutar[$temp]}" "${trozos[$tempIndx]}" "${trozos[$(( tempIndx + 1 ))]}" " $estado"

                        

                        # No imprimir las direcciones al final
                        imprDir=0

                        # Imrpimir las direcciones en la primera línea de los procesos no continuos
                        xx=0
                        for (( v = 0; v < ${paginaActualProceso[$temp]} ; v++ )); do
                            if [[ xx -eq 0 && "${estado}" != "Fuera de sistema" && "${estado}" != "En espera" && "${estado}" != "Finalizado" && "${estado}" != "En pausa" ]]; then
                                printf " "
                            fi
                            printf "\e[4;3${colorines[$temp]}m%s-\e[1m%s\e[0m " "${direcciones[$temp,$xx]}" "${paginas[$temp,$xx]}"
                            ((xx++))
                        done
                    
                        for (( v = 0; v < $((  ${maxpags[$temp]} - ${paginaActualProceso[$temp]}  )) ; v++ )); do
                            printf "\e[3${colorines[$temp]}m%s-\e[1m%s\e[0m " "${direcciones[$temp,$xx]}" "${paginas[$temp,$xx]}"
                            ((xx++))
                        done

                    else
                        printf "\n    \e[1;3${colorines[$temp]}m%32s%5s%5s\e[0m" "" "${trozos[$tempIndx]}" "${trozos[$(( tempIndx + 1 ))]}"
                    fi

                    tempIndx=$(( tempIndx + 2 ))
                done

            # Si es continuo imprimir el proceso de una
            else
                echo -en " ${nombreProcesoColor[temp]}"

                printf "\e[1;3${colorines[$temp]}m%4s%4s%5s%4s%5s%5s%5s%5s%5s%-19s\e[0m" "${tLlegada[$temp]}" "${tEjec[$temp]}" "${nMarcos[$temp]}" "${paginasCodigo[$temp]}" "${tiempoDeEspera[$temp]}" "${tiempoDeRetorno[$temp]}" "${tiempoPorEjecutar[$temp]}" "${trozos[0]}" "${trozos[1]}" " $estado"

            fi
        fi


        # Direccion-Pag
        if [[ imprDir -eq 1 ]]; then
            xx=0
            for (( v = 0; v <= ${paginaActualProceso[$temp]} ; v++ )); do
                if [[ xx -eq 0 && "${estado}" != "Fuera de sistema" && "${estado}" != "En espera" && "${estado}" != "Finalizado" && "${estado}" != "En pausa" ]]; then
                    printf " "
                fi
                printf "\e[4;3${colorines[$temp]}m%s-\e[1m%s\e[0m " "${direcciones[$temp,$xx]}" "${paginas[$temp,$xx]}"
                ((xx++))
            done
        
            for (( v = 0; v <  $((  ${maxpags[$temp]} - ${paginaActualProceso[$temp]} - 1))  ; v++ )); do
                printf "\e[3${colorines[$temp]}m%s-\e[1m%s\e[0m " "${direcciones[$temp,$xx]}" "${paginas[$temp,$xx]}"
                ((xx++))
            done
        fi

        printf "\n"

    done


    local tiempoMedioDeEspera=0
    for tEspera in ${tiempoDeEspera[@]}
    do
        tiempoMedioDeEspera=$(($tiempoMedioDeEspera+$tEspera))
    done
    local resultado=$(echo "scale=2; $tiempoMedioDeEspera / $nProc" | bc)
    printf  "Tiempo medio de espera: $resultado\t" 
    local tiempoMedioDeRetorno=0
    for tRetorno in ${tiempoDeRetorno[@]}
    do
        tiempoMedioDeRetorno=$(($tiempoMedioDeRetorno+$tRetorno))
    done
    local resultado=$(echo "scale=2; $tiempoMedioDeRetorno / $nProc" | bc)
    printf  "Tiempo medio de retorno: $resultado\n" 


}


# Función que imprime un resumen con las estadísticas de la ejecución del algoritmo. Tiempos de espera, retorno, fallos de página...
resumenfinal(){

    media 'tiempoDeEspera[@]'
    mediaespera=$laMedia
    media 'tiempoDeRetorno[@]'
    mediadura=$laMedia
    laMedia=0
    clear
    echo "" >> $informe
    echo "" >> $informe
    echo "" >> $informe
    echo "" >> $informe
    echo "" >> $informe
    echo "" >> $informe
    echo "" >> $informe
    echo "" | tee -a $informeColor
    echo "" | tee -a $informeColor
    echo -e " T.Espera:    Tiempo que el proceso no ha estado ejecutándose en la CPU desde que entra en memoria hasta que sale" | tee -a $informeColor
    echo -e " Inicio/Fin:  Tiempo de llegada al gestor de memoria del proceso y tiempo de salida del proceso" | tee -a $informeColor
    echo -e " T.Retorno:   Tiempo total de ejecución del proceso, incluyendo tiempos de espera, desde la señal de entrada hasta la salida" | tee -a $informeColor
    echo -e " Fallos Pág.:   Número de fallos de página que han ocurrido en la ejecución de cada proceso" | tee -a $informeColor
    echo -e " Resumen final con tiempos de ejecución y fallos de página de cada proceso" | tee -a $informeColor
    echo -e " Proc. T.Espera Inicio/Fin T.Retorno Fallos Pág. " | tee -a $informeColor
    
    #					 | Proc. | T.Espera | Inicio/Fin  | T.Retorno | Fallos Pág.
    #					 |----------------------------------------------------------->
    #					 |-------|----------|-------------|-----------|-------------->
    #					  .......|..........|.............|...........|
    #						7          10         12           11
    #                    |..###..|.########.|.#####/#####.|..#######..|.

    echo " T.Espera: Tiempo que el proceso no ha estado ejecutándose en la CPU desde que entra en memoria hasta que sale" >> $informe
    echo " Inicio/Fin:  Tiempo de llegada al gestor de memoria del proceso y tiempo de salida del proceso" >> $informe
    echo " T.Retorno:   Tiempo total de ejecución del proceso, incluyendo tiempos de espera, desde la señal de entrada hasta la salida" >> $informe
    echo " Fallos Pág.:   Número de fallos de página que han ocurrido en la ejecución de cada proceso" >> $informe
    echo "" >> $informe
    echo "" >> $informe
    echo " Resumen final con tiempos de ejecución y fallos de página de cada proceso" >> $informe
    echo "" >> $informe
    echo "" >> $informe
    for (( counter=1; counter <= $nProc; counter++ ))
        do
            echo "|" >> $informe
            if [[ $counter -lt 10 ]]
                then
                    printf " \e[1;3${colorines[$counter]}mP0$counter\e[0m  \e[1;3${colorines[$counter]}m%8u\e[0m \e[1;3${colorines[$counter]}m%5u/%-5u\e[0m   \e[1;3${colorines[$counter]}m%7u\e[0m   \e[1;3${colorines[$counter]}m%u \e[0m\n" "${tiempoDeEspera[$counter]}" "${tiempoDeInicio[$counter]}" "${tiempoDeFin[$counter]}" "${tiempoDeRetorno[$counter]}"  "${nFallosPagina[$counter]}"  | tee -a $informeColor
                    echo "|  Proceso: P0$counter	T.Espera: ${tiempoDeEspera[$counter]}	Inicio/fin: ${tiempoDeInicio[$counter]}/${tiempoDeFin[$counter]}	T.Retorno: ${tiempoDeRetorno[$counter]}	Fallos Pág.: ${nFallosPagina[$counter]}" >> $informe
                else
                    printf " \e[1;3${colorines[$counter]}mP$counter\e[0m  \e[1;3${colorines[$counter]}m%8u\e[0m \e[1;3${colorines[$counter]}m%5u/%-5u\e[0m   \e[1;3${colorines[$counter]}m%7u\e[0m   \e[1;3${colorines[$counter]}m%u \e[0m\n" "${tiempoDeEspera[$counter]}" "${tiempoDeInicio[$counter]}" "${tiempoDeFin[$counter]}" "${tiempoDeRetorno[$counter]}"  "${nFallosPagina[$counter]}"  | tee -a $informeColor
                    echo "|  Proceso: P$counter	T.Espera: ${tiempoDeEspera[$counter]}	Inicio/fin: ${tiempoDeInicio[$counter]}/${tiempoDeFin[$counter]}	T.Retorno: ${tiempoDeRetorno[$counter]}	Fallos Pág.: ${nFallosPagina[$counter]}" >> $informe
            fi
        done
    echo "|" >> $informe
    echo -e "   \e[1;31mTiempo total\e[0m transcurrido en ejecutar todos los procesos: \e[1;31m$((tiempoDelSistema+1))\e[0m" | tee -a $informeColor
    echo -e "   \e[1;31mMedia tiempo espera\e[0m  de todos los procesos: \e[1;31m$mediaespera\e[0m" | tee -a $informeColor
    echo -e "   \e[1;31mMedia tiempo retorno\e[0m de todos los procesos: \e[1;31m$mediadura\e[0m" | tee -a $informeColor
    echo "   Tiempo total transcurrido en ejecutar todos los procesos: $tiempoDelSistema" >> $informe
    echo "   Media tiempo espera  de todos los procesos: $mediaespera" >> $informe
    echo "   Media tiempo retorno de todos los procesos: $mediadura" >> $informe
    echo "" | tee -a $informeColor
    echo "" | tee -a $informeColor
    echo "" >> $informe
    echo "" >> $informe


}



# Imprime un panel con más información acerca de la memoria.
# Este panel incluye los procesos en memoria, sus páginas, marcos, direcciones y contadores
# para el algoritmo de reemplazo. Sirve para memoria no continua y continua y está mucho
# más optimizado y simplificado que la función antigua.
imprimeOptimo() {

    # Var
    local temp
    local temp2
    local tempBloque

    local anchoBloque=5
    local anchoEtiqueta=12
    local anchoRestante=$(( $( tput cols ) - anchoEtiqueta - 2 ))
    
    local numBloquesPorLinea

    local procesoAnterior=-1
    local procesoActual=-2
    local primerMarco=0
    local ultimoMarco=""
    local ultimoProceso=""

    local  VectorMejorContadorProceso
    local  VectorMarcoReemplazo


    # Estos primeros bucles en para colocar los punteros a los marcos donde se introducirán
    # las paginas, ya sea por que hay marcos vacios o porque se va a producir un reemplazo

    for (( j=1 ; j<=$nProc ; j++))
    do
        VectorMejorContadorProceso[$j]=0

    done


    for (( i=0 ; i<$marcosMem ; i++ ))
    do
        
        local procesoAct=${VectorMemoriaProceso[$i]}


        if [[ "$procesoAct" == 0 || "$procesoAct" == '.' || "${VectorMemoriaPag[$i]}" == '+' ]]
        then
            continue
        fi

        local contadorMarcoActual=${VectorMemoriaContadorOptimo[$i]}
        local mejorContadorProceso=${VectorMejorContadorProceso[$procesoAct]}

        if [[ "${VectorMejorContadorProceso[$procesoAct]}" != '-' ]]
        then
            

            if [[ "$contadorMarcoActual" == '-' ]]
            then
                VectorMejorContadorProceso[$procesoAct]='-'
                VectorMarcoReemplazo[$procesoAct]=$i
            elif [[ "$contadorMarcoActual" == '*' && "$mejorContadorProceso" != '*' ]]
            then
                VectorMejorContadorProceso[$procesoAct]='*'
                VectorMarcoReemplazo[$procesoAct]=$i
            elif [[ "$mejorContadorProceso" == '*' ]]
            then
                continue
            elif [[ $mejorContadorProceso -lt $contadorMarcoActual ]]
            then
                VectorMejorContadorProceso[$procesoAct]=$contadorMarcoActual
                VectorMarcoReemplazo[$procesoAct]=$i
            fi
        fi

    done


    for (( i=0 ; i < $marcosMem ; i++ ))
    do
        VectorMemoriaApuntador[$i]=0
    done

    for i in ${VectorMarcoReemplazo[@]}
    do
        VectorMemoriaApuntador[$i]=1
    done

    if [[ $anchoPorBloque -gt 5 ]]; then

        anchoBloque=${anchoPorBloque}
        if [[ ${#tamMem} -gt $anchoBloque ]]
        then
            anchoBloque=${#tamMem}
        fi
    fi

    anchoBloque=$(max $anchoBloque ${#tamMem})

    for (( linea=0; ; linea++ )); do

        # Calcular cuantos marcos se van a imprimir en esta linea
        numBloquesPorLinea=$(( anchoRestante / anchoBloque ))
        ultimoMarco=$(( primerMarco + numBloquesPorLinea - 1 ))
        if [ $ultimoMarco -ge $marcosMem ];then
            ultimoMarco=$(( marcosMem - 1 ))
        fi

        procesoActual=-1
        procesoAnterior=-2

        #PROCESOS
        # Imprimir la etiqueta si estamos en la primera linea
        [ "$linea" -eq 0 ] && printf "%${anchoEtiqueta}s" " Proceso:   "
        ultimoProceso=-2
        for (( m=primerMarco; m<=ultimoMarco; m++ ));do
            procesoActual=${VectorMemoriaProceso[$m]}
            # Si el marco está vacío
            if [ "$procesoActual" == "." ];then
                printf -v tempBloque "\e[0m%-${anchoBloque}s" "|"
                echo -en "${tempBloque// /-}"


            # Si el marco es del mismo proceso
            elif [ "$procesoAnterior" == "$procesoActual" ];then
                if [[ "$procesoActual" != "${VectorMemoriaProceso[$((m+1))]}" ]]; then
                    printf -v tempBloque "\e[3${colorines[$procesoActual]};1m%$(( anchoBloque - 1 ))s\e[0m" ""
                    echo -en "${tempBloque// /-}"
                else
                    printf -v tempBloque "\e[3${colorines[$procesoActual]};1m%${anchoBloque}s\e[0m" ""
                    echo -en "${tempBloque// /-}"
                fi

            # Si se cambia de proceso
            elif [ "$procesoAnterior" !=  "$procesoActual" ];then

                echo -en "\e[0m|${nombreProcesoColor[$procesoActual]}"
                if [[ "$procesoActual" != "${VectorMemoriaProceso[$((m+1))]}" && "$procesoActual" != "." ]]; then
                    printf -v tempBloque "\e[3${colorines[$procesoActual]};1m%$(( anchoBloque - ${#nombreProceso[$procesoActual]} - 1))s" ""
                    echo -en "${tempBloque// /-}"
                else
                    printf -v tempBloque "\e[3${colorines[$procesoActual]};1m%$(( anchoBloque - ${#nombreProceso[$procesoActual]} ))s" ""
                    echo -en "${tempBloque// /-}"
                fi
            fi
            procesoAnterior=$procesoActual
        done
        printf "\e[0m|\n"

        procesoActual=-1
        procesoAnterior=-2

        # Nº MARCO
        # Fila con los números de los marcos de la memoria
        [ "$linea" -eq 0 ] && printf "%${anchoEtiqueta}s" " Marco:     "
        for (( m=primerMarco; m<=ultimoMarco; m++ )); do
            procesoActual=${VectorMemoriaProceso[$m]}
            # Si el marco esta vacio
            if [ "$procesoActual" == "." ];then
                printf "\e[0m|%-$((anchoBloque - 1))s" "M${m}"

            # Si el marco ha cambiado colocar | en la tabla
            elif [[ "$procesoActual" != "$procesoAnterior" ]]; then
                printf "\e[0m|\e[3${colorines[$procesoActual]};1m%-$((anchoBloque - 1))s" "M${m}"

            # Si el marco no esta vacio (dar color y unir)
            else
                printf " \e[3${colorines[$procesoActual]};1m%-$((anchoBloque - 1))s" "M${m}"
            fi
            procesoAnterior=$procesoActual
        done
        printf "\e[0m|\n"

        
        procesoActual=-1
        procesoAnterior=-2

        # PÁGINAS
        # Imprimir la etiqueta si estamos en la primera linea
        [ "$linea" -eq 0 ] && printf "%${anchoEtiqueta}s" " Página:    "
        for (( m=primerMarco; m<=ultimoMarco; m++ ));do
            procesoActual=${VectorMemoriaProceso[$m]}

            # Poner el color
            if [ "$procesoActual" != "." ]; then
                temp=$procesoActual
                temp2=${colorines[$temp]}
            fi

            # temp=${vectorMarcos[$m]}
            # marcoActualDentroDelProceso "$temp" "$m"
            # temp2=$? # marco dentro del proceso

            if [ "${memoriaPagina[$m]}" = "vacio" ] && [ "${paginasUso[$temp,$temp2]}" -eq "${memoriaPagina[$m]}" ];then
                printf "\e[1m"
            fi

            if [ "$procesoActual" == "." ];then
                printf -v tempBloque "%-${anchoBloque}s" "|"
                echo -en "${tempBloque// /-}"

            elif [[ "${VectorMemoriaPag[$m]}" = "-" && "$procesoActual" != "$procesoAnterior" ]]; then
                printf -v tempBloque "|\e[3${colorines[$temp]};1m%$(( anchoBloque - 1 ))s\e[0m" ""
                echo -en "${tempBloque// /-}"

            elif [[ "${VectorMemoriaPag[$m]}" == "-" ]]; then
                printf -v tempBloque "\e[3${colorines[$temp]};1m|%$(( anchoBloque - 1 ))s\e[0m" ""
                echo -en "${tempBloque// /-}"

            elif [[ "$procesoActual" != "$procesoAnterior" ]]; then
                printf "|\e[3${colorines[$temp]};1m%$(( anchoBloque - 1 ))s\e[0m" "${VectorMemoriaPag[$m]}"
            else
                printf "\e[3${colorines[$temp]};1m|%$(( anchoBloque - 1 ))s\e[0m" "${VectorMemoriaPag[$m]}"
            fi

            # if [ -n "${memoriaPagina[$m]}" ] && [ "${paginasUso[$temp,$temp2]}" -eq "${memoriaPagina[$m]}" ];then
            #     printf "\e[22m"
            # fi

            procesoAnterior=$procesoActual
        done
        printf "\e[0m|\n"

        procesoActual=-1
        procesoAnterior=-2


        # DIR. MEM.
        # Imprime la dirección de memoria en la que comienza cada "cacho" de proceso
        [ "$linea" -eq 0 ] && printf "%${anchoEtiqueta}s" "Dir. Mem.: "
        ultimoProceso=-2
        for (( m=primerMarco; m<=ultimoMarco; m++ ))
        do
            procesoActual=${VectorMemoriaProceso[$m]}

            if [[ "$procesoActual" == "." ]]
            then
                printf "\e[0m|%$(( anchoBloque - 1 ))s" ""
            elif [[ "$procesoActual" != "$procesoAnterior" ]]
            then
                printf "\e[0m|\e[3${colorines[$procesoActual]};1m%$(( anchoBloque - 1 ))s" "$(( m * tamPag ))"
            else
                printf "%${anchoBloque}s" ""
            fi
            procesoAnterior=$procesoActual
        done
        printf "\e[0m|\n"

        procesoActual=-1
        procesoAnterior=-2

        # CONTADOR
        # Imprime el contador del algoritmo de reemplazo
        [ "$linea" -eq 0 ] && printf "%${anchoEtiqueta}s" " Contador:  "
 
        for (( m=primerMarco; m<=ultimoMarco; m++ ));do
            procesoActual=${VectorMemoriaProceso[$m]}


            # Si no hay marco
            if [[ "$procesoActual" == "." ]]; then
                printf "\e[0m%${anchoBloque}s" " [--]"

            # Si hay marco y la página tiene contador
            elif [[ "${VectorMemoriaPag[$m]}" != "-" &&  "${VectorMemoriaContadorOptimo[$m]}" =~ [0-9] ]]; then
                if [[ "${VectorMemoriaContadorOptimo[$m]}" -lt 10 ]]; then
                    printf "\e[3${colorines[$procesoActual]};1m%${anchoBloque}s" " [ ${VectorMemoriaContadorOptimo[$m]}]"
                else
                    printf "\e[3${colorines[$procesoActual]};1m%${anchoBloque}s" " [${VectorMemoriaContadorOptimo[$m]}]"
                fi

            elif [[ "${VectorMemoriaPag[$m]}" == "-"  ]]
            then
                printf "\e[3${colorines[$procesoActual]};1m%${anchoBloque}s" " [--]"
            elif [[ "${VectorMemoriaPag[$m]}" == "+" ]]
            then
                printf "\e[3${colorines[$procesoActual]};1m%${anchoBloque}s" " [++]"

            # Si hay marco pero la página no tiene contador
            else
                printf "\e[3${colorines[$procesoActual]};1m%${anchoBloque}s" " [ *]"
            fi

            procesoAnterior=$procesoActual
        done
        printf "\e[0m\n"

        [ "$linea" -eq 0 ] && printf "%${anchoEtiqueta}s" " Apuntador: "
        printf " "
        for (( m=primerMarco; m<=ultimoMarco; m++ ));do
            procesoActual=${VectorMemoriaProceso[$m]}

            # Poner el color
            if [ "$procesoActual" != "." ]; then
                temp=$procesoActual
                temp2=${colorines[$temp]}
            fi

            if [[ ${VectorMemoriaApuntador[$m]} -eq 1 ]]
            then
                printf -v tempBloque "\e[3${colorines[$temp]};1m%$(( anchoBloque - 1 ))s\e[0m" ""
                echo -en "${tempBloque// /^}"
                echo -en " "
                
            else
                printf "%${anchoBloque}s" " "
            fi
        done
        printf "\e[0m\n"

        # Si se ha llegado al último marco
        if [ $ultimoMarco -eq $(( marcosMem - 1 )) ];then
            break;
        fi
        primerMarco=$(( ultimoMarco + 1 ))
        anchoRestante=$(( $( tput cols ) - 2 ))

        echo ""
    done

}


# Esta funcion inicializa los datos necesarios para realizar la ejecucion del algoritmo.
# Las variables utilizadas durante la ejecución del propio round robin se inicializan aquí
InicializaRoundRobin()
{
    # Declaraciones e inicializaciones de variables aqui

    # Esta variable se corresponderá con el tiempo en el que se encuentra el sistema
    declare -ig tiempoDelSistema=0;

    # Vector con posiciones de 1 a nProc que guarda el estado de cada proceso
    # Cada elemento puede tomar los valores:
    # - "Fuera de sistema": Cuando el proceso no ha llegado al sistema
    # - "En memoria": Cuando el proceso se encuentra alojado en memoria
    # - "En ejecución": Cuando el proceso se encuentra ejecutandose
    # - "En espera": Cuando el proceso ha llegado al sistema pero no se ha alojado en memoria
    # - "En pausa": Ha empezado a ejecutarse pero no se encuentra en ejecucion
    # - "Finalizado": Cuando el proceso ha terminado por completo su tiempo de ejecucion
    declare -ag estadosProcesos;

    # Este vector guarda el tiempo ejecutado de cada proceso
    declare -ag tiempoEjecutado;
    #Este vector guarda el tiempo que queda por ejecutar de cada proceso
    declare -ag tiempoPorEjecutar;
    #Este vector guarda los tiempos de espera de cada proceso
    declare -ag tiempoDeEspera;
    #Este vector guarda el tiempo de retorno del proceso
    declare -ag tiempoDeRetorno
    #Este vector guarda el tiempo de inicio de cada proceso
    declare -ag tiempoDeInicio
    #Este vector guarda el tiempo de fin de cada proceso
    declare -ag tiempoDeFin
    #Este vector guarda el numero de fallos de página de cada proceso
    declare -ag nFallosPagina

    # Cola de entrada a memoria
    colaEntradaMemoria=()

    # Cola de RoundRobin
    colaRoundRobin=()
    # puntero RoundRobin
    posicionRoundRobin=0;

    ## Vectores del estado de la memoria

    #Este vector contiene posiciones de 0 a nMarcos-1, correspondiendose con los marcos de memoria. El numero que contienen sus posiciones es el proceso al que pertenece el marco
    # en caso de ser '.' el marco no esta adquirido por ningun proceso.
    VectorMemoriaProceso=()

    # Este vector contiene posiciones de 0 a nMarcos-1, correspondiendose con los marcos de memoria. El numero que contienen sus posiciones es la pagina que contiene dicho marco,
    # en caso de que sea "-" significa que el marco no contiene ninguna página
    VectorMemoriaPag=()

    # Este vector contiene posiciones de 0 a nMarcos-1, correspondiendose con los marcos memoria. El numero que contienen sus posiciones es el contador del algoritmo optimo para el
    # reemplazo de paginas, si es '*' quiere decir que la pagina de ese marco no va a volver a utilizarse, puede entenderse como un infinito.
    VectorMemoriaContadorOptimo=()

    VectorMemoriaApuntador=()
    # Vector-diccionario que se indexa mediante proceso, marco, tiempo, contiene el estado de cada uno de los marcos de cada proceso.
    # guarda el nº de marco, pagina que contiene, y contador de optimo.
    declare -Ag historialProcesosPaginas
    declare -Ag historialApuntador

    ## Vectores de linea de tiempo

    #Este vector guarda que proceso se esta ejecutando en cada instante de tiempo
    VectorTiempoProceso=()
    #Este vector guarda la pagina que se ha procesado en cada instante de tiempo
    VectorTiempoPagina=()
    
    # Tiempo restante de quantum
    quantumRestante=$tamQuant

    #
    espacioLibreMemoria=$marcosMem

    ## FLAGS------------------------------------------------

    # Variable que indica cuando se ha producido un evento importante en el sistema
    #   Toma los valores:
    #   - 1: Cuando se ha producido un evento  
    #   - 0: Cuando no se ha producido un evento
    hayEvento=0;
    hayEntradaCPU=0;
    # Variable que indica cuando se ha producido una reubicación de memoria
    # Toma los valores:
    #   -1: cuando se ha producido reubicacion
    #   -0: cuando no hay reubicacion
    hayReubicacion=0

    # Variable que indica cuando un proceso ha finalizado su ejecución y así mostrar el historial de páginas de este por pantalla.
    # Toma los valores:
    #   -1: cuando un proceso ha finalizado
    #   -0: en caso contrario
    hayFinDeProceso=0;

    # Variable que indica cuándo se debe cambiar de proceso
    cambiarProceso=0

    ## FLAGS------------------------------------------------

    ## Logs------------------------------------------------

    # Cadena de texto que guarda los eventos que se han ido produciendo en el sistema
    logDeEventos=''
    # Cadena de texto que guarda las acciones que se hayan tomado con las distintas páginas
    logDePaginas=''

    ## Logs------------------------------------------------

    # Variables que guardaran los distintos estados de la memoria cuando se produzca la reubicacion. Solo para la salida por pantalla.
    antiguoEstadoMemoria=''
    nuevoEstadoMemoria=''

    # Variables de proceso en ejecucion
    # 0 indica ningún proceso
    procesoEjecutandose=0;
    antiguoProcesoEjecutandose=0;

    # punteros para las colas de llegada al sistema y a memoria
    punteroLlegadaProcesos=1;
    punteroProcesosMemoria=1;

    # Posicion a partir de la cual el proceso por entrar a memoria debe adquirir los marcos
    posicionEntradaMem=0

    paginaActualProceso=()




    tiempoRestanteEntradaCPU=0

    if [[ $tiempoPorPagina -eq 0 ]]
    then
        conEntradaCPU=0
    else
        conEntradaCPU=1
    fi


    #Estados de los procesos
    for (( i = 1 ; i <= $nProc ; i++));
    do
        estadosProcesos[$i]="Fuera de sistema"
        tiempoEjecutado[$i]=0
        tiempoPorEjecutar[$i]=${tEjec[$i]}
        tiempoDeEspera[$i]=0
        tiempoDeRetorno[$i]=0
        nFallosPagina[$i]=0
        paginaActualProceso[$i]=-1
        tiempoRestantePaginaProceso[$i]=0

    done;



    #   Codigo de vectores y bandas de memoria:
    #   - · Vacio, no reclamado por ningun proceso en la memoria
    #   -[0-9] pagina que contiene o se ha ejecutado
    #   - - Espacio reclamado por proceso pero que no contiene ninguna pagina


    #Estado de la memoria
    for (( i = 0 ; i < $marcosMem ; i++ ))
    do
        VectorMemoriaProceso[$i]="."
        VectorMemoriaPag[$i]="-"
        VectorMemoriaContadorOptimo[$i]="-"
        VectorMemoriaApuntador[$i]=0
    done;

}


# Esta funcion contempla toda la ejecucion del algoritmo
# Dependencias funcionales:
#   -calcularAnchoDeBloque: Se llama para poder conocer el ancho en caracteres para las funciones que sacan informacion por pantalla
#   -InicializaRoundRobin: Se llama para inicializar los datos necesarios para la ejecucion del algoritmo
#   -SeleccionRR: Se llama para poder elegir el modo de ejecucion que se desea del algoritmo por eventos/Completa/Automatizada/por instantes de tiempo
#   -CompruebaFinDeEjecucion: Se llama a la funcion para conocer si el algoritmo ha finalizado su ejecucion
#   -GestionLLegadaProcesosAlSistema: Funcion encargada de meter los procesos al sistema en funcion de su y a la cola por el acceso de memoria
#                                       tiempo de llegada.
#   -GestionLLegadaProcesosMemoria: Funcion encargada de meter los procesos que se encuentren en la cola de acceso a memoria.
#   -ImprimeSeleccionDeEjecucion: Funcion que saca los datos por pantalla dependiendo de la opcion de ejecucion escogida al inicio del algoritmo
#   -GestionProcesoRoundRobin: Funcion encargada de los quantum y cambiar los procesos en ejecucion segun lo haria un algoritmo RoundRobin.
#   -EjecutaProceso: Funcion que ejecuta el proceso que esta indicado como en ejecucion.
#   -ActualizaEstadisticasProcesos: Funcion que actualiza los distintos tiempos (espera/retorno) en funcion del estado de cada uno de los procesos
EjecutaRoundRobin()
{
   
    anchoPorBloque=$(calcularAnchoDeBloque)
    InicializaRoundRobin
    seleccionRR

    hayEvento=1
    ImprimeSeleccionDeEjecucion
    #Mientras no se haya completado la ejecucion 
    while [[ $(CompruebaFinDeEjecucion) -eq 0 ]];
    do

        GestionLlegadaProcesosAlSistema
        GestionLlegadaProcesosMemoria

        GestionProcesoRoundRobin
        EjecutaProceso

        ImprimeSeleccionDeEjecucion
        ActualizaEstadisticasProcesos
        GestionFinDeProceso
        # Aumentamos el instante de tiempo del sistema
        let tiempoDelSistema++;


    done

    clear
    let tiempoDelSistema--

    let posicionRoundRobin++
    ImprimeEstadoSistema
    ImprimeEstadoSistema >> $informeColor
    ImprimeEstadoSistema | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> $informe
    EsperaIntro

    resumenfinal

}

# Funcion encargada de la reubicacion de la memoria.
# Dependencias Funcionales:
#   -CalcularContadorOptimo: Se llama a la funcion para volver a calcular los valores del algoritmo optimo para 
#                               los marcos reubicados.
RealizarReubicacion()
{
    local marcoActual=0


    local indiceMarcosProceso=()
    local procesosEnMemoria=()

    antiguoEstadoMemoria="$(DiagramaDeMemoria)"

    for proceso in ${ordenados[@]}
    do

        local estadoProc=${estadosProcesos[$proceso]}

        if [[ "$estadoProc" != "Fuera de sistema" && "$estadoProc" != "Finalizado" && "$estadoProc" != "En espera" ]]
        then
            indiceMarcosProceso[$proceso]=0
            procesosEnMemoria+=($proceso)
        fi    
    done

    local -A paginasProceso=()


    for (( i=0 ; i < $marcosMem ; i++ ))
    do


        local proceso=${VectorMemoriaProceso[$i]}
        if [[ "$proceso" == "." ]]
        then
            continue
        fi

        local indicePag=${indiceMarcosProceso[$proceso]}

        paginasProceso[$proceso,$indicePag]=${VectorMemoriaPag[i]}
        let indiceMarcosProceso[$proceso]++

    done

    local contador=0

    for proceso in ${procesosEnMemoria[@]}
    do
        for (( i=0 ; i < ${indiceMarcosProceso[$proceso]} ; i++ ))
        do
            VectorMemoriaProceso[$contador]=$proceso
            VectorMemoriaPag[$contador]=${paginasProceso[$proceso,$i]}
            let contador++
        done
        CalculaContadorOptimo $proceso

    done

    for (( i=$contador ; i < $marcosMem ; i++ ))
    do
        VectorMemoriaProceso[$i]='.'
        VectorMemoriaPag[$i]='-'
        VectorMemoriaContadorOptimo[$i]='-'

    done

    nuevoEstadoMemoria="$(DiagramaDeMemoria)"

}


# Funcion que indica si hay que realizar una reubicacion de memoria en funcion del estado de esta.
# Los factores que pueden variar la necesidad de reubicacion son el factor de reubicacion y los marcos 
# que necesita el proceso por entrar a memoria para entrar de forma continua.
# Parametros:
#   - $1: Proceso que va a entrar en memoria
# Valores de retorno:
#   - 1: En caso de que haya que reubicar
#   - 0: En caso de que no haya que reubicar
ComprobarReubicacion()
{
    local marcosLibres=0
    local recuentoMarcos=0

    local marcosVacios=()

    if [[ "$factReub" == 0 ]]; then
        echo 0
    else
        for (( i=0 ; i < $marcosMem ; i++))
        do
            
            if [[ "${VectorMemoriaProceso[$i]}" == '.' ]]
            then
                marcosLibres=0

                for (( j=i ; j <= $marcosMem ; j++ ))
                do
                    if [[ "${VectorMemoriaProceso[$j]}" != '.' ]]
                    then 
                        marcosVacios[$i]=$marcosLibres
                        i=$(($j - 1))
                        break
                    fi

                    ((marcosLibres++))
                done
            fi
        done


        recuentoMarcos=${nMarcos[$1]}
        for (( i=0 ; i<$marcosMem ;i++))
        do
            
            # En caso de poder meter el proceso mandar la posición donde meterlo
            if [[ ${marcosVacios[$i]} -ge ${nMarcos[$1]} ]] 
            then
                posicionEntradaMem=$i

                recuentoMarcos=0
                break
            # elif [[ "${marcosVacios[$i]}" = "$factReub" && $(( recuentoMarcos - ${marcosVacios[$i]} )) -le 0 ]]; then
            #     recuentoMarcos=0
            #     break
            elif [[ ${marcosVacios[$i]} -gt $factReub ]]; then
                recuentoMarcos=$(( recuentoMarcos - ${marcosVacios[$i]} ))
            fi
        done

        if [[ $recuentoMarcos -gt 0 ]]
        then
            hayReubicacion=1
        else
            hayReubicacion=0
        fi

    fi

}


# Funcion destinada a realizar las labores de ejecucion del proceso en ejecucion, actualizando tiempo restante
# de ejecucion, disminuyendo tiempo del quantum etc.
# Dependencias Funcionales:
#   - GestionPaginasProceso: Funcion llamada para encargarse de ejecutar las paginas asociadas a cada proceso en funcion del tiempo ejecutado,
#                               tambien se encarga de la sustitucion de paginas mediante el algoritmo Optimo.
#   - GuardaHistorialPaginasProceso: Función que guarda el estado de páginas del proceso que se está ejecutando.
EjecutaProceso()
{
    if [[ $hayEntradaCPU -eq 1 && $conEntradaCPU -eq 1 ]]
    then
        EjecutaEntradasCPU
        return 0
    fi


    if [[ $conEntradaCPU -eq 1 ]]
    then
        #Comprobamos que se está ejecutando un proceso
        if [[ $procesoEjecutandose -ne 0 ]]
        then
        


            let paginaActualProceso[$procesoEjecutandose]++
            VectorTiempoProceso+=("$procesoEjecutandose")
            GestionPaginasProceso



            let tiempoEjecutado[$procesoEjecutandose]++
            # let tiempoPorEjecutar[$procesoEjecutandose]--
            let quantumRestante--

            CalculaContadorOptimo $procesoEjecutandose
            GuardaHistorialPaginasProceso
            



        else
            VectorTiempoProceso+=(".")
            VectorTiempoPagina+=("-")
        fi

    else
        if [[ $procesoEjecutandose -ne 0 ]]
        then
            let paginaActualProceso[$procesoEjecutandose]++
            VectorTiempoProceso+=("$procesoEjecutandose")
            GestionPaginasProceso



            let tiempoEjecutado[$procesoEjecutandose]++
            # let tiempoPorEjecutar[$procesoEjecutandose]--
            let quantumRestante--

            CalculaContadorOptimo $procesoEjecutandose
            GuardaHistorialPaginasProceso
            

        else
            VectorTiempoProceso+=(".")
            VectorTiempoPagina+=("-")
        fi

    fi

}



# Funcion que comprueba si la ejecucion de un proceso ha finalizado
# Parametros:
#   - $1: Proceso a comprobar
# Valores de retorno:
#   - 1: En caso de que el proceso haya acabado su ejecucion
#   - 0: En caso contrario
HaFinalizadoProceso()
{
    # $1 proceso a comprobar

    if [[ $1 -eq 0 ]]
    then
        echo 0
    fi 

    if [[ ${tiempoEjecutado[$1]} -eq ${tEjec[$1]} ]]
    then
        echo 1
    else
        echo 0
    fi

}

# Funcion que se encarga de gestionar la llegada de los procesos, actualizando su estado, tiempo de inicio
# y añadiendolos a la cola de entrada a memoria
GestionLlegadaProcesosAlSistema()
{
    
    for ((i=$punteroLlegadaProcesos; i <= $nProc ; i++ ))
    do
        local proceso=${ordenados[$i]}
       

        if [[ $tiempoDelSistema -ge ${tLlegada[$proceso]} ]]
        then
            logDeEventos+="El proceso ${nombreProcesoColor[$proceso]} ha llegado al sistema\n"
            hayEvento=1
            estadosProcesos[$proceso]="En espera"
            tiempoDeInicio[$proceso]=$tiempoDelSistema
            colaEntradaMemoria+=($proceso)

            let punteroLlegadaProcesos++
        else
            break
        fi

    done

}


# Funcion encargada de la entrada de los procesos a memoria. Funciona como una cola FIFO, si el primer proceso de la cola no puede entrar a memoria por falta
# de marcos libres, el resto no podran entrar aunque tengan los suficientes marcos libres en memoria como para poder entrar.
# Tambien agrega los procesos que entren a memoria a la cola RoundRobin.
# Dependencias Funcionales:
#       - ObtenerMarcosLibresMemoria: Funcion llamada para obtener los marcos libres que hay en memoria y comprobar si un proceso puede entrar
#       - InsertarProcesoEnMemoria: Funcion que mete un proceso en memoria 
GestionLlegadaProcesosMemoria()
{


    if [[ ${#colaEntradaMemoria[@]} -le 0 ]]
    then 
        return 0;
    fi

    local procesoAMeter=${colaEntradaMemoria[0]}
    local marcosRequeridos=${nMarcos[$procesoAMeter]}


    while [ $marcosRequeridos -le $espacioLibreMemoria ]
    do
        ComprobarReubicacion $procesoAMeter

        if [[ $hayReubicacion -eq 1 ]]
        then
            hayReubicacion=1
            RealizarReubicacion
        fi


        InsertarProcesoEnMemoria $procesoAMeter $marcosRequeridos
        posicionEntradaMem=0
        hayEvento=1
        colaRoundRobin+=($procesoAMeter)
        #Sacamos como si fuera una cola el primer elemento

        if [[ ${#colaEntradaMemoria[@]} -gt 1 ]]
        then
            for (( i = 1 ; i < ${#colaEntradaMemoria[@]} ; i++ )) 
            do
                colaEntradaMemoria[$i-1]=${colaEntradaMemoria[$i]}
            done

            unset colaEntradaMemoria[${#colaEntradaMemoria[@]}-1]

            procesoAMeter=${colaEntradaMemoria[0]}
            marcosRequeridos=${nMarcos[$procesoAMeter]}

        else
            unset colaEntradaMemoria[${#colaEntradaMemoria[@]}-1]
            break
        fi

    done

}

# Funcion encargada de la gestion de las paginas que un proceso requiere en su ejecucion.
# Dependencias Funcionales:
#       - PaginaYaCargada: Funcion llamada para comprobar si la pagina que se va a ejecutar ya se encuentra cargada dentro de los marcos del proceso
#       - CalculaPaginasLibresProceso: Funcion llamada para comprobar si el proceso dispone de algun marco que no contenga ninguna pagina
#       - ReemplazoDePaginaOptimo: Funcion que realiza el reemplazo de pagina segun el algoritmo Optimo cuando no hay marcos libres del proceso
#       - CalculaContadorOptimo: Funcion que calcula el valor del algoritmo optimo para las paginas del proceso en ejecucion
GestionPaginasProceso()
{
    local paginaPorIntroducir=${paginas[$procesoEjecutandose,${paginaActualProceso[$procesoEjecutandose]}]}
    VectorTiempoPagina+=($paginaPorIntroducir)

    #Si la pagina ya esta cargada
    if [[ $(PaginaYaCargada $paginaPorIntroducir) -eq 0  ]]
    then
        let nFallosPagina[$procesoEjecutandose]++
        #Si existen marcos libres en los asignados al proceso
        if [[ $(CalculaPaginasLibresProceso) -ge 1 ]]
        then
            for (( i=0 ; i < $marcosMem ; i++ ))
            do

                if [[ "${VectorMemoriaProceso[$i]}" == "$procesoEjecutandose" && "${VectorMemoriaPag[$i]}" == '-' ]]
                then
                    VectorMemoriaPag[$i]=$paginaPorIntroducir
                    logDePaginas+="Se ha introducido la página \e[3${colorines[$procesoEjecutandose]}m$paginaPorIntroducir\e[0m del proceso ${nombreProcesoColor[$procesoEjecutandose]}\e[0m en el marco \e[31m$i \e[0m\n"
                    break
                fi
            done
            #CalculaContadorOptimo $procesoEjecutandose

            #Si no hay marcos libres
        else
  
            ReemplazoDePaginaOptimo $paginaPorIntroducir
            #CalculaContadorOptimo $procesoEjecutandose

        fi
    fi



}

# Función que guarda el estado de los marcos y páginas del proceso en ejecución.
GuardaHistorialPaginasProceso()
{
    local marcoProceso=1
    local cadena=''
    local apuntadorColocado=0;
    local marcoApuntador=-1;
    local maxContadorOptimo=-1;

    for (( i=0 ; i<$marcosMem ; i++ ))
    do

        if [[ "${VectorMemoriaProceso[$i]}" != "$procesoEjecutandose" ]]
        then
            continue
        fi

        if [[ "${VectorMemoriaPag[$i]}" == "-" ]]
        then
            cadena="M$i"
            if [[ $apuntadorColocado -eq  0 ]]
            then

                marcoApuntador=$marcoProceso
                apuntadorColocado=1
            fi
        elif [[ "${VectorMemoriaPag[$i]}" == '+' ]]
        then
            cadena="M$i-+"
        else
            cadena="M$i-${VectorMemoriaPag[$i]}-${VectorMemoriaContadorOptimo[$i]}"

            if [[ $apuntadorColocado -eq 0  && "$maxContadorOptimo" != '*' ]]
            then
                if [[ "${VectorMemoriaContadorOptimo[$i]}" == '*' ]]
                then

                    maxContadorOptimo='*'
                    marcoApuntador=$marcoProceso
                    
                elif [[ $maxContadorOptimo -lt ${VectorMemoriaContadorOptimo[$i]} ]]
                then
                    maxContadorOptimo=${VectorMemoriaContadorOptimo[$i]}
                    marcoApuntador=$marcoProceso
                fi

            fi
        fi

        historialProcesosPaginas[$procesoEjecutandose,$marcoProceso,${paginaActualProceso[$procesoEjecutandose]}]="$cadena"

        let marcoProceso++

    done
    historialApuntador[$procesoEjecutandose,$marcoApuntador,${paginaActualProceso[$procesoEjecutandose]}]="1"

}



# Funcion que realiza el reemplazo de pagina segun el algoritmo optimo.
# Parametros:
#       - $1: es la pagina a introducir
ReemplazoDePaginaOptimo()
{
    local contadorOptimoMaximo=0
    local paginaAReemplazar=''

    for (( i=0; i < $marcosMem ; i++ ))
    do
        if [[ "${VectorMemoriaProceso[$i]}" != "$procesoEjecutandose" || "${VectorMemoriaPag[$i]}" == '+' ]]
        then
            continue
        fi

        #El * lo tomamos como infinito, es decir no se vuelve a usar es pagina en el proceso
        if [[ "${VectorMemoriaContadorOptimo[$i]}" == '*' ]]
        then
            paginaAReemplazar=$i
            #valor random
            contadorOptimoMaximo=66666666666
            break
        fi

        if [[ ${VectorMemoriaContadorOptimo[$i]} -gt  $contadorOptimoMaximo ]]
        then
            paginaAReemplazar=$i
            contadorOptimoMaximo=${VectorMemoriaContadorOptimo[$i]}
        fi

    done
    logDePaginas+="Se ha reemplazado la página \e[3${colorines[$procesoEjecutandose]}m${VectorMemoriaPag[$paginaAReemplazar]}\e[0m por la página \e[3${colorines[$procesoEjecutandose]}m$1\e[0m 
                    del proceso ${nombreProcesoColor[$procesoEjecutandose]}\e[0m en el marco \e[31m$paginaAReemplazar\e[0m\n"
    #Procedemos a realizar el reemplazo de la pagina
    VectorMemoriaPag[$paginaAReemplazar]=$1
}


# Funcion que calcula el valor del contador del algoritmo de reemplazo de paginas Optimo.
# Parametros:
#   - $1: Proceso del que calcular los valores de optimo para sus marcos de memoria
CalculaContadorOptimo()
{
    local procesoACalcular=$1

    local marcosDelProceso=${nMarcos[$1]}

    if [[ $1 -eq 0 ]]
    then
        return 0
    fi

    for (( i=0 ; i < $marcosMem ; i++))
    do
        local paginaDelMarco=${VectorMemoriaPag[$i]}

        if [[ "$paginaDelMarco" == '+'  ]]
        then
            continue
        fi

        if [[ "${VectorMemoriaProceso[$i]}" == "$procesoACalcular" ]]
        then
            

            if [[ "$paginaDelMarco" == '-' ]]
            then
                VectorMemoriaContadorOptimo[$i]='-'
            else
                local contadorOptimo=0
                local flagExistePag=0

                for (( indexPaginas=$((${paginaActualProceso[$procesoACalcular]} + 1)) ; indexPaginas < ${maxpags[$procesoACalcular]} ; indexPaginas++ ))
                do
                    let contadorOptimo++

                    if [[ "$paginaDelMarco" == "${paginas[$procesoACalcular,$indexPaginas]}" ]]
                    then
                        flagExistePag=1
                        break
                    fi

                done

                if [[ $flagExistePag -eq 0 ]]
                then
                    VectorMemoriaContadorOptimo[$i]='*'
                else
                    VectorMemoriaContadorOptimo[$i]=$contadorOptimo
                fi

            fi

            let marcosDelProceso--

            if [[ $marcosDelProceso -le 0 ]]
            then
                break
            fi

        fi
    done


}

# Funcion que calcula los marcos de memoria sin una pagina cargada para el proceso en ejecucion
#   Valores de retorno:
#       - Numero de paginas Libres del proceso en ejecucion
CalculaPaginasLibresProceso()
{
    local nPaginasLibres=0

    for (( i=0 ; i < $marcosMem ; i++))
    do
        if [[ "${VectorMemoriaProceso[$i]}" == "$procesoEjecutandose" && "${VectorMemoriaPag[$i]}" == '-' ]]
        then
            let nPaginasLibres++
        fi
    done

    echo $nPaginasLibres
}

# Funcion que comprueba si una pagina ya esta cargada en uno de los marcos del proceso en ejecucion
# Parametros:
#   - $1: Pagina a comprobar
# Valores de retorno:
#   - 1: en caso de que la pagina esté cargada
#   - 0: en caso contrario
PaginaYaCargada()
{
    local paginaAComprobar=$1
    local cargada=0

    for (( i=0 ; i < $marcosMem ; i++))
    do
        if [[ "${VectorMemoriaProceso[$i]}" == "$procesoEjecutandose" && "${VectorMemoriaPag[$i]}" == "$paginaAComprobar" ]]
        then
            cargada=1
            break
        fi
    done


    echo $cargada
}

#   Funcion que inserta en memoria un proceso
#   Parametros:
#   - $1: numero del 1 al 99, proceso a insertar
#   - $2: numero de marcos que el proceso requiere
InsertarProcesoEnMemoria()
{
    local marcosRellenados=0
  
    local marcosDeCodigoYDatos=${paginasCodigo[$1]}

    logDeEventos+="El proceso ${nombreProcesoColor[$1]} ha entrado en memoria a partir de la dirección \e[31m$(($posicionEntradaMem*tamPag))\e[0m\n"
    
    for (( i=$posicionEntradaMem ; i < ${#VectorMemoriaProceso[@]} ; i++ ))
    do

        if [[ "${VectorMemoriaProceso[$i]}" == "." ]]
        then

            # Rellenamos los marcos de código y datos
            if [[ $marcosDeCodigoYDatos -gt 0 ]]
            then
                VectorMemoriaProceso[$i]="$1"
                VectorMemoriaPag[$i]='+'
                VectorMemoriaContadorOptimo[$i]="+"
                let marcosDeCodigoYDatos--
            else
                VectorMemoriaProceso[$i]="$1"
                VectorMemoriaPag[$i]='-'
                VectorMemoriaContadorOptimo[$i]="-"

            fi

            let marcosRellenados++
        fi

        if [[ $marcosRellenados -ge $2 ]]
        then
            break
        fi

    done

    espacioLibreMemoria=$(($espacioLibreMemoria-$2))
    estadosProcesos[$1]="En memoria"
    posicionEntradaMem=0


}

# Funcion encargada de sacar de memoria un proceso cuando ha terminado su ejecucion
# Parametros:
#       - $1: Proceso a sacar de memoria
SacarProcesoMemoria()
{
    local procesoASacar=$1
    local marcosASacar=${nMarcos[$1]}


    for (( i=0 ; i<$marcosMem ; i++ ))
    do
        if [[ "$procesoASacar" == "${VectorMemoriaProceso[$i]}" ]]
        then
            VectorMemoriaProceso[$i]="."
            VectorMemoriaPag[$i]="-"
            VectorMemoriaContadorOptimo[$i]="-"
            let marcosASacar--
        fi

        if [[ $marcosASacar -le 0 ]]
        then
            break
        fi
    done
    espacioLibreMemoria=$(($espacioLibreMemoria+${nMarcos[$1]}))

}

# Funcion que devuelve el número de marcos libres de la memoria
# Valores de retorno:
#       - $marcosVacios: Numero de marcos vacios de la memoria
ObtenerMarcosLibresMemoria()
{
    local marcosVacios=0;

    for marco in "${VectorMemoriaProceso[@]}"
    do
        if [[ "$marco" == "." ]]
        then 
            let marcosVacios++;
        fi

    done

    echo $marcosVacios
}


# Funcion que dependiendo de la opcion de ejecucion elegida
# ajustara la salida por pantalla para adecuarse a dicha 
# opcion.
ImprimeSeleccionDeEjecucion()
{
    case "$opcionEjec" in
        "1") # Por eventos
            if [[ "$hayEvento" == 1 ]]
            then
                ImprimeEstadoSistema
                EsperaIntro
                ImprimeEstadoSistema >> $informeColor
                ImprimeEstadoSistema | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> $informe
                hayEvento=0
                hayReubicacion=0
                hayFinDeProceso=0

                logDeEventos=''
                logDePaginas=''
                clear
            fi
        ;;
        "2") # Automatico
            if [[ "$hayEvento" == 1 ]]
            then
                ImprimeEstadoSistema
                ImprimeEstadoSistema >> $informeColor
                ImprimeEstadoSistema | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> $informe
                hayEvento=0
                hayReubicacion=0
                hayFinDeProceso=0

                logDeEventos=''
                logDePaginas=''


                echo -e " Espere ${segAuto} segundos para la siguiente iteración."
                sleep "$segAuto"
                clear
            fi
        ;;

        "3") # Completa
            if [[ "$hayEvento" == 1 ]]
            then
                ImprimeEstadoSistema
                ImprimeEstadoSistema >> $informeColor
                ImprimeEstadoSistema | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> $informe
                hayEvento=0
                hayReubicacion=0
                hayFinDeProceso=0

                logDeEventos=''
                logDePaginas=''
                clear

            fi
        ;;
        "4") # Por instantes
            ImprimeEstadoSistema
            EsperaIntro
            ImprimeEstadoSistema >> $informeColor
            ImprimeEstadoSistema | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> $informe
            hayEvento=0
            hayReubicacion=0
            hayFinDeProceso=0

            logDeEventos=''
            logDePaginas=''
            clear
        ;;
        "5") #Ultimo instante
            hayEvento=0
            hayReubicacion=0
            hayFinDeProceso=0

            logDeEventos=''
            logDePaginas=''
            clear
            numeroDePuntos=$tiempoDelSistema
            dots=$(($numeroDePuntos % 6))
            puntos="................"

            echo -ne "\e[3${dots}m"
            echo -n "> Ejecutando"
            echo -n ${puntos:1:$dots}
            echo -ne "\e[0m"

        ;;

    esac    

}


# Funcion que imprime el estado del sistema y los procesos, así como las bandas
# de memoria y otros datos
# Dependencias Funcionales:
#   - ImprimeHistorialPáginas: Imprime el historial de páginas del proceso finalizado
#   - ImprimeOptimo: Imprime una versión más detallada de la banda de memoria
#   - ImprimeReubicación: En caso de que se haya producido una reubicación imprime el anterior y el nuevo estado de la memoria
#   - DiagramaDeMemoria: Imprime la banda de memoria
#   - DiagramaDeTiempo: Imprime la banda de tiempo
ImprimeEstadoSistema()
{
    imprimeTiempo
    diagramaresumen
    # 02-05 COMENTO LA LINEA DONDE SE IMPRIME EL ESTADO DEL ROUND ROBIN
    # ImprimeEstadoRoundRobin
    echo "-Log de Eventos:"
    echo -ne $logDeEventos
    echo "-Log de Páginas:"
    echo -ne $logDePaginas

    if [[ $antiguoProcesoEjecutandose -gt 0 && $antiguoProcesoEjecutandose -ne $procesoEjecutandose ]]
    then
        echo -ne "Se han producido \e[31m${nFallosPagina[$antiguoProcesoEjecutandose]} fallos\e[0m de página en el proceso ${nombreProcesoColor[$antiguoProcesoEjecutandose]} \e[0m\n"
    fi

    if [[ $procesoEjecutandose -gt 0 ]]
    then
        echo -ne "Se han producido \e[31m${nFallosPagina[$procesoEjecutandose]} fallos\e[0m de página en el proceso ${nombreProcesoColor[$procesoEjecutandose]} \e[0m\n\n"
    fi

    ImprimeHistorialPaginas $procesoFinalizado
    imprimeOptimo
    ImprimeReubicacion
    DiagramaDeMemoria
    DiagramaDeTiempo 
    #DebugEstadoSistema
}


# Función que imprime el proceso de reubicación de memoria cuando esta se produzca.
ImprimeReubicacion()
{
    if [[ $hayReubicacion -eq 1 ]]
    then
        echo "Reubicación:"
        echo "Anterior Estado de la Memoria:"
        echo -e "$antiguoEstadoMemoria"
        echo "Nuevo Estado de la Memoria:"
        echo -e "$nuevoEstadoMemoria"
        echo "Estado Memoria Actual:"

    fi
}


# Función que imprime el historial de páginas del proceso cuando se produce la finalización de un proceso.
# El historial de páginas contiene el estado de cada marco del proceso en cada uno de los instantes de ejecución de este.
# Cada entrada de este historial tendrá el formato: nº de marco-página contenida en el marco-Contador óptimo. Si una entrada 
# está precedida por el símbolo ">" significará que este será el marco donde se introducirá la siguiente página del proceso.
# Parámetros:
#   - $1: Proceso del que guardar el historial
ImprimeHistorialPaginas()
{
    if [[ $hayFinDeProceso -ne 1 ]]
    then
        return 0;
    fi

    local proceso=$1
    local padding=13
    local anchoRestante=$(( $(tput cols)  ))
    local numPagsPorLinea

    local primeraPagina=1
    local ultimaPagina
    printf "\e[3${colorines[$proceso]}m"
    echo "Historial de paginas ${nombreProceso[$proceso]}:"
    echo ""


    for(( linea=0 ; ; linea++ ))
    do
        numPagsPorLinea=$(( ((anchoRestante-6) / 13) ))
        ultimaPagina=$(( primeraPagina + numPagsPorLinea - 1))


        if [[ $ultimaPagina -gt ${maxpags[$proceso]} ]]
        then
            ultimaPagina=$((${maxpags[$proceso]} ))
        fi


        printf "%-6s" " "


        #cabeceras de pagina
        for (( m=$primeraPagina-1;m<$ultimaPagina;m++))
        do
            printf "%-${padding}s" " ${paginas[$proceso,$m]}"  
        done
        printf "\n"

        for(( i=1; i<=${nMarcos[$proceso]}; i++ ))
        do

            printf "%-6s" "M$i"
        

            for ((j=$primeraPagina-1; j<$ultimaPagina; j++ ))
            do
                if [[ "${historialApuntador["$proceso","$i","$j"]}" == "1" ]]
                then
                    printf  "%-${padding}s" ">${historialProcesosPaginas["$proceso","$i","$j"]}"
                else
                    printf  "%-${padding}s" " ${historialProcesosPaginas["$proceso","$i","$j"]}"
                fi    


            done
            printf "\n"
        done

        if [[ $ultimaPagina -ge ${maxpags[$proceso]} ]]
        then
            break
        fi

        primeraPagina=$(( ultimaPagina + 1 ))
        anchoRestante=$(( $( tput cols )  ))
        echo ""

    done
    echo -e "\e[0m"

}


# Funcion que comprueba si la ejecucion del programa ha finalizado, es decir
# que todos los procesos han finalizado.
# Valores de retorno:
#   - 1: en caso de que la ejecucion haya finalizado
#   - 0: en caso contrario
CompruebaFinDeEjecucion()
{
    # Esta variable tomará los valores 0 o 1.
    # 1 si la ejecucion ha finalizado
    # 0 si la ejecucion no ha finalizado
    local quedaPorEjecutar=1;

    for estado in "${estadosProcesos[@]}"
    do
        #Si queda un proceso que no haya finalizado
        if [[ "$estado" != "Finalizado" ]]
        then
            quedaPorEjecutar=0
            break
        fi

    done

    echo $quedaPorEjecutar
}


# Funcion que se encarga de la gestion de procesos segun el algoritmo RoundRobin. Tambien se encarga de la finalizacion de la ejecucion de los procesos
# Dependencias Funcionales:
#   - SacarProcesoMemoria: funcion llamada cuando un proceso termina su ejecucion y sacarle de memoria.
#   - GestionLlegadaProcesosMemoria: funcion llamada cuando un proceso termina su ejecucion para alojar en memoria los
#                                   procesos que antes no cabian en memoria por falta de espacio
#   - SacarProcesoRoundRobin: funcion llamada cuando un proceso finaliza su ejecucion para así sacarlo de la cola RoundRobin
#   - SiguienteProcesoRoundRobin: funcion llamada cuando un proceso finaliza o termina el quantum de tiempo para el cambiar el proceso en ejecucion
GestionProcesoRoundRobin()
{
    if [[ $hayEntradaCPU -eq 1 && $conEntradaCPU -eq 1 ]]
    then
        return 0
    fi


    if [[ $conEntradaCPU -eq 1 ]]
    then
        if [[ $quantumRestante -le 0  || $procesoEjecutandose -eq 0 || $cambiarProceso -eq 1 ]]
        then
            
            tiempoRestanteEntradaCPU=$(CalculoTiempoTotalEntradaCPU)
            SiguienteProcesoRoundRobin
            if [[ $tiempoRestanteEntradaCPU -ne 0 ]]
            then
                hayEntradaCPU=1
            fi
            cambiarProceso=0


        fi
    else
        if [[ $quantumRestante -le 0 || $cambiarProceso -eq 1 || $procesoEjecutandose -eq 0 ]]
        then
            SiguienteProcesoRoundRobin
            cambiarProceso=0
        fi

    fi

}


# Función que ejecuta los tiempos de entrada a la cpu cuando se produzcan
EjecutaEntradasCPU()
{
    
    if [[ $tiempoRestanteEntradaCPU -gt 0 ]]
    then

        VectorTiempoPagina+=(">")
        VectorTiempoProceso+=("$procesoEjecutandose")
        let tiempoRestanteEntradaCPU--
    fi



}


# Funcion que actualiza el proceso en ejecucion a el siguiente proceso a ejecutar segun el algoritmo RoundRobin.
# Tambien actualiza el estado de los procesos que va a pasar a ejecutarse y el que ha dejado de estarlo.
SiguienteProcesoRoundRobin()
{



    if [[ $posicionRoundRobin -lt ${#colaRoundRobin[@]} ]]
    then
        if [[ $procesoEjecutandose -ne 0 ]]
        then
            antiguoProcesoEjecutandose=$procesoEjecutandose
            # estadosProcesos[$antiguoProcesoEjecutandose]="En pausa"
        fi
        procesoEjecutandose=${colaRoundRobin[$posicionRoundRobin]}
        logDeEventos+="El proceso ${nombreProcesoColor[$procesoEjecutandose]}\e[0m ha entrado al procesador\n"
        estadosProcesos[$procesoEjecutandose]="En ejecución"
        quantumRestante=$tamQuant
        hayEvento=1
        let posicionRoundRobin++
    else
        if [[ $procesoEjecutandose -ne 0 ]]
        then
            antiguoProcesoEjecutandose=$procesoEjecutandose
            hayEvento=1
            # estadosProcesos[$antiguoProcesoEjecutandose]="En pausa"
            # logDeEventos+="Se ha ejecutado un quantum de \e[31m$(( $tamQuant - $quantumRestante ))\e[0m del proceso ${nombreProcesoColor[$antiguoProcesoEjecutandose]}\e[0m\n"
        fi
        procesoEjecutandose=0
        quantumRestante=$tamQuant
    fi
}

# Función que calcula el tiempo de entrada a CPU que requerirá un proceso.
# Parámetros:
#   - $1: proceso a calcular
# Valores de retorno:
#   - Tiempo de entrada a CPU del proceso
CalculaTiempoProcesoEntradaCPU()
{


    if [[ $1 -le 0 ]]
    then
        echo 0
    else
        local indexPagProc=${paginaActualProceso[$1]}
        local maxPagsProc=$(( ${maxpags[$1]}))
        
        local limsup=$(min $(( $indexPagProc + $tamQuant + 1 )) $maxPagsProc )

        local paginaAnt=-1
        local paginaAct=-2

        local nTiemposEntradaCPU=0
        paginaAct=${paginas[$1,$(($indexPagProc + 1))]}
        for (( pagina=$indexPagProc + 2 ; pagina <= $limsup ; pagina++ ))
        do

            if [[ "$paginaAnt" != "$paginaAct" ]]
            then
                let nTiemposEntradaCPU++
            fi

            paginaAnt=$paginaAct
            paginaAct=${paginas[$1,$pagina]}



        done


        echo $(( $nTiemposEntradaCPU*$tiempoPorPagina ))
    fi
}

# Función que calcula el tiempo de entrada a CPU del proceso que pasará a ejecutarse
CalculoTiempoTotalEntradaCPU()
{
    local totalEntradaCPU=0

    totalEntradaCPU=$(CalculaTiempoProcesoEntradaCPU $(PeekColaRoundRobin))

    echo $totalEntradaCPU
}


# Función que devuelve el siguiente proceso en Round Robin sin pasar a este
# Valores de retorno:
#   - Siguiente Proceso en la cola Round Robin
PeekColaRoundRobin()
{
    if [[ $posicionRoundRobin -lt ${#colaRoundRobin[@]} ]]
    then
        echo ${colaRoundRobin[$posicionRoundRobin]}

    else
        echo 0

    fi
}

# Función que realiza el tratamiento de finalización de un proceso
GestionFinDeProceso()
{

    if [[ "$procesoEjecutandose" == 0 || $hayEntradaCPU -eq 1 ]]
    then
        return 0
    fi


    if [[ $quantumRestante -gt 0 && $(HaFinalizadoProceso $procesoEjecutandose) -eq 0 ]]
    then
        return 0
    fi

    if [[ $conEntradaCPU -eq 1 ]]
    then

        if [[ $(HaFinalizadoProceso $procesoEjecutandose) -eq 1 ]]
        then
            estadosProcesos[$procesoEjecutandose]="Finalizado"
            # 02-05 COMENTO LA LINEA DONDE MUESTRO POR PANTALLA EL QUANTUM DE TIEMPO
            # logDeEventos+="Se ha ejecutado un quantum de \e[31m$(( $tamQuant - $quantumRestante ))\e[0m del proceso ${nombreProcesoColor[$procesoEjecutandose]}\e[0m\n"
            logDeEventos+="El proceso ${nombreProcesoColor[$procesoEjecutandose]}\e[0m ha finalizado su ejecución\n"
            hayFinDeProceso=1
            cambiarProceso=1

            tiempoDeFin[$procesoEjecutandose]=$(($tiempoDelSistema+1))
            procesoFinalizado=$procesoEjecutandose
            SacarProcesoMemoria $procesoEjecutandose
        elif [[ $quantumRestante -le 0 && $antiguoProcesoEjecutandose -ne $procesoEjecutandose ]]
        then
            estadosProcesos[$procesoEjecutandose]="En pausa"
            colaRoundRobin+=($procesoEjecutandose)
            # 02-05 COMENTO LA LINEA DONDE MUESTRO POR PANTALLA EL QUANTUM DE TIEMPO
            # logDeEventos+="Se ha ejecutado un quantum de \e[31m$(( $tamQuant - $quantumRestante ))\e[0m del proceso ${nombreProcesoColor[$procesoEjecutandose]}\e[0m\n"
            cambiarProceso=1
        fi
    else
        if [[ $(HaFinalizadoProceso $procesoEjecutandose) -eq 1 ]]
        then
            estadosProcesos[$procesoEjecutandose]="Finalizado"
            # 02-05 COMENTO LA LINEA DONDE MUESTRO POR PANTALLA EL QUANTUM DE TIEMPO
            # logDeEventos+="Se ha ejecutado un quantum de \e[31m$(( $tamQuant - $quantumRestante ))\e[0m del proceso ${nombreProcesoColor[$procesoEjecutandose]}\e[0m\n"
            logDeEventos+="El proceso ${nombreProcesoColor[$procesoEjecutandose]}\e[0m ha finalizado su ejecución\n"
            hayFinDeProceso=1
            cambiarProceso=1

            tiempoDeFin[$procesoEjecutandose]=$(($tiempoDelSistema+1))
            procesoFinalizado=$procesoEjecutandose
            SacarProcesoMemoria $procesoEjecutandose
        elif [[ $quantumRestante -le 0 ]]
        then
            estadosProcesos[$procesoEjecutandose]="En pausa"
            colaRoundRobin+=($procesoEjecutandose)
            # 02-05 COMENTO LA LINEA DONDE MUESTRO POR PANTALLA EL QUANTUM DE TIEMPO
            # logDeEventos+="Se ha ejecutado un quantum de \e[31m$(( $tamQuant - $quantumRestante ))\e[0m del proceso ${nombreProcesoColor[$procesoEjecutandose]}\e[0m\n"

        fi

    fi
}

# Funcion que actualiza los tiempos de espera y retorno de cada uno de los procesos
# en funcion del estado de estos.
ActualizaEstadisticasProcesos()
{

    for ((proceso=1;proceso<=$nProc;proceso++))
    do
        local estadoDelProceso=${estadosProcesos[$proceso]}

        case $estadoDelProceso in
            "Fuera de sistema")
                #No se hace nada
            ;;
            "En memoria")
                let tiempoDeEspera[$proceso]++
                let tiempoDeRetorno[$proceso]++
            ;;
            "En ejecución")

                let tiempoDeRetorno[$proceso]++
                if [[ $hayEntradaCPU -eq 0 || $conEntradaCPU -eq 0 ]]
                then
                    
                    let tiempoPorEjecutar[$proceso]--         
                fi
            ;;
            "En espera")
                let tiempoDeEspera[$proceso]++
                let tiempoDeRetorno[$proceso]++
            ;;
            "En pausa")
                let tiempoDeEspera[$proceso]++
                let tiempoDeRetorno[$proceso]++
            ;;
            "Finalizado")
                #No se hace nada, se trata cuando finaliza el proceso
            ;;
        esac

    done

    if [[ $tiempoRestanteEntradaCPU -eq 0 ]]
    then
        hayEntradaCPU=0
    fi

}


# Funcion que saca por pantalla el estado de la cola RoundRobin
ImprimeEstadoRoundRobin()
{

    echo -ne "Estado Round Robin:"

   
    local flag=1

    if [[ ${#colaRoundRobin[@]} -eq 0 || ${#colaRoundRobin[@]} -lt $posicionRoundRobin || $procesoEjecutandose -eq 0 ]]
    then 
        echo ""
    else


        for (( i=$posicionRoundRobin - 1 ; i < ${#colaRoundRobin[@]} ; i++ ))
        do
            local proceso=${colaRoundRobin[$i]}
            if [[ $flag -eq 1 ]]
            then
                printf "\t\e[1;4${colorines[$proceso]}m "${nombreProceso[$proceso]}" \e[0m"
                flag=0
            else

                printf "\t\e[1;3${colorines[$proceso]}m "${nombreProceso[$proceso]}" \e[0m"
            fi
        done
        echo ""
    fi

}

# Función que imprime el diagrama de memoria del sistema del algoritmo
DiagramaDeMemoria()
{
    local anchoBloque=${anchoPorBloque}
    anchoBloque=$(max $anchoBloque  $((${#marcosMem} + 1)) )
    local anchoEtiqueta=5
    local anchoRestante=$(( $( tput cols ) -  $anchoEtiqueta   ))
    local lengthEtiquetaFinal=$(( $anchoEtiqueta + ${#marcosMem} )) 
    local colocarEtiqueta=0

    local numBloquesPorLinea
    local procesoAnterior=-1
    local procesoActual=-2

    local primerMarco=0

    echo ""
    for (( linea=0; ; linea++ ))
    do

        numBloquesPorLinea=$(( (anchoRestante / anchoBloque - 1) )) 
        ultimoMarco=$(( primerMarco + numBloquesPorLinea  ))
        if [ $ultimoMarco -ge $marcosMem ];then
            ultimoMarco=$(( marcosMem - 1 ))
            colocarEtiqueta=1
        fi

        #PROCESOS
        # Imprimir la etiqueta si estamos en la primera linea
        # [ "$linea" -eq 0 ] && printf "%${anchoEtiqueta}s" "|" || printf "%${anchoEtiqueta}s"
        [ "$linea" -eq 0 ] && printf "%${anchoEtiqueta}s" "|"
        
        for (( m=primerMarco; m<=ultimoMarco; m++ ))
        do
            procesoActual=${VectorMemoriaProceso[$m]}

            if [[ "$procesoActual" != "." ]]
            then
                if [[ "$procesoActual" != "$procesoAnterior" ]]
                then
                    echo -en "${nombreProcesoColor[$procesoActual]}"
                    printf "%$(( anchoBloque - ${#nombreProceso[$procesoActual]} ))s" ""
                else
                    printf "%${anchoBloque}s" ""
                fi

            else
                printf "%${anchoBloque}s" ""
            fi
            
            procesoAnterior=$procesoActual
        done


        if [[ $(( ($numBloquesPorLinea - ($ultimoMarco - $primerMarco) ) * $anchoBloque )) -ge $lengthEtiquetaFinal && $colocarEtiqueta -eq 1 ]]
        then
            printf "\e[0m|\n"
        else
            printf "\e[0m\n"
        fi

        [ "$linea" -eq 0 ] && printf "%${anchoEtiqueta}s" " BM |"
        local procesoAnterior=-1
        local procesoActual=-2

        for (( m=primerMarco; m<=ultimoMarco; m++ ))
        do
            procesoActual=${VectorMemoriaProceso[$m]}
            if [[ "$procesoActual" != "." ]]
            then
                printf "\e[4${colorines[$procesoActual]}m%${anchoBloque}s\e[0m" "${VectorMemoriaPag[$m]}"
            else
                printf "\e[107m%${anchoBloque}s\e[0m" "_"
            fi

        done


        if [[ $(( ($numBloquesPorLinea - ($ultimoMarco - $primerMarco) ) * $anchoBloque )) -ge $lengthEtiquetaFinal && $colocarEtiqueta -eq 1 ]]
        then
            printf "\e[0m|\e[1;39m M: ${marcosMem}\e[0m\n"

        else
            printf "\e[0m\n"
        fi


        [ "$linea" -eq 0 ] && printf "%${anchoEtiqueta}s" "|" 

        for (( m=primerMarco; m<=ultimoMarco ; m++ ))
        do
            procesoActual=${VectorMemoriaProceso[$m]}

            if [[ "$procesoActual" != "$procesoAnterior" ]]
            then
                printf "%${anchoBloque}s" "$m"
            else
                printf "%${anchoBloque}s" ""
            fi
            procesoAnterior=$procesoActual
        done



        if [[ $(( ($numBloquesPorLinea - ($ultimoMarco - $primerMarco) ) * $anchoBloque )) -ge $lengthEtiquetaFinal && $colocarEtiqueta -eq 1 ]]
        then
            printf "\e[0m|\n"
            colocarEtiqueta=0
            break
        else
            printf "\e[0m\n"
        fi



        if [[ $colocarEtiqueta -eq 1 ]]
        then
            echo ""
            printf "\e[0m|\n"
            printf "\e[0m|\e[1;39m M: ${marcosMem}\e[0m\n"
            printf "\e[0m|\n"
            colocarEtiqueta=0
            break
        fi

        primerMarco=$(( ultimoMarco + 1 ))
        # anchoRestante=$(( $( tput cols ) - 2 ))
        anchoRestante=$(( $( tput cols ) ))


    done
    echo ""

}


# Función que imprime la banda de tiempo de la ejecución del algoritmo hasta el instante de ejecución actual
DiagramaDeTiempo()
{
    local anchoBloque=${anchoPorBloque}
    anchoBloque=$(max $anchoBloque $((${#tiempoDelSistema}+1)))
    local anchoEtiqueta=5
    local colocarEtiqueta=0
    local lengthEtiquetaFinal=$(( $anchoEtiqueta + ${#tiempoDelSistema} ))

    local anchoRestante=$(( $( tput cols ) - $anchoEtiqueta  ))
    local primerTiempo=0
    local procesoAnterior=-1
    local procesoActual=-2

    for (( linea=0; ;linea++ ))
    do
        numBloquesPorLinea=$(( (anchoRestante / anchoBloque - 1) ))

        ultimoTiempo=$(( primerTiempo + numBloquesPorLinea ))
        if [ $ultimoTiempo -ge $tiempoDelSistema ];then
            ultimoTiempo=$(( tiempoDelSistema))
            colocarEtiqueta=1
        fi

        #Procesos
        # [ $linea -eq 0 ] && printf "%${anchoEtiqueta}s" "|" || printf "%${anchoEtiqueta}s"
        [ $linea -eq 0 ] && printf "%${anchoEtiqueta}s" "|" 
        procesoAnterior=-1
        procesoActual=-2
        local restantequantum=0
        for (( m=primerTiempo; m<=ultimoTiempo; m++))
        do
            procesoActual=${VectorTiempoProceso[$m]}

            if [[ $m -eq $tiempoDelSistema && $(CompruebaFinDeEjecucion) -eq 0 && "$procesoActual" != "." ]]
            then
                echo -en "${nombreProcesoColor[$procesoActual]}"
                printf "%$(( anchoBloque - ${#nombreProceso[$procesoActual]} ))s" ""
            else

                if [[ "$procesoActual" != "." ]]
                then
                    if [[ "$procesoActual" != "$procesoAnterior" ]]
                    then
                        restantequantum=$(($tamQuant - 1))
                        echo -en "${nombreProcesoColor[$procesoActual]}"
                        printf "%$(( anchoBloque - ${#nombreProceso[$procesoActual]} ))s" ""
                    else

                        printf "%${anchoBloque}s" ""

                    fi
                else
                    printf "%${anchoBloque}s" ""
                fi

            fi

            procesoAnterior=$procesoActual
        done

        if [[ $(( ($numBloquesPorLinea - ($ultimoTiempo - $primerTiempo) ) * $anchoBloque )) -ge $lengthEtiquetaFinal && $colocarEtiqueta -eq 1 ]]
        then
            printf "\e[0m|\n"
        else
            printf "\e[0m\n"
        fi


        #Paginas
        procesoAnterior=-1
        procesoActual=-2
        [ $linea -eq 0 ] && printf "%${anchoEtiqueta}s" "BT |"
        # [ $linea -eq 0 ] && printf "%${anchoEtiqueta}s" "BT |" || printf "%${anchoEtiqueta}s"
        for (( m=primerTiempo; m<=ultimoTiempo; m++))
        do  
            procesoActual=${VectorTiempoProceso[$m]}

            if [[ $m -eq $tiempoDelSistema && $(CompruebaFinDeEjecucion) -eq 0 ]]
            then
                printf "%${anchoBloque}s" "${VectorTiempoPagina[$m]}"
            else

                if [[ "$procesoActual" != "." ]]
                then
                    if [[ $m -gt 0 && "${VectorTiempoPagina[$m]}" == "${VectorTiempoPagina[$(($m-1))]}" && "$procesoActual" != "$procesoAnterior" ]]
                    then
                        printf "\e[4${colorines[$procesoActual]}m%${anchoBloque}s\e[0m" "${VectorTiempoPagina[$m]}" #"-"
                    else
                        printf "\e[4${colorines[$procesoActual]}m%${anchoBloque}s\e[0m" "${VectorTiempoPagina[$m]}"
                    fi
                else
                    printf "\e[107m%${anchoBloque}s\e[0m" "_"
                fi

            fi
        done

        
        if [[ $(( ($numBloquesPorLinea - ($ultimoTiempo - $primerTiempo) ) * $anchoBloque )) -ge $lengthEtiquetaFinal && $colocarEtiqueta -eq 1 ]]
        then
            printf "\e[0m|\e[1;39m T: ${tiempoDelSistema}\e[0m\n"
        else
            printf "\e[0m\n"
        fi



        #tiempo
        procesoAnterior=-1
        procesoActual=-2
        local restantequantum=0
        # [ $linea -eq 0 ] && printf "%${anchoEtiqueta}s" "|" || printf "%${anchoEtiqueta}s"
        [ $linea -eq 0 ] && printf "%${anchoEtiqueta}s" "|"
        for (( m=primerTiempo; m<=ultimoTiempo; m++))
        do
            if [[ "${VectorTiempoPagina[$m]}" != '<' && "${VectorTiempoPagina[$m]}" != '>' ]]
            then
                procesoActual=${VectorTiempoProceso[$m]}
            fi


            if [[ "$procesoActual" != "$procesoAnterior" && ("${VectorTiempoPagina[$m]}" != '<' && "${VectorTiempoPagina[$m]}" != '>') ]]
            then
                printf "\e[1m%${anchoBloque}s\e[0m" "$m"
            else
                printf "\e[1m%${anchoBloque}s\e[0m" ""

            fi

            if [[ "${VectorTiempoPagina[$m]}" != '<' && "${VectorTiempoPagina[$m]}" != '>' ]]
            then
                procesoAnterior=$procesoActual
            fi

        done

        if [[ $(( ($numBloquesPorLinea - ($ultimoTiempo - $primerTiempo) ) * $anchoBloque )) -ge $lengthEtiquetaFinal && $colocarEtiqueta -eq 1 ]]
        then
            printf "\e[0m|\n"
            colocarEtiqueta=0
            break
        else
            printf "\e[0m\n"
        fi
  

        if [[ $colocarEtiqueta -eq 1 ]]
        then
            echo ""
            printf "\e[0m|\n"
            printf "\e[0m|\e[1;39m T: ${tiempoDelSistema}\e[0m\n"
            printf "\e[0m|\n"
            colocarEtiqueta=0
            break
        fi

        primerTiempo=$(( ultimoTiempo + 1 ))


        anchoRestante=$(( $( tput cols )  ))

    done

    echo ""
}

###################################################################################
##         ###########                                       ###########         ##
##  #####   #########   #####    ##  #########  ##    #####   #########   #####  ##
##   #####             #####     ##  ##     ##  ##     #####             #####   ##
##    #####################   #  ##  #########  ##  #   #####################    ##
##     ###################   ##                     ##   ###################     ##
##  #   #####       #####   ###########################   #####       #####   #  ##
######   #####     #####   ###-----------------------###   #####     #####   ######
#######   #############   ####--FUNCIONES-DEL-FINAL--####   #############   #######
######   #####     #####   ###-----------------------###   #####     #####   ######
##  #   #####       #####   ###########################   #####       #####   #  ##
##     ###################   ##                     ##   ###################     ##
##    #####################   #  ####  #####  ####  #   #####################    ##
##   #####             #####     ####  ## ##  ####     #####             #####   ##
##  #####   #########   #####    ####  #####  ####    #####   #########   #####  ##
##         ###########                                       ###########         ##
###################################################################################


# Función que imprime un menú al finalizar el algoritmo principal
final(){
    openInforme=0;
    editor=0;
    echo -e "\e[1;31mFin de el algoritmo\e[0m" | tee -a $informeColor
    echo
    echo "Presione INTRO para continuar"
    read
    clear


    echo ""
    echo -e "\e[1;38;5;81mPor último, ¿desea abrir el informe? \e[0m"
    echo ""
    echo -e "    \e[1;32m	[s]\e[0m -> Sí	"
    echo -e "    \e[1;32m	[n]\e[0m -> No	"
    echo ""
    read -p "Seleccione la opción: " openInforme

    until [[ "$openInforme" == "s" || "$openInforme" == "n" ]]; do
        echo ""
        echo -e -n "\e[1;31mValor incorrecto, escriba \e[1;33ms\e[0m \e[1;31mo\e[0m \e[1;33mn\e[0m\e[1;31m: \e[0m"
        read openInforme
    done
        
    if [[ $openInforme = "s" ]]; then

        clear
        echo ""
        echo -e "\e[1;38;5;81mPor último, ¿desea abrir el informe? \e[0m"
        echo ""
        echo -e "    \e[1;38;5;64;48;5;7m   [s]\e[90m -> Sí   \e[0m"
        echo -e "    \e[1;32m   [n]\e[0m -> No	"
        echo ""
        sleep 0.5

        clear
        echo -e "\n\n  ¿Con qué editor desea abrir el informe?"
        echo -e "  \e[1;32mnano\e[0m, \e[1;33mvi\e[0m, \e[1;34m[vim]\e[0m, \e[1;35mgvim\e[0m, \e[1;32mgedit\e[0m, \e[1;33matom\e[0m, \e[1;34mcat (a color)\e[0m, \e[1;31motro\e[0m"
        echo "  Después de visualizarlo vuelva a esta ventana y terminará el algoritmo"
        read -p "  Seleccione: " editor

        until [[ $editor = "nano" ||  $editor = "vi" ||  $editor = "vim" ||  $editor = "gvim" ||  $editor = "gedit" ||  $editor = "atom" || $editor = "cat" || $editor = "otro" || $editor = "" ]]; do
            echo -e "  \e[1;31mPor favor escoja uno de la lista\e[0m"
            echo "¿Con qué editor desea abrir el informe?"
            echo "  \e[1;32mnano\e[0m, \e[1;33mvi\e[0m, \e[1;34m[vim]\e[0m, \e[1;35mgvim\e[0m, \e[1;32mgedit\e[0m, \e[1;33matom\e[0m, \e[1;34mcat (a color)\e[0m, \e[1;31motro\e[0m"
            read -p "  Seleccione: " editor
        done
                
        case $editor in
            "nano")
                nano $informe
                ;;
            "vi")
                vi $informe
                ;;
            "vim")
                vim $informe
                ;;
            "gvim")
                gvim $informe
                ;;
            "gedit")
                gedit $informe
                ;;
            "atom")
                atom $informe
                ;;
            "cat")
                cat $informeColor
                ;;
            "otro")
                echo -e "\n  \e[1;31mAl escoger otro editor tenga en cuenta que debe tenerlo instalado, si no dará error\e[0m"
                read -p "  Introduzca: " editor
                $editor $nombre".txt"
                ;;
            "")
                vim $informe
                ;;
        esac
        
        echo -e "\nPresione cualquier tecla para continuar"
        read -n 1
            
    else
        clear
        echo -e "\n\e[1;38;5;81mPor último, ¿desea abrir el informe? \e[0m"
        echo -e "\n    \e[1;32m   [s]\e[0m -> Sí	"
        echo -e "    \e[1;38;5;64;48;5;7m   [n]\e[90m -> No   \e[0m\n"
        sleep 0.5

        clear
        echo -e "\n  \e[1;31mNo se abrirá el informe\e[0m\n"
    fi

    clear
    cabeceraFinal
    sleep 1
}

# Función con un final alternativo
finalAlternativo(){
    sleep 2
    clear
    cabeceraFinal
    sleep 1
}


# ███████╗██╗   ██╗███╗   ██╗ ██████╗██╗ ██████╗ ███╗   ██╗███████╗███████╗
# ██╔════╝██║   ██║████╗  ██║██╔════╝██║██╔═══██╗████╗  ██║██╔════╝██╔════╝
# █████╗  ██║   ██║██╔██╗ ██║██║     ██║██║   ██║██╔██╗ ██║█████╗  ███████╗
# ██╔══╝  ██║   ██║██║╚██╗██║██║     ██║██║   ██║██║╚██╗██║██╔══╝  ╚════██║
# ██║     ╚██████╔╝██║ ╚████║╚██████╗██║╚██████╔╝██║ ╚████║███████╗███████║
# ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚══════╝
                                                                         
#  █████╗ ██╗   ██╗██╗  ██╗██╗██╗     ██╗ █████╗ ██████╗ ███████╗███████╗  
# ██╔══██╗██║   ██║╚██╗██╔╝██║██║     ██║██╔══██╗██╔══██╗██╔════╝██╔════╝  
# ███████║██║   ██║ ╚███╔╝ ██║██║     ██║███████║██████╔╝█████╗  ███████╗  
# ██╔══██║██║   ██║ ██╔██╗ ██║██║     ██║██╔══██║██╔══██╗██╔══╝  ╚════██║  
# ██║  ██║╚██████╔╝██╔╝ ██╗██║███████╗██║██║  ██║██║  ██║███████╗███████║  
# ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝╚══════╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝  
                                                                         



# Función que espera a que pulses intro para continuar
EsperaIntro()
{
    local enter=''

    read -n 1 -s -p "Pulse ENTER para continuar:" enter
    while [[ "$enter" != "" ]]
    do
        read -n 1 -s enter
    done
}

# Función que calcula la media del vector de entrada
media(){
    local vector=("${!1}")
    laMedia=0
    local tot

    tot=0
    for (( counter=0; counter< $nProc; counter++ ))
        do
            let laMedia=laMedia+vector[$counter]
            ((tot++))
        done
    laMedia=`(echo "scale=3;$laMedia/$tot" | bc -l)`
    
}

# Función que calcula el valor máximo del vector de entrada
# Parámetros:
#   -$@: Vector de valores
# Valor de retorno:
#   - Valor máximo del vector
max()
{
  local maxVal=-9999999999
  for i in $@
  do
    if [[ $i -gt $maxVal ]]
    then
      maxVal=$i
    fi
  done

  echo $maxVal
}

# Función que calcula el valor mínimo de un vector de entrada
# Parámetros:
#   -$@: Vector de entrada de valores
# Valor de retorno:
#   - Valor mínimo del vector
min()
{
  local minVal=9999999999
  for i in $@
  do
    if [[ $i -lt $minVal ]]
    then
      minVal=$i
    fi
  done

  echo $minVal
}

# Función que calcula un valor aleatorio entre un valor mínimo y máximo
# Parámetros:
#   -$1: Valor mínimo
#   -$2: Valor máximo
# Valor de retorno:
#   - Valor aleatorio entre el mínimo y el máximo
rand()
{
  local minVal=$1
  local maxVal=$2

  local intervalo=$(( $maxVal - $minVal + 1))

  if [[ $intervalo -eq 0 ]]
  then
    intervalo=1
  fi
  
  if [[ $minVal -eq $maxVal ]]
  then
    local value=$minVal
  else
    local value=$(( ($RANDOM % $intervalo) + $minVal ))
  fi

  echo $value
}


# Funcion que devuelve la longitud de la variable que se le pase por parámetro
# Parámetros:
#   -$1: Variable de la que calcular la longitud
# Valores de retorno:
#   - Longitud de la variable pasada
len()
{
    echo ${#1}
}

# Funcion que devuelve la longitud de la variable que se le pase por parámetro
# Parámetros:
#   -$1: Variable de la que calcular la longitud
# Valores de retorno:
#   - Longitud de la variable pasada
length()
{
    echo `expr length "$1"`
}


# Funcion que permite saber si el contenido de una variable pasada por parámetro está vacío o no.
# Devuelve 1 si la variable está vacia, 0 en caso contrario.
variableVacia()
{
    if [ -z "$1"]
    then
        echo 1
    else
        echo 0
    fi
}

#!#

#-------------------------------------Cadenas de Escape ANSI-----------------------------------------

##  Aviso: Puede que estas cadenas de escape no funcionen en algunas terminales antiguas al no ser compatibles con 
##          colores de 256 bits. 
##
##  Enlaces con información al respecto:  
##      https://en.wikipedia.org/wiki/ANSI_escape_code
##      https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html
##
##  Una mejora que se puede realizar a esta práctica es ampliar los colores que puede usar en lugar de los 8
##  que usa actualmente, teniendo cuidado que los colores de 256 bits que usemos no sean problemáticos 
##  (Blanco, negro, gris...).
##


# Función con propositos de debug que permite escribir un log con los eventos en un fichero de texto
# Puedes pasarle varios parámetros para que los imprima.
Logger()
{
    # if [[ $hayLog -eq 1 ]]
    # then
    #     rm log.txt
    #     hayLog=0
    # fi

    local entry="t:$tiempoDelSistema|>"

    for param in $@
    do
        entry+="·$param"
    done
    echo -e "$entry" >> log.txt
}





###################################################################################
###################################             ###################################
##############################      ####   ####      ##############################
#########################      #########   #########      #########################
####################      ##############   ##############      ####################
###############      ###################   ###################      ###############
##########      ######################       ######################      ##########
#####      #########################     #     #########################      #####
#                                       ###                                       #
#####      #########################     #     #########################      #####
##########      ######################       ######################      ##########
###############      ###################   ###################      ###############
####################      ##############   ##############      ####################
#########################      #########   #########      #########################
##############################      ####   ####      ##############################
###################################             ###################################
###################################################################################
    
    
    
####ALGORITMO#####

rm log.txt
cabecera
cabeceraInicio
imprimeTamano
menuInicio

if [[ menu -eq 1 ]]; then
    seleccionInforme
    seleccionEntrada
    # RoundRobin
    EjecutaRoundRobin
    final
else
    clear
    cat ./Ayuda/ayuda.txt
    echo ""
    read -p "Presione INTRO para continua
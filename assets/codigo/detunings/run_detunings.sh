#!/bin/bash

set -e # detener el script si cualquier comando falla

# funciones
telegram() {
    local mensaje=$1
    curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
        -d chat_id="$CHAT_ID" \
        -d text="$mensaje" > /dev/null
}
error_handler() {
    local exit_code=$? # código de error del último comando
    local line_number=$1 # línea del error
    local command=$2 # comando que falló

    local error_msg="
-------------------------------------------
📍 línea: $line_number
💻 comando: $command
🚫 código de salida: $exit_code
-------------------------------------------"
    echo -e "ERROR: \n[$(date '+%Y-%m-%d %H:%M:%S')] $error_msg"

    telegram "error: la ejecución de DETUNINGS ($N_ATOMS at, $M_LEVELS lvl, $NMAX f) falló (P)"

    exit $exit_code
}

# parámetros
N_ATOMS=$1
M_LEVELS=$2
NMAX=$3
# variables de entorno
if [ -f ".env" ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi
# nombres de archivos
PREFIX="${N_ATOMS}at${M_LEVELS}lvl"
PYTHON_FILE="${N_ATOMS}at${M_LEVELS}lvl.py"

# manejo de errores
trap 'error_handler $LINENO "$BASH_COMMAND"' ERR

# ejecución
mkdir -p ${PREFIX}/ 2>/dev/null || true
cd pyfiles/

run_detuning() {
    i=$1
    d=$2
    echo "$i - procesando detuning = $d..."
    CURRFILE="${PREFIX}_d$i"
    
    python3 ${PYTHON_FILE} --nmax ${NMAX} --detuning $d --idx $i
    gcc ${CURRFILE}.c -o ${CURRFILE}.out -O0 \
    -I/usr/include/hdf5/serial -I/usr/include/gsl \
    -lhdf5_serial -lhdf5_serial_hl \
    -lgsl -lgslcblas -lm
    ./${CURRFILE}.out
    
    mv -f ${CURRFILE}*.c ../cfiles/
    mv -f ${CURRFILE}*.h5 ../${PREFIX}/
    mv -f ${CURRFILE}*.out ../outfiles/
    rm -f dic${CURRFILE}.py func${CURRFILE}.c
}

INICIO=$(date '+%Y-%m-%d %H:%M:%S')
echo "======================================================"
echo "iniciando para DETUNINGS, N=${N_ATOMS}, M=${M_LEVELS}, f=${NMAX}"
echo "timestamp: ${INICIO}"
echo "======================================================"

# paralelización
# run_detuning 1 -3.0
export -f run_detuning
export N_ATOMS M_LEVELS NMAX PREFIX PYTHON_FILE
seq -3.0 0.2 3.0 | parallel -j 8 --eta run_detuning '{= $_=($job->seq()) =}' {}

TERMINO=$(date '+%Y-%m-%d %H:%M:%S')
echo "======================================================"
echo "barrido paralelo completado"
echo "timestamp: ${TERMINO}"
echo "======================================================"

telegram "barrido paralelo completado (P)
átomos: ${N_ATOMS}
niveles: ${M_LEVELS}
fotones: ${NMAX}
inicio: ${INICIO}
término: ${TERMINO}"
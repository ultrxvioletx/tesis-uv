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

    telegram "error: la ejecución GCC ($N_ATOMS at, $M_LEVELS lvl, $NMAX f) falló (P)"

    exit $exit_code
}
format_mem() {
    local kb=$1
    if [[ -z "$kb" ]] || ! [[ "$kb" =~ ^[0-9]+$ ]]; then echo "N/A"; return; fi
    if [ "$kb" -lt 1024 ]; then echo "${kb} KB"
    elif [ "$kb" -lt 1048576 ]; then echo "$(echo "scale=2; $kb / 1024" | bc) MB"
    else echo "$(echo "scale=2; $kb / (1024*1024)" | bc) GB"; fi
}

# parámetros
N_ATOMS=$1
M_LEVELS=$2
NMAX=$3

# cálculo de RAM mínima
DIM_HILBERT=$(( (M_LEVELS ** N_ATOMS) * NMAX ))
RAM_BYTES=$(( 1000 * DIM_HILBERT**2 * 16 ))
RAM_MIN=$(format_mem $((RAM_BYTES / 1024)))

# variables de entorno
if [ -f ".env" ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi
# nombres de archivos
FILENAME="${N_ATOMS}at${M_LEVELS}lvl${NMAX}f"
MAINC_FILE="${FILENAME}.c"
H5_FILE="${FILENAME}.h5"
LOG_FILE="log.csv"

# manejo de errores
trap 'error_handler $LINENO "$BASH_COMMAND"' ERR

# ejecución
cd ~/simulaciones/cfiles/

INICIO=$(date '+%Y-%m-%d %H:%M:%S')
echo "======================================================"
echo "iniciando para ${MAINC_FILE}, N=${N_ATOMS}, M=${M_LEVELS}, f=${NMAX}"
echo "timestamp: ${INICIO}"
echo "======================================================"

# compilar
echo "compilando..."
START=$(date +%s.%N)
/usr/bin/time -f "%M" gcc ${MAINC_FILE} -o runsim -O0 \
    -I/usr/include/hdf5/serial -I/usr/include/gsl \
    -lhdf5_serial -lhdf5_serial_hl \
    -lgsl -lgslcblas -lm 2> gcc_mem${FILENAME}.tmp
END=$(date +%s.%N)

T_COMPILE=$(echo "$END - $START" | bc)
M_COMPILE=$(cat gcc_mem${FILENAME}.tmp)
# guarda métricas en un txt
echo "$T_COMPILE" > gccdat${FILENAME}.txt
echo "$M_COMPILE" >> gccdat${FILENAME}.txt

# run
echo "ejecutando..."
START=$(date +%s.%N)
/usr/bin/time -f "%M" ./runsim 2> run_mem${FILENAME}.tmp
END=$(date +%s.%N)

T_RUN=$(echo "$END - $START" | bc)
M_RUN=$(cat run_mem${FILENAME}.tmp)
# guarda métricas en un txt
echo "$T_RUN" > rundat${FILENAME}.txt
echo "$M_RUN" >> rundat${FILENAME}.txt

rm -f gcc_mem${FILENAME}.tmp run_mem${FILENAME}.tmp
mv -f gccdat${FILENAME}.txt ~/simulaciones/dats/ 2>/dev/null || true
mv -f rundat${FILENAME}.txt ~/simulaciones/dats/ 2>/dev/null || true
mv -f ${H5_FILE} ~/simulaciones/h5files/ 2>/dev/null || true

# log
echo "actualizando log..."
cd ~/simulaciones/
T_BUILDODE=$(head -n 1 dats/pydat${FILENAME}.txt)
M_BUILDODE=$(head -n 2 dats/pydat${FILENAME}.txt | tail -n 1)
T_COMPILE=$(head -n 1 dats/gccdat${FILENAME}.txt)
M_BUILDODE=$(head -n 2 dats/gccdat${FILENAME}.txt | tail -n 1)
T_RUN=$(head -n 1 dats/rundat${FILENAME}.txt)
M_RUN=$(head -n 2 dats/rundat${FILENAME}.txt | tail -n 1)

RAM_BUILDODE=$(format_mem $M_BUILDODE)
RAM_COMPILE=$(format_mem $M_COMPILE)
RAM_RUN=$(format_mem $M_RUN)

echo "${N_ATOMS},${M_LEVELS},${NMAX},1000,${RAM_MIN},${T_BUILDODE},${RAM_BUILDODE},${T_COMPILE},${RAM_COMPILE},${T_RUN},${RAM_RUN}" >> "$LOG_FILE"

TERMINO=$(date '+%Y-%m-%d %H:%M:%S')
echo "======================================================"
echo "proceso completado"
echo "timestamp: ${TERMINO}"
echo "======================================================"

telegram "simulación terminada (P)
átomos: ${N_ATOMS}
niveles: ${M_LEVELS}
fotones: ${NMAX}
inicio: ${INICIO}
término: ${TERMINO} 
    - buildode: ${RAM_BUILDODE}, ${T_BUILDODE}
    - compile: ${RAM_COMPILE}, ${T_COMPILE}
    - run: ${RAM_RUN}, ${T_RUN}"
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

    telegram "error: la ejecución PYTHON ($N_ATOMS at, $M_LEVELS lvl, $NMAX f) falló (P)"

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
# variables de entorno
if [ -f ".env" ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi
# nombres de archivos
FILENAME="${N_ATOMS}at${M_LEVELS}lvl${NMAX}f"
MAINC_FILE="${FILENAME}.c"
PYTHON_FILE="Nat${M_LEVELS}lvl.py"
PYTHON_ARGS=" ${N_ATOMS} ${NMAX}"

# manejo de errores
trap 'telegram error_handler $LINENO "$BASH_COMMAND"' ERR

# ejecución
cd ~/simulaciones/pyfiles/

INICIO=$(date '+%Y-%m-%d %H:%M:%S')
echo "======================================================"
echo "iniciando para ${PYTHON_FILE}, N=${N_ATOMS}, M=${M_LEVELS}, f=${NMAX}"
echo "timestamp: ${INICIO}"
echo "======================================================"

echo "ejecutando archivo python..."
START=$(date +%s.%N)
/usr/bin/time -f "%M" python3 ${PYTHON_FILE} ${PYTHON_ARGS} 2> py_mem${FILENAME}.tmp
END=$(date +%s.%N)
T_BUILDODE=$(echo "$END - $START" | bc)
M_BUILDODE=$(cat py_mem${FILENAME}.tmp)

# guarda métricas en un txt
echo "$T_BUILDODE" > pydat${FILENAME}.txt
echo "$M_BUILDODE" >> pydat${FILENAME}.txt

rm -f py_mem${FILENAME}.tmp
mv -f pydat${FILENAME}.txt ~/simulaciones/dats/ 2>/dev/null || true
mv -f ${MAINC_FILE} ~/simulaciones/cfiles/ 2>/dev/null || true

TERMINO=$(date '+%Y-%m-%d %H:%M:%S')
echo "======================================================"
echo "proceso completado"
echo "timestamp: ${TERMINO}"
echo "======================================================"

telegram "archivo c generado (P)
átomos: ${N_ATOMS}
niveles: ${M_LEVELS}
fotones: ${NMAX}
inicio: ${INICIO}
término: ${TERMINO} 
    - buildode: $(format_mem $M_BUILDODE), ${T_BUILDODE} s"
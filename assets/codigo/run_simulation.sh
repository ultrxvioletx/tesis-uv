#!/bin/bash

set -e # detener el script si cualquier comando falla

PATH_LOCAL="$HOME/Fciencias/tesis/assets/codigo/escalabilidad"
PATH_P="~/simulaciones"
PATH_L="~/simulaciones"

# parámetros
N_ATOMS=$1
M_LEVELS=$2
NMAX=$3
NT=1000

# nombres de archivos
FILENAME="${N_ATOMS}at${M_LEVELS}lvl"
# si hay más de un átomo, corre Nat2lvl.py
if [ "${N_ATOMS}" -gt 1 ]; then
    PYTHON_FILE="Nat${M_LEVELS}lvl.py"
    PYTHON_ARGS=" ${N_ATOMS} ${NMAX}"
else
    PYTHON_FILE="${FILENAME}.py"
    PYTHON_ARGS="${NMAX}"
fi
MAINC_FILE="${FILENAME}.c"
H5_FILE="${FILENAME}.h5"
TEMPFILE="_mem${N_ATOMS}${N_LEVELS}${NMAX}.tmp"
EXECUTABLE_NAME="runsim"
LOG_FILE="log.csv"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# calcula ram mínima requerida (MB o GB)
DIM_HILBERT=$(( (M_LEVELS ** N_ATOMS) * NMAX ))
RAM_BYTES=$(( NT * DIM_HILBERT**2 * 16 ))
RAM_MIN=$((RAM_BYTES / 1024 ))
format_mem() {
    local kb=$1
    if [[ -z "$kb" ]] || ! [[ "$kb" =~ ^[0-9]+$ ]]; then
        echo "N/A"
        return
    fi
    if [ "$kb" -lt 1024 ]; then
        echo "${kb} KB"
    elif [ "$kb" -lt 1048576 ]; then
        echo "$(echo "scale=2; $kb / 1024" | bc) MB"
    else
        echo "$(echo "scale=2; $kb / (1024*1024)" | bc) GB"
    fi
}
RAM_MIN=$(format_mem $RAM_MIN)

# inicializa log
cd ${PATH_LOCAL}/
if [ ! -f "$LOG_FILE" ]; then
    echo "N_atoms,M_levels,nmax,nt,RAM_min,TIME_build,RAM_build,TIME_compile,RAM_compile,TIME_run,RAM_run" > "$LOG_FILE"
fi

# inicia proceso
echo "======================================================"
echo "iniciando para ${PYTHON_FILE}"
echo "RAM estimada: ${RAM_MIN}"
echo "timestamp: ${TIMESTAMP}"
echo "======================================================"

# serverpablo
echo "generando código c en servidor P..."
REMOTE_OUTPUT_P=$(ssh serverpablo "
    cd ${PATH_P}/pyfiles/ && \
    START=\$(date +%s.%N) && \
    /usr/bin/time -f "MEM_KB:%M" python3 ${PYTHON_FILE} ${PYTHON_ARGS} 2> py${TEMPFILE} && \
    END=\$(date +%s.%N) && \
    T_BUILDODE=\$(echo \"\$END - \$START\" | bc) && \
    M_BUILDODE=\$(cat py${TEMPFILE} | cut -d':' -f2) && \

    echo \"T_BUILDODE=\$T_BUILDODE\" && \
    echo \"M_BUILDODE=\$M_BUILDODE\" && \
    rm py${TEMPFILE} && \

    mv -f ${MAINC_FILE} ${PATH_P}/cfiles/ 2>/dev/null || true
")
T_BUILDODE=$(echo "${REMOTE_OUTPUT_P}" | grep 'T_BUILDODE=' | cut -d'=' -f2)
M_BUILDODE=$(echo "${REMOTE_OUTPUT_P}" | grep 'M_BUILDODE=' | cut -d'=' -f2)
echo "build: ${T_BUILDODE} s"

echo "transfiriendo archivo c de P hacia L..."
scp serverpablo:${PATH_P}/cfiles/${MAINC_FILE} serverluis:${PATH_L}/cfiles/

# serverluis
echo "compilando y ejecutando código c en servidor L..."
REMOTE_OUTPUT_L=$(ssh serverluis "
    cd ${PATH_L}/cfiles && \
    START=\$(date +%s.%N) && \
    /usr/bin/time -f \"MEM_KB:%M\" gcc ${MAINC_FILE} -o ${EXECUTABLE_NAME} -O3 \
        -I\"\$HOME/local/include\" \
        -I/usr/include/hdf5/serial \
        -L\"\$HOME/local/lib\" \
        -Wl,-rpath,\"\$HOME/local/lib\" \
        -lgsl -lgslcblas \
        -lhdf5 -lhdf5_hl \
        -lm 2> gcc${TEMPFILE} && \
    END=\$(date +%s.%N) && \
    T_COMPILE=\$(echo \"\$END - \$START\" | bc) && \
    M_COMPILE=\$(cat gcc${TEMPFILE} | cut -d':' -f2) && \

    START=\$(date +%s.%N) && \
    /usr/bin/time -f \"MEM_KB:%M\" ./${EXECUTABLE_NAME} 2> run${TEMPFILE} && \
    END=\$(date +%s.%N) && \
    T_RUN=\$(echo \"\$END - \$START\" | bc) && \
    M_RUN=\$(cat run${TEMPFILE} | cut -d':' -f2) && \
    
    echo \"T_COMPILE=\$T_COMPILE\" && \
    echo \"T_RUN=\${T_RUN}\" && \
    echo \"M_COMPILE=\$M_COMPILE\" && \
    echo \"M_RUN=\$M_RUN\" && \

    rm gcc${TEMPFILE} run${TEMPFILE} && \
    mv -f ${H5_FILE} ${PATH_L}/h5files/ 2>/dev/null || true
")
T_COMPILE=$(echo "${REMOTE_OUTPUT_L}" | grep 'T_COMPILE=' | cut -d'=' -f2)
T_RUN=$(echo "${REMOTE_OUTPUT_L}" | grep 'T_RUN=' | cut -d'=' -f2)
M_COMPILE=$(echo "${REMOTE_OUTPUT_L}" | grep 'M_COMPILE=' | cut -d'=' -f2)
M_RUN=$(echo "${REMOTE_OUTPUT_L}" | grep 'M_RUN=' | cut -d'=' -f2)
echo "compilación: ${T_COMPILE} s"
echo "ejecución: ${T_RUN} s"

# local
echo "descargando archivos y log a pc local..."
scp serverpablo:${PATH_P}/pyfiles/${PYTHON_FILE} ${PATH_LOCAL}/pyfiles/
scp serverpablo:${PATH_P}/cfiles/${MAINC_FILE} ${PATH_LOCAL}/cfiles/
scp serverluis:${PATH_L}/h5files/${H5_FILE} ${PATH_LOCAL}/h5files/


# consolida datos en el log
RAM_BUILDODE=$(format_mem $M_BUILDODE)
RAM_COMPILE=$(format_mem $M_COMPILE)
RAM_RUN=$(format_mem $M_RUN)

echo "actualizando log..."
csv_line="${N_ATOMS},${M_LEVELS},${NMAX},${NT},${RAM_MIN},${T_BUILDODE},${RAM_BUILDODE},${T_COMPILE},${RAM_COMPILE},${T_RUN},${RAM_RUN}"
echo "$csv_line" >> "$LOG_FILE"

echo "======================================================"
echo "proceso completado, ${LOG_FILE} actualizado"
echo "======================================================"
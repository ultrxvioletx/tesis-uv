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
PYTHON_FILE="${FILENAME}.py"
MAINC_FILE="${FILENAME}.c"
H5_FILE="${FILENAME}.h5"
EXECUTABLE_NAME="runsim"
LOG_FILE="log.csv"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# calcula ram mínima requerida (MB o GB)
DIM_HILBERT=$(( (M_LEVELS ** N_ATOMS) * NMAX ))
NEQ_REALES=$(( 2 * DIM_HILBERT * DIM_HILBERT ))
RAM_BYTES=$(( NT * NEQ_REALES * 8 ))
RAM_MIN=$(echo "scale=4; ${RAM_BYTES} / (1024*1024)" | bc)
UNIT_RAM="MB"
if (( $(echo "$RAM_MIN < 1024" | bc -l) )); then
    RAM_MIN=$(printf "%.0f" "$RAM_MIN")
else #en GB
    RAM_MIN=$(printf "%.2f" "$(echo "scale=2; ${RAM_MIN} / 1024" | bc)")
    UNIT_RAM="GB"
fi

# inicializa log
cd ${PATH_LOCAL}/
if [ ! -f "$LOG_FILE" ]; then
    echo "N_atoms,M_levels,nmax,nt,RAM_min,build_ode,c_compile,c_run" > "$LOG_FILE"
fi

# inicia proceso
echo "======================================================"
echo "iniciando para ${FILENAME}"
echo "RAM estimada: ${RAM_MIN} ${UNIT_RAM}"
echo "timestamp: ${TIMESTAMP}"
echo "======================================================"

# serverpablo
echo "generando código c en servidor P..."
REMOTE_OUTPUT_P=$(ssh serverpablo "
    cd ${PATH_P}/pyfiles/ && \
    START=\$(date +%s.%N) && \
    python3 ${PYTHON_FILE} ${NMAX} && \
    END=\$(date +%s.%N) && \
    T_BUILDODE=\$(echo \"\$END - \$START\" | bc) && \
    echo \"T_BUILDODE=\$T_BUILDODE\" && \

    mv -f ${MAINC_FILE} ${PATH_P}/cfiles/ 2>/dev/null || true
")
T_BUILDODE=$(echo "${REMOTE_OUTPUT_P}" | grep 'T_BUILDODE=' | cut -d'=' -f2)
echo "build: ${T_BUILDODE} s"

echo "transfiriendo archivo c de P hacia L..."
scp serverpablo:${PATH_P}/cfiles/${MAINC_FILE} serverluis:${PATH_L}/cfiles/

# serverluis
echo "compilando y ejecutando código c en servidor L..."
REMOTE_OUTPUT_L=$(ssh serverluis "
    cd ${PATH_L}/cfiles && \
    START=\$(date +%s.%N) && \
    gcc ${MAINC_FILE} -o ${EXECUTABLE_NAME} -O3 \
        -I\"\$HOME/local/include\" \
        -I/usr/include/hdf5/serial \
        -L\"\$HOME/local/lib\" \
        -Wl,-rpath,\"\$HOME/local/lib\" \
        -lgsl -lgslcblas \
        -lhdf5 -lhdf5_hl \
        -lm && \
    END=\$(date +%s.%N) && \
    T_COMPILE=\$(echo \"\$END - \$START\" | bc) && \

    START=\$(date +%s.%N) && \
    ./${EXECUTABLE_NAME} && \
    END=\$(date +%s.%N) && \
    T_RUN=\$(echo \"\$END - \$START\" | bc) && \
    
    echo \"T_COMPILE=\$T_COMPILE\" && \
    echo \"T_RUN=\${T_RUN}\" && \

    mv -f ${H5_FILE} ${PATH_L}/h5files/ 2>/dev/null || true
")
T_COMPILE=$(echo "${REMOTE_OUTPUT_L}" | grep 'T_COMPILE=' | cut -d'=' -f2)
T_RUN=$(echo "${REMOTE_OUTPUT_L}" | grep 'T_RUN=' | cut -d'=' -f2)
echo "compilación: ${T_COMPILE} s"
echo "ejecución: ${T_RUN} s"

# local
echo "descargando archivos y log a pc local..."
scp serverpablo:${PATH_P}/pyfiles/${PYTHON_FILE} ${PATH_LOCAL}/pyfiles/
scp serverpablo:${PATH_P}/cfiles/${MAINC_FILE} ${PATH_LOCAL}/cfiles/
scp serverluis:${PATH_L}/h5files/${H5_FILE} ${PATH_LOCAL}/h5files/

# consolida datos en el log
echo "actualizando log..."
csv_line="${N_ATOMS},${M_LEVELS},${NMAX},${NT},${RAM_MIN} ${UNIT_RAM},${T_BUILDODE},${T_COMPILE},${T_RUN}"
echo "$csv_line" >> "$LOG_FILE"

echo "======================================================"
echo "proceso completado, ${LOG_FILE} actualizado"
echo "======================================================"
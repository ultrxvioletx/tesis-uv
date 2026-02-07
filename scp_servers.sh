#!/bin/bash

set -e # detener el script si cualquier comando falla

PATH_LOCAL="./assets/codigo/escalabilidad"

# parámetros
N_ATOMS=$1
M_LEVELS=$2
NMAX=$3
SERVER=$4

FILENAME="${N_ATOMS}at${M_LEVELS}lvl${NMAX}f"
PYTHON_FILE="Nat${M_LEVELS}lvl.py"
PYTHON_ARGS=" ${N_ATOMS} ${NMAX}"
MAINC_FILE="${FILENAME}.c"
H5_FILE="${FILENAME}.h5"
LOG_FILE="log.csv"

if [ "$SERVER" == "P" ]; then
    scp serverpablo:~/simulaciones/run_python.sh ${PATH_LOCAL}/run_python\(P\).sh
    scp serverpablo:~/simulaciones/run_gcc.sh ${PATH_LOCAL}/run_gcc\(P\).sh
    scp serverpablo:~/simulaciones/log.csv ${PATH_LOCAL}/log\(P\).csv

    scp serverpablo:~/simulaciones/pyfiles/${PYTHON_FILE} ${PATH_LOCAL}/pyfiles/
    scp serverpablo:~/simulaciones/cfiles/${MAINC_FILE} ${PATH_LOCAL}/cfiles/
    scp serverpablo:~/simulaciones/h5files/${H5_FILE} ${PATH_LOCAL}/h5files/
elif [ "$SERVER" == "L" ]; then
    scp serverluis:~/simulaciones/run_gcc.sh ${PATH_LOCAL}/run_gcc\(L\).sh
    scp serverluis:~/simulaciones/log.csv ${PATH_LOCAL}/log\(L\).csv

    scp serverpablo:~/simulaciones/pyfiles/${PYTHON_FILE} ${PATH_LOCAL}/pyfiles/
    scp serverluis:~/simulaciones/cfiles/${MAINC_FILE} ${PATH_LOCAL}/cfiles/
    scp serverluis:~/simulaciones/h5files/${H5_FILE} ${PATH_LOCAL}/h5files/
else
    echo "Servidor no reconocido"
    exit 1
fi

echo "Archivos descargados."
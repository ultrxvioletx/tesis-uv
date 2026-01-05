import csv
import subprocess

def create_file(filename, t, probs, expects, params):
  with open(filename, 'w', newline='', encoding='utf-8') as file:
    file.write(f"# n={params['n']}\n")
    file.write(f"# g={params['g']}\n")
    file.write(f"# kappa={params['kappa']}\n")
    file.write(f"# gamma={params['gamma']}\n")
    file.write(f"# Omega12={params['Omega12']}\n")
    file.write(f"# rabi_b={params['rabi_b']}\n")
    file.write(f"# rabi_l={params['rabi_l']}\n")
    file.write(f"# detuning_bc={params['detuning_bc']}\n")
    file.write(f"# detuning_ca={params['detuning_ca']}\n")
    file.write(f"# detuning_al={params['detuning_al']}\n")
    writer = csv.writer(file)
    headers = ["t"]
    for i in range(len(probs)):
      headers.append(f"estado_{i}")
    headers.extend(["N_expect", "X_expect", "P_expect"])
    writer.writerow(headers)
    N_expect = expects[0]
    X_expect = expects[1]
    P_expect = expects[2]
    for i in range(len(t)):
      row = [t[i]]
      for j in range(len(probs)):
        row.append(probs[j,i])
      row.extend([N_expect[i], X_expect[i], P_expect[i]])
      writer.writerow(row)


def exec_c(file, args=None):
    ejecutable = "temp"
    compilacion = subprocess.run(
        ["gcc", file, "-o", ejecutable,"-I/usr/include/hdf5/serial", "-I/usr/include/gsl", "-lhdf5_serial", "-lhdf5_serial_hl", "-lgsl", "-lgslcblas", "-lm"],
        stderr=subprocess.PIPE,
        text=True
    )
    if compilacion.returncode != 0:
        return f"error de compilación:\n{compilacion.stderr}"
    
    comando = [f"./{ejecutable}"]
    if args:
        comando.extend(args)
    
    resultado = subprocess.run(
        comando,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )
    
    return {
        "salida": resultado.stdout,
        "errores": resultado.stderr,
        "codigo_salida": resultado.returncode
    }
#!/bin/bash
#SBATCH --job-name=MD_T300                # Nombre del trabajo
#SBATCH --output=run_%j.log              # Nombre del archivo de salida (%j se reemplaza por el jobID)
#SBATCH --error=run_%j.err               # Nombre del archivo de errores (%j se reemplaza por el jobID)
#SBATCH --ntasks=1                       # Número de tareas (procesos)
#SBATCH --cpus-per-task=1                # Número de CPUs por tarea
#SBATCH --time=00:03:00                  # Tiempo máximo de ejecución (en este caso, 1 minuto)
#SBATCH --partition=tests                # Partición (cola) a la que se enviará el trabajo

# Ejecutar el comando
python analisis.py


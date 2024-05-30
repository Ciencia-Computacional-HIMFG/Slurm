# Slurm.conf

https://slurm.schedmd.com/slurm.conf.html

## Sección de configuración general

**ClusterName**
Nombre del cluster (del universo de recursos). Slurm recurre a una base de
datos (MySQL o MariaDB) para almacenar su información y tiene la capacidad de
incluir en la misma base de datos más de un cluster. Es por eso que es
necesario etiquetar con un nombre de no más de 40 caracteres la gestión y
recursos de cada cluster.
```bash
SlurmctldHost=Hobbes
```

**SlurmctldHost**
Nombre de host de la máquina que aloja el demonio de control de Slurm. El
nombre puede ir seguido de su dirección IP entre paréntesis si el cluster
definido tiene más nodos secundarios.

Por ejemplo, en el caso de instalar Slurm en una sóla máquina basta:
```bash
SlurmctldHost=localhost
```
O si tiene nombre:
```bash
SlurmctldHost=fibonacci
```

Recuerda que el nombre de la máquina, si no aparece en tu prompt tras la arroba
"@", puedes obtenerlo por terminal con el comando:
```bash
hostname -s
```

Si tu instalación de Slurm va a gestionar los recursos en más de una máquina,
es pertinente añadir la correspondiente IP:
```bash
SlurmctldHost=fibonacci(192.168.0.100)
```

**MpiDefault**
Versión empleada para el protocolo MPI de paralelización de cómputo en el
cluster. La opción `none` está por defecto y es útil para la mayoría de casos.
```bash
MpiDefault=none
```

**ProctrackType**
Mecanismo para identificar los procesos ligados a un trabajo gestionado por el
demonio de Slurm. Aunque hay varias opciones, la recomendada es "proctrack/cgroup".

```bash
ProctrackType=proctrack/cgroup
```

**ReturnToService**
Parametro que controla el comportamiento de un nodo "caido". Con valor 0 (por
defecto) un nodo "caido" permanecerá en ese estado hasta que el administrador
lo levante. Con valor 1, el nodo "caido" volverá automáticamente a estar
disponible cuando sea posible si su baja era únicamente debida a fallos en la
comunicación. Con valor 2, el nodo "caido" estará disponible tan pronto se
resuelvan los motivos de su baja: configuración no válida.
```bash
ReturnToService=1
```

**SlurmctldPidFile**
Fichero con el que trabaja el demonio `slurmtld` para escribir su id de proceso.
```bash
SlurmctldPidFile=/var/run/slurmctld.pid
```

**SlurmctldPort**
Número de puerto que el controlador de Slurm `slurmctld` escucha para trabajar.
```bash
SlurmctldPort=6817
```

**SlurmdPidFile**
Fichero con el que trabaja el demonio `slurmd` para escribir su id de proceso.
```bash
SlurmdPidFile=/var/run/slurmd.pid
```

**SlurmdPort**
Número de puerto que el controlador de Slurm `slurmd` escucha para trabajar.
```bash
SlurmdPort=6817
```

**SlurmdSpoolDir**
Directorio empleado por `slurmd` para escribir los ficheros y scripts empleados en la gestión de cada trabajo job.
```bash
SlurmdSpoolDir=/var/lib/slurm/slurmd
```

**SlurmUser**
El usuario que el demonio `slurmctld` va a emplear para ejecutar sus tareas.
Aunque el valor por defecto sea `root`, por seguridad se recomienda crear un
usuario específico distinto.
```bash
SlurmUser=slurm
```

**StateSaveLocation**
Directorio en el que el demonio `slurmctld` va a guardar los detalles de su
estado en caso de tener que recuperar su funcionalidad después de un fallo de
sistema.
```bash
StateSaveLocation=/var/lib/slurm/slurmctld
```

**SwitchType**
Tipo de interconexión usada para la comunicación de aplicaciones. Lo más común
es que no haga falta especificar nada a no ser que se estén empleando
infraestructuras muy específicas como sistemas Cray o HPE Slingshot.
```bash
SwitchType=switch/none
```

**TaskPlugin**
Gestor de tareas o jobs en su relación con el hardware en el que corren. Las
opciones `task/affinity` y `task/cgroup` permiten fijar un proceso a ciertos
procesadores o recursos de memoria. La opción `task/none` no incluye ninguna de
estas opciones, puede ser conveniente si los usuarios no requieren ninguna de
estas gestiones específicas.
```bash
TaskPlugin=task/none
```

## Sección del temporizador

**InactiveLimite**
Periodo de tiempo en segundos después del cual un job que no responde es suspendido.
```bash
InactiveLimit=0
```

**KillWait**
Periodo de tiempo en segundos de espera para interrumpir un proceso que ha alcanzado su tiempo límite.
```bash
KillWait=30
```

**MinJobAge**
Periodo de tiempo en segundos que `slrumctld` mantiene la información de un job en memoria después de que haya sido completado.
```bash
MinJobAge=300
```

**SlurmctldTimeout**
Periodo de tiempo en segundos que el controlador de respaldo espera antes de asumir el control en caso de que el controlador primario falle.
```bash
SlurmctldTimeout=120
```

**SlurmdTimeout**
Periodo de tiempo en segundos que el controlador de Slurm espera a que el
demonio `slurmd` de un cierto nodo responda antes de declararlo "caido" en caso
de que haya sufrido algún problema.
```bash
SlurmdTimeout=300
```

**WaitTime**
Periodo de tiempo en segundos máximo de espera de un job submitido en cola por
defecto. El valor '0' desactiva la posibilidad de fijar un tiempo por defecto
para todo job. El usuario, incluyendo `--wait` en el comando `srun`
sobre-escribe este parámetro.
```bash
WaitTime=0
```

## Sección de planeación

**SchedulerType**
Tipo de planeador o programador usado por defecto. La opción 'sched/backfill'
es la opción por defecto, este planeador iniciará jobs con prioridad baja en el
caso de que el tiempo de inicio de los de más alta prioridad no se vea
alterado.
```bash
SchedulerType=sched/backfill
```

**SelectType**
Tipo de algoritmo usado para seleccionar los recursos usados por un job. La
opción `select/cons_tres` habilita la posibilidad de ocupar recursos dentro de
un nodo sin ocupar todo el nodo. Esta es la opción por defecto.
```bash
SelectType=select/cons_tres
```

**SelectTypeParameters**
En el caso de que `SelectType=select/cons_tres`, este valor nos describe qué
tipo de recursos pueden ser consumibles o asignados en un nodo. Por ejemplo
`CR_CPU_Memory` permite asignar una cantidad de cpus (nucleos y hiperhilos
según la configuración del nodo) y la memoria. El valor `CR_Core` nos permite
fijar los nucleos como recursos consumibles o asignables.
```bash
SelectTypeParameters=CR_Core
```

## Registro y contabilidad

**AccountingStorageType**
El almacenamiento de la contabilidad puede ser escrito en la base de datos de
Slurm (MySQL) en el caso de que esta variable tome el valor
'accounting_storage/slurmdb'. En caso de tomar el valor
'accounting_storage/none' ninguna contabilidad será almacenada.
```bash
AccountingStorageType=accounting_storage/none
```

**JobCompType**
Tipo de mecanismo de reporte (logging) para los jobs terminados. En el caso de
tomar el valor 'jobcomp/none' ningún registro será preservado despues del
término de cualquier job.
```bash
JobCompType=jobcomp/none
```

**JobAcctGatherFrequency**
Periodo de tiempo en segundos entre consultas a un job para recabar información de registro y contabilidad.
```bash
JobAcctGatherFrequency=30
```

**JobAcctGatherType**
Tipo de recogida de datos de contabilidad para cada job. En el caso de que tome
el valor 'jobacct_gather/none' ningún dato es recabado.
```bash
JobAcctGatherType=jobacct_gather/none
```

**SlurmctldDebug**
Nivel de detalle del log del demonio slurmctld.
```bash
SlurmctldDebug=info
```

**SlurmctldLogFile**
Fichero en el que se escribe el log del demonio slurmctld.
```bash
SlurmctldLogFile=/var/log/slurm/slurmctld.log
```

**SlurmdDebug**
Nivel de detalle del log del demonio slurmd.
```bash
SlurmdDebug=info
```

**SlurmdLogFile**
Fichero en el que se escribe el log del demonio slurmd.
```bash
SlurmdLogFile=/var/log/slurm/slurmd.log
```

## Sección de soporte para gpus

**GresTypes**
Lista de recursos genéricos, separados por coma.
```bash
GresTypes=gpu
```

## Sección de nodos del cluster

**NodeName**
Nombre que usa Slurm para referirse a un nodo.
```bash
NodeName=fibonacci01
```

**CPUs**
Número de procesadores lógicos
```bash
CPUs=12
```

**RealMemory**
Tamaño de la memoria en el nodo en megabytes
```bash
RealMemory=30517
```

**State**
Estado inicial del nodo para recibir trabajos. En el caso de que el parámetro
tome el valor 'UNKNOWN', este estado es consultado al inicio por el demonio
slurmd.
```bash
State=UNKNOWN
```

**NodeAddr**
Nombre de host o dirección IP del nodo descrito en su participación en el cluster gestionado por Slurm.
```bash
NodeAddr=192.168.0.100
```

**Sockets**
Número de sockets físicos (chips) en el nodo.
```bash
Sockets=2
```

**CoresPerSocket**
Número de núcleos por cada sockets físicos en el nodo.
```bash
CoresPerSocket=10
```

**ThreadsPerCore**
Número de hilos por núcleo en el nodo. Sólo tomará valor distinto a 1 si el hyperthreading está activado.
```bash
ThreadsPerCore=1
```

**Gres**
Descripción de los recursos genéricos en el nodo. En el caso por ejemplo de
tener 4 gpus etiquetados en el fichero de configuración 'gres.conf' como
'GTX1080Ti':
```bash
Gres=gpu:GTX1080Ti:4
```

## Sección de particiones

**NodeName**
Nombre que usa Slurm para referirse a un cola o partición.
```bash
PartitionName=priority
```

**Nodes**
Lista de los nombres de los nodos que participan en la partición o cola.
```bash
Nodes=node01,node02
```

**Default**
Toma el valor 'YES' or 'NO' según si la partición o cola es la usada por defecto.
```bash
Default=YES
```

**MaxTime**
Tiempo límite para los jobs ejecutados en la partición. El formato es:
"dias-horas:minutos:segundos". El valor "INFINITE" se emplea cuando no se
limita el tiempo de los jobs.
```bash
MaxTime=2:00:00
```

**State**
Estado de la partición que describe su capacidad de recibir jobs. En el
caso de tomar el valor "UP", la partición acepta jobs para ser almacenados en
cola y ejecutados.
```bash
State=UP
```

**PriorityJobFactor**
Factor de prioridad de un job usado para calcular su posición en la cola y su
momento de ser ejecutado. Su valor es un entero mayor que 0 que no puede
exceder el valor 65533.
```bash
PriorityJobFactor=10000
```

**PriorityTier**
Jobs enviados a una partición con PriorityTier más alto serán evaluados con
mayor prioridad que aquellos que fueron enviados a una cola de PriorityTier más
bajo. Su valor es un entero mayor que 0 que no puede exceder el valor 65533
```bash
PriorityJobFactor=60000
```

**AllowGroups**
Grupos de usuarios del sistema operativo linux que tienen permitido el envío de
jobs a la partición. En el caso de no estar descrito este parámetro para la
partición, cualquier usuario puede hacer uso de ella.
```bash
AllowGroups=lab_vips
```



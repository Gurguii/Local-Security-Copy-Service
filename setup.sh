#!/bin/bash
if [[ $EUID != 0 ]]; then
  printf "Por favor ejecuta el script con permisos de administrador\n"
  printf "sudo bash %s\n" $0
  exit 0
fi
if [[ ! $(command -v rsync) ]]; then
  printf "No tienes rsync instalado\nsudo apt install rsync"
fi
printf "~ Ronda de preguntas ~\n"
while true; do
  read -p "Nombre del servicio: " nombreServicio
  if [[ -e /etc/systemd/system/$nombreServicio.service ]]; then
    printf "Ya existe un servicio llamado %s\n" $nombreServicio
    continue
  else
    break
  fi
done
read -p "Ruta a copiar: " rutaCopia
if [[ ! -e $rutaCopia || ! -d $rutaCopia ]]; then
  mkdir $rutaCopia
fi
read -p "Ruta de copia: " rutaBackup
if [[ ! -e $rutaBackup || ! -d $rutaBackup ]]; then
  mkdir $rutaBackup
fi
read -p "Ruta para guardar los scripts: " rutaScripts
if [[ ! -e $rutaScripts || ! -d $rutaScripts ]]; then
  mkdir $rutaScripts
fi
while true; do
  read -p "Tiempo entre copias(minutos): " tiempo
  if (( $tiempo <= 0 )); then
    printf "El tiempo ha de ser positivo y 1 como minimo\n"
    continue
  else
    break
  fi
done
if [[ ${rutaScripts:(-1)} == "/" ]]; then
  rutaScripts=${rutaScripts:0:$((${#rutaScripts}-1))}
fi
if [[ ${rutaCopia:(-1)} == "/" ]]; then
  rutaCopia=${rutaCopia:0:$((${#rutaCopia}-1))}
fi
if [[ ${rutaBackup:(-1)} == "/" ]]; then
  rutaBackup=${rutaBackup:0:$((${#rutaBackup}-1))}
fi
#CREAR DIRECTORIO Y FICHERO 'LOGS'
if [[ -e logs_Servicios && -d logs_Servicios ]]; then
  touch logs_Servicios/servicio_$nombreServicio.txt
else
  mkdir logs_Servicios
  touch logs_Servicios/servicio_$nombreServicio.txt
fi
#CREAR DIRECTORIO Y FICHERO 'ELIMINAR SERVICIOS'
if [[ -e eliminar_Servicios && -d eliminar_Servicios ]]; then
  touch eliminar_Servicios/eliminar_$nombreServicio.sh
else
  mkdir eliminar_Servicios
  touch eliminar_Servicios/eliminar_$nombreServicio.sh
fi
#CREAR SCRIPT INICIO
cat script_inicio.sh | sed "0,/copiar/s||$rutaCopia|" | sed "/pegar/s||$rutaBackup/|" | sed "0,/tiempo/s||$(($tiempo*60))|" | sed "/rutaLogs/s||$(pwd)/logs_Servicios/servicio_$nombreServicio.txt|" >> $rutaScripts/inicio_servicio_$nombreServicio.sh
sudo chmod +x $rutaScripts/inicio_servicio_$nombreServicio.sh
#CREAR SCRIPT ELIMINAR SERVICIO
cat eliminar_servicio.sh | sed "0,/scripts/s||$rutaScripts/inicio_servicio_$nombreServicio.sh|" | sed "0,/nombre/s||$nombreServicio|" | sed "0,/logs/s||$(pwd)/logs_Servicios/servicio_$nombreServicio.txt|" >> $(pwd)/eliminar_Servicios/eliminar_$nombreServicio.sh
echo "[!] Scripts de inicio y fin creados"
#CREAR SERVICIO
cat servicio.txt | sed "0,/inicioScript/s||$rutaScripts/inicio_servicio_$nombreServicio.sh|" | sed "0,/finScript/s||$rutaScripts/fin_servicio_$nombreServicio|" >> /etc/systemd/system/$nombreServicio.service
echo "[!] Servicio creado"
sudo systemctl daemon-reload
echo 'Todo listo :)'

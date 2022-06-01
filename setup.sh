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
  printf "La ruta %s no existe" $rutaCopia
  read -p "¿Crear? s/n: " rsp
  if [[ ${rsp,,} == "s" || ${rsp,,} == "si" ]]; then
    mkdir -p $rutaCopia && printf "[!] Ruta creada\n"
  else
    printf "Saliendo..."
    exit 0
  fi
fi
read -p "Ruta de copia: " rutaBackup
if [[ ! -e $rutaBackup || ! -d $rutaBackup ]]; then
  printf "La ruta %s no existe" $rutaCopia
  read -p "¿Crear? s/n: " rsp
  if [[ ${rsp,,} == "s" || ${rsp,,} == "si" ]]; then
    mkdir -p $rutaBackup && printf "[!] Ruta creada\n"
  else
    printf "Saliendo..."
    exit 0
  fi
fi
if [[ ! -e scripts_servicios || ! -d scripts_servicios ]]; then
  mkdir $(pwd)/scripts_servicios
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
while true; do
  read -p "Numero maximo de logs: " maxLogs
  if (( $maxLogs <= 0 )); then
    printf "Tiene que haber al menos 1 fichero de cambios"
    continue
  else
    break
  fi
done

if [[ ${rutaCopia:(-1)} == "/" ]]; then
  rutaCopia=${rutaCopia:0:$((${#rutaCopia}-1))}
fi
if [[ ${rutaBackup:(-1)} == "/" ]]; then
  rutaBackup=${rutaBackup:0:$((${#rutaBackup}-1))}
fi

#CREAR DIRECTORIO Y FICHERO 'LOGS'
if [[ -e logs_Servicios && -d logs_Servicios ]]; then
  mkdir logs_Servicios/servicio_$nombreServicio
else
  mkdir logs_Servicios
  mkdir logs_Servicios/servicio_$nombreServicio
fi
#CREAR DIRECTORIO Y FICHERO 'ELIMINAR SERVICIOS'
if [[ -e eliminar_Servicios && -d eliminar_Servicios ]]; then
  touch eliminar_Servicios/eliminar_$nombreServicio.sh
else
  mkdir eliminar_Servicios
  touch eliminar_Servicios/eliminar_$nombreServicio.sh
fi

#CREAR SCRIPT INICIO
cat script_inicio.sh | sed "/copiar/s||$rutaCopia|" | sed "/pegar/s||$rutaBackup/|" | sed "/tiempo/s||$(($tiempo*60))|" | sed "/rutaLogs/s||$(pwd)/logs_Servicios/servicio_$nombreServicio|" | sed "0,/maxLogs/s||$maxLogs|" >> $(pwd)/scripts_servicios/script_$nombreServicio.sh
sudo chmod u+x $(pwd)/scripts_servicios/script_$nombreServicio.sh

#CREAR SCRIPT ELIMINAR SERVICIO
cat eliminar_servicio.sh | sed "0,/scripts/s||$(pwd)/scripts_servicios/script_$nombreServicio.sh|" | sed "0,/nombre/s||$nombreServicio|" | sed "0,/logs/s||$(pwd)/logs_Servicios/servicio_$nombreServicio|" >> $(pwd)/eliminar_Servicios/eliminar_$nombreServicio.sh
echo "[!] Scripts de inicio y fin creados"

#CREAR SERVICIO
cat servicio.txt | sed "0,/inicioScript/s||$(pwd)/scripts_servicios/script_$nombreServicio.sh|" >> /etc/systemd/system/$nombreServicio.service
echo "[!] Servicio creado"
sudo systemctl daemon-reload

#FIN
echo 'Todo listo :)'

#!/bin/bash
clear
if [[ $EUID != 0 ]]; then
  printf "Por favor ejecuta el script con permisos de administrador\n"
  printf "sudo bash %s\n" $0
  exit 0
fi
echo "~ Ronda de preguntas ~"
read -p "Nombre del servicio: " nombreServicio
read -p "Ruta a copiar: " rutaCopia
read -p "Ruta de copia: " rutaBackup
read -p "Ruta para scripts de inicio/fin: " rutaScripts
read -p "Intervalo de tiempo entre backups(minutos): " tiempo

if [[ ${rutaScripts:(-1)} == "/" ]]; then
  rutaScripts=${rutaScripts:0:$((${#rutaScripts}-1))}
fi
if [[ ${rutaCopia:(-1)} == "/" ]]; then
  rutaCopia=${rutaCopia:0:$((${#rutaCopia}-1))}
fi
if [[ ${rutaBackup:(-1)} == "/" ]]; then
  rutaBackup=${rutaBackup:0:$((${#rutaBackup}-1))}
fi
#CREAR DIRECTORIO Y FICHERO CAMBIOS
if [[ -e cambios && -d cambios ]]; then
  touch cambios/servicio_$nombreServicio.txt
else
  mkdir cambios
  touch cambios/servicio_$nombreServicio.txt
fi
#CREAR SCRIPT INICIO
cat script_inicio.sh | sed "0,/copiar/s||$rutaCopia/*|" | sed "0,/pegar/s||$rutaBackup/|" | sed "0,/tiempo/s||$(($tiempo*60))|" | sed "0,/borrar/s||$rutaBackup/*|" | sed "0,/borrarCambios/s||$(pwd)/cambios/servicio_$nombreServicio.txt|" | sed "0,/pegarCambios/s||$(pwd)/cambios/servicio_$nombreServicio.txt|" >> $rutaScripts/inicio_servicio_$nombreServicio
#CREAR SCRIPT FIN
cat script_fin.sh >> $rutaScripts/fin_servicio_$nombreServicio
echo "[!] Scripts de inicio y fin creados"
#CREAR SERVICIO
cat servicio.txt | sed "0,/inicioScript/s||$rutaScripts/inicio_servicio_$nombreServicio|" | sed "0,/finScript/s||$rutaScripts/fin_servicio_$nombreServicio|" >> /etc/systemd/system/$nombreServicio.service
#CREAR SCRIPT DE ELIMINACION DE SERVICIO
cat eliminar_servicio.sh | sed "0,/scripts/s||$rutaScripts|" | sed "0,/servicio/s||$nombreServicio.service|" >> eliminar_servicio_$nombreServicio.sh
sudo systemctl daemon-reload
echo "Todo listo :)"

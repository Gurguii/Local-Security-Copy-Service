#!/bin/bash
if [[ $EUID != 0 ]]; then
  printf "[!] Please execute the script with sudo privileges\n"
  printf "sudo bash %s\n" "$0"
  exit 0
fi
if [[ ! $(command -v rsync) ]]; then
  printf "[!] Seems like you don't have rsync installed\nsudo apt install rsync"
fi
printf "     ~ Info ~\n"
while true; do
  printf "Service name: "
  read -r nombreServicio
  if [[ -e /etc/systemd/system/$nombreServicio.service ]]; then
    printf "[!] There is a service called %s already\n" "$nombreServicio"
    continue
  else
    break
  fi
done
print "Path to copy: "
read -r rutaCopia
if [[ ! -e $rutaCopia || ! -d $rutaCopia ]]; then
  printf "[!] Path %s does not exist\nCreate y/n: " "$rutaCopia"
  read -r rsp
  if [[ ${rsp,,} == "y" || ${rsp,,} == "yes" ]]; then
    mkdir -p "$rutaCopia" && printf "[!] Path created\n"
  else
    printf "Exiting..."
    exit 0
  fi
fi
printf "Path to save the copy: "
read -r rutaBackup
if [[ ! -e $rutaBackup || ! -d $rutaBackup ]]; then
  printf "[!] Path %s does not exist\nCreate y/n: " "$rutaCopia"
  read -r rsp
  if [[ ${rsp,,} == "y" || ${rsp,,} == "yes" ]]; then
    mkdir -p "$rutaBackup" && printf "[!] Path created\n"
  else
    printf "Exiting..."
    exit 0
  fi
fi
if [[ ! -e .servicesScripts || ! -d .servicesScripts ]]; then
  mkdir "$(pwd)/.servicesScripts"
fi
while true; do
  printf "Time between copies(minutes):"
  read -r tiempo
  if (( tiempo <= 0 )); then
    printf "[!] Time must be 1 or higher\n"
    continue
  else
    break
  fi
done
while true; do
  printf "Max logs: "
  read -r maxLogs
  if (( maxLogs <= 0 )); then
    printf "[!] There must be at least 1 log file"
    continue
  else
    break
  fi
done
scriptPath=$(pwd)/.servicesScripts/$nombreServicio.sh
if [[ ${rutaCopia:(-1)} == "/" ]]; then
  rutaCopia=${rutaCopia:0:$((${#rutaCopia}-1))}
fi
if [[ ${rutaBackup:(-1)} == "/" ]]; then
  rutaBackup=${rutaBackup:0:$((${#rutaBackup}-1))}
fi

if [[ -e servicesLogs && -d servicesLogs ]]; then
  mkdir servicesLogs/"$nombreServicio".log
else
  mkdir servicesLogs
  mkdir servicesLogs/"$nombreServicio".log
fi

if [[ -e deleteServices && -d deleteServices ]]; then
  touch deleteServices/"$nombreServicio".sh
else
  mkdir deleteServices
  touch deleteServices/"$nombreServicio".sh
fi

# Create service script
cat .service_script.sh | sed "/copiar/s||$rutaCopia|" | sed "/pegar/s||$rutaBackup/|" | sed "/tiempo/s||$((tiempo*60))|" | sed "/rutaLogs/s||$(pwd)/servicesLogs/$nombreServicio.log|" | sed "0,/maxLogs/s||$maxLogs|" >> "$scriptPath"
sudo chmod u+x "$scriptPath"

# Create delete_service script
cat .delete_service.sh | sed "0,/scripts/s||$scriptPath|" | sed "0,/nombre/s||$nombreServicio|" | sed "0,/logs/s||$(pwd)/servicesLogs/$nombreServicio.log|" >> "$(pwd)/deleteServices/$nombreServicio.sh"
echo "[!] Service script created"

# Create service file
cat .service.info | sed "0,/inicioScript/s||$scriptPath|" >> /etc/systemd/system/"$nombreServicio".service
echo "[!] Service created"
sudo systemctl daemon-reload
echo "[!] Systemd manager configuration reloaded"
echo 'DONE'

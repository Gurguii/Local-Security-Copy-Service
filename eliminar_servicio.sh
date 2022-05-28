#!/bin/bash
if [[ $EUID != 0 ]]; then
  printf "Necesito que me ejecutes con permisos de administrador\nsudo bash %s\n" $0
  exit 0
fi
read -p "Estas segur@? s/n : " check
if [[ $check == "s" || $check == "S" ]]; then
  rm -r -f scripts && rm -f /etc/systemd/system/nombre.service && rm -f logs && echo "Servicio eliminado :)" && rm $0
else
  exit 0
fi

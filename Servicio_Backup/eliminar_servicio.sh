#!/bin/bash
if [[ $EUID != 0 ]]; then
  echo "Necesito que me ejecutes con permisos de administrador"
  echo "sudo bash $0"
  exit 0
fi
rm -r -f scripts && rm -f /etc/systemd/system/servicio && echo "Servicio eliminado :)" && rm $0
echo "Hubo algun problema borrandoa algo"
exit 0

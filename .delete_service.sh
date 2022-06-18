#!/bin/bash
if [[ $EUID != 0 ]]; then
  printf "I need to be executed with sudo privileges\nsudo bash %s\n" $0
  exit 0
fi
read -p "[!] Sure y/n: " check
if [[ ${check,,} == "y" || ${check,,} == "yes" ]]; then
  rm -r -f scripts && rm -f /etc/systemd/system/nombre.service && rm -r -f logs && echo "[!] Service successfuly deleted" && rm $0
else
  exit 0
fi

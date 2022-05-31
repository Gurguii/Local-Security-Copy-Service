#!/bin/bash
max=maxLogs
contador=0
while true; do
  if (( $contador == $max )); then
    ultimoFichero=$(ls -lt rutaLogs | tail -1 | awk '{print $9}')
    rm -f rutaLogs/$ultimoFichero
    rsync -zvhr copiar pegar >> rutaLogs/"$(date | tr " " "_")"
    sleep tiempo
  else
    rsync -zvhr copiar pegar >> rutaLogs/"$(date | tr " " "_")"
    let contador+=1
    sleep tiempo
  fi
done

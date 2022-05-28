#!/bin/bash
while true; do
  echo $(date) >> rutaLogs
  rsync -zvhr copiar pegar >> rutaLogs
  sleep tiempo
done

#!/bin/bash

#Pruébate 1/3
#Script que recorre cada uno de los parámetros dados en la línea de comandos
#y para cada parámetro busque un archivo con ese nombre
#en el directorio actual y despliegue su tamaño.

for archivo in "$@"; do
	if [[ -f "$archivo" ]]; then
		tamano=$(stat -c %s "$archivo") 
		echo "El archivo $archivo se encuentra en el directorio actual"
		echo "Tamaño del archivo: $tamano bytes"
		echo
	else
		echo "$archivo no se encuentra en este directorio"
	fi

done

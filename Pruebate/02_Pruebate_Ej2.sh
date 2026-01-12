#!/bin/bash


#Un script que recorra cada uno de los parámetros dados en la línea de comandos,
#y para cada parámetro busque un archivo con ese nombre en el directorio actual
#y despliegue su tamaño


if [[ $# -eq 0 ]]; then
	echo "Bienvenido: Este programa te permite conocer el tamaño de los archivos en el directorio actual"
	echo "Ingresa el nombre de los archivos que buscas: $0 archivo01.extensión archivo02.extensión ....."
	exit 1
fi


for archivo in "$@"; do

	if [[ -f "$archivo" ]]; then
		tamano=$(stat -c %s "$archivo")
		echo "Afirmativo: el $archivo se encuentra en el directorio actual"
		echo "Directorio: $PWD"
		echo "Tamaño del archivo: $tamano bytes"
		echo
	else
	echo "$archivo no encontrado; no es un archivo válido en el directorio actual"
	fi

done


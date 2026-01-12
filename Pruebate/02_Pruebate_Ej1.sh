#!/bin/bash

#Un script que continuamente pregunte por información en la consola
#y al recibir el valor, busque un archivo con el nombre definido,
#si existe haga un respaldo, y si no existe, despliegue un mensaje de error.

while true; do
	
	echo "*--Bienvenido al buscador de archivos--*"
	echo "**-Escribe el nombre del archivo o digita la palabra EXIT para terminar-**"
	echo -n "No olvides colocar la extensión de tu archivo: "
	read archivo

	[[ "$archivo" == "EXIT" ]] && break #Palabra clave para salir del ejecutable

	if [[ -f "$archivo" ]]; then
		backup="${archivo}.bak"
		cp "$archivo" "$backup"
		echo "Acabas de crear un respaldo: $backup"
	else
		echo "ERROR: $archivo no encontrado"
		echo "Ingresa el nombre de un archivo válido"
	fi

	echo

done

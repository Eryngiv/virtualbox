#!/bin/bash

#Un script que pregunte continuamente por números, hasta que se introduzca un número múltiplo de 7.


while true; do
	

	echo -n "Introduce un número o digita la palabra EXIT para salir del programa: "
	read numero
	
	[[ "$numero" == EXIT ]] && break

	if (( numero % 7 == 0 )); then
		echo "Afirmativo: el $numero es múltiplo de 7"
		break
	else
		echo "Negativo: el $numero NO es múltiplo de 7"

	fi

done


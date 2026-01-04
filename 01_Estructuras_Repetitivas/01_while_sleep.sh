#!/bin/bash

while :
do
	humedad=$(cat sensor.txt)

	if [[ $humedad -lt 30 ]]; then
		echo "Activa riego"

	else 
		echo "Huedad adecuada ($humedad%)"
		echo "Condición adecuada de humedad."
		break

	fi


	if [[ $i -ge $max ]]; then
		echo "Límite máximo de riego alcanzado."
		break
	fi

	((i++))
	sleep 60
done

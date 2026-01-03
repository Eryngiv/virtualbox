#!/bin/bash

superficie=$1

if [[ -z $superficie ]]; then
	echo "Uso: ./02_CondicionalNUM.sh"
	exit 1
fi

if [[ $superficie -lt 5 ]]; then
	echo "Superficie pequeña ($superficie ha)"
elif [[ $superficie -ge 5 && $superficie -lt 20 ]]; then
	echo "Superficie mediana ($superficie ha)"
else
	echo "Superficie grande ($superficie ha)"
fi


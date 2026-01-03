#!/bin/bash

valor=$1

if [[ $valor -lt 10 ]]; then
	echo "El valor $valor es menor que 10"
else
	echo "El valor $valor es mayor o igual a 10"
fi


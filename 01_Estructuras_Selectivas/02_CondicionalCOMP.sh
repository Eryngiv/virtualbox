#!/bin/bash

valor1=$1
valor2=$2

if [[ $valor1 = $valor2 ]]
then
	echo "$valor1 es igual a $valor2"
else 
	echo "$valor1 es diferente a $valor2"

fi
echo "Fin del programa"



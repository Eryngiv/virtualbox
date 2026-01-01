#!/bin/bash

#Descripción: Este programa admite dos números que pasan como parámetros # y, después, realiza todas las operaciones aritméticas que puede realizar bash.


num1=$1
num2=$2

echo "La suma de $num1 y $num2 es $((num1+num2))" #El doble paréntesis significa (()) - bloque matemático

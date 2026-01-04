#!/bin/bash

limite=$1
i=0

while [[ $i -le $limite ]]
do
	echo "El número es $i"
	i=$((i+1))
done

#!/bin/bash

nombre=$1
nacimiento=$2
anio_actual=$(date +%Y)

edad=$((anio_actual - nacimiento))

echo "Hola $nombre 🌱"
echo "Tienes $edad años"



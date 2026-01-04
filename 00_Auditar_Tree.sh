#!/bin/bash

#Auditor simple de archivos/carpetas y permisos en ~/virtualbox


base="${1:-$PWD}"

#Test de string: -z / -n
if [[ -z "$base" ]]; then
	echo "Error: base está vacío (esto no debería pasar)."
	exit 1
fi

if [[ -n "$base" ]]; then
	echo "Auditando: $base"
fi

#Test  de existencia de ruta: -e
if [[ ! -e "$base" ]]; then
	echo "No existe la ruta: $base"
	exit 2
fi

#Test de directorio:  -d
if [[ ! -d "$base" ]]; then
	echo "La ruta existe, pero NO es directoro: $base"
	exit 3
fi

echo
echo "== Permisos sobre el directorio base =="
[[ -r "$base" ]] && echo "Lectura (-r)" || echo "Sin lectura (-r)"
[[ -w "$base" ]] && echo "Escritura (-w)" || echo "Sin escritura (-w)"
[[ -x "$base" ]] && echo "Ejecución/entrada (-x)" || echo "Sin ejecución/entrada (-x)"

echo
echo "== Conteos =="
# Comparadores numéricos usando (( ... ))
archivos=0
dirs=0
ejecutables=0
no_vacios=0

#Recorremos todo (sin meternos en .git) de forma segura con NUL

while IFS= read -r -d '' item; do
	# -d / -f
	if [[ -d "$item" ]]; then
	((dirs++))
	elif [[ -f "$item" ]]; then
	((archivos++))
	fi

	# -x (ejecutable)
	[[ -x "$item" ]] && ((ejecutables++))

	# -s (existe y NO está vacío)
	[[ -s "$item" ]] && ((no_vacios++))

done < <(find "$base" -path "$base/.git" -prune -o -print0)

echo "Directorios: $dirs"
echo "Archivos: $archivos"
echo "Ejecutables: $ejecutables"
echo "No vacíos: $no_vacios"

echo
echo "== Reglas rápidas (comparadores numéricos) =="

if [[ archivos -eq 0 ]]; then
	echo "No hay archivos."
elif [[ archivos -lt 10 ]]; then
	echo "Pocos archivos (<10)."
elif [[ archivos -ge 10 && archivos -lt 100 ]]; then
	echo "Cantidad media (10-99)."
else
	echo "Cantidad extensa de archivos (>=100)."
fi


echo
echo "== Muestra de scripts .sh y su estado =="

sh_count=0
while IFS= read -r -d '' sh; do
	((sh_count++))
	echo "--- $sh"
	[[ -e "$sh" ]] && echo "Existe (-e)" || echo "No existe (-e)"
	[[ -f "$sh" ]] && echo "Es archivo (-f)" || echo "No es archivo (-f)"
	[[ -s "$sh" ]] && echo "No vacío (-s)" || echo "Vacío (-s)"
	[[ -r "$sh" ]] && echo "Legible (-r)" || echo "No legible (-r)"
	[[ -w "$sh" ]] && echo "Escribible (-w)" || echo "No escribible (-w)"
	[[ -x "$sh" ]] && echo "Ejecutable (-x)" || echo "No ejecutable (-x)"

done < <(find "$base" -path "$base/.git" -prune -o -name "*.sh" -type f -print0)

# -z / -n aplicado al conteo
echo
if (( sh_count -le 0 )); then
	echo "No encontré scritps .sh en $base"
else 
	echo "Scripts .sh encontrados: $sh_count"
fi

echo
echo "Auditoría terminada."

fecha=$(date "+%Y-%m-%d %H:%M:%S")
echo "Fecha de auditoría: $fecha"





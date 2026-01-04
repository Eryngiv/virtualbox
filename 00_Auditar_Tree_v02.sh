#!/bin/bash
# Auditor simple de archivos/carpetas y permisos en ~/virtualbox

base="${1:-$PWD}"

# Test de string: -z / -n
if [[ -z "$base" ]]; then
  echo "Error: base está vacío (esto no debería pasar)."
  exit 1
fi

echo "Auditando: $base"

# Test de existencia de ruta: -e
if [[ ! -e "$base" ]]; then
  echo "No existe la ruta: $base"
  exit 2
fi

# Test de directorio: -d
if [[ ! -d "$base" ]]; then
  echo "La ruta existe, pero NO es directorio: $base"
  exit 3
fi

echo
echo "== Permisos sobre el directorio base =="
[[ -r "$base" ]] && echo "Lectura (-r)" || echo "Sin lectura (-r)"
[[ -w "$base" ]] && echo "Escritura (-w)" || echo "Sin escritura (-w)"
[[ -x "$base" ]] && echo "Ejecución/entrada (-x)" || echo "Sin ejecución/entrada (-x)"

echo
echo "== Conteos =="

archivos=0
dirs=0
ejecutables=0
no_vacios=0

# Recorremos todo (sin meternos en .git) de forma segura con NUL
while IFS= read -r -d '' item; do
  if [[ -d "$item" ]]; then
    ((dirs++))
  elif [[ -f "$item" ]]; then
    ((archivos++))
  fi

  [[ -x "$item" ]] && ((ejecutables++))
  [[ -s "$item" ]] && ((no_vacios++))
done < <(find "$base" -path "$base/.git" -prune -o -print0)

echo "Directorios: $dirs"
echo "Archivos: $archivos"
echo "Ejecutables: $ejecutables"
echo "No vacíos: $no_vacios"

echo
echo "== Reglas rápidas (comparadores numéricos) =="

if (( archivos == 0 )); then
  echo "No hay archivos."
elif (( archivos < 10 )); then
  echo "Pocos archivos (<10)."
elif (( archivos >= 10 && archivos < 100 )); then
  echo "Cantidad media (10-99)."
else
  echo "Cantidad extensa de archivos (>=100)."
fi

echo
echo "== Muestra de scripts .sh y su estado =="

check() {
  local flag="$1" path="$2" ok="$3" no="$4"
  if test "$flag" "$path"; then
    echo "✅ $ok"
  else
    echo "❌ $no"
  fi
}

sh_count=0
while IFS= read -r -d '' sh; do
  ((sh_count++))
  echo "--- $sh"

  check -e "$sh" "Existe (-e)"        "No existe (-e)"
  check -f "$sh" "Es archivo (-f)"    "No es archivo (-f)"
  check -s "$sh" "No vacío (-s)"      "Vacío (-s)"
  check -r "$sh" "Legible (-r)"       "No legible (-r)"
  check -w "$sh" "Escribible (-w)"    "No escribible (-w)"
  check -x "$sh" "Ejecutable (-x)"    "No ejecutable (-x)"

  echo
done < <(find "$base" -path "$base/.git" -prune -o -name "*.sh" -type f -print0)

echo
if (( sh_count <= 0 )); then
  echo "No encontré scripts .sh en $base"
else
  echo "Scripts .sh encontrados: $sh_count"
fi

echo
echo "Auditoría terminada."

fecha=$(date "+%Y-%m-%d %H:%M:%S")
echo "Fecha de auditoría: $fecha"

#!/bin/bash

# Uso: ./03_Riego_Niveles.sh <humedad_pct> humedad porcentual

# Ejemplo: ./03_Riego_Niveles.sh 62

humedad=$1

# Validación básica de ingreso de valor 
if [[ -z "$humedad" ]]; then
  echo "Uso: $0 <humedad_pct (0-100)>" 
  exit 1
fi

# Verificar que sea entero (solo dígitos / recuerda que bash no computa float solo int)
if [[ ! "$humedad" =~ ^[0-9]+$ ]]; then
  echo "Error: humedad debe ser un número ENTERO (0-100)."
  exit 1
fi

# Verificar que el valor ingresado esté dentro de rango
if (( humedad < 0 || humedad > 100 )); then
  echo "Error: humedad fuera de rango. Usa un valor entre 0 y 100."
  exit 1
fi

# Umbrales (ajústalos si quieres):
# Saturación: >= 90
# Capacidad de campo: 75–89
# 75% CC: 55–74
# PMP: < 55

if (( humedad >= 90 )); then
  echo "Estado: SATURACIÓN ($humedad%)"
  echo "Acción: NO regar. Riesgo de asfixia radicular / lixiviación. Monitorear diariamente."
elif (( humedad >= 75 )); then
  echo "Estado: CAPACIDAD DE CAMPO ($humedad%)"
  echo "Acción: NO regar. Mantener monitoreo."
elif (( humedad >= 55 )); then
  echo "Estado: 75% de CAPACIDAD DE CAMPO ($humedad%)"
  echo "Acción: RIEGO LIGERO o programar riego pronto. Observar signos de alerta en follaje y raíz."
else
  echo "Estado: PUNTO DE MARCHITEZ PERMANENTE (PMP) ($humedad%)"
  echo "Acción: RIEGO URGENTE (estrés hídrico severo). Regar de forma gradual hasta llegar a CC."
fi

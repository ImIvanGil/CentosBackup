#!/bin/bash

#Autor: orion
#Fecha: mar oct 18 13:19:32 PDT 2016
#Comentario: Programa de envio de correo masivo 

if [ $# -ne 3  ]; then
	echo "Se reuiqere asunto y contenido y listado" >&2
	exit 1
fi


if [ -e $3 ]; then
	for linea in $(cat $3)
	do
		nombre=$(echo $linea | cut -d ":" -f 1)
		correo=$(echo $linea | cut -d ":" -f 2)
		echo "$nombre:\n $2" | mail -s $1 "$correo@uach.mx"
	done
else
	echo $3 no existe
	exit 1
fi
exit 0

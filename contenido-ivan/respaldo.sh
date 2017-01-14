#!/bin/bash

#Autor: orion
#Fecha: jue oct  6 15:04:08 PDT 2016
#Comentario: Script de backup mediante rsync 

if [ $# -ne 1 ] ; then
	echo "Cantidad de argumentos incorrecta">&2
	exit 1
fi

lista=$(cat $1);

for lineas in $lista; do
	host=$(echo $lineas | cut -d ":" -f 1)
	dremoto=$(echo $lineas | cut -d ":" -f 2)
	dlocal=$(echo $lineas | cut -d ":" -f 3)
	echo "$host";
	
	rsync -arze ssh  $host:$dremoto $dlocal
done

exit 0

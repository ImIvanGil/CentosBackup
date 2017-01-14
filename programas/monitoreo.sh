#!/bin/bash

#Autor: orion
#Fecha: vie oct 28 09:27:11 PDT 2016
#Comentario: script de monitoreo remoto 

if [ $# -ne 1 ]; then 
	echo " Cantidad de argumentos invalida, especifica una lista" >&2
	exit 1
fi

if [ -e $1 ]; then
	for linea in $(cat $1)
	do
		#Usuario y mail
		user=$(echo $linea | cut -d ":" -f 1)
		mail=$(echo $linea | cut -d ":" -f 2)

		#RAM
		echo "Usuario $user :"
		mem=$(ssh $user free | grep Mem)
		total=$(echo $mem | cut -d " " -f 2)
		usado=$(echo $mem | cut -d " " -f 3)
		memoriaPorcentaje=$(echo "$usado*100/$total" | bc)
		if [ $memoriaPorcentaje -lt 3 ]; then
			echo La memoria esta por terminarse
			echo "Memoria RAM por debajo del limite de $user" | mail -s "Memora RAM baja" "$mail"
		else
			echo "Memoria RAM OK"
		fi

		#DISCO
		disco=$(ssh $user df | grep root)
		use=$(echo $disco | cut -d " " -f 5 )
		used=$(echo $disco | cut -d " " -f 3 )
		available=$(echo $disco | cut -d " " -f 4 )
		porcentajeDisco=$(echo "$used*100/$available" | bc)
		if [ $porcentajeDisco -gt 80 ]; then
			echo "Espacio de disco bajo"
			echo "Memoria RAM por debajo del limite de $user" | mail -s "Espacio en disco bajo" "$mail"
		else
			echo "Memora RAM OK"
		fi

		#CPU
		procesador=$(ssh $user uptime)
                cargaAQuince=$(echo $procesador | cut -d " " -f 11)
                echo $cargaAQuince
		isCargaAlta=$(echo  "$cargaAQuince > 80" | bc)
		echo $isCargaAlta
                if [ $isCargaAlta -eq 1 ]; then
                        echo "Procesador por debajo del limite"
			echo "Memoria RAM por debajo del limite de $user" | mail -s "Alerta procesador" "$mail"
		else
			echo "Procesador OK"
                fi
                echo $cargaAQuince

	done
else
	echo "$1 no existe" >&2
	exit 1 
fi


exit 0

#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Cantidad de argumentos incorrecta">&2
	exit 1
fi



echo "#!/bin/bash" > $1
echo "" >> $1
echo "#Autor: $USER" >> $1
echo "#Fecha: $(date)" >> $1
echo "#Comentario: $2 " >> $1
echo "" >> $1
echo "" >> $1
echo "" >> $1
echo "exit0" >> $1

chmod +x $1

exit 0




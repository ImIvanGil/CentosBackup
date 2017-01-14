#/bin/bash

var1="Hola amigos"

echo  -n "Dime tu nombre"
read var2

echo "Buen dia $var2"
echo "$var1"
echo -n  "Escribe lo que tu quieras"
read var1
echo $var1

exit 0

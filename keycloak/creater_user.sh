# create random password
PASSWDDB="$(openssl rand -base64 12)"


helpFunction()
{
   echo ""
   echo "Usage: $0 -u username -d database"
   exit 1 # Exit script after printing help
}

while getopts "u:d:" opt
do
   case "$opt" in
        (u) USER_NAME="$OPTARG" ;;
        (d) MAINDB="$OPTARG" ;;
        (?) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done


#mysql -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
#mysql -e "CREATE USER ${USER_NAME}@'%' IDENTIFIED BY '${PASSWDDB}';"
#mysql -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${USER_NAME}'@'%';"
#mysql -e "FLUSH PRIVILEGES;"

echo "User : ${USER_NAME}"
echo "Senha: ${PASSWDDB}"
echo "Banco" ${MAINDB}"

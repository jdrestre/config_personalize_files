# Ejecutar Traductor en - es
alias traducir='trans -b -j :es'
alias traducires='trans -b -j :en'

# Configuración al abrir una nueva ventana de la terminal
fortune es 
# figlet jdrestre -f slant
# echo -e '\n'
figlet jdrestre -f slant | lolcat && echo -e '\n'
# bold=$(tput bold)
date +$'\033[1mHoy es: %A, %d de %B de %Y%nHora: %H:%M:%S%nSemana del año: %V%nDía del año: %j\033[0m' | lolcat

~/geek_ephemeris/dayValidator.sh

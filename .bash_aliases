# Copy to clipboard option cli
alias clipb='xclip -r -selection clip'

# Clean emacs files ~ virgulilla
function cemacs {
    rm *~
    rm .*~
}

# emacs in new windows terminal
alias emacs='emacs -nw'

# ls with asteroids inode files
alias l1='ls -laihFtr'

# Ejecutar Traductor en - es
alias traducir='trans -b -j :es'
alias traducires='trans -b -j :en'

# Configuración al abrir una nueva ventana de la terminal
fortune es 
# figlet jdrestre -f slant
# echo -e '\n'
figlet jdrestre -f slant | lolcat && echo -e '\n'
# bold=$(tput bold)
date +$'\033[1mHoy es: %A, %d de %B de %Y%nHora: %H:%M:%S%nSemana del año: %V%nDía del año: %j\033[0m'

~/.geek_ephemeris/dayValidator.sh

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


###################################################
###################################################


###################################################
# GENERAL PERSONALIZED BASH SCRIPT

# Linux update and upgrade
alias update_linux='sudo apt-get update'
alias list_upgradable='apt list --upgradable'
alias upgrade_linux='sudo apt-get upgrade'

# Edit .bashrc commands
alias bashrc_edit='emacs -nw ~/.bashrc'

# update change into bashrc file
alias bashrc_update='source ~/.bashrc'

# Copy clipboard option pbcopy on Ubuntu/Linux
alias pbcopy="xclip -sel clip"

# Change permmision files 764
function ch764 {
    if [ $# -lt 1 ]
    then
	echo "Usage: chmod764 '#n_file_name'"
    else
	chmod 764 ${*}
    fi
}

# Clean emacs files ~ virgulilla
function clean_emacs {
    rm *~
    rm .*~
}

# Edit Emacs Config .emacs
alias edit_emacs="emacs -nw ~/.emacs"
###################################################


###################################################
#DATABASE MYSQL OPTIONS
# Connect to MySQL
alias db_mysql='mysql -u root -p'
###################################################


###################################################
# CONNECTION SSH WEB SERVER HOLBERTON
# Connect web server 01
alias 1238_web_01='ssh ubuntu@34.74.80.43'

# Connect web server 02
alias 1238_web_02='ssh ubuntu@54.89.185.132'

# Connect load balancer
alias 1238_lb_01='ssh ubuntu@54.221.151.142'
###################################################


###################################################
# TRANSFER FILES WEB SERVER AND LOAD BALANCER HOLBERTON PROJECTS
# Transfers a file from our client to a server web01 Holberton web server
function transfer_file_1238_web_01 {
    if [ $# -lt 1 ]
    then
	echo "Usage: transfer_file_1238-web-01 'file_name'"
    else
	scp -o StrictHostKeyChecking=no -i ~/.ssh/holberton "$1" ubuntu@34.74.80.43:~/
    fi
}

# Transfers a file from our client to a server web02 Holberton web server
function transfer_file_1238_web_02 {
    if [ $# -lt 1 ]
    then
	echo "Usage: transfer_file_1238-web-02 'file_name'"
    else
	scp -o StrictHostKeyChecking=no -i ~/.ssh/holberton "$1" ubuntu@54.89.185.132:~/
    fi
}

# Transfers a file from our client to a server lb01 Holberton Load Balancer
function transfer_file_1238_lb_01 {
    if [ $# -lt 1 ]
    then
	echo "Usage: transfer_file_1238-lb-01 'file_name'"
    else
	scp -o StrictHostKeyChecking=no -i ~/.ssh/holberton "$1" ubuntu@54.221.151.142:~/
    fi
}
###################################################


###################################################
# DOCKER COOMMANDS OPTIONS

# Docker RUN container based from IMAGE
function docker_run_container {
    if [ $# -lt 1 ]
    then
	echo "Usage: docker_run_container IMAGE_NAME"
    else
	docker run -d -ti "$1"
    fi
}

# Docker EXECUTE container
function docker_execute_container {
    if [ $# -lt 1 ]
    then
	echo "Usage: docker_execute_container CONTAINER_ID"
    else
	docker exec -ti "$1" /bin/bash
    fi
}

# Docker COPY Local to Container
function docker_copy_local_container {
    if [ $# -lt 1 ]
    then
	echo "Usage: docker_copy_local_container 1)FILE_COPY 2)CONTAINER_ID:3)CONTAINER_PATH"
    else
	docker cp "$1" "$2":"$3"
    fi
}

# Docker COPY Container to Local
function docker_copy_container_local {
    if [ $# -lt 1 ]
    then
	echo "Usage: docker_copy_container_local 1)CONTAINER_ID:2)CONTAINER_PATH 3)NAME_FILE_LOCAL"
    else
	docker cp "$1":"$2" "$3"
    fi
}
###################################################


###################################################
# GIT COMMANDS AND SCRIPT
# Check git status of multiple repos: Source https://gist.github.com/mzabriskie/6631607
function git_status {
dir="$1"

# No directory has been provided, use current
if [ -z "$dir" ]
then
    dir="`pwd`"
fi

# Make sure directory ends with "/"
if [[ $dir != */ ]]
then
	dir="$dir/*"
else
	dir="$dir*"
fi

# Loop all sub-directories
for f in $dir
do
    # Only interested in directories
    [ -d "${f}" ] || continue

    echo -en "\033[0;35m"
    echo "${f}"
    echo -en "\033[0m"

    # Check if directory is a git repository
    if [ -d "$f/.git" ]
    then
	mod=0
	cd $f

	# Check for modified files
	if [ $(git status | grep modified -c) -ne 0 ]
	then
	    mod=1
	    echo -en "\033[0;31m"
	    echo "Modified files"
	    echo -en "\033[0m"
	fi

	# Check for untracked files
	if [ $(git status | grep Untracked -c) -ne 0 ]
	then
	    mod=1
	    echo -en "\033[0;31m"
	    echo "Untracked files"
	    echo -en "\033[0m"
	fi

	# Check if everything is peachy keen
	if [ $mod -eq 0 ]
	then
	    echo "Nothing to commit"
	fi

	cd ../
    else
	echo "Not a git repository"
    fi

    echo
done
}

# Git Pull Status verificated Repo. Source: https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git
function git_pull_status {
    git remote -v update

    UPSTREAM=${1:-'@{u}'}
    LOCAL=$(git rev-parse @)
    REMOTE=$(git rev-parse "$UPSTREAM")
    BASE=$(git merge-base @ "$UPSTREAM")

    if [ $LOCAL = $REMOTE ]; then
	echo "Up-to-date"
    elif [ $LOCAL = $BASE ]; then
	echo "Need to pull"
    elif [ $REMOTE = $BASE ]; then
	echo "Need to push"
    else
	echo "Diverged"
    fi
}
# Git Branch color
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
###################################################


###################################################
# PYTHON DOCUMENTATION VERIFICATED
# Modules should have documentation Execution into module if __name__ == "__main__":
function python_doc_all_modules {
    if [ $# -lt 1 ]
    then
	echo "Usage: python_doc_all_modules Name_File_Without_extention_.py"
    else
	python3 -c 'print(__import__("'$1'").__doc__)'
    fi
}

# Classes should have documentation :
function python_doc_MyClass {
    if [ $# -lt 1 ]
    then
	echo "Usage: python_doc_MyClass Name_File_Without_extention_.py Class_Name"
    else
	python3 -c 'print(__import__("'$1'").'$2'.__doc__)'
    fi
}

# Functions (inside and outside a class) should have documentation :
function python_doc_my_function {
    if [ $# -lt 1 ]
    then
	echo "Usage: python_doc_my_function Name_File_Without_extention_.py Function-Name"
    else
	python3 -c 'print(__import__("'$1'").'$2'.__doc__)'
    fi
}

function python_doc_MyClass_my_function {
    if [ $# -lt 1 ]
    then
	echo "Usage: python_doc_my_function Name_File_Without_extention_.py Class_Name Function_name"
    else
	python3 -c 'print(__import__("'$1'").'$2'.'$3'.__doc__)'
    fi
}
###################################################

###################################################
###################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
# ORIGINAL     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\][\u@\h]\[\033[00m\]:\[\033[01;34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\n $ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# cabal for ShellCheck
export PATH="$HOME/.cabal/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

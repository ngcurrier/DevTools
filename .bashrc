# ~/.bashrc: executed by bash(1) for non-login shells.                                                                                                                                                              
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)                                                                                                                                          
# for examples                                                                                                                                                                                                      

# If not running interactively, don't do anything                                                                                                                                                                   
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.                                                                                                                                            
# See bash(1) for more options                                                                                                                                                                                      
export HISTCONTROL=ignoreboth:erasedups:ignoredups
export HISTIGNORE="history:history *:pwd:ls: ls *:clear"

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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"                                                                                                                                                       

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
force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

    #alias grep='grep --color=auto'                                                                                                                                                                                 
    #alias fgrep='fgrep --color=auto'                                                                                                                                                                               
    #alias egrep='egrep --color=auto'                                                                                                                                                                               
fi

alias wemacs='emacs --no-windows'
# change command in screen to avoid control-a                                                                                                                                                                       
alias screen='screen -e^^^'

# grep utilities to find things in common repo file types                                                                                                                                                           
function grepcc(){
    grep "${1}" -irn --include=*.cc --include=*.c --include=*.cxx --include=*.cpp
}
function greph(){
    grep "${1}" -irn --include=*.h --include=*.hxx --include=*.hpp
}
function greppy(){
    grep "${1}" -irn --include=*.py
}
function grepipy(){
    grep "${1}" -irn --include=*.ipynb
}
function grepfbs(){
    grep "${1}" -irn --include=*.fbs
}
function grepsh(){
    grep "${1}" -irn --include=*.sh
}
function grepjs(){
    grep "${1}" -irn --include=*.js
}
function grepxml(){
    grep "${1}" -irn --include=*.xml
}
function grepall(){
    grep "${1}" -irn --include=*.js --include=*.cc --include=*.c --include=*.cpp --include=*.h --include=*.py --include=*.fbs --include=*.sh --include=*.xml --include=*.hxx --include=*.cxx --incl$
}

alias emacs='emacs -nw'
alias acroread='mupdf' # other option is xpdf but sucks 

lookupDNS()
{
    getent hosts $1 | awk '{ print $1 }'
}

dakotaCleanup()
{
    rm -r workdir.*
    rm *.interleaved.pdf
    rm dakota_tabular.dat
    rm dakota_stdout.txt
}

export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash

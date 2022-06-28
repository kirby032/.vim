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
    xterm-color) color_prompt=yes;;
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
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

#   ____          _                    ____  _          __  __
#  / ___|   _ ___| |_ ___  _ __ ___   / ___|| |_ _   _ / _|/ _|
# | |  | | | / __| __/ _ \| '_ ` _ \  \___ \| __| | | | |_| |_
# | |__| |_| \__ \ || (_) | | | | | |  ___) | |_| |_| |  _|  _|
#  \____\__,_|___/\__\___/|_| |_| |_| |____/ \__|\__,_|_| |_|
#  FIGLET: Custom Stuff
#

HISTSIZE=4000
HISTFILESIZE=8000

PATH="/opt/qumulo/toolchain/bin:${PATH}"
PATH=$PATH:/home/mkirby/src/tools
PATH=$PATH:/home/mkirby/tools

stty ixany
stty ixoff -ixon

# Use unicode style diff
alias diff='diff -u'

# nice to haves for Qumulo
alias lsgravy='ls -al  /mnt/gravy-home/'
alias cr='./check_run.py'
alias qc='simnode/qc'
alias lscore='find build/tmp -regex .*core.*'
alias rmcore='rm -i build/tmp/cluster/node*/core*'
alias qc_internal='simnode/qq_internal'
alias tn='prototypes/triageninja'
alias tn_steps="prototypes/triageninja --steps run_python 'print(\"{} {:<12} {} {}\".format(f.url(), f.build.name, f.started, f.display_name))'"
alias tn_step=tn_steps
alias tn_tests="prototypes/triageninja run_python 'print(\"{} {:<12} {} {}\".format(f.url(), f.step.build.name, f.started, f.output.split(\"/\")[-1]))'"
alias tn_test=tn_tests
alias qq_internal='api/client/qq_internal'
alias enzo='source /home/mkirby/src/tools/qston/enzo/enzo.bash'

# Always output core files
ulimit -c unlimited

#Always have colors for less and line numbers
export LESS="-RFX"
alias ls='ls --color=always'
alias grep='grep --color=always'

# Enable vi mode instead of emacs
set -o vi

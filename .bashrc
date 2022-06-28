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

PATH=$PATH:/home/mkirby/.local/bin
PATH=$PATH:/home/mkirby/src/tools
PATH=$PATH:/home/mkirby/tools
PATH=$PATH:/home/mkirby/my_tools

PATH=/opt/qumulo/toolchain/bin:$PATH
PATH=$PATH:/usr/local/go/bin:/home/mkirby/go/bin

stty -ixon
#stty ixany
#stty ixoff -ixon

# Use unicode style diff
alias diff='diff -u'

# nice to haves for Qumulo
alias lsgravy='ls -al  /mnt/gravy-home/'
alias cr='./check_run.py'
alias qc='simnode/qc'
alias lscore='find build/tmp -regex .*core.*'
alias rmcore='rm -i build/tmp/cluster/node*/core*'
alias qc_internal='simnode/qq_internal'
alias tn='triage/triageninja'
alias tn_stat="tn run 'echo \$URL : \$BUILD : \$(rg \"FIXTURE SETUP STARTING\" test_output)'"
alias tn_steps="triage/triageninja --steps run_python 'print(\"{} {:<12} {} {}\".format(f.url(), f.build.name, f.started, f.display_name))'"
alias tn_step=tn_steps
alias tn_tests="triage/triageninja run_python 'print(\"{} {:<12} {} {}\".format(f.url(), f.step.build.name, f.started, f.output.split(\"/\")[-1]))'"
alias tn_test=tn_tests
alias qq_internal='api/client/qq_internal'
alias enzo='source /home/mkirby/src/tools/qston/enzo/enzo.bash'
alias kubectl="minikube kubectl --"

alias work-with-rachel='setxkbmap -option caps:ctrl_modifier; xmodmap /home/mkirby/dotfiles/xmodmap.das-keyboard'

# Always output core files
ulimit -c unlimited

#Always have colors for less and line numbers
export LESS="-RFX"
alias ls='ls --color=always'
alias grep='grep --color=always'

# Create an alarm for event
alias create-alarm='~/my_tools/set-alarm.sh'
alias show-alarms='ps aux | grep set-alarm | grep -v grep | tr -s " " | cut -d " " -f 13-'

# sudo with qumulo environment
alias qsudo='sudo env PATH="/opt/qumulo/toolchain/bin:${PATH}"'


# __     ___    ____ _____   ____        _
# \ \   / / \  / ___|_   _| |  _ \  __ _| |_ __ _
#  \ \ / / _ \ \___ \ | |   | | | |/ _` | __/ _` |
#   \ V / ___ \ ___) || |   | |_| | (_| | || (_| |
#    \_/_/   \_\____/ |_|   |____/ \__,_|\__\__,_|
#  FIGLET: VAST Data
# Start/Stop Vast VPN
alias vpn='nmcli con'
alias vpn-start='nmcli con up MiTAC.vpn.121719'
alias vpn-stop='nmcli con down MiTAC.vpn.121719'

# SSH azure dev vm
alias ssh-azvm='ssh centos@rnd-mkirby-vastdata.eastus2.cloudapp.azure.com'
alias ui-azvm='ssh -i ~/.ssh/id_rsa -N -g -C -o "StrictHostKeyChecking no" -L 8443:localhost:443 centos@rnd-mkirby-vastdata.eastus2.cloudapp.azure.com'

# rsync source code to azure vm
#alias rsync-src='rsync -avzr .git centos@rnd-mkirby-vastdata.eastus2.cloudapp.azure.com:/home/centos/orion/;  rsync -avzr -0 --files-from=<(git ls-files -z) . centos@rnd-mkirby-vastdata.eastus2.cloudapp.azure.com:/home/centos/orion/'
#
rsync-src() {
    if [ "$PWD" = "/home/mkirby/orion" ]; then
        rsync -avzr /home/mkirby/orion/.git centos@rnd-mkirby-vastdata.eastus2.cloudapp.azure.com:/home/centos/orion/
        rsync -avzr -0 --files-from=<(git ls-files -z) . centos@rnd-mkirby-vastdata.eastus2.cloudapp.azure.com:/home/centos/orion/
    else
        echo "Must be in /home/mkirby/orion but currently at $PWD"
    fi
}

set bell-style none

# __  __         ____  _          __  __
#|  \/  |_   _  / ___|| |_ _   _ / _|/ _|
#| |\/| | | | | \___ \| __| | | | |_| |_
#| |  | | |_| |  ___) | |_| |_| |  _|  _|
#|_|  |_|\__, | |____/ \__|\__,_|_| |_|
#        |___/
# FIGLET: My Stuff
# Daily routine aliases
start-day() {
    mkdir -p /home/mkirby/daily-notes/$(date +%Y)/$(date +%B)/
    touch /home/mkirby/daily-notes/$(date +%Y)/$(date +%B)/$(date +%d).notes
}

add-note() {
    echo '-' $@ >> /home/mkirby/daily-notes/$(date +%Y)/$(date +%B)/$(date +%d).notes
}

end-day() {
    GIT_DIR=/home/mkirby/daily-notes/.git GIT_WORK_TREE=/home/mkirby/daily-notes \
        git add $(date +%Y)

    GIT_DIR=/home/mkirby/daily-notes/.git GIT_WORK_TREE=/home/mkirby/daily-notes \
        git commit -m "Notes for $(date +%m/%d/%Y)" -e

    GIT_DIR=/home/mkirby/daily-notes/.git GIT_WORK_TREE=/home/mkirby/daily-notes \
        git fetch kirby032

    GIT_DIR=/home/mkirby/daily-notes/.git GIT_WORK_TREE=/home/mkirby/daily-notes \
        git push
}

amount-worked() {
    day_of_week=$(date +%u)
    year=$(date +%Y)

    total_time_worked=0

    for ((i = 1; i <= day_of_week && i <= 5; ++i )); do
        day_modifier=$(($day_of_week - $i))
        month=$(date -d "-$day_modifier days" +%B)
        day=$(date -d "-$day_modifier days" +%d)
        day_name=$(date -d "-$day_modifier days" +%A)

        echo $day_name
        started=$(head -n1 /home/mkirby/daily-notes/$year/$month/$day.notes | ag 'started:' | awk '{print $2}')
        started=$(date -d $started +%s)

        stopped=$(tail -n1 /home/mkirby/daily-notes/$year/$month/$day.notes | ag 'stopped:' | cut -d ' ' -f2 | sed 's/,$//')
        stopped=$(date -d $stopped +%s)

        breaks=$(tail -n1 /home/mkirby/daily-notes/$year/$month/$day.notes | ag 'breaks: [0-9]+min' | awk '{print $4}' | cut -d 'm' -f1)

        diffsec=$(expr "$stopped" - "$started")
        if [ $breaks ]; then
            diffsec=$(expr "$diffsec" - 60 \* "$breaks")
        fi
        total_time_worked=$(expr "$total_time_worked" + "$diffsec")
        total_worked=$(date +%H:%M:%S -ud @$diffsec)
        ag --nonumbers --nocolor 'started:|stopped:' /home/mkirby/daily-notes/$year/$month/$day.notes
        echo Worked total of $total_worked
        echo
    done

    total_worked=$(expr "$total_time_worked" / 60 / 60)
    mins_worked=$(date +%M -ud @$total_time_worked)
    echo Worked $total_worked:$mins_worked so far this week
}

save-git-stack() {
    if [ "$#" -ne 2 ]; then
        echo "Entered:" $@
        echo "Usage: save-git-stack {base_reference} {target_patchstack_dir}"
        echo "Example:"
        echo "    save-git-stack orion/TEAM/smb /jupiter/mkirby/my_new_stack"
        return
    fi

    ref=$1
    stack_dir=$2


    # Create $stack_dir if it doesn't exist
    mkdir -p $stack_dir

    # Create series file and move existing to .old
    if [[ -f "$stack_dir/series" ]]; then
        echo "$stack_dir/series" already exists, moving to "$stack_dir/series.old"
        mv "$stack_dir/series" "$stack_dir/series.old"
    fi

    git log "$ref"..HEAD -v --stat > "$stack_dir/series"

    patches=$(cat "$stack_dir/series" | grep '^commit' | awk '{print $2;}')

    echo Copying $(echo $patches | wc -w) patches....

    for patch in $patches; do
        echo Diffing "$patch" to "$stack_dir"/"$patch"
        git diff "$ref"~..HEAD > "$stack_dir/$patch"
    done
}

#test-shit() {
#    echo some stuff \
#        and some more
#}

# 'Alias' (really a function) for ps aux and grep for specific program
pss() {
    ps aux | grep -ie $@ | sed "1i $(ps -aux | head -n1)"
}

pss-mem() {
    pss $@ | sed '1d' | awk -v proc=$@ '{rss += $6; virtual += $5} END {printf proc " is using %.2f GB Virtual, %.2f GB Real\n", virtual / 1024 / 1024, rss / 1024 / 1024}'
}

# Enable vi mode instead of emacs
set -o vi

# Use fzf for terminal fuzzy finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_ALT_C_COMMAND="rg --files --hidden -g !build/* -g !.hg/* -g !.qpkg/*"
export FZF_DEFAULT_COMMAND='rg --files --hidden -g !build/* -g !.hg/* -g !.qpkg/*'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Make docker/minikube not bitch about locale error:
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

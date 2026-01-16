# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#Get the global variable
source /etc/profile

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

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


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

#export Document=/mnt/Win10/Document
#export Win10=/mnt/Win10/System
#export rbLearning=/mnt/RBdesktop/rbLearning
#export rbOther=/mnt/RBdesktop/rbOther
#export rbRoot=/mnt/RBdesktop/rbRoot
#export rbHome=/mnt/RBdesktop/rbHome

export PATH=$PATH:/home/lysander/Android/android_sdk/cmdline-tools/latest/bin
#export PATH=$PATH:/home/lysander/Android/android_sdk/platform-tools
export PATH=$PATH:/home/lysander/Android/flutter/bin
#export PATH=$PATH:/home/lysander/Android/android_sdk/build-tools/30.0.3

export ANDROID_HOME=/home/lysander/Android/android_sdk
export ANDROID_SDK_ROOT=/home/lysander/Android/android_sdk

export JAVA_HOME21=/usr/java/jdk-21-oracle-x64
export JAVA_HOME8=/usr/local/my_java/jdk1.8.0_202
export JAVA_HOME=$JAVA_HOME8

export LFS=/mnt/lfs

#Android gts key
export APE_API_KEY='/home/lysander/Android/test_suite/gts_key/gts-fih-public.json'
export PATH=$PATH:/home/lysander/usr/cross-compiler/gcc-linaro-5.5.0-2017.10-x86_64_arm-linux-gnueabihf/bin
export PATH=$PATH:/home/lysander/Android/tools/SP_Flash_Tool_v6.2228_Linux

#For WSL Linux 
export QT_QPA_PLATFORMTHEME=gtk2
export QT_SCALE_FACTOR=1.25
export GDK_DPI_SCALE=1.25
export GDK_SCALE=1.25
export PATH=$PATH:/home/lysander/Qt5.12.9/Tools/QtCreator/bin

#QTSOURCE
export QTSRC5129=$HOME/Qt5.12.9/5.12.9/Src

# stm8flash
export PATH=$HOME/Tools/stm8flash:$PATH

# xtensa crosscompiler
export PATH=$HOME/Tools/xtensa-lx106-elf/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lysander/.pyenv/versions/miniconda3-3.12-24.1.2-0/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lysander/.pyenv/versions/miniconda3-3.12-24.1.2-0/etc/profile.d/conda.sh" ]; then
        . "/home/lysander/.pyenv/versions/miniconda3-3.12-24.1.2-0/etc/profile.d/conda.sh"
    else
        export PATH="/home/lysander/.pyenv/versions/miniconda3-3.12-24.1.2-0/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


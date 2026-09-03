#!/bin/bash

if [ "$(uname)" = "Linux" ]; then
    alias cat='batcat -p'
    alias dps='dpkg -s'
    alias dpS='dpkg -S'
    alias dpl='dpkg -l'
    alias dpL='dpkg -L'
    alias ll='ls -1vFAlh'
    alias la='ls -vhA'
    alias l='ls -1vhCF'
    alias apt='sudo apt'
    alias fdisk='sudo fdisk'
    alias copy='wl-copy'
    alias paste="wl-paste | grep -v '^$'"
    alias lu='lsusb'
    alias lsb='lsblk -af'
    alias minicom1='sudo minicom -c on -D /dev/ttyUSB0 -b 115200'
    alias minicom2='sudo minicom -c on -D /dev/ttyUSB1 -b 115200'
    alias minicom3='sudo minicom -c on -D /dev/ttyUSB0 -b 1500000'
    alias minicom4='sudo minicom -c on -D /dev/ttyUSB0 -b 921600'
    alias dmesg='sudo dmesg -e'
    alias odiff='TMPDIR=/run/shm diffoscope --markdown=diff.md --exclude-directory-metadata=yes'
    alias hdiff='TMPDIR=/home/lysander/tmp/ diffoscope --markdown=diff.md --exclude-directory-metadata=yes'
    alias journalctl='sudo journalctl'
    alias rkLinuxUgTool='sudo rkLinuxUgTool'

    Open() {
        local file_path
        if [ $# -ge 1 ]; then
            file_path="$1"
        else
        file_path=$(wl-paste)
        fi
    
        if command -v wslview > /dev/null 2>&1; then
            wslview "$file_path" > /dev/null 2>&1 &
        else
            xdg-open "$file_path" > /dev/null 2>&1 &
        fi
    }

    cathura() {
        local file_path
        if [ $# -ge 1 ]; then
            file_path="$1"
        else
            file_path=$(wl-paste)
        fi
    
        # Check if path is non-empty
        if [ -z "$file_path" ]; then
            echo "Clipboard is empty!"
            return 1
        fi
    
        # Resolve to real path (handle symlinks)
        real_path=$(realpath "$file_path" 2>/dev/null)
        command nohup cathura "$file_path" > /dev/null 2>&1 &
    }

elif [ "$(uname)" = "Darwin" ]; then
    alias cat='bat -p'
    alias dmesg='sudo dmesg'
    alias lsb='diskutil list'
    alias lu='system_profiler SPUSBHostDataType'

    function dum(){
        du -m -d 1 "$@" | awk '$1 > 300' 
    }
    function dug(){
        du -g -d 1 "$@" | awk '$1 > 1' 
    }

    function apt(){
        export HOMEBREW_PREFIX="/opt/homebrew";
        export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
        export HOMEBREW_REPOSITORY="/opt/homebrew";
        export HOMEBREW_INFO="/opt/homebrew/share/info"

        fpath[1,0]="/opt/homebrew/share/zsh/site-functions";
        eval "$(/usr/bin/env PATH_HELPER_ROOT="/opt/homebrew" /usr/libexec/path_helper -s)"
        [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";

        # Only prepend if it's not already in INFOPATH
        if ! echo "$INFOPATH" | tr ':' '\n' | grep -qx "$HOMEBREW_INFO"; then
            export INFOPATH="$HOMEBREW_INFO${INFOPATH:+:$INFOPATH}"
        fi

        # Prepend external Homebrew bin to PATH for this command only
        $HOMEBREW_REPOSITORY/bin/brew "$@"
    }
    alias odiff='TMPDIR=/tmp diffoscope --markdown=diff.md --exclude-directory-metadata=yes'
    alias journalctl='sudo log show'

    # External Homebrew on /Volumes/Apps/Homebrew
    function Apt() {
        # Temporarily set environment variables for this session
        export HOMEBREW_PREFIX="/Volumes/Apps/Homebrew";
        export HOMEBREW_CELLAR="/Volumes/Apps/Homebrew/Cellar";
        export HOMEBREW_REPOSITORY="/Volumes/Apps/Homebrew";
        export HOMEBREW_INFO="/Volumes/Apps/Homebrew/share/info"

        fpath[1,0]="/Volumes/Apps/Homebrew/share/zsh/site-functions";
        eval "$(/usr/bin/env PATH_HELPER_ROOT="/Volumes/Apps/Homebrew" /usr/libexec/path_helper -s)"
        [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}";

        # Only prepend if it's not already in INFOPATH
        if ! echo "$INFOPATH" | tr ':' '\n' | grep -qx "$HOMEBREW_INFO"; then
            export INFOPATH="$HOMEBREW_INFO${INFOPATH:+:$INFOPATH}"
        fi

        # Prepend external Homebrew bin to PATH for this command only
        $HOMEBREW_PREFIX/bin/brew "$@"
    }

    function mpt() {
        # Set MacPorts environment
        export MACPORTS_PREFIX="/opt/local"
        export PATH="$MACPORTS_PREFIX/bin:$MACPORTS_PREFIX/sbin:$PATH"
        export MANPATH="$MACPORTS_PREFIX/share/man:${MANPATH:-}"
        export MACPORTS_INFO="$MACPORTS_PREFIX/share/info"

        # Only prepend if it's not already in INFOPATH
        if ! echo "$INFOPATH" | tr ':' '\n' | grep -qx "$MACPORTS_INFO"; then
            export INFOPATH="$MACPORTS_INFO${INFOPATH:+:$INFOPATH}"
        fi
    
        # Run MacPorts command
        sudo /opt/local/bin/port "$@"
    }

    Open() {
        file_path=$(pbpaste | tr -d '\r\n')
        # Check if path is non-empty
        if [ -z "$file_path" ]; then
            echo "Clipboard is empty!"
            return 1
        fi

        # Open Zathura in background
        command open "$file_path" > /dev/null 2>&1 &
    }

    cathura() {
        file_path=$(pbpaste | tr -d '\r\n')
        # Check if path is non-empty
        if [ -z "$file_path" ]; then
            echo "Clipboard is empty!"
            return 1
        fi
    
        # Open Zathura in background
        command nohup zathura --mode fullscreen "$file_path" > /dev/null 2>&1 &
    }

    alias ll='ls -1vFAlhG'
    alias la='ls -vhAG'
    alias l='ls -1vhCFG'
    alias copy="tr -d '\r\n' | pbcopy"
    alias paste="pbpaste | tr -d '\n'"
    alias office="open -a wpsoffice"
    alias rkLinuxUgTool="sudo rkLinuxUgTool"
    alias ufb="sudo uuu FB:"
    alias ufbu="sudo uuu FB: ucmd"
    alias usdp="sudo uuu SDP:"

    alias dolphin='dolphin > /dev/null 2>&1 &'
    coffice() {
        file_path=$(pbpaste | tr -d '\r\n')
        # Check if path is non-empty
        if [ -z "$file_path" ]; then
            echo "Clipboard is empty!"
            return 1
        fi
    
        # Open Zathura in background
        open -a wpsoffice "$file_path"
    }

    cB() {
        file_path=$(pbpaste | tr -d '\r\n')
        # Check if path is non-empty
        if [ -z "$file_path" ]; then
            echo "Clipboard is empty!"
            return 1
        fi
    
        # Open Zathura in background
        cb cp "$file_path"
    }

    cypora() {
        file_path=$(pbpaste | tr -d '\r\n')
        # Check if path is non-empty
        if [ -z "$file_path" ]; then
            echo "Clipboard is empty!"
            return 1
        fi
    
        # Open Zathura in background
        open -a typora "$file_path"
    }

    # Mac port only packages
    svn2git() {
        PATH="/opt/local/bin:/opt/local/sbin:$PATH" /opt/local/bin/svn-all-fast-export "$@"
    }
    alias minicom1='minicom -D "/dev/tty.usbserial-BG02DFXU" -b 115200 -c on '
    alias minicom2='minicom -D "/dev/tty.usbserial-BG02DFXU" -b 921600 -c on '
    alias minicom3='minicom -D "/dev/tty.usbserial-BG02DFXU" -b 1500000 -c on '
    alias minicom4='minicom -D "/dev/tty.usbserial-BG02DFXU" -b 2000000 -c on '
    alias picocom1='picocom "/dev/tty.usbserial-BG02DFXU" -b 115200'
    alias picocom2='picocom "/dev/tty.usbserial-BG02DFXU" -b 921600'
    alias picocom3='picocom "/dev/tty.usbserial-BG02DFXU" -b 1500000'
    alias picocom4='picocom "/dev/tty.usbserial-BG02DFXU" -b 2000000'
# Other OS
else
    echo "Other OS bash_alias"
fi

# Below is the Linux and Darwin compatible alias
alias api='apt info'
alias c='clear'
alias du1='du -hd 1'
alias fh='df -ah'
alias mount='sudo mount -v'
alias tcpdump='sudo tcpdump'
alias umount='sudo umount -v'
alias man1='tldr'
alias uuu='sudo uuu -v'
alias dd='sudo dd status=progress'
alias rsync='rsync --progress'
alias watch='watch -n 0.1'
alias fzf='fzf|copy'
alias wssh='ssh -p 20222'
alias wscp='scp -P 20222'
alias ssh_macos='ssh -p 53100 lysander@tcloud'
alias ssh_win10='ssh -p 43100 lysander@tcloud'
alias ssh_wsl='ssh -p 34200 lysander@tcloud'

man3(){
    command nvim -n -c "$*" -c "wincmd o"
}

man2(){
    command nvim -n -c "Man $*" -c "wincmd o"
}

#For command line launch
colphin() {
    command nohup dolphin "$@" > /dev/null 2>&1 &
}

#For ghostty on linux
Ghostty() {
    command nohup ghostty > /dev/null 2>&1 & exit
}

ckular() {
    file_path=$(paste)
    command nohup okular "$file_path" > /dev/null 2>&1 &
}

calcmem() {
    local process_name="${1:-bash}"
    local pids
    
    pids=$(pgrep -d, -x "$process_name" 2>/dev/null)
    
    if [ -z "$pids" ]; then
        echo "No '$process_name' processes found"
        return 1
    fi
    
    echo "Calculating memory usage for '$process_name' (PIDs: $pids)"
    ps -o rss -p "$pids" 2>/dev/null | awk 'NR>1 {sum+=$1} END {
        if (sum > 0) 
            printf "Total memory: %.2f GB\n", sum/1024/1024
        else 
            print "No memory data available"
    }'
}

erans() {
    command trans "$@" zh:en
}

crans() {
    command trans "$@" en:zh
}


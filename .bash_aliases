#!/bin/bash

if [ -n "$BASH_VERSION" ]; then
    alias cat='batcat -P'
    alias ll='ls -1vFAlh'
    alias la='ls -vhA'
    alias l='ls -1vhCF'
    alias apt='sudo apt'
    alias copy='wl-copy'
    alias paste="wl-paste | grep -v '^$'"
    alias lu='lsusb'
    alias lsb='lsblk -af'
    alias minicom1='sudo minicom -c on -D /dev/ttyUSB0 -b 115200'
    alias minicom2='sudo minicom -c on -D /dev/ttyUSB1 -b 115200'
    alias minicom3='sudo minicom -c on -D /dev/ttyUSB0 -b 1500000'
    alias dmesg='sudo dmesg -e'
    alias odiff='TMPDIR=/run/shm diffoscope --markdown=diff.md --exclude-directory-metadata=yes'
    alias hdiff='TMPDIR=/home/lysander/tmp/ diffoscope --markdown=diff.md --exclude-directory-metadata=yes'
    alias journalctl='sudo journalctl'
    alias rkLinuxUgTool='sudo rkLinuxUgTool'

    cathura() {
        file_path=$(wl-paste)
        command nohup zathura "$file_path" > /dev/null 2>&1 &
    }

else
    alias dmesg='sudo dmesg'
    alias lsb='diskutil list'
    alias lu='system_profiler SPUSBDataType'

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
    alias minicom3='sudo minicom -D "/dev/tty.usbserial-12440" -b 1500000 -c on '
fi
alias c='clear'
alias du1='du -hd 1'
alias fh='df -ah'
alias mount='sudo mount -v'
alias umount='sudo umount -v'
alias fdisk='sudo fdisk'
alias man1='tldr'
alias pip='python3 -m pipi'
alias dd='sudo dd status=progress'
alias rsync='rsync --progress'
alias watch='watch -n 0.1'
alias fzf='fzf|copy'
alias dolphin='dolphin > /dev/null 2>&1 &'
alias wssh='ssh -p 20222'
alias wscp='scp -P 20222'

man(){
    command nvim -n -c "Man $*" -c "wincmd o"
}

#For command line launch
tolphin() {
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

V2rayN() {
    command nohup v2rayN > /dev/null 2>&1 &
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

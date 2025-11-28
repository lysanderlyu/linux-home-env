#!/bin/bash

alias ll='ls -1vFAlh'
alias la='ls -vhA'
alias l='ls -1vhCF'
alias c='clear'
alias cat='batcat -P'
alias du1='du -hd 1'
alias lsb='lsblk -af'
alias lu='lsusb'
alias fh='df -ah'
alias minicom1='sudo minicom -c on -D /dev/ttyUSB0 -b 115200'
alias minicom2='sudo minicom -c on -D /dev/ttyUSB1 -b 115200'
alias minicom3='sudo minicom -c on -D /dev/ttyUSB0 -b 1500000'
alias mount='sudo mount -v'
alias umount='sudo umount -v'
alias dmesg='sudo dmesg -e'
alias journalctl='sudo journalctl'
alias fdisk='sudo fdisk'
alias apt='sudo apt'
alias man1='tldr'
alias pip='python3 -m pipi'
alias dd='sudo dd status=progress'
alias rsync='rsync --progress'
alias watch='watch -n 0.1'
alias find2='find ./ -name'
alias find1='find ./ -iname'
alias wlc='wl-copy'
alias wlp="wl-paste | grep -v '^$'"
alias fzf='fzf|wlc'
alias odiff='TMPDIR=/run/shm diffoscope --markdown=diff.md --exclude-directory-metadata=yes'
alias hdiff='TMPDIR=/home/lysander/tmp/ diffoscope --markdown=diff.md --exclude-directory-metadata=yes'
alias rkLinuxUgTool='sudo rkLinuxUgTool'
alias dolphin='dolphin > /dev/null 2>&1 &'
alias zathura='zathura'
alias wssh='ssh -p 20222'
alias wscp='scp -P 20222'


#For command line launch
tolphin() {
    command nohup dolphin "$@" > /dev/null 2>&1 &
}

wathura() {
    path=$(wlp)
    command nohup zathura "$path" > /dev/null 2>&1 &
}

wkular() {
    path=$(wlp)
    command nohup okular "$path" > /dev/null 2>&1 &
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

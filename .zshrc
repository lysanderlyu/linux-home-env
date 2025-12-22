# Fix the color term on Macos
autoload -Uz colors && colors
PS1="%F{green}%n@%m%f:%F{blue}%~%f$ "

# set PATH so it includes user's private bin if it exists
if [ -f "$HOME/.bash_aliases" ] ; then
    source $HOME/.bash_aliases
fi

# ---------------------------
# Zsh completion (native only)
# ---------------------------
# Add Zsh completion directories
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)

# Initialize completions
autoload -Uz compinit && compinit

# Skip insecure directory warnings
zstyle ':completion:*' insecure

# ---------------------------
# Environment variables
# ---------------------------
export HOMEBREW_COLOR=1
export TERM="xterm-256color"

# Export some path
export Android156=$HOME/mnt/Android156                                                                                                                                                                            
export RealbomFTP=$HOME/mnt/RealbomFTP                                                                                                                                                                            
export Learning=$HOME/mnt/Win10/Learning                                                                                                                                                                         
export Data=$HOME/mnt/Win10/Data                                                                                                                                                                         
export Other=$HOME/mnt/Win10/Other                                                                                                                                                                         
export System=$HOME/mnt/Win10/System                                                                                                                                                                               
export GDriver=$HOME/mnt/GDriver                                                                                                                                                                               
export RBDebian=$HOME/mnt/RBDebian                                                                                                                                                                                    
export Ubuntu=$HOME/mnt/Ubuntu                                                                                                                                                                                    
export Ubuntu2204=$HOME/mnt/Ubuntu2204                                                                                                                                                                                    
export ArmWin11_Dev=$HOME/mnt/ArmWin11/Dev                                                                                                                                                                                    
                                                                                                                                                                                                             
export LFS=$HOME/mnt/LFS                                                                                                                                                                                          

export SVN_SSL_NO_VERIFY=true
export LIMA_HOME=$HOME/lima/
export ESP_HOME=$HOME/Tools-cs/ESP-IDF
export EDITOR="nvim"

# Use Apps/brew by default
eval "$(/Users/lysander/Apps/Homebrew/bin/brew shellenv)"
# Eval the pyenv
eval "$(pyenv init -)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/lysander/.pyenv/versions/miniconda3-3.8-23.9.0-0/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/lysander/.pyenv/versions/miniconda3-3.8-23.9.0-0/etc/profile.d/conda.sh" ]; then
        . "/Users/lysander/.pyenv/versions/miniconda3-3.8-23.9.0-0/etc/profile.d/conda.sh"
    else
        export PATH="/Users/lysander/.pyenv/versions/miniconda3-3.8-23.9.0-0/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


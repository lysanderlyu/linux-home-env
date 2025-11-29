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
# ---------------------------
# Environment variables
# ---------------------------
export HOMEBREW_COLOR=1
export TERM="xterm-256color"

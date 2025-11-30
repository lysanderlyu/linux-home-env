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


# Export some path
export Android156=$HOME/mnt/Android156                                                                                                                                                                            
export RealbomFTP=$HOME/mnt/RealbomFTP                                                                                                                                                                            
export Learning=$HOME/mnt/Win10/Learning                                                                                                                                                                         
export Data=$HOME/mnt/Win10/Data                                                                                                                                                                         
export Other=$HOME/mnt/Win10/Other                                                                                                                                                                         
export System=$HOME/mnt/Win10/System                                                                                                                                                                               
export GDriver=$HOME/mnt/GDriver                                                                                                                                                                               
export RBDebian=$HOME/mnt/RBDebian                                                                                                                                                                                    
                                                                                                                                                                                                             
export LFS=$HOME/mnt/LFS                                                                                                                                                                                          

# brew qt5 on macos
export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/qt@5/lib"
export CPPFLAGS="-I/opt/homebrew/opt/qt@5/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/qt@5/lib/pkgconfig"
export CMAKE_PREFIX_PATH="/opt/homebrew/opt/qt@5"

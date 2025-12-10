# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# if running zsh
# include .bashrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    . "$HOME/.zshrc"
fi

# set the PATH of CLT line tools after Homebrew
PATH="/Library/Developer/CommandLineTools/usr/bin:$PATH"

# Set ruby path
PATH="/opt/homebrew/opt/ruby/bin:$PATH"
PATH="/opt/homebrew/lib/ruby/gems/3.4.0/bin:$PATH"

# set PATH so it includes external disk bin if it exists before the CLT
PATH="$HOME/Apps/Homebrew/bin:$PATH"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

cd ~

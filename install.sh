#!/bin/bash
# This install script only install the home wide configuration

# Get the realpath of this script, and this path is also the root_path for configuration
SCRIPT_PATH="$(realpath "$0")"
ROOT_DIR="$(dirname "$SCRIPT_PATH")"

if [ "$(uname)" = "Linux" ]; then
    # First remove the origin profile
    rm ~/.bashrc
    rm ~/.profile

    # Then hard link to them back to
    ln ${ROOT_DIR}/.bashrc ~/
    ln ${ROOT_DIR}/.profile ~/

elif [ "$(uname)" = "Darwin" ];then
    # First remove the origin profile
    rm ~/.zshrc
    rm ~/.zprofile

    # Then hard link to them back to
    ln ${ROOT_DIR}/.zshrc ~/
    ln ${ROOT_DIR}/.profile ~/.zprofile
else
    echo "Other platform"
fi

# Some general configuration
rm ~/.bash_aliases
rm ~/.vimrc
rm ~/.gitconfig
rm ~/.config/zathura/zathurarc

ln ${ROOT_DIR}/.bash_aliases ~/
ln ${ROOT_DIR}/.vimrc ~/
ln ${ROOT_DIR}/.gitconfig ~/
ln ${ROOT_DIR}/.config/zathura/zathurarc ~/.config/zathura/zathurarc

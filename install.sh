#!/bin/bash
# This install script only install the home wide configuration

# Get the realpath of this script, and this path is also the root_path for configuration
SCRIPT_PATH="$(realpath "$0")"
ROOT_DIR="$(dirname "$SCRIPT_PATH")"

if [ "$(uname)" = "Linux" ]; then
    ln -f ${ROOT_DIR}/.bashrc ${HOME}/
    ln -f ${ROOT_DIR}/.profile ${HOME}/

elif [ "$(uname)" = "Darwin" ];then
    ln -f ${ROOT_DIR}/.zshrc ${HOME}/
    ln -f ${ROOT_DIR}/.profile ${HOME}/.zprofile
else
    echo "Other platform"
fi

# Some general configuration
ln -f ${ROOT_DIR}/.bash_aliases ${HOME}/
ln -f ${ROOT_DIR}/.vimrc ${HOME}/
ln -f ${ROOT_DIR}/.qt512.env ${HOME}/
ln -f ${ROOT_DIR}/.gitconfig ${HOME}/

mkdir -p ${HOME}/.config/zathura/ 
ln -f ${ROOT_DIR}/.config/zathura/zathurarc ${HOME}/.config/zathura/zathurarc

mkdir -p ${HOME}/bin
ln -f ${ROOT_DIR}/mountSamba.sh ${HOME}/bin/mountSamba.sh
ln -f ${ROOT_DIR}/lfsChangeRoot.sh ${HOME}/bin/lfsChangeRoot.sh

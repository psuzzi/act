#!/bin/bash

echo "Act Setup Script with parameters : ${@}"

setup(){

    printf "\nParams before expansion\n- clone_dir:${1}\n- env_file:${2}\n"

    # replace tilde, get absolute path
    _xpand(){ realpath "${1/#\~/$HOME}"; }

    local clone_dir=$(_xpand ${1})
    local env_file=$(_xpand ${2})

    # checks
    [ ! -d "${clone_dir}" ] && echo "clone dir $clone_dir does not exists. Exit" && exit 1
    [ ! -f "${env_file}" ] && echo "env file $env_file does not exists. Exit" && exit 1

    printf "\n\n Preparing Setup\n- cloning into:${clone_dir}\n- updating env into:${env_file}\n"
    read -p "Do you want to proceed? [y/n] : " yn
    [[ ! $yn =~ ^[Yy]$ ]] && echo "Exit" && exit 1

    if [ -d "${clone_dir}/act" ]; then
        printf "\n\n The act directory already exists in $clone_dir. Such directory will be overwritten.\n"
        read -p "Do you want to proceed? [y/n] : " yn
        [[ ! $yn =~ ^[Yy]$ ]] && echo "Exit" && exit 1
        # existing directory will be overwritten
        rm -rf "${clone_dir}/act"

    fi

    # Actual Setup
    echo "SETUP ..."

    # Clone act
    echo "cloning into $clone_dir"
    git -C "${clone_dir}" clone https://github.com/psuzzi/act.git

    # Update env
    echo "updating env into $env_file"
    local env_line='export "ACT_HOME=${HOME}/act" && source "${ACT_HOME}/dev.sh"'
    if grep -qF -- "${env_line}" "${env_file}"; then
        echo "ACT environment already set in ${env_file}"
    else
        echo "Adding ACT environment in ${env_file}"
        printf "\n# Setup ACT environment\n${env_line}\n" >> "${env_file}"
    fi

}

# given params or defaults
setup "${1:-~/}" "${2:-~/.bashrc}"
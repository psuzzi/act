#!/bin/bash

setup(){

    echo "SETUP: ${1} ${2}"

    # replace tilde, get absolute path
    _xpand(){ realpath "${1/#\~/$HOME}"; }

    local clone_dir=$(_xpand ${1})
    local env_file=$(_xpand ${2})


    echo "SETUP DEST: ${clone_dir} ${env_file}"

    exit 0

    local env_line='export "ACT_HOME=${HOME}/act" && source "${ACT_HOME}/dev.sh"'

    [ ! -d "$clone_dir" ] && echo "clone dir $clone_dir does not exists" && exit 1
    [ ! -f "$env_file" ] && echo "env file $env_file does not exists" && exit 1

    echo "cloning into $clone_dir"
    echo "updating env into $env_file"
    read -p "Do you want to proceed? [y/n] : " yn
    [[ ! $yn =~ ^[Yy]$ ]] && echo "Exit" && exit 1

    git -C "${clone_dir}" clone https://github.com/psuzzi/act.git

    if grep -qF -- "${env_line}" "${env_file}"; then
        echo "ACT environment already set in ${env_file}"
    else
        echo "Adding ACT environment in ${env_file}"
        printf "\n# Setup ACT environment\n${env_line}\n" >> "${env_file}"
    fi

}


setup "~/test/" "./bashrc"
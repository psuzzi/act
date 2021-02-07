#!/bin/bash

DEV_SCRIPT="${ACT_HOME}/dev.sh"

alias ls='ls -F'
alias ll='ls -lh --color'
alias lh='ls -lah --color'
alias ..='cd ../'
alias cl='clear'

# $1 used as separator to join the array passed as arg
join_by() { local IFS="${1}"; shift; echo "$*"; }

# usage: $1 $2 array as separated list
__usage() {  echo "usage: ${1} <$(join_by "|" ${@:2})>" ; }

dev(){
    local funcs=("load" "code" "info") # public
    local sourced=("prompt.sh git-help.sh" )
    case "${1}" in 
        load)
            source "${DEV_SCRIPT}"
            ;;
        code)
            if ! command -v code &> /dev/null; then
                printf "code not installed, please install it as per: https://code.visualstudio.com/docs/setup/linux"
                exit 0
            fi
            # different folder depending on system
            code "${ACT_HOME}/dev.code-workspace" 
            ;;
        info)
            echo "${DEV_SCRIPT} sourcing $(join_by " " ${sourced[@]}) " 
            ;;
        _completion)
            echo "${dev_funcs[@]}"
            ;;
        _sourcing)
            for f in ${sourced[@]}; do source "${ACT_HOME}/${f}"; done ;
            ;;
        *)
            echo "Nothing executed. Undefined flag(s): ${@}"
            __usage "${FUNCNAME[0]}" ${funcs[@]}
            ;;
    esac
}
complete -W "$(dev _completion)" dev
dev _sourcing
echo "bash -> entry $DEV_SCRIPT"
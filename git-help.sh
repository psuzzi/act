#! /bin/bash

git_help(){

    local gh_funcs=("usage" "set_aliases" "remove_aliases")

    usage(){
        echo "git_help"
        echo " - set_aliases: co, st, cm, br, rem, log1, alias"
        echo " - remove_aliases: remove the above"
    }

    set_aliases(){
        git config --global alias.co        'checkout'
        git config --global alias.st        'status -sb'
        git config --global alias.cm        'commit' #commit
        git config --global alias.remove    'checkout .' 
        git config --global alias.br        '!git --no-pager branch'
        git config --global alias.log1      '!git --no-pager log --graph --pretty=format:'"'"'%Cred%h %Creset%<(55,trunc)%s %C(bold blue)%<(10,trunc)%ae%Creset %Cgreen%<(6,trunc)%cr %C(yellow)%<(35,trunc)%d%Creset'"'"' --abbrev-commit -10'
        git config --global alias.alias     "!git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /"
    }
    remove_aliases(){
        git config --global --unset alias.co
        git config --global --unset alias.st
        git config --global --unset alias.cm
        git config --global --unset alias.remove 
        git config --global --unset alias.br
        git config --global --unset alias.log1
        git config --global --unset alias.alias
    }

    # the below aliases does not work on mac, function not ready for production
    _git_alias_set_nomac(){
        git config --global alias.log2      '!git --no-pager log --graph --pretty=format:'"'"'%Cred%h %Creset%<(55,trunc)%s %C(bold blue)%<(10,trunc)%ae%Creset %Cgreen%<(6,trunc)%cr %C(yellow)%<(35,trunc)%d%Creset'"'"' --abbrev-commit -20'
        git config --global alias.log3      '!git --no-pager log --graph --pretty=format:'"'"'%Cred%h %Creset%<(55,trunc)%s %C(bold blue)%<(10,trunc)%ae%Creset %Cgreen%<(6,trunc)%cr %C(yellow)%<(35,trunc)%d%Creset'"'"' --abbrev-commit -30'
        git config --global alias.unstage   'reset HEAD --     # Unstage everything'
        git config --global alias.undo   'reset --soft HEAD^   # Undo last commit and moves the files in the commit to staging'
        git config --global alias.clr   'clean -d -f           # delete unstaged dirs files'
        git config --global alias.clrx   'clean -d -f -X       # delete unstaged dirs files, including untracked'
    }


    if [[ $# -eq 0 ]] ; then
        usage
    else
        case "${1}" in 
            set_aliases)    set_aliases ;;
            remove_aliases) remove_aliases ;;
            _completion)    echo "${gh_funcs[@]}" ;;
            *)              usage ;;
        esac
    fi
}

complete -W "$(git_help _completion)" git_help





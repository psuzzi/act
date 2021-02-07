#! /bin/bash

_git_prompt_install(){
    cd ~
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh >"${ACT_HOME}/support/git-prompt.sh"
    curl -OL https://github.com/git/git/raw/master/contrib/completion/git-completion.bash
    mv ~/git-completion.bash ~/.git-completion.bash
}

_git_alias_set(){
    git config --global alias.co        'checkout'
    git config --global alias.st        'status -sb'
    git config --global alias.cm        'commit' #commit
    git config --global alias.remove    'checkout .' 
    git config --global alias.br        '!git --no-pager branch'
    git config --global alias.log1      '!git --no-pager log --graph --pretty=format:'"'"'%Cred%h %Creset%<(55,trunc)%s %C(bold blue)%<(10,trunc)%ae%Creset %Cgreen%<(6,trunc)%cr %C(yellow)%<(35,trunc)%d%Creset'"'"' --abbrev-commit -10'
    git config --global alias.alias     "!git config --get-regexp ^alias\. | sed -e s/^alias\.// -e s/\ /\ =\ /"
}
_git_alias_set_nomac(){
    git config --global alias.log2      '!git --no-pager log --graph --pretty=format:'"'"'%Cred%h %Creset%<(55,trunc)%s %C(bold blue)%<(10,trunc)%ae%Creset %Cgreen%<(6,trunc)%cr %C(yellow)%<(35,trunc)%d%Creset'"'"' --abbrev-commit -20'
    git config --global alias.log3      '!git --no-pager log --graph --pretty=format:'"'"'%Cred%h %Creset%<(55,trunc)%s %C(bold blue)%<(10,trunc)%ae%Creset %Cgreen%<(6,trunc)%cr %C(yellow)%<(35,trunc)%d%Creset'"'"' --abbrev-commit -30'
    git config --global alias.unstage   'reset HEAD --     # Unstage everything'
    git config --global alias.undo   'reset --soft HEAD^   # Undo last commit and moves the files in the commit to staging'
    git config --global alias.clr   'clean -d -f           # delete unstaged dirs files'
    git config --global alias.clrx   'clean -d -f -X       # delete unstaged dirs files, including untracked'
}

_git_alias_remove(){
    git config --global --unset alias.co
    git config --global --unset alias.st
    git config --global --unset alias.cm
    git config --global --unset alias.remove 
    git config --global --unset alias.br
    git config --global --unset alias.log1
    git config --global --unset alias.alias
}
_git_alias_remove_nomac(){
    git config --global --unset alias.log2 
    git config --global --unset alias.log3 
    git config --global --unset alias.unstage 
    git config --global --unset alias.undo 
    git config --global --unset alias.clr 
    git config --global --unset alias.clrx
}


gt() {
    local gt_funcs=("load" "info" "alias" "unalias" "pullall")
    local gt_descs=("reload script" "get information" "set git global aliases" "remove aliases" "pull all repositories in this folder")
    
    _info(){
        for i in "${!gt_funcs[@]}"; do 
            printf "%s\t%s\n" "${gt_funcs[$i]}" "${gt_descs[$i]}"
        done
    }

    case "${1}" in
        load)
            source "${ENTRY_DIR}/git-help.sh"
            ;;
        info)           
            _info
            ;;
        alias)
            _git_alias_set
            _git_alias_set_nomac
            ;;
        unalias)
            _git_alias_remove
            _git_alias_remove_nomac
            ;;
        pullall) # pull all projects 1 level below this dir
            find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;
            ;;
        _completion)
            echo "${gt_funcs[@]}" 
            ;;
        *)
            __usage "${FUNCNAME[0]}" ${gt_funcs[@]} 
            ;;
    esac

}

complete -W "$(gt _completion)" gt





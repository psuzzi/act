

if [ ! -f "${ACT_HOME}/support/git-prompt.sh" ]; then
    echo "Download Prompt Support Scripts"
    mkdir -p "${ACT_HOME}/support"
    curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > "${ACT_HOME}/support/git-prompt.sh"
    curl -L https://github.com/git/git/raw/master/contrib/completion/git-completion.bash > "${ACT_HOME}/support/.git-completion.bash"
fi
if [ "$(type -t __git_ps1)" != "function" ]; then 
    echo "Source Prompt Support Scripts"
    source "${ACT_HOME}/support/.git-completion.bash"
    source "${ACT_HOME}/support/git-prompt.sh"
fi 

#colors
export COL_NC='\[\e[0m\]'
export COL_GREEN='\[\e[0;32m\]'
export COL_WHITE='\[\e[1;37m\]'
export COL_RED='\[\e[0;31m\]'
export COL_RED_I='\[\e[3;31m\]'
export COL_LIT_BLUE='\[\e[1;34m\]'
export COL_GRAY='\e[90m'
#prompt
export PROMPT_COMMAND='PS1="\n[${YS}] ${COL_GREEN}\u@\h${COL_NC}${COL_WHITE} \w${COL_NC}${COL_RED_I}$(__git_ps1)${COL_NC}\n\$ "'
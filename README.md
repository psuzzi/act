# act

Scripts to speed up development. To install

- clone the "act" folder on disk
- add "ACT_HOME" to your env (.bashrc), and source ${ACT_HOME}/dev.sh.

Alternatively, install from remote

`bash <(curl -Ls https://raw.githubusercontent.com/psuzzi/act/main/setup.sh) "clone_dir" "env_file"`

where 
- clone_dir : base folder to contain act (default is ${HOME} ) 
- env_file : script to be altered for sourcing act (default ${HOME}/.bashrc)


# Local development


For local development, you can run 

`bash <(cat ./setup.sh) "~/" "~/.bashrc"`

Just remember to not overwrite your current installation
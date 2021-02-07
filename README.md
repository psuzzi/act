# act


# Install 

Scripts to speed up development. To install

- clone the "act" folder on disk
- add "ACT_HOME" to your env (.bashrc), and source ${ACT_HOME}/dev.sh.

Alternatively, install from remote

`bash <(curl -Ls https://raw.githubusercontent.com/psuzzi/act/main/setup.sh) "clone_dir" "env_file"`

where 
- clone_dir : base folder to contain act (default is ${HOME} ) 
- env_file : script to be altered for sourcing act (default ${HOME}/.bashrc)

## Note

If you want to perform changes and push via ssh, you can change the origin

`git remote set-url origin git@github.com:psuzzi/act.git`

# Local development


For local development, you can run 

`bash <(cat ./setup.sh) "~/" "~/.bashrc"`

Just remember to not overwrite your current installation
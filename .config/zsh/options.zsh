setopt autocd autopushd # this command will let you navigatge without cding
setopt correct # this command correct typos in your commands

autoload -Uz compinit # zsh completion
compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"

# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

export ZDOTDIR="$HOME"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

fpath=($XDG_CONFIG_HOME/zsh/completions $fpath)

# Load zsh config files
for conf in "$XDG_CONFIG_HOME/zsh/"*.zsh; do
  source "${conf}"
done
unset conf

# zsh completion
autoload -Uz compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"

# prevent duplicates in $PATH and $FPATH.
unique path
unique fpath

# Added by Docker Desktop
if [ -f "/Users/noam/.docker/init-zsh.sh" ]; then
    source /Users/noam/.docker/init-zsh.sh || true
fi


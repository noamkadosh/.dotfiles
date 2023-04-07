export ZDOTDIR="$HOME"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Load zsh config files
for conf in "$XDG_CONFIG_HOME/zsh/"*.zsh; do
  source "${conf}"
done
unset conf

fpath=($XDG_CONFIG_HOME/zsh/completions $fpath)

# prevent duplicates in $PATH and $FPATH.
unique path
unique fpath

# Start Zellij on startup
eval "$(zellij setup --generate-auto-start zsh)"

# Added by Docker Desktop
if [ -f "/Users/noam/.docker/init-zsh.sh" ]; then
    source /Users/noam/.docker/init-zsh.sh || true
fi


export PATH="$HOME/.local/bin:$VOLTA_HOME/bin:$PATH"
export FPATH="$HOME/.config/zsh/completions:$FPATH"
export ZDOTDIR="$HOME"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export VOLTA_HOME="$HOME/.volta"
export EDITOR='code'

# Load zsh config files
for conf in "$XDG_CONFIG_HOME/zsh/"*.zsh; do
  source "${conf}"
done
unset conf

# prevent duplicates in $PATH and $FPATH.
unique path
unique fpath

# Start Zellij on startup
eval "$(zellij setup --generate-auto-start zsh)"

source /Users/noam/.docker/init-zsh.sh || true # Added by Docker Desktop

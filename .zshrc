# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

setopt autocd autopushd # this command will let you navigatge without cding
setopt correct # this command correct typos in your commands

autoload -U compinit # zsh completion
compinit

eval "$(starship init zsh)"
eval "$(sheldon source)"

export BAT_THEME="Nord"
test -r ~/.config/.dir_colors && eval $(gdircolors ~/.config/.dir_colors)

# fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#2E3440,hl+:#e5e9f0
    --color=info:#eacb8a,prompt:#bf6069,pointer:#a3be8b
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
# fzf end

# fzf-tab
zstyle ':fzf-tab:*' switch-group '[' ']'
zstyle ':fzf-tab:*' continuous-trigger 'tab'
zstyle ':fzf-tab:complete:_zlua:*' query-string input
# fzf-tab end

# pnpm
export PNPM_HOME="/Users/noam/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

export EDITOR='code'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias ls='gls --color=always -G' # use GNU ls to get dir_colors
alias cmon='sudo $(fc -ln -1)'
alias c='cargo'
alias cr='cargo run'
alias crr='cargo run --release'
alias cb='cargo build'
alias ct='cargo test'
alias cta='cargo test && cargo test -- --ignored'
alias p='pnpm'
alias px='pnpm exec'
alias pr='pnpm run'
alias pnx='pnpm nx'
alias zshconfig='$EDITOR ~/.zshrc'
alias tmuxconfig='$EDITOR ~/.tmux.conf'
alias nvimconfig='$EDITOR ~/.config/nvim/init.vim'
alias gitconfig='$EDITOR ~/.gitconfig'
alias reloadzsh='source ~/.zshrc'
alias reloadtmux='tmux source-file ~/.tmux.conf'
alias myip='curl http://ipecho.net/plain; echo'
alias unique='typeset -U'
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
alias dotsc='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME commit'
alias dotsl='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME pull'
alias dotsp='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME push'
alias dotsa='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME add'
alias dotss='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME status'
alias dotsco='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME checkout'
alias gwt='git worktree'
alias gwta='gitWorktreeAdd existsing'
alias gwtab='gitWorktreeAdd new'
alias gwtls='git worktree list'
alias gwtrm='git worktree remove'
alias gwtrmf='git worktree remove -f'
alias gwtprn='git worktree prune'
alias gcns='gc && saveLastCommit'
alias gcplast='gcp $lastCommit'
alias gbstop='git bisect reset HEAD'
# gco-- <commit> <filename>
alias gco--='gRemoveFileChangesTillCommit'
# byebye <port>
alias byebye='killPort'

# Define personal functions
# getLastCommit
function saveLastCommit() {
    lastCommit=$(git rev-parse HEAD | cut -c 1-8)
}

# gitWorktreeAdd <new/existing> <branch>
function gitWorktreeAdd() {
    if [[ -n "$2" ]]
    then
      local folder_name=$(echo "$2" | tr '/' '-')
      local folder_path="../.git-worktrees/${folder_name}"
      if [[ "$1" == "new" ]]
      then
          git worktree add --track -b "$2" "${folder_path}"
          pushd "${folder_path}" > /dev/null
      else
          git worktree add "${folder_path}" "$2"
          pushd "${folder_path}" > /dev/null
      fi
    else
        echo 'Error: please provide path and a branch.'
    fi
}

# gRemoveFileChangesTillCommit <commit> <filename>
function gRemoveFileChangesTillCommit() {
    if [[ -n "$1" || -n "$2" ]]
    then
        git checkout "$1" -- "$2"
    else
        echo 'Error: please provide a commit and a filename.'
    fi
}

# killPort <port>
function killPort() {
    if [[ -n "$1" ]]
    then
        lsof -t -i tcp:"$1" | xargs kill
    else
        echo 'Error: please provide a port number.'
    fi
}

export PATH="$HOME/.local/bin:$PATH"

# prevent duplicates in $PATH and $FPATH.
unique path
unique fpath

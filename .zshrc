export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

setopt autocd autopushd # this command will let you navigatge without cding
setopt correct # this command correct typos in your commands

autoload -U compinit # zsh completion
compinit

eval "$(starship init zsh)"
eval "$(sheldon source)"
eval "$(zoxide init zsh)"

export BAT_THEME="tokyo-night"
test -r ~/.config/.dir_colors && eval $(gdircolors ~/.config/.dir_colors)

# fzf
	export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' 
	--color=fg:#C0CAF5,bg:#1A1B26,hl:#bb9af7
	--color=fg+:#C0CAF5,bg+:#1A1B26,hl+:#7DCFFF
	--color=info:#7AA2F7,prompt:#7DCFFF,pointer:#7DCFFF 
	--color=marker:#9ECE6A,spinner:#9ECE6A,header:#9ECE6A'
# fzf end

# fzf-tab
zstyle ':completion:*:descriptions' format '[%d]' # set descriptions format to enable group support
zstyle ':fzf-tab:*' switch-group '[' ']' # switch group using `[` and `]`
zstyle ':fzf-tab:*' continuous-trigger 'tab' # continuous trigger using tab key
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:_zlua:*' query-string input
# fzf-tab end

# pnpm
export PNPM_HOME="/Users/noam/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
# pnpm end

export EDITOR='code'

# Built-ins aliases
alias ls='exa'
alias cat='bat'
alias find='fd'
alias ps='procs'
alias sed='sd'
alias du='dust'
alias grep='ripgrep'
alias top='ytop'

# Other aliases
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
alias pdlx='pnpm dlx'
alias alacrittyconfig='$EDITOR ~/.config/alacritty/alacritty.yml'
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
alias gwtco='gitWorktreeAdd existing'
alias gwtan='gitWorktreeAdd new'
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

# getLastCommit
function saveLastCommit() {
    lastCommit=$(git rev-parse HEAD | cut -c 1-8)
}

# gitWorktreeAdd <new/existing> <branch>
function gitWorktreeAdd() {
    if [[ -n "$2" ]]
    then
        local folder_name=$(echo "$2" | tr '/' '-')
        local folder_path=".git-worktrees/${folder_name}"

        if [[ $PWD = *.git-worktrees ]];
        then
            folder_path="${folder_name}"
        elif [[ $PWD = *.git-worktrees* ]];
        then
            folder_path="../${folder_name}"
        fi

        if [[ "$1" == "new" ]]
        then
            git worktree add --track -b "$2" "${folder_path}"
            pushd "${folder_path}" > /dev/null
        else
            # git worktree add "${folder_path}" "$2"
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

# prevent duplicates in $PATH and $FPATH.
unique path
unique fpath

# Start Zellij on startup
eval "$(zellij setup --generate-auto-start zsh)"
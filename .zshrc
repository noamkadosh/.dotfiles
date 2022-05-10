# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

setopt autocd autopushd # this command will let you navigatge without cding
setopt correct # this command correct typos in your commands

autoload -U compinit # zsh completion
compinit

expand-or-complete-with-dots() {
  echo -n "\e[31m...\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

eval "$(starship init zsh)"

test -r ~/.dir_colors && eval $(gdircolors ~/.dir_colors)

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

eval "$(sheldon source)"

export EDITOR='code'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias p='pnpm'
alias px='pnpm exec'
alias pr='pnpm run'
alias zshconfig='$EDITOR ~/.zshrc'
alias tmuxconfig='$EDITOR ~/.tmux.conf'
alias hyperconfig='$EDITOR ~/.hyper.js'
alias ohmyzsh='$EDITOR ~/.oh-my-zsh'
alias nvimconfig='$EDITOR ~/.config/nvim/init.vim'
alias gitconfig='$EDITOR ~/.gitconfig'
alias reloadzsh='source ~/.zshrc'
alias reloadtmux='tmux source-file ~/.tmux.conf'
alias myip='curl http://ipecho.net/plain; echo'
alias unique='typeset -U'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
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

# prevent duplicates in $PATH and $FPATH, check why this is happening.
unique path
unique fpath

# Start tmux on every shell session
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#     exec tmux
# fi

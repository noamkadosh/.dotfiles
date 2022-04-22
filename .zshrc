# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.custom

source ~/.git-prompt.sh
ZSH_THEME="igloo"
test -r ~/.dir_colors && eval $(gdircolors ~/.dir_colors)

### Alien ZSH theme - Start ###
# export ALIEN_SECTIONS_LEFT=(
#   time 
#   exit
#   user
#   path
#   vcs_branch:async
#   vcs_status:async
#   vcs_dirty:async
#   newline
#   venv
#   prompt
# )

# Prompt section
# export ALIEN_PROMPT_SYM='❯'
# export ALIEN_PROMPT_FG='#FFFFFF'

# Exit section
# export ALIEN_SECTION_EXIT_FG='#EF5350'
# export ALIEN_SECTION_EXIT_BG='#02243F'
# export ALIEN_SECTION_EXIT_BG_ERROR='#02243F'

# Time section
# export ALIEN_SECTION_TIME_FORMAT=%l:%M' '%p
# export ALIEN_SECTION_TIME_FG='#C792EA'
# export ALIEN_SECTION_TIME_BG='#011D34'

# User section
# export ALIEN_SECTION_USER_FG='#82AAFF'
# export ALIEN_SECTION_USER_BG='#022A4B'

# Path section
# change this according to git at the alien.zsh file
# export ALIEN_SECTION_PATH_COMPONENTS=3
# export ALIEN_SECTION_PATH_FG='#21C7A8'
# export ALIEN_SECTION_PATH_BG='#023157'

# VCS Branch section
# export ALIEN_SECTION_VCS_BRANCH_FG='#ADDB67'
# export ALIEN_SECTION_VCS_BRANCH_BG='#033E6E'

# VCS Status section
# export ALIEN_SECTION_VCS_STATUS_FG='#ADDB67'
# export ALIEN_SECTION_VCS_STATUS_BG='#033E6E'

# VCS Dirty section
# export ALIEN_SECTION_VCS_DIRTY_FG='#C792EA'
# export ALIEN_SECTION_VCS_DIRTY_BG='#03447A'

# export ALIEN_THEME="blue"

# export ALIEN_KEEP_PROMPT=1

# export ALIEN_GIT_STASH_SYM=' 🐅'
# export ALIEN_GIT_SYM=' 🟢'
# export ALIEN_BRANCH_SYM=' 🐉'
# export ALIEN_GIT_ADD_SYM=' 🦍'
# export ALIEN_GIT_DEL_SYM=' 🦈'
# export ALIEN_GIT_MOD_SYM=' 🐋'
# export ALIEN_GIT_NEW_SYM=' 🦅'
# export ALIEN_GIT_PUSH_SYM=' 🐘'
# export ALIEN_GIT_PULL_SYM=' 🦣'

# source ~/.oh-my-zsh/custom/themes/alien/alien.zsh

# ZSH_THEME="alien/alien"
### Alien ZSH theme - End ###

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

### Bullet Train ZSH theme - Start ###
# ZSH_THEME="bullet-train"

# export BULLETTRAIN_PROMPT_ORDER=(time status context dir git cmd_exec_time)
# export BULLETTRAIN_PROMPT_CHAR="❯"
# export BULLETTRAIN_STATUS_EXIT_SHOW="true"
# export BULLETTRAIN_TIME_12HR="true"
# export BULLETTRAIN_GIT_PROMPT_CMD="\$(custom_git_prompt)"
# export BULLETTRAIN_EXEC_TIME_ELAPSED="60"
# export BULLETTRAIN_DIR_EXTENDED=4

# custom_git_prompt() {
#   prompt=$(git_prompt_info)
#   prompt=${prompt//\//\ \ }
#   prompt=${prompt//_/\ }
#   echo ${prompt}
# }

# # Emoji config
# export BULLETTRAIN_GIT_PREFIX="🟢 "
# export BULLETTRAIN_GIT_DIRTY=" 🌈"
# export BULLETTRAIN_GIT_CLEAN=" ✨"
# export BULLETTRAIN_GIT_UNTRACKED=" 🐅"
# export BULLETTRAIN_GIT_ADDED=" 🦍"
# export BULLETTRAIN_GIT_MODIFIED=" 🐋"
# export BULLETTRAIN_GIT_RENAMED=" 🦖"
# export BULLETTRAIN_GIT_DELETED=" 🦈"
# export BULLETTRAIN_GIT_UNMERGED=" 🦅"
# export BULLETTRAIN_GIT_AHEAD=" 🐘"
# export BULLETTRAIN_GIT_BEHIND=" 🦣"
# export BULLETTRAIN_GIT_DIVERGED=" 🐉"

# # Color config
# export BULLETTRAIN_TIME_BG="#011D34" 
# export BULLETTRAIN_TIME_FG="#C792EA"
# export BULLETTRAIN_STATUS_BG="#02243F"
# export BULLETTRAIN_STATUS_FG="#EF5350"
# export BULLETTRAIN_STATUS_ERROR_BG="#02243F"
# export BULLETTRAIN_CONTEXT_BG="#022A4B"
# export BULLETTRAIN_CONTEXT_FG="#82AAFF"
# export BULLETTRAIN_DIR_BG="#023157"
# export BULLETTRAIN_DIR_FG="#21C7A8"
# export BULLETTRAIN_GIT_BG="#033E6E"
# export BULLETTRAIN_GIT_FG="#ADDB67"
# export BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR="#033E6E"
# export BULLETTRAIN_GIT_COLORIZE_DIRTY_FG_COLOR="#ADDB67"
# export BULLETTRAIN_EXEC_TIME_BG="#03447A"
# export BULLETTRAIN_EXEC_TIME_FG="#C792EA"
### Bullet Train ZSH theme - End ###

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(macos web-search vscode git yarn docker-compose z zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi
export EDITOR='code'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

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
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
fi

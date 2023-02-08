zstyle ':completion:*:descriptions' format '[%d]' # set descriptions format to enable group support
zstyle ':fzf-tab:*' switch-group '[' ']' # switch group using `[` and `]`
zstyle ':fzf-tab:*' continuous-trigger 'tab' # continuous trigger using tab key
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:_zlua:*' query-string input

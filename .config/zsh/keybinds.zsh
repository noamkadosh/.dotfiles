# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

bindkey "^[[3~" delete-char
bindkey "^[[3;3~" kill-word
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

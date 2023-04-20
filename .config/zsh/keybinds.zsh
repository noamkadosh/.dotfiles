# autocompletion using arrow keys (based on history)
bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward

bindkey "\e[3~" delete-char
bindkey "\e3;3~" kill-word
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

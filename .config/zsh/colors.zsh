export BAT_THEME="tokyo-night"
test -r ~/.config/.dir_colors && eval $(dircolors ~/.config/.dir_colors)

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' 
	--color=fg:#C0CAF5,bg:#1A1B26,hl:#bb9af7
	--color=fg+:#C0CAF5,bg+:#1A1B26,hl+:#7DCFFF
	--color=info:#7AA2F7,prompt:#7DCFFF,pointer:#7DCFFF 
	--color=marker:#9ECE6A,spinner:#9ECE6A,header:#9ECE6A'

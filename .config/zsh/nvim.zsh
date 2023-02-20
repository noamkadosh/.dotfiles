# get last working directory from nvim and cd to it, other part of the solution is in nvim config.
nvim() {
# lazygit () {
     export NVIM_NEW_DIR_FILE="$HOME/.temp/nvim/cwd"

    command nvim "$@"

    if [[ -f "$NVIM_NEW_DIR_FILE" ]]; then
        rc=$?
        cd "$(cat "$NVIM_NEW_DIR_FILE")" && rm "$NVIM_NEW_DIR_FILE" &&
    
        return $rc
    fi
}

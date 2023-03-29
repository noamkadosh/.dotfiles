#!/bin/zsh

ZELLIJ_STATUSBAR_SRC="~/.config/zellij/plugins_src/statusbar/"
ZELLIJ_STATUSBAR_DIST="~/.config/zellij/plugins/"
ZELLIJ_STATUSBAR_BIN="statusbar.wasm"

mkdir -p "$ZELLIJ_STATUSBAR_DIST"
rm "$ZELLIJ_STATUSBAR_DIST/statusbar.wasm" || true
cd $ZELLIJ_STATUSBAR_SRC
cargo build --release
cp "target/wasm32-wasi/release/$ZELLIJ_STATUSBAR_BIN" "$ZELLIJ_STATUSBAR_DIST/"

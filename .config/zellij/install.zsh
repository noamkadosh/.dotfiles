#!/bin/zsh

ZELLIJ_STATUSBAR_SRC="~/.config/zellij/plugins_src/statusbar"
ZELLIJ_STATUSBAR_DIST="~/.config/zellij/plugins"
ZELLIJ_STATUSBAR_BIN="statusbar.wasm"

$(command -v rustup) target add wasm32-wasi

mkdir -p "$ZELLIJ_STATUSBAR_DIST"
rm "$ZELLIJ_STATUSBAR_DIST/$ZELLIJ_STATUSBAR_BIN" || true
cd $ZELLIJ_STATUSBAR_SRC || die "$ZELLIJ_STATUSBAR_SRC might not exist"
$(command -v cargo) build --release || die "Failed to build zellij statusbar"
cp "target/wasm32-wasi/release/$ZELLIJ_STATUSBAR_BIN" "$ZELLIJ_STATUSBAR_DIST/" || die "Encountered a problem copying statusbar"

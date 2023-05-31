#!/bin/zsh

$(command -v cargo) install cargo-watch

# Bob-nvim
$(command -v cargo) install bob-nvim
$(command -v bob) use nightly

# AiChat
$(command -v cargo) install --force aichat

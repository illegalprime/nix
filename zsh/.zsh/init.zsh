#!/bin/zsh
source ~/.zsh/zgen/zgen.zsh
if ! zgen saved; then
    # use zgen reset to reload config after you change this:

    # Fish-like autosuggestions.
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load tarruda/zsh-autosuggestions

    # auto get to last working dir plugin
    zgen oh-my-zsh plugins/last-working-dir

    # Save loaded plugins.
    zgen save
fi

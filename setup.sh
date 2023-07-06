#!/bin/bash

DOTFILES_DIR="${HOME}/workspace/dotfiles"

ln -s "${DOTFILES_DIR}/.alacritty.yml" "${HOME}/.alacritty.yml"
ln -s "${DOTFILES_DIR}/.editorconfig" "${HOME}/.editorconfig"
ln -s "${DOTFILES_DIR}/.gitconfig" "${HOME}/.gitconfig"
ln -s "${DOTFILES_DIR}/.irbrc" "${HOME}/.irbrc"
ln -s "${DOTFILES_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
ln -s "${DOTFILES_DIR}/.zshrc" "${HOME}/.zshrc"

if [[ $(uname) == 'Darwin' ]]; then
    ln -s "${DOTFILES_DIR}/.zshrc_mac" "${HOME}/.zshrc_mac"
fi
